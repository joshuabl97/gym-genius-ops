#!/bin/bash
# Helper script to interact with Notion wiki pages

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

NOTION_API_VERSION="2022-06-28"

notion_curl() {
    curl -s \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: $NOTION_API_VERSION" \
        "$@"
}

case "${1:-}" in
    search)
        # Search for pages containing text
        query="${2:-}"
        notion_curl -X POST "https://api.notion.com/v1/search" \
            -d "{\"query\": \"$query\", \"page_size\": 100}"
        ;;
    get-blocks)
        # Get blocks (content) of a page
        page_id="$2"
        notion_curl "https://api.notion.com/v1/blocks/$page_id/children?page_size=100"
        ;;
    get-page)
        # Get page properties
        page_id="$2"
        notion_curl "https://api.notion.com/v1/pages/$page_id"
        ;;
    list-wiki)
        # List wiki children (wiki page ID: 2cf94de2-5d4d-81f0-9890-d7302b3365d4)
        notion_curl "https://api.notion.com/v1/blocks/2cf94de25d4d81f09890d7302b3365d4/children?page_size=100"
        ;;
    update-block)
        # Update a text block
        block_id="$2"
        new_text="$3"
        notion_curl -X PATCH "https://api.notion.com/v1/blocks/$block_id" \
            -d "{\"paragraph\": {\"rich_text\": [{\"type\": \"text\", \"text\": {\"content\": \"$new_text\"}}]}}"
        ;;
    *)
        echo "Usage: $0 {search|get-blocks|get-page|list-wiki|update-block} [args]"
        ;;
esac
