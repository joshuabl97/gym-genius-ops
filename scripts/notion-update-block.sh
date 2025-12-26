#!/bin/bash
# Update a Notion block with new content

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

BLOCK_ID="$1"
BLOCK_TYPE="$2"
NEW_TEXT="$3"

if [[ -z "$BLOCK_ID" || -z "$BLOCK_TYPE" || -z "$NEW_TEXT" ]]; then
    echo "Usage: $0 <block_id> <block_type> <new_text>"
    echo "Block types: paragraph, callout, heading_1, heading_2, heading_3, bulleted_list_item"
    exit 1
fi

# Escape quotes for JSON
ESCAPED_TEXT=$(echo "$NEW_TEXT" | sed 's/"/\\"/g')

case "$BLOCK_TYPE" in
    callout)
        curl -s -X PATCH "https://api.notion.com/v1/blocks/$BLOCK_ID" \
            -H "Authorization: Bearer $NOTION_TOKEN" \
            -H "Content-Type: application/json" \
            -H "Notion-Version: 2022-06-28" \
            -d "{
                \"callout\": {
                    \"rich_text\": [{
                        \"type\": \"text\",
                        \"text\": {\"content\": \"$ESCAPED_TEXT\"}
                    }]
                }
            }"
        ;;
    paragraph)
        curl -s -X PATCH "https://api.notion.com/v1/blocks/$BLOCK_ID" \
            -H "Authorization: Bearer $NOTION_TOKEN" \
            -H "Content-Type: application/json" \
            -H "Notion-Version: 2022-06-28" \
            -d "{
                \"paragraph\": {
                    \"rich_text\": [{
                        \"type\": \"text\",
                        \"text\": {\"content\": \"$ESCAPED_TEXT\"}
                    }]
                }
            }"
        ;;
    *)
        echo "Unsupported block type: $BLOCK_TYPE"
        exit 1
        ;;
esac
