# Gym Genius Ops - Project Context

## Strategy: EU-First, WT-Secondary

| Track | Priority | Focus |
|-------|----------|-------|
| **Equipment Utilization (EU)** | PRIMARY | B2B analytics for gym operators |
| **Workout Tracking (WT)** | SECONDARY | Member experience (future upsell) |

## Key Documents (Read These First)
- `docs/gym_genius_executive_summary.md` - EU-first overview
- `docs/gym_genius_strategic_questions.md` - Business decisions
- `docs/gym_genius_action_plan.md` - EU/WT ticket breakdown

## Business Context
- **EU Target Market:** Regional gym chains, premium independents
- **EU Business Model:** Hardware lease (~$200-300/mo) + Software (~$300-500/mo)
- **EU Value Prop:** Equipment ROI, utilization insights, capacity planning
- **EU Privacy:** No individual tracking, just zone occupancy
- **WT Status:** Secondary track, build for fun when EU is blocked

## Project Structure
```
gym-genius-ops/
├── docs/                  # Strategy documents
├── deliverables/
│   ├── eu-sales/         # EU value prop, pricing, sales playbook
│   ├── research/         # Research Agent outputs
│   ├── investor/         # Investor Agent outputs
│   └── partner/          # Partner Agent outputs
├── knowledge/            # Shared knowledge base
└── scripts/              # Agent startup scripts
```

## Working Conventions
- Create deliverables in `deliverables/<your-agent-folder>/`
- Update `LEARNINGS.md` after completing tasks
- Update ticket status in Notion when done (use MCP tools)
- Commit deliverables after completion

## Notion (Primary)
All tickets, CRM, and documentation are managed in Notion:
- **Tickets Board:** https://www.notion.so/2cf94de25d4d81c8b1afd31631fb5730?v=2cf94de25d4d8082bcfa000c55fefdee
- **Wiki:** https://notion.so/2cf94de2-5d4d-81f0-9890-d7302b3365d4
- **Tickets Database ID:** `2cf94de2-5d4d-81c8-b1af-d31631fb5730`

Use Notion MCP tools to query and update tickets. See `AGENT_SETUP_GUIDE.md` for database IDs.
