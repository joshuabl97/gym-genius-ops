# Gym Genius GTM - Dual-Track Operator Guide

This guide walks you through executing the EU-first GTM strategy using 2-3 concurrent Claude Code agents.

**Last Updated:** 2025-12-20

---

## Strategy Overview

### Dual-Track Development

| Track | Priority | Focus |
|-------|----------|-------|
| **Equipment Utilization (EU)** | PRIMARY | B2B analytics for gym operators - ship for revenue |
| **Workout Tracking (WT)** | SECONDARY | Member experience - build for fun, future upsell |

### Decision Flowchart

```
Is the task EU-related?
├── YES → Do it now (PRIMARY)
└── NO → Is it WT-related?
    ├── YES → Is EU work blocked or complete?
    │   ├── YES → Work on WT (fun project)
    │   └── NO → Defer, work on EU first
    └── NO → Evaluate priority
```

---

## Current State

### Project Boards
| Board | Purpose | Tickets |
|-------|---------|---------|
| [Gym Vision Development](https://github.com/users/joshuabl97/projects/1) | Technical (EU-*, WT-*, DASH-*) | ~29 |
| [Gym Genius GTM Strategy](https://github.com/users/joshuabl97/projects/2) | Business development | ~24 |

### Labels for Filtering
| Label | Meaning |
|-------|---------|
| `track:eu-gtm` | Equipment Utilization GTM work |
| `track:wt-future` | Workout Tracking (future/secondary) |
| `status:needs-update` | Content needs EU strategy update |

---

## EU-First Batch Order

### Batch 1: Foundation (Start Here)
| Terminal | Issue | Ticket | Notes |
|----------|-------|--------|-------|
| 1 | #44 | GTM-001: EU Value Proposition | Core sales document |
| 2 | #42 | GTM-004: EU Pricing Sheet | Needed for sales |
| 3 | #9 | INVESTOR-002: Financial Model | Update for EU economics |

### Batch 2: Sales Enablement
| Terminal | Issue | Ticket | Notes |
|----------|-------|--------|-------|
| 1 | #40 | GTM-002: EU Sales Playbook | Outreach templates |
| 2 | #34 | PARTNER-001: Partnership Deck | Update for EU focus |
| 3 | #35 | PARTNER-002: Pilot Program | EU pilot structure |

### Batch 3: Investor Prep
| Terminal | Issue | Ticket | Notes |
|----------|-------|--------|-------|
| 1 | #8 | INVESTOR-001: Pitch Deck | Reframe for EU-first |
| 2 | #10 | INVESTOR-003: Equinox Prep | EU pilot pitch |
| 3 | #12 | INVESTOR-005: Elevator Pitch | Rewrite for EU |

### Batch 4: Research & Validation
| Terminal | Issue | Ticket | Notes |
|----------|-------|--------|-------|
| 1 | #14 | RESEARCH-002: Gym Owner Discovery | Expand EU questions |
| 2 | #13 | RESEARCH-001: Competitive Deep Dive | Add EU competitors |
| 3 | #21 | RESEARCH-009: Pricing & Unit Economics | Focus on EU |

### Batch 5: Cleanup
| Terminal | Issue | Ticket | Notes |
|----------|-------|--------|-------|
| 1 | #36 | PARTNER-003: Deployment Calculator | EU-only costs |
| 2 | #29 | BIZ-002: Budget & Runway | Update for EU model |

---

## Workflow: Running 2-3 Concurrent Agents

### Step 1: Open Terminal Windows

Open 2-3 separate terminal windows. Each runs an independent Claude Code session.

### Step 2: Start EU Batch

**Terminal 1 - GTM Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm working on the Gym Genius EU-first GTM Strategy. Help me complete issue #44 (GTM-001: EU Value Proposition Document). Read docs/ for context about Equipment Utilization focus. Create deliverables in deliverables/eu-sales/. When done, close the issue."
```

**Terminal 2 - Pricing Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm working on the Gym Genius EU-first GTM Strategy. Help me complete issue #42 (GTM-004: EU Pricing Sheet). Read docs/ for context. Create deliverables in deliverables/eu-sales/. When done, close the issue."
```

**Terminal 3 - Investor Agent:**
```bash
cd /home/josh/Code/gym-genius-ops
claude "I'm working on the Gym Genius EU-first GTM Strategy. Help me complete issue #9 (INVESTOR-002: Financial Model). Read docs/ for context. Update the model for EU unit economics. Create deliverables in deliverables/investor/. When done, close the issue."
```

### Step 3: Monitor Progress

Check remaining EU tickets:
```bash
gh issue list --repo joshuabl97/gym-genius-ops --state open --label "track:eu-gtm"
```

Check which need content updates:
```bash
gh issue list --repo joshuabl97/gym-genius-ops --state open --label "status:needs-update"
```

### Step 4: After Each Ticket Completes

1. **Review the deliverable** in `deliverables/<folder>/`
2. **Commit and push:**
   ```bash
   git add deliverables/
   git commit -m "Add deliverable for <TICKET-ID>"
   git push
   ```
3. **Start the next ticket** from batch order

---

## When to Work on Workout Tracking

WT is the secondary/passion track. Work on it when:

1. **EU work is blocked** (waiting on external input, hardware, etc.)
2. **You want a fun coding break** from business tasks
3. **EU MVP is feature-complete** and you're ahead of sales

### WT Tickets (gym-vision repo)
```bash
gh issue list --repo joshuabl97/gym-vision --state open --label "track:wt"
```

### WT Quick Start
```bash
cd /home/josh/Code/gym-vision
claude "I'm working on Workout Tracking for fun. Help me with WT-001 (Exercise Detection). This is secondary to EU work but I want to make progress on the tech."
```

---

## Quick Reference Commands

### EU GTM tickets
```bash
gh issue list --repo joshuabl97/gym-genius-ops --state open --label "track:eu-gtm"
```

### EU technical tickets
```bash
gh issue list --repo joshuabl97/gym-vision --state open --label "track:eu"
```

### WT tickets (secondary)
```bash
gh issue list --repo joshuabl97/gym-vision --state open --label "track:wt"
```

### View project board
Open https://github.com/users/joshuabl97/projects/2 for GTM tickets.

---

## Folder Structure

```
gym-genius-ops/
├── docs/
│   ├── gym_genius_action_plan.md      # EU-first strategy
│   ├── gym_genius_strategic_questions.md  # Business decisions
│   └── gym_genius_executive_summary.md    # Overview
├── deliverables/
│   ├── eu-sales/      # EU value prop, pricing, sales playbook
│   ├── investor/      # Pitch deck, financial model
│   ├── partner/       # Partnership materials, pilot docs
│   └── research/      # Market research, competitive analysis
├── scripts/
│   └── update-project-fields.sh
├── OPERATOR_GUIDE.md  # This file
└── README.md
```

---

## Tips

1. **EU first, always** - Unless EU work is blocked, prioritize EU tickets
2. **WT is for fun** - Don't feel guilty about WT work, it's a passion project
3. **Context in docs/** - Agents read strategy docs for context. Keep them updated.
4. **Tickets marked `status:needs-update`** need content rewritten for EU focus
5. **Simpler demo for EU** - EU demo is easier than WT (no multi-person tracking needed)

---

## Getting Help

- **Claude Code issues:** https://github.com/anthropics/claude-code/issues
- **GTM Project board:** https://github.com/users/joshuabl97/projects/2
- **Technical Project board:** https://github.com/users/joshuabl97/projects/1
- **Strategy docs:** See `docs/` folder

---

*Strategy: Ship EU for revenue, build WT for fun.*
