#!/bin/bash
# Sync deliverables to Notion wiki

set -e

# Load token
if [[ -f ~/.bashrc ]]; then
    NOTION_TOKEN=$(grep -oP 'NOTION_TOKEN="\K[^"]+' ~/.bashrc 2>/dev/null || true)
    export NOTION_TOKEN
fi

if [[ -z "$NOTION_TOKEN" ]]; then
    echo "Error: NOTION_TOKEN not found" >&2
    exit 1
fi

WIKI_PAGE_ID="2cf94de2-5d4d-81f0-9890-d7302b3365d4"

notion_curl() {
    curl -s \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        "$@"
}

update_block() {
    local block_id="$1"
    local block_type="$2"
    local new_text="$3"

    local escaped_text=$(echo "$new_text" | sed 's/"/\\"/g' | tr '\n' ' ')

    notion_curl -X PATCH "https://api.notion.com/v1/blocks/$block_id" \
        -d "{
            \"$block_type\": {
                \"rich_text\": [{
                    \"type\": \"text\",
                    \"text\": {\"content\": \"$escaped_text\"}
                }]
            }
        }" | jq -r ".$block_type.rich_text[0].plain_text // .message"
}

create_page() {
    local parent_id="$1"
    local title="$2"

    notion_curl -X POST "https://api.notion.com/v1/pages" \
        -d "{
            \"parent\": {\"page_id\": \"$parent_id\"},
            \"properties\": {
                \"title\": [{\"text\": {\"content\": \"$title\"}}]
            }
        }" | jq -r '.id'
}

append_paragraph() {
    local page_id="$1"
    local text="$2"

    local escaped_text=$(echo "$text" | sed 's/"/\\"/g' | tr '\n' ' ')

    notion_curl -X PATCH "https://api.notion.com/v1/blocks/$page_id/children" \
        -d "{
            \"children\": [{
                \"object\": \"block\",
                \"type\": \"paragraph\",
                \"paragraph\": {
                    \"rich_text\": [{\"type\": \"text\", \"text\": {\"content\": \"$escaped_text\"}}]
                }
            }]
        }" > /dev/null
}

append_heading() {
    local page_id="$1"
    local level="$2"
    local text="$3"

    notion_curl -X PATCH "https://api.notion.com/v1/blocks/$page_id/children" \
        -d "{
            \"children\": [{
                \"object\": \"block\",
                \"type\": \"heading_$level\",
                \"heading_$level\": {
                    \"rich_text\": [{\"type\": \"text\", \"text\": {\"content\": \"$text\"}}]
                }
            }]
        }" > /dev/null
}

append_callout() {
    local page_id="$1"
    local emoji="$2"
    local text="$3"

    local escaped_text=$(echo "$text" | sed 's/"/\\"/g' | tr '\n' ' ')

    notion_curl -X PATCH "https://api.notion.com/v1/blocks/$page_id/children" \
        -d "{
            \"children\": [{
                \"object\": \"block\",
                \"type\": \"callout\",
                \"callout\": {
                    \"icon\": {\"type\": \"emoji\", \"emoji\": \"$emoji\"},
                    \"rich_text\": [{\"type\": \"text\", \"text\": {\"content\": \"$escaped_text\"}}]
                }
            }]
        }" > /dev/null
}

echo "=== Syncing Deliverables to Notion Wiki ==="
echo ""

# 1. Update main wiki callout (already done, but verify)
echo "1. Updating main wiki callout..."
update_block "2cf94de2-5d4d-8153-bdae-efb2ff85694e" "callout" "Central knowledge base for Uzzage. All reference docs, playbooks, and guides in one place."

# 2. Update Pricing Calculator callout
echo "2. Updating Pricing Calculator..."
update_block "2cf94de2-5d4d-8169-85fa-c72c8e1061bb" "callout" "Comprehensive pricing reference for Uzzage. Use this to prepare quotes, calculate ROI for prospects, and understand unit economics."

# 3. Update paragraph in Pricing Calculator
echo "3. Updating Pricing Calculator paragraph..."
update_block "2cf94de2-5d4d-81b8-a811-d888204f9552" "paragraph" "Uzzage uses a sqft-based pricing model: Base Fee + Per Sqft Rate. This scales naturally with gym size while keeping pricing simple."

# 4. Create One-Pager page
echo "4. Creating One-Pager page..."
ONE_PAGER_ID=$(create_page "$WIKI_PAGE_ID" "Uzzage One-Pager")
echo "   Created page: $ONE_PAGER_ID"

# Add content to one-pager
append_callout "$ONE_PAGER_ID" "📄" "Customer-facing one-pager for gym owners. Print or share digitally."

append_heading "$ONE_PAGER_ID" "1" "Know Which Equipment Your Members Actually Use"

