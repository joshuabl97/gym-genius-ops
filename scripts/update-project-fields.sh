#!/bin/bash
# Update project fields based on labels

PROJECT_ID="PVT_kwHOAYNB084BK28r"
WS_FIELD="PVTSSF_lAHOAYNB084BK28rzg6mryg"
PR_FIELD="PVTSSF_lAHOAYNB084BK28rzg6mrzM"

gh project item-list 2 --owner joshuabl97 --limit 50 --format json | jq -r '.items[] | "\(.id)|\(.labels | join(","))"' | while IFS='|' read -r item_id labels; do
  ws_option=""
  if [[ "$labels" == *"workstream:demo"* ]]; then ws_option="3f6570e5"
  elif [[ "$labels" == *"workstream:content"* ]]; then ws_option="4bb3f89e"
  elif [[ "$labels" == *"workstream:investor"* ]]; then ws_option="feeab653"
  elif [[ "$labels" == *"workstream:research"* ]]; then ws_option="03a2f375"
  elif [[ "$labels" == *"workstream:biz"* ]]; then ws_option="0be4152e"
  elif [[ "$labels" == *"workstream:partner"* ]]; then ws_option="d845a8fc"
  elif [[ "$labels" == *"workstream:social"* ]]; then ws_option="908a1996"
  fi

  pr_option=""
  if [[ "$labels" == *"priority:critical"* ]]; then pr_option="5d8e5bfa"
  elif [[ "$labels" == *"priority:high"* ]]; then pr_option="2f3fef3e"
  elif [[ "$labels" == *"priority:medium"* ]]; then pr_option="dd30e947"
  elif [[ "$labels" == *"priority:low"* ]]; then pr_option="93fc3bd7"
  fi

  if [ -n "$ws_option" ]; then
    gh project item-edit --project-id "$PROJECT_ID" --id "$item_id" --field-id "$WS_FIELD" --single-select-option-id "$ws_option" 2>/dev/null
  fi

  if [ -n "$pr_option" ]; then
    gh project item-edit --project-id "$PROJECT_ID" --id "$item_id" --field-id "$PR_FIELD" --single-select-option-id "$pr_option" 2>/dev/null
  fi

  echo "Updated: $item_id"
done

echo "Done!"
