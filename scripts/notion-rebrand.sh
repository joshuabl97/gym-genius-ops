#!/bin/bash
# Rebrand Gym Genius to Uzzage in Notion wiki

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

update_block() {
    local block_id="$1"
    local block_type="$2"
    local new_text="$3"

    # Escape quotes for JSON
    local escaped_text=$(echo "$new_text" | sed 's/"/\\"/g')

    echo "Updating $block_type block $block_id..."

    curl -s -X PATCH "https://api.notion.com/v1/blocks/$block_id" \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        -d "{
            \"$block_type\": {
                \"rich_text\": [{
                    \"type\": \"text\",
                    \"text\": {\"content\": \"$escaped_text\"}
                }]
            }
        }" | jq -r ".$block_type.rich_text[0].plain_text // .message"
}

echo "=== Rebranding Gym Genius -> Uzzage ==="

# Demo Script & Playbook page
echo ""
echo "--- Demo Script & Playbook ---"

# Callout: "Complete sales playbook for Gym Genius EU demos..."
update_block "2cf94de2-5d4d-8126-8996-edcf6a2a2ddb" "callout" "Complete sales playbook for Uzzage demos. Includes elevator pitch, demo script, objection handling, and follow-up templates."

# Paragraph: "Use this structure to quickly explain Gym Genius EU to anyone."
update_block "2cf94de2-5d4d-81be-8cfc-c6b3da146248" "paragraph" "Use this structure to quickly explain Uzzage to anyone."

# Quote: The elevator pitch
update_block "2cf94de2-5d4d-81ad-86f5-f187eb4b931b" "quote" "\"You know how gyms spend \$50-100K a year on equipment with zero data on what actually gets used? We fix that. Uzzage uses computer vision to track equipment utilization—not individual members, just zone occupancy. Gym owners see exactly which machines are busy, when peak hours hit, and which equipment is sitting unused. The insight pays for itself with one avoided bad purchase. We are looking for pilot partners—interested in a 30-day trial?\""

echo ""
echo "=== Done ==="
