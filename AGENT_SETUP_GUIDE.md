# Agent Setup Guide

This guide explains how agents are configured for the Gym Genius projects and how to set up multi-agent workflows.

**Last Updated:** 2025-12-18

---

## Overview

Agents are independent Claude Code sessions that work on specific areas of the project. Each agent:
- Runs in its own terminal window
- Has a designated focus area (workstream, service, or feature)
- Works on assigned tickets from the GitHub Project board
- Creates deliverables in designated folders

---

## Project Agent Configurations

### GTM Strategy Agents (Project 2)

Used for pre-investment go-to-market work in [gym-genius-ops](https://github.com/joshuabl97/gym-genius-ops).

| Agent | Focus | Deliverables Folder |
|-------|-------|---------------------|
| **Research Agent** | Customer discovery, market research, unit economics | `deliverables/research/` |
| **Investor Agent** | Pitch deck, VC prep, Equinox prep | `deliverables/investor/` |
| **Partner Agent** | Gym partnership materials, pilot program | `deliverables/partner/` |
| **Demo Agent** | Lab setup, hardware, video content | `deliverables/content/` |

### Development Agents (Project 1)

Used for technical development across the Gym Vision ecosystem.

| Agent | Focus | Repository |
|-------|-------|------------|
| **A-Vision** | CV/ML pipeline, annotations, video processing | gym-vision |
| **B-Web** | Dashboard UI (Go + HTMX) | gym-vision-web |
| **C-Infra** | Infrastructure, Docker, storage | gym-vision |
| **D-Inference** | Python inference service | gym-vision-inference |
| **E-Hub** | API hub, orchestration | gym-genius |

---

## Setting Up Agents in GitHub Projects

### Step 1: Create the Agent Field

```bash
gh project field-create <PROJECT_NUMBER> \
  --owner joshuabl97 \
  --name "Agent" \
  --data-type "SINGLE_SELECT" \
  --single-select-options "Agent1,Agent2,Agent3"
```

**Example for GTM project:**
```bash
gh project field-create 2 \
  --owner joshuabl97 \
  --name "Agent" \
  --data-type "SINGLE_SELECT" \
  --single-select-options "Research Agent,Investor Agent,Partner Agent,Demo Agent"
```

### Step 2: Get Field and Option IDs

```bash
gh project field-list <PROJECT_NUMBER> --owner joshuabl97 --format json | jq '.fields[] | select(.name == "Agent")'
```

This returns the field ID and option IDs needed for bulk assignment.

### Step 3: Assign Agents to Tickets

Create a script to bulk-assign agents based on ticket patterns:

```bash
#!/bin/bash
# assign-agents.sh

PROJECT_ID="<your-project-id>"
AGENT_FIELD="<agent-field-id>"

# Agent option IDs (from Step 2)
RESEARCH="<option-id>"
INVESTOR="<option-id>"
PARTNER="<option-id>"
DEMO="<option-id>"

gh project item-list <PROJECT_NUMBER> --owner joshuabl97 --limit 100 --format json | \
  jq -r '.items[] | "\(.id)|\(.content.number)"' | \
  while IFS='|' read -r item_id issue_num; do
    agent=""

    # Assign based on issue number or pattern
    case $issue_num in
      14|16|17|18|19|21|24) agent="$RESEARCH" ;;
      8|10|11|12) agent="$INVESTOR" ;;
      34|35) agent="$PARTNER" ;;
      1|2|4|5) agent="$DEMO" ;;
    esac

    if [ -n "$agent" ]; then
      gh project item-edit --project-id "$PROJECT_ID" --id "$item_id" \
        --field-id "$AGENT_FIELD" --single-select-option-id "$agent"
      echo "Assigned issue #$issue_num"
    fi
  done
```

---

## Starting Agent Sessions

### Basic Pattern

```bash
cd <repository-path>
claude "<context> Help me complete issue #<NUMBER> (<TICKET-ID>: <TITLE>). <instructions>"
```

### GTM Agent Startup Commands

**Research Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm the Research Agent working on Gym Genius GTM Strategy. Help me complete issue #<NUM> (<TICKET>). Read docs/ for strategic context. Create deliverables in deliverables/research/. Close the issue when done."
```

**Investor Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm the Investor Agent working on Gym Genius GTM Strategy. Help me complete issue #<NUM> (<TICKET>). Read docs/ for strategic context. Create deliverables in deliverables/investor/. Close the issue when done."
```

**Partner Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm the Partner Agent working on Gym Genius GTM Strategy. Help me complete issue #<NUM> (<TICKET>). Read docs/ for strategic context. Create deliverables in deliverables/partner/. Close the issue when done."
```

**Demo Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm the Demo Agent working on Gym Genius GTM Strategy. Help me complete issue #<NUM> (<TICKET>). Read docs/ for strategic context. Create deliverables in deliverables/content/. Close the issue when done."
```

### Development Agent Startup Commands

**A-Vision (CV/ML):**
```bash
cd ~/Code/gym-vision
claude "I'm Agent A-Vision working on Gym Vision Development. Help me complete issue #<NUM> (<TICKET>). This is computer vision / ML work."
```

**B-Web (Dashboard):**
```bash
cd ~/Code/gym-vision-web
claude "I'm Agent B-Web working on Gym Vision Development. Help me complete issue #<NUM> (<TICKET>). This is Go + HTMX dashboard work."
```

**C-Infra (Infrastructure):**
```bash
cd ~/Code/gym-vision
claude "I'm Agent C-Infra working on Gym Vision Development. Help me complete issue #<NUM> (<TICKET>). This is infrastructure / DevOps work."
```

**D-Inference (Inference Service):**
```bash
cd ~/Code/gym-vision-inference
claude "I'm Agent D-Inference working on Gym Vision Development. Help me complete issue #<NUM> (<TICKET>). This is Python inference service work."
```

**E-Hub (API Hub):**
```bash
cd ~/Code/gym-genius
claude "I'm Agent E-Hub working on Gym Vision Development. Help me complete issue #<NUM> (<TICKET>). This is API hub / backend work."
```

---

## Creating a "By Agent" View in GitHub Projects

1. Open your project board
2. Click **"+ New view"** → **Board**
3. Rename to **"By Agent"**
4. Click the column field dropdown (says "Status")
5. Select **"Agent"**

You'll see columns for each agent showing their assigned tickets.

### Useful Filters

```
# Show only one agent's work
agent:"Research Agent"

# Show high priority for an agent
agent:"A-Vision" priority:High,Critical

# Show in-progress across all agents
status:"In Progress"
```

---

## Agent Coordination Best Practices

### 1. Avoid File Conflicts

Assign agents to **non-overlapping areas**:
- Each agent works in different directories or repos
- If agents must share files, coordinate who edits what

### 2. Respect Dependencies

Some tickets depend on others:
```
#8 (Pitch Deck) → #10, #11 (Prep materials)
#34 (Partnership Deck) → #35 (Pilot Program)
```

Don't start dependent tickets until prerequisites complete.

### 3. Use Consistent Naming

Deliverables should follow patterns:
```
deliverables/research/unit-economics.md
deliverables/investor/pitch-deck-v1.md
deliverables/partner/partnership-deck.md
```

### 4. Close Issues Promptly

When a ticket completes:
```bash
gh issue close <number> --repo joshuabl97/<repo-name>
```

### 5. Commit Deliverables

After each ticket:
```bash
git add deliverables/
git commit -m "Add <deliverable-name> for <TICKET-ID>"
git push
```

---

## Monitoring Agent Progress

### Check All Agents' Status

```bash
# GTM Project
gh project item-list 2 --owner joshuabl97 --limit 100 --format json | \
  jq -r '.items | group_by(.agent) | .[] | "\n\(.[0].agent // "Unassigned"):", (.[] | select(.status == "Todo" or .status == "In Progress") | "  [\(.status)] #\(.content.number): \(.title)")'

# Development Project
gh project item-list 1 --owner joshuabl97 --limit 100 --format json | \
  jq -r '.items | group_by(.agent) | .[] | "\n\(.[0].agent // "Unassigned"):", (.[] | select(.status == "Todo" or .status == "In Progress") | "  [\(.status)] #\(.content.number): \(.title)")'
```

### Count Tickets by Agent

```bash
gh project item-list <PROJECT_NUMBER> --owner joshuabl97 --limit 100 --format json | \
  jq -r '[.items[] | .agent] | group_by(.) | map({agent: .[0], count: length}) | .[] | "\(.agent // "Unassigned"): \(.count)"'
```

### Check Completed Work

```bash
gh project item-list <PROJECT_NUMBER> --owner joshuabl97 --limit 100 --format json | \
  jq -r '.items[] | select(.status == "Done") | "#\(.content.number): \(.title) | \(.agent)"'
```

---

## Adding New Agents

### 1. Add Option to Agent Field

```bash
# First, get current field info
gh project field-list <PROJECT_NUMBER> --owner joshuabl97 --format json | jq '.fields[] | select(.name == "Agent")'

# Note: Adding options requires the GitHub web UI
# Go to Project Settings → Custom Fields → Agent → Add option
```

### 2. Create Deliverables Folder (if GTM)

```bash
mkdir -p /home/josh/Code/gym-genius-ops/deliverables/<new-agent-folder>
touch /home/josh/Code/gym-genius-ops/deliverables/<new-agent-folder>/.gitkeep
git add deliverables/<new-agent-folder>
git commit -m "Add deliverables folder for <New Agent>"
git push
```

### 3. Update Documentation

- Add agent to this guide
- Add agent to relevant operator guide
- Update README if needed

---

## Troubleshooting

### Agent Can't Find Context

Ensure the agent has access to documentation:
```bash
claude "Read the docs in docs/ folder first, then help me with issue #<NUM>"
```

### Conflicting Edits

If two agents edited the same file:
```bash
git status  # Check conflicts
git diff    # Review changes
# Manually resolve, then:
git add <file>
git commit -m "Resolve merge conflict in <file>"
```

### Agent Lost Track of Task

Resume with context:
```bash
claude "Continue working on issue #<NUM> (<TICKET>). Check git status to see what's already done."
```

### Wrong Agent Assigned

Update in GitHub UI or via CLI:
```bash
# Get item ID first
gh project item-list <PROJECT_NUMBER> --owner joshuabl97 --format json | \
  jq -r '.items[] | select(.content.number == <ISSUE_NUM>) | .id'

# Then update
gh project item-edit --project-id "<PROJECT_ID>" --id "<ITEM_ID>" \
  --field-id "<AGENT_FIELD_ID>" --single-select-option-id "<NEW_AGENT_OPTION_ID>"
```

---

## Quick Reference

| Task | Command |
|------|---------|
| List agents | `gh project field-list <NUM> --owner joshuabl97 --format json \| jq '.fields[] \| select(.name == "Agent")'` |
| Tickets by agent | See "Monitoring Agent Progress" section |
| Start GTM agent | `cd ~/Code/gym-genius-ops && claude "..."` |
| Start Dev agent | `cd ~/Code/<repo> && claude "..."` |
| Close ticket | `gh issue close <NUM> --repo joshuabl97/<repo>` |
| Create agent view | Project Board → New View → Board → Column: Agent |

---

## Related Documents

- [GTM Operator Guide](OPERATOR_GUIDE.md) - GTM ticket workflow
- [Gym Vision Operator Guide](GYM_VISION_OPERATOR_GUIDE.md) - Development ticket workflow
- [README](README.md) - Repository overview
