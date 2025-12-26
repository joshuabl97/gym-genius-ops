#!/bin/bash
#
# Centralized Notion API Script for GTM Agents
# Uses NOTION_TOKEN from environment (set in ~/.bashrc)
#
# Notion API Endpoints Used:
# --------------------------
# POST https://api.notion.com/v1/databases/{database_id}/query  - Query tickets
# GET  https://api.notion.com/v1/pages/{page_id}                - Get single ticket
# PATCH https://api.notion.com/v1/pages/{page_id}               - Update ticket
# POST https://api.notion.com/v1/pages                          - Create ticket
# GET  https://api.notion.com/v1/blocks/{block_id}/children     - Get page content
# PATCH https://api.notion.com/v1/blocks/{block_id}/children    - Append to page
#

set -e

# Configuration
NOTION_API_VERSION="2022-06-28"
NOTION_BASE_URL="https://api.notion.com/v1"

# Database IDs
TICKETS_DB_ID="2cf94de2-5d4d-81c8-b1af-d31631fb5730"

# Workstream mappings for agents
declare -A AGENT_WORKSTREAMS=(
    ["research"]="RESEARCH"
    ["business"]="INVESTOR,BIZ"
    ["partner"]="GTM,PARTNER"
    ["operations"]="BIZ,DEMO,CONTENT"
)

# Check for required token - auto-load from ~/.bashrc if needed
check_token() {
    if [[ -z "$NOTION_TOKEN" ]]; then
        # Try to extract NOTION_TOKEN from ~/.bashrc
        if [[ -f ~/.bashrc ]]; then
            NOTION_TOKEN=$(grep -oP 'export NOTION_TOKEN="\K[^"]+' ~/.bashrc 2>/dev/null || true)
            export NOTION_TOKEN
        fi
    fi

    if [[ -z "$NOTION_TOKEN" ]]; then
        echo "Error: NOTION_TOKEN environment variable is not set" >&2
        echo "Add to ~/.bashrc: export NOTION_TOKEN=\"your-token-here\"" >&2
        exit 1
    fi
}

# Common curl options for Notion API
notion_curl() {
    curl -s \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: $NOTION_API_VERSION" \
        "$@"
}

# =============================================================================
# QUERY TICKETS
# Endpoint: POST /databases/{database_id}/query
# =============================================================================
list_tickets() {
    local agent="$1"
    local status="${2:-}"  # Optional: filter by status (e.g., "In Progress", "Todo", "Done")

    check_token

    # Build filter based on agent workstreams
    local workstreams="${AGENT_WORKSTREAMS[$agent]}"
    if [[ -z "$workstreams" ]]; then
        echo "Error: Unknown agent '$agent'. Valid agents: ${!AGENT_WORKSTREAMS[*]}" >&2
        exit 1
    fi

    # Build workstream filter array
    local filter_conditions=""
    IFS=',' read -ra WS_ARRAY <<< "$workstreams"
    for ws in "${WS_ARRAY[@]}"; do
        if [[ -n "$filter_conditions" ]]; then
            filter_conditions+=","
        fi
        filter_conditions+="{\"property\": \"Workstream\", \"select\": {\"equals\": \"$ws\"}}"
    done

    # Add status filter if provided
    local status_filter=""
    if [[ -n "$status" ]]; then
        status_filter=",{\"property\": \"Status\", \"status\": {\"equals\": \"$status\"}}"
    fi

    local query_body
    if [[ $(echo "$workstreams" | tr ',' '\n' | wc -l) -gt 1 ]]; then
        # Multiple workstreams - use OR
        query_body="{
            \"filter\": {
                \"and\": [
                    {\"or\": [$filter_conditions]}
                    $status_filter
                ]
            },
            \"sorts\": [
                {\"property\": \"Priority\", \"direction\": \"ascending\"}
            ]
        }"
    else
        # Single workstream
        query_body="{
            \"filter\": {
                \"and\": [
                    $filter_conditions
                    $status_filter
                ]
            },
            \"sorts\": [
                {\"property\": \"Priority\", \"direction\": \"ascending\"}
            ]
        }"
    fi

    notion_curl -X POST \
        "$NOTION_BASE_URL/databases/$TICKETS_DB_ID/query" \
        -d "$query_body"
}

