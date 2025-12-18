# Gym Genius GTM - Operator Guide

This guide walks you through executing the GTM strategy using 2-3 concurrent Claude Code agents.

**Last Updated:** 2025-12-18

---

## Current State

### Project Overview
- **Repository:** [gym-genius-ops](https://github.com/joshuabl97/gym-genius-ops)
- **Project Board:** [Gym Genius GTM Strategy](https://github.com/users/joshuabl97/projects/2)
- **Total Tickets:** 39
- **Critical/High Priority:** 17 (assigned to agents)
- **Medium/Low Priority:** 22 (unassigned)

### Ticket Status
| Status | Count |
|--------|-------|
| Todo | 38 |
| In Progress | 1 (#14 RESEARCH-002) |
| Done | 0 |

### Agent Assignments
| Agent | Tickets | Focus |
|-------|---------|-------|
| **Research Agent** | #14, #16, #17, #18, #19, #21, #24 | Customer discovery, market research, unit economics |
| **Investor Agent** | #8, #10, #11, #12 | Pitch deck, VC prep, Equinox prep |
| **Partner Agent** | #34, #35 | Gym partnership materials, pilot program |
| **Demo Agent** | #1, #2, #4, #5 | Lab setup, hardware, video content |

---

## Workflow: Running 2-3 Concurrent Agents

### Step 1: Open Terminal Windows

Open 2-3 separate terminal windows or tabs. Each will run an independent Claude Code session.

### Step 2: Start Batch 1 (First Priority)

**Terminal 1 - Research Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm working on the Gym Genius GTM Strategy. Help me complete issue #21 (RESEARCH-009: Pricing, Tiers & Unit Economics). Read the docs in docs/ for context about the business model and strategic decisions. Create deliverables in deliverables/research/. When done, close the issue with: gh issue close 21"
```

**Terminal 2 - Investor Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm working on the Gym Genius GTM Strategy. Help me complete issue #8 (INVESTOR-001: Pitch Deck). Read the docs in docs/ for context - especially the executive summary and strategic questions. Create deliverables in deliverables/investor/. When done, close the issue with: gh issue close 8"
```

**Terminal 3 - Partner Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm working on the Gym Genius GTM Strategy. Help me complete issue #34 (PARTNER-001: Gym Partnership Deck). Read the docs in docs/ for context about target gyms and value props. Create deliverables in deliverables/partner/. When done, close the issue with: gh issue close 34"
```

### Step 3: Monitor Progress

Switch between terminals to check progress. Each agent works independently.

**Check remaining tickets:**
```bash
gh issue list --repo joshuabl97/gym-genius-ops --state open --label "priority:critical" --label "priority:high"
```

**View project board:**
Open https://github.com/users/joshuabl97/projects/2 and use the "By Agent" view.

### Step 4: After Each Ticket Completes

When an agent finishes a ticket:

1. **Review the deliverable** in the appropriate `deliverables/` folder
2. **Close the issue** (agent should do this, or run manually):
   ```bash
   gh issue close <number> --repo joshuabl97/gym-genius-ops
   ```
3. **Commit the deliverable:**
   ```bash
   git add deliverables/
   git commit -m "Add deliverable for TICKET-NAME"
   git push
   ```
4. **Start the next ticket** in that terminal (see Batch Order below)

### Step 5: Continue with Next Batches

Once Batch 1 completes, start Batch 2, and so on.

---

## Batch Order

### Batch 1 (Start Here)
| Terminal | Issue | Ticket |
|----------|-------|--------|
| 1 | #21 | RESEARCH-009: Pricing, Tiers & Unit Economics |
| 2 | #8 | INVESTOR-001: Pitch Deck |
| 3 | #34 | PARTNER-001: Gym Partnership Deck |

### Batch 2
| Terminal | Issue | Ticket |
|----------|-------|--------|
| 1 | #14 | RESEARCH-002: Gym Owner Customer Discovery |
| 2 | #10 | INVESTOR-003: Equinox-Specific Prep |
| 3 | #35 | PARTNER-002: Pilot Program Structure |

### Batch 3
| Terminal | Issue | Ticket |
|----------|-------|--------|
| 1 | #16 | RESEARCH-004: Deployment Model Research |
| 2 | #11 | INVESTOR-004: VC Meeting Prep |
| 3 | #1 | DEMO-001: Lab Space Setup |

### Batch 4
| Terminal | Issue | Ticket |
|----------|-------|--------|
| 1 | #17 | RESEARCH-005: Target Segment Analysis |
| 2 | #12 | INVESTOR-005: Elevator Pitch & Founder Story |
| 3 | #2 | DEMO-002: Hardware Finalization |

### Batch 5
| Terminal | Issue | Ticket |
|----------|-------|--------|
| 1 | #18 | RESEARCH-006: Demo Lab Cost Analysis |
| 2 | #19 | RESEARCH-007: Platform vs White-Label Validation |
| 3 | #4 | CONTENT-001: Demo Video Concept |

### Batch 6
| Terminal | Issue | Ticket |
|----------|-------|--------|
| 1 | #24 | RESEARCH-012: Moat & Defensibility Strategy |
| 2 | #5 | CONTENT-002: Video Production |

---

## Quick Reference Commands

### Start a new agent session
```bash
cd /home/josh/Code/gym-genius-ops
claude "Help me complete issue #<NUMBER> (<TICKET-ID>: <TITLE>). Read docs/ for context. Create deliverables in deliverables/<folder>/. Close the issue when done."
```

### Check open high-priority tickets
```bash
gh issue list --repo joshuabl97/gym-genius-ops --state open --label "priority:high"
```

### Check tickets by agent
```bash
gh project item-list 2 --owner joshuabl97 --limit 50 --format json | jq -r '.items | group_by(.agent) | .[] | "\n\(.[0].agent // "Unassigned"):", (.[] | "  #\(.content.number): \(.title)")'
```

### Sync project fields after label changes
```bash
/home/josh/Code/gym-genius-ops/scripts/update-project-fields.sh
```

### View deliverables
```bash
ls -la deliverables/*/
```

---

## Folder Structure

```
gym-genius-ops/
├── docs/
│   ├── gym_genius_action_plan.md      # Full ticket breakdown
│   ├── gym_genius_strategic_questions.md  # 30 Q&A shaping strategy
│   └── gym_genius_executive_summary.md    # One-pager overview
├── deliverables/
│   ├── research/     # Research agent outputs
│   ├── investor/     # Investor agent outputs
│   ├── partner/      # Partner agent outputs
│   └── content/      # Content/demo agent outputs
├── scripts/
│   └── update-project-fields.sh  # Sync labels to project fields
├── OPERATOR_GUIDE.md  # This file
└── README.md
```

---

## Tips

1. **Let agents work autonomously** - Don't interrupt unless they ask questions
2. **Review before committing** - Check deliverables make sense before pushing
3. **Use the project board** - The "By Agent" view shows workload at a glance
4. **Dependent tickets** - Some tickets (like #10, #11) depend on earlier work (#8). The batch order accounts for this.
5. **Context matters** - Agents read `docs/` for context. Keep those files updated.

---

## Getting Help

- **Claude Code issues:** https://github.com/anthropics/claude-code/issues
- **Project board:** https://github.com/users/joshuabl97/projects/2
- **Strategy docs:** See `docs/` folder
