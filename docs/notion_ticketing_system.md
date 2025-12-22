# Notion Ticketing System

Single unified database for all workstream tickets.

**Created:** 2025-12-20
**Status:** Complete

---

## Architecture

```
Gym Genius HQ (Workspace)
│
├── Workstream Tickets (parent page)
│   ├── All Tickets (single database)
│   ├── Submit Ticket (instructions page)
│   └── GTM Dashboard (views page)
│
├── CRM
│   ├── Gyms
│   ├── People (Contacts)
│   ├── Deals
│   └── Activities
│
└── Archive
    └── Old databases (archived)
```

---

## All Tickets Database

**URL:** `https://www.notion.so/2cf94de25d4d815890c6e080d62bfa7c`

### Properties

| Property | Type | Description |
|----------|------|-------------|
| Initiative | Title | Ticket name |
| ID | Text | Manual ID (GTM-6, INVESTOR-3, etc.) |
| Workstream | Select | GTM, INVESTOR, RESEARCH, PARTNER, BIZ, DEMO, CONTENT |
| Priority | Select | Critical, High, Medium, Low |
| Status | Select | Not Started, In Progress, Blocked, Done |
| Track | Select | EU (Primary), WT (Future) |
| Due Date | Date | When it's needed |
| Github Issue | URL | Link to related GitHub issue (if any) |
| Notes | Text | Additional context |

### Page Content (per ticket)

Each ticket page contains:
- **Deliverables** - To-do checkboxes for what will be produced
- **Acceptance Criteria** - To-do checkboxes for how to know it's done

---

## Creating New Tickets

1. Open **All Tickets** database
2. Click **+ New**
3. Fill in:
   - **Initiative**: Ticket title
   - **ID**: Check existing tickets for highest number in that workstream, use next number (e.g., GTM-6)
   - **Workstream**: Select appropriate category
   - **Priority**: Critical/High/Medium/Low
   - **Status**: Defaults to "Not Started"
   - **Track**: EU (Primary) or WT (Future)
4. In the page body, add:
   - Deliverables as to-do items
   - Acceptance Criteria as to-do items

### ID Format

IDs are manually set in format: `WORKSTREAM-NUMBER`

| Workstream | Current Max | Next ID |
|------------|-------------|---------|
| GTM | 5 | GTM-6 |
| INVESTOR | 5 | INVESTOR-6 |
| RESEARCH | 8 | RESEARCH-9 |
| PARTNER | 3 | PARTNER-4 |
| BIZ | 4 | BIZ-5 |
| DEMO | 2 | DEMO-3 |
| CONTENT | 2 | CONTENT-3 |

---

## Recommended Views

Create these views in the All Tickets database:

| View Name | Type | Configuration |
|-----------|------|---------------|
| All Tickets | Table | Default, sort by ID |
| By Status | Board | Group by Status |
| By Priority | Board | Group by Priority |
| By Workstream | Board | Group by Workstream |
| Active | Table | Filter: Status != Done |
| Critical | Table | Filter: Priority = Critical |

---

## Workstream Descriptions

| Workstream | Purpose |
|------------|---------|
| **GTM** | Sales playbooks, pricing, case studies, value proposition |
| **INVESTOR** | Pitch deck, financial model, VC meeting prep |
| **RESEARCH** | Customer discovery, competitive analysis, pricing research |
| **PARTNER** | Gym partnerships, pilot programs, deployment |
| **BIZ** | Entity formation, budget, compensation, legal |
| **DEMO** | Lab space, hardware, demo environment |
| **CONTENT** | Demo videos, marketing content |

---

## Database ID Reference

| Item | ID |
|------|-----|
| Workstream Tickets (parent page) | `2cf94de2-5d4d-8035-9896-e1f0ed573f1e` |
| All Tickets | `2cf94de2-5d4d-8158-90c6-e080d62bfa7c` |
| Submit Ticket page | `2cf94de2-5d4d-81c4-9f21-fb7e9238c614` |

### Archived Databases

These databases are archived and should not be used:
- GTM Tickets: `2cf94de2-5d4d-810a-874c-c098d0275b94`
- INVESTOR Tickets: `2cf94de2-5d4d-816c-92c1-f7072ffc6289`
- RESEARCH Tickets: `2cf94de2-5d4d-81a9-85b6-d9ab578647c0`
- PARTNER Tickets: `2cf94de2-5d4d-81af-9f16-e830ae80a41e`
- BIZ Tickets: `2cf94de2-5d4d-810c-b83f-fd42641c5242`
- CONTENT Tickets: `2cf94de2-5d4d-816d-935f-d6216a1cfacc`
- DEMO Tickets: `2cf94de2-5d4d-8169-8b83-e405b1fe8dc2`

---

*Last updated: 2025-12-20*