# Format tickets as readable list
list_tickets_pretty() {
    local agent="$1"
    local status="${2:-}"

    list_tickets "$agent" "$status" | jq -r '
        .results[] |
        "[\(.properties.Status.select.name // "Unknown")] " +
        (.properties.Initiative.title[0].plain_text // "Untitled") +
        " (Priority: " + (.properties.Priority.select.name // "None") + ")" +
        "\n  ID: " + .id +
        "\n  Ticket: " + (.properties."Ticket #".unique_id.prefix // "") + (.properties."Ticket #".unique_id.number | tostring) +
        "\n  Workstream: " + (.properties.Workstream.select.name // "None") +
        "\n"
    '
}

# =============================================================================
# GET SINGLE TICKET
# Endpoint: GET /pages/{page_id}
# =============================================================================
get_ticket() {
    local page_id="$1"

    check_token

    if [[ -z "$page_id" ]]; then
        echo "Error: page_id is required" >&2
        exit 1
    fi

    notion_curl "$NOTION_BASE_URL/pages/$page_id"
}

# Get ticket with formatted output
get_ticket_pretty() {
    local page_id="$1"

    get_ticket "$page_id" | jq -r '
        "Title: " + (.properties.Initiative.title[0].plain_text // "Untitled") +
        "\nTicket: " + (.properties."Ticket #".unique_id.prefix // "") + (.properties."Ticket #".unique_id.number | tostring) +
        "\nStatus: " + (.properties.Status.select.name // "Unknown") +
        "\nPriority: " + (.properties.Priority.select.name // "None") +
        "\nWorkstream: " + (.properties.Workstream.select.name // "None") +
        "\nNotes: " + (.properties.Notes.rich_text[0].plain_text // "None") +
        "\nID: " + .id +
        "\nURL: " + .url
    '
}

# =============================================================================
# UPDATE TICKET STATUS
# Endpoint: PATCH /pages/{page_id}
# =============================================================================
update_ticket_status() {
    local page_id="$1"
    local new_status="$2"  # e.g., "Not Started", "In Progress", "Done", "Blocked"

    check_token

    if [[ -z "$page_id" || -z "$new_status" ]]; then
        echo "Error: page_id and new_status are required" >&2
        echo "Usage: update_ticket_status <page_id> <status>" >&2
        echo "Valid statuses: Not Started, In Progress, Done, Blocked" >&2
        exit 1
    fi

    notion_curl -X PATCH \
        "$NOTION_BASE_URL/pages/$page_id" \
        -d "{
            \"properties\": {
                \"Status\": {
                    \"select\": {
                        \"name\": \"$new_status\"
                    }
                }
            }
        }"
}

# =============================================================================
# ADD NOTES TO TICKET
# Endpoint: PATCH /blocks/{block_id}/children
# =============================================================================
add_ticket_notes() {
    local page_id="$1"
    local notes="$2"

    check_token

    if [[ -z "$page_id" || -z "$notes" ]]; then
        echo "Error: page_id and notes are required" >&2
        exit 1
    fi

    # Escape quotes in notes for JSON
    local escaped_notes=$(echo "$notes" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

    notion_curl -X PATCH \
        "$NOTION_BASE_URL/blocks/$page_id/children" \
        -d "{
            \"children\": [
                {
                    \"object\": \"block\",
                    \"type\": \"paragraph\",
                    \"paragraph\": {
                        \"rich_text\": [
                            {
                                \"type\": \"text\",
                                \"text\": {
                                    \"content\": \"$escaped_notes\"
                                }
                            }
                        ]
                    }
                }
            ]
        }"
}

# =============================================================================
# MARK TICKET COMPLETE
# Convenience function to update status and add completion notes
# =============================================================================
complete_ticket() {
    local page_id="$1"
    local completion_notes="${2:-Completed by agent}"

    check_token

    echo "Updating ticket status to Done..."
    update_ticket_status "$page_id" "Done" > /dev/null

    echo "Adding completion notes..."
    local timestamp=$(date "+%Y-%m-%d %H:%M")
    add_ticket_notes "$page_id" "[$timestamp] $completion_notes" > /dev/null

    echo "Ticket marked as complete."
}

# =============================================================================
# START WORK ON TICKET
# Convenience function to mark ticket as in progress
# =============================================================================
start_ticket() {
    local page_id="$1"

    check_token

    echo "Updating ticket status to In Progress..."
    update_ticket_status "$page_id" "In Progress" > /dev/null

    local timestamp=$(date "+%Y-%m-%d %H:%M")
    add_ticket_notes "$page_id" "[$timestamp] Work started by agent" > /dev/null

    echo "Ticket marked as In Progress."
}

# =============================================================================
# USAGE / HELP
# =============================================================================
show_help() {
    cat << 'EOF'
Notion API Script for GTM Agents

Usage: notion-api.sh <command> [args...]

Commands:
  list <agent> [status]     List tickets for agent (research|business|partner|operations)
                            Optional status filter: Todo, In Progress, Done, Blocked

  get <page_id>             Get details for a specific ticket

  status <page_id> <status> Update ticket status
                            Valid statuses: Not Started, In Progress, Done, Blocked

  start <page_id>           Mark ticket as "In Progress" with timestamp

  complete <page_id> [note] Mark ticket as "Done" with optional completion note

  notes <page_id> <text>    Add notes to a ticket

Environment:
  NOTION_TOKEN              Required. Your Notion integration token.
                            Set in ~/.bashrc: export NOTION_TOKEN="your-token"

Examples:
  # List all tickets for research agent
  ./notion-api.sh list research

  # List only "Todo" tickets for business agent
  ./notion-api.sh list business "Todo"

  # Start working on a ticket
  ./notion-api.sh start abc123-def456-...

  # Mark ticket complete with notes
  ./notion-api.sh complete abc123-def456-... "Finished financial model v1"

Notion API Endpoints Used:
  POST   /databases/{id}/query     - Query tickets by workstream/status
  GET    /pages/{id}               - Get single ticket details
  PATCH  /pages/{id}               - Update ticket properties
  PATCH  /blocks/{id}/children     - Add notes to ticket
EOF
}

# =============================================================================
# MAIN
# =============================================================================
case "${1:-}" in
    list)
        list_tickets_pretty "${2:-}" "${3:-}"
        ;;
    get)
        get_ticket_pretty "$2"
        ;;
    status)
        update_ticket_status "$2" "$3"
        echo "Status updated to: $3"
        ;;
    start)
        start_ticket "$2"
        ;;
    complete)
        complete_ticket "$2" "${3:-Completed by agent}"
        ;;
    notes)
        add_ticket_notes "$2" "$3"
        echo "Notes added."
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "Unknown command: $1" >&2
        echo "Run './notion-api.sh help' for usage." >&2
        exit 1
        ;;
esac
