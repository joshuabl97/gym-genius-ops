# Gym Genius Ops

Operations repository for Gym Genius - Equipment Utilization Analytics with future Workout Tracking.

## Strategy: Dual-Track Development

| Track | Focus | Priority |
|-------|-------|----------|
| **Equipment Utilization (EU)** | B2B analytics for gym operators | PRIMARY |
| **Workout Tracking (WT)** | Member experience, future upsell | SECONDARY |

## Where Things Live

| System | What's There |
|--------|--------------|
| **Notion** | CRM, GTM tickets, sales pipeline, business operations |
| **GitHub** | Dev tickets only (EU-*, WT-*, DASH-*) |

### GitHub (Dev Only)
| Board | Purpose |
|-------|---------|
| [Gym Vision Development](https://github.com/users/joshuabl97/projects/1) | Technical tickets (EU-*, WT-*, DASH-*) |

### Notion (Business + CRM)
- Sales Pipeline (Gyms, Contacts, Deals)
- GTM Initiatives (migrated from GitHub)
- Activities tracking
- Business operations

## Guides

| Guide | Purpose |
|-------|---------|
| [Operator Guide](OPERATOR_GUIDE.md) | How to work on EU (primary) and WT (secondary) |
| [Agent Setup Guide](AGENT_SETUP_GUIDE.md) | Claude Code agent configuration |
| [Notion CRM Setup](docs/notion_setup_steps.md) | CRM database setup instructions |

## Strategy Documents

| Document | Purpose |
|----------|---------|
| [Action Plan](docs/gym_genius_action_plan.md) | EU-first GTM strategy |
| [Strategic Questions](docs/gym_genius_strategic_questions.md) | Business decisions and rationale |
| [Executive Summary](docs/gym_genius_executive_summary.md) | One-pager overview |

## Related Repositories

| Repo | Purpose |
|------|---------|
| [gym-genius](https://github.com/joshuabl97/gym-genius) | Backend API |
| [gym-vision](https://github.com/joshuabl97/gym-vision) | ML/CV library (EU + WT) |
| [gym-vision-web](https://github.com/joshuabl97/gym-vision-web) | Dashboard (EU + WT tabs) |
| [gym-vision-inference](https://github.com/joshuabl97/gym-vision-inference) | Inference service |

---

*Strategy: Ship EU for revenue, build WT for fun.*