append_paragraph "$ONE_PAGER_ID" "Equipment utilization analytics for gyms—powered by your existing security cameras."

append_heading "$ONE_PAGER_ID" "2" "The Problem"

append_paragraph "$ONE_PAGER_ID" "You buy equipment based on gut feel. You guess which machines are popular. You don't know what's gathering dust until members complain. Result: Wasted capital on underused equipment. Overcrowded zones that frustrate members."

append_heading "$ONE_PAGER_ID" "2" "What We Do"

append_paragraph "$ONE_PAGER_ID" "We use your existing security cameras to show you exactly which equipment gets used, when, and for how long. No surveys. No sensors on every machine. No member apps. Just real data from cameras you already have."

append_heading "$ONE_PAGER_ID" "2" "Packages"

append_paragraph "$ONE_PAGER_ID" "Connect: Already have IP cameras - \$359-\$718 setup + \$314-\$799/mo. Enhance: Some cameras, need more - \$2,838-\$6,586 setup + \$314-\$799/mo. Complete: No cameras or new build - \$5,900-\$45,834 setup + \$314-\$799/mo."

append_heading "$ONE_PAGER_ID" "2" "The ROI"

append_paragraph "$ONE_PAGER_ID" "One avoided bad equipment purchase pays for a year of service. Commercial treadmill: \$5,000-\$12,000. Elliptical: \$4,000-\$8,000. If our data helps you buy one machine that members actually use instead of one that collects dust—that's your ROI."

append_heading "$ONE_PAGER_ID" "2" "Works With Your Cameras"

append_paragraph "$ONE_PAGER_ID" "Ubiquiti UniFi, Meraki, Axis, Hikvision, Verkada, and any IP camera with RTSP support."

# 5. Update Agent Setup Guide
echo "5. Updating Agent Setup Guide..."
update_block "2cf94de2-5d4d-8143-8fc6-d13313e01314" "callout" "Quick reference for setting up and running Claude Code agents for Uzzage development. For full details, see AGENT_SETUP_GUIDE.md in the repository."
update_block "2cf94de2-5d4d-8199-866f-d1bed2cb3c18" "heading_2" "GTM Agents (uzzage-ops)"
update_block "2cf94de2-5d4d-8155-ba7b-ce29ff62e063" "callout" "Full documentation: See AGENT_SETUP_GUIDE.md in uzzage-ops repository (2000+ lines with detailed setup for each agent)"

# 6. Update Pilot Program Playbook
echo "6. Updating Pilot Program Playbook..."
# Get the blocks first
PILOT_BLOCKS=$(notion_curl "https://api.notion.com/v1/blocks/2cf94de2-5d4d-81bd-a856-e20067e73c75/children?page_size=100")
echo "$PILOT_BLOCKS" | jq -r '.results[] | select((.callout.rich_text[0].plain_text // .paragraph.rich_text[0].plain_text // "") | test("Gym.Genius"; "i")) | .id' | while read block_id; do
    block_type=$(echo "$PILOT_BLOCKS" | jq -r ".results[] | select(.id == \"$block_id\") | .type")
    old_text=$(echo "$PILOT_BLOCKS" | jq -r ".results[] | select(.id == \"$block_id\") | .$block_type.rich_text[0].plain_text")
    new_text=$(echo "$old_text" | sed 's/Gym Genius/Uzzage/g')
    update_block "$block_id" "$block_type" "$new_text"
done

# 7. Update Technical Architecture
echo "7. Updating Technical Architecture..."
TECH_BLOCKS=$(notion_curl "https://api.notion.com/v1/blocks/2cf94de2-5d4d-817b-8b96-ede5d603b2df/children?page_size=100")
echo "$TECH_BLOCKS" | jq -r '.results[] | select((.callout.rich_text[0].plain_text // .paragraph.rich_text[0].plain_text // "") | test("Gym.Genius"; "i")) | .id' | while read block_id; do
    block_type=$(echo "$TECH_BLOCKS" | jq -r ".results[] | select(.id == \"$block_id\") | .type")
    old_text=$(echo "$TECH_BLOCKS" | jq -r ".results[] | select(.id == \"$block_id\") | .$block_type.rich_text[0].plain_text")
    new_text=$(echo "$old_text" | sed 's/Gym Genius/Uzzage/g')
    update_block "$block_id" "$block_type" "$new_text"
done

echo ""
echo "=== Sync Complete ==="
echo ""
echo "Updated pages:"
echo "  - Main wiki callout"
echo "  - Pricing Calculator"
echo "  - Agent Setup Guide"
echo "  - Pilot Program Playbook"
echo "  - Technical Architecture"
echo "  - Created: Uzzage One-Pager ($ONE_PAGER_ID)"
