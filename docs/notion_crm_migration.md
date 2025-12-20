# Notion CRM Migration Guide

Migration guide for setting up Notion CRM and moving GTM tickets from GitHub.

**Created:** 2025-12-20
**Status:** In Progress

---

## Migration Strategy

### Decision: Migrate GTM to Notion (Don't Sync)

| System | Purpose | What Lives Here |
|--------|---------|-----------------|
| **GitHub** | Dev work only | EU-*, WT-*, DASH-* technical tickets |
| **Notion** | Business + CRM | GTM, INVESTOR, RESEARCH, PARTNER, BIZ, CONTENT |

### Why Migrate Instead of Sync

- CRM is in Notion—GTM tickets are tightly coupled with sales/customers
- Syncing creates maintenance overhead with little benefit
- GTM work needs rich docs, strategy pages, flexible views (Notion excels)
- GitHub's strength is code proximity—business tickets don't need this
- Cost: Sync tools cost $30-100/mo; manual linking is free

---

## Phase 1: Notion Workspace Structure

```
Gym Genius HQ
├── CRM
│   ├── Gyms (companies/accounts)
│   ├── Contacts (gym owners, decision makers)
│   ├── Deals (sales pipeline)
│   └── Activities (calls, emails, meetings)
├── GTM Initiatives
│   ├── All GTM tickets (migrated from GitHub)
│   └── Views: By Workstream, By Priority, Timeline
├── Sales Assets
│   ├── Deliverables (pitch deck, pricing, case studies)
│   └── Templates
├── Research & Learning
│   └── Competitive analysis, discovery notes
└── Dev Dashboard
    └── GitHub synced database (view-only)
```

---

## Phase 1: Database Schemas

### 1. Gyms Database (Companies)

| Property | Type | Options/Notes |
|----------|------|---------------|
| Gym Name | Title | Primary identifier |
| Status | Select | Lead, Contacted, Qualified, Pilot, Customer, Lost |
| Pipeline Stage | Select | Prospecting, Discovery, Demo, Proposal, Negotiating, Pilot Active, Closed Won, Closed Lost |
| Deal Value (Annual) | Number | Currency, e.g., $6,000 |
| Gym Type | Select | Big Box, Boutique, CrossFit, Regional Chain, University Rec, Corporate |
| Location | Text | City, State |
| Member Count | Select | <100, 100-300, 300-500, 500-1000, 1000+ |
| Equipment Count | Number | For EU value prop |
| Website | URL | |
| Primary Contact | Relation | → Contacts |
| All Contacts | Relation | → Contacts |
| Deals | Relation | → Deals |
| Activities | Relation | → Activities |
| Last Contact | Rollup | Latest date from Activities |
| Total Activities | Rollup | Count from Activities |
| Pain Points | Multi-select | Equipment ROI, Peak Crowding, Layout Guesswork, Member Churn |
| Current Software | Text | Mindbody, Zen Planner, etc. |
| Lead Source | Select | Cold Outreach, Referral, LinkedIn, Equinox Intro, Trade Show |
| Decision Timeline | Select | Immediate, 1-3 months, 3-6 months, 6+ months |
| Priority | Select | High, Medium, Low |
| Notes | Text | Key info, context |

### 2. Contacts Database

| Property | Type | Options/Notes |
|----------|------|---------------|
| Name | Title | Full name |
| Gym | Relation | → Gyms |
| Role | Select | Owner, GM, Operations Manager, Facilities Manager, Trainer |
| Email | Email | |
| Phone | Phone | |
| LinkedIn | URL | |
| Decision Maker | Checkbox | Is this person the decision maker? |
| Champion | Checkbox | Is this person our internal champion? |
| Preferred Contact | Select | Email, Phone, Text, LinkedIn |
| Last Contact | Date | |
| Next Follow-up | Date | |
| Relationship | Select | Cold, Warm, Hot |
| Notes | Text | Personal details, conversation notes |
| Activities | Relation | → Activities |

### 3. Deals Database (Sales Pipeline)

| Property | Type | Options/Notes |
|----------|------|---------------|
| Deal Name | Title | "Gym Name - EU Pilot" |
| Gym | Relation | → Gyms |
| Primary Contact | Relation | → Contacts |
| Stage | Select | Lead, Discovery, Demo Scheduled, Demo Completed, Proposal Sent, Negotiating, Pilot Active, Closed Won, Closed Lost |
| Monthly Value | Number | $500-800 typical |
| Annual Value | Formula | Monthly Value × 12 |
| Probability | Select | 10%, 25%, 50%, 75%, 90%, 100% |
| Weighted Value | Formula | Annual Value × Probability |
| Expected Close | Date | |
| Actual Close | Date | |
| Created Date | Created time | Auto |
| Days in Pipeline | Formula | Days since created |
| Product | Select | EU Only, EU + WT, Custom |
| Contract Length | Select | Monthly, Quarterly, Annual |
| Next Step | Text | Clear next action |
| Lost Reason | Select | Price, No Budget, Timing, Competitor, No Response, Not a Fit |
| Activities | Relation | → Activities |
| Notes | Text | |

### 4. Activities Database

| Property | Type | Options/Notes |
|----------|------|---------------|
| Activity | Title | Brief description |
| Gym | Relation | → Gyms |
| Contact | Relation | → Contacts |
| Deal | Relation | → Deals |
| Type | Select | Call, Email, Meeting, Demo, Proposal, Follow-up, LinkedIn |
| Date | Date | When it happened |
| Duration | Number | Minutes |
| Direction | Select | Inbound, Outbound |
| Outcome | Select | Positive, Neutral, Negative, No Response |
| Demo Completed | Checkbox | |
| Pricing Shared | Checkbox | |
| Next Steps | Text | What was agreed |
| Notes | Text | Detailed notes |

### 5. GTM Initiatives Database

| Property | Type | Options/Notes |
|----------|------|---------------|
| Initiative | Title | Ticket title from GitHub |
| Workstream | Select | GTM, INVESTOR, RESEARCH, PARTNER, BIZ, CONTENT, DEMO |
| Status | Select | Not Started, In Progress, Blocked, Done |
| Priority | Select | Critical, High, Medium, Low |
| Track | Select | EU (Primary), WT (Future) |
| GitHub Issue | URL | Original issue link (for reference) |
| Related Deals | Relation | → Deals |
| Deliverable | Files/URL | Output document |
| Due Date | Date | |
| Notes | Text | |

---

## Phase 2: GTM Tickets to Migrate

### Open Tickets (24 total)

**GTM Workstream (5 tickets):**
- [ ] #44 GTM-001: EU Value Proposition Document (priority:high)
- [ ] #40 GTM-002: EU Sales Playbook (priority:high)
- [ ] #41 GTM-003: EU Case Study Template (priority:medium)
- [ ] #42 GTM-004: EU Pricing Sheet (priority:high)
- [ ] #43 GTM-005: Workout Tracking Teaser (priority:low, track:wt-future)

**INVESTOR Workstream (4 tickets):**
- [ ] #8 INVESTOR-001: Pitch Deck (priority:high, needs-update)
- [ ] #9 INVESTOR-002: Financial Model (priority:medium)
- [ ] #10 INVESTOR-003: Equinox-Specific Prep (priority:high, needs-update)
- [ ] #11 INVESTOR-004: VC Meeting Prep (priority:high)
- [ ] #12 INVESTOR-005: Elevator Pitch & Founder Story (priority:high, needs-update)

**RESEARCH Workstream (7 tickets):**
- [ ] #13 RESEARCH-001: Competitive Deep Dive (priority:medium)
- [ ] #14 RESEARCH-002: Gym Owner Customer Discovery (priority:critical, in-progress)
- [ ] #16 RESEARCH-004: Deployment Model Research (priority:high)
- [ ] #17 RESEARCH-005: Target Segment Analysis (priority:high)
- [ ] #21 RESEARCH-009: Pricing, Tiers & Unit Economics (priority:high)
- [ ] #23 RESEARCH-011: Privacy Messaging & Visual Indicators (priority:medium)
- [ ] #25 RESEARCH-013: Regulatory & Compliance (priority:low)
- [ ] #26 RESEARCH-014: Data Retention Policy (priority:low)

**PARTNER Workstream (3 tickets):**
- [ ] #34 PARTNER-001: Gym Partnership Deck (priority:high, needs-update)
- [ ] #35 PARTNER-002: Pilot Program Structure (priority:high, needs-update)
- [ ] #36 PARTNER-003: Deployment Budget Calculator (priority:medium, needs-update)

**BIZ Workstream (4 tickets):**
- [ ] #28 BIZ-001: Entity Formation (priority:medium)
- [ ] #29 BIZ-002: Budget & Runway Planning (priority:medium)
- [ ] #31 BIZ-004: Sales Compensation Model (priority:medium)
- [ ] #32 BIZ-005: CRM & Pipeline Tracking (priority:medium) ← This one is being done now!

**DEMO Workstream (1 ticket):**
- [ ] #1 DEMO-001: Lab Space Setup (priority:critical)
- [ ] #2 DEMO-002: Hardware Finalization (priority:high)

**CONTENT Workstream (2 tickets):**
- [ ] #4 CONTENT-001: Demo Video Concept (priority:high)
- [ ] #5 CONTENT-002: Video Production (priority:high)

### Closed Tickets (15 total) - Archive in Notion

Already closed as "Deprioritized for EU-first strategy":
- #3, #6, #7, #15, #18, #19, #20, #22, #24, #27, #30, #33, #37, #38, #39

---

## Phase 3: GitHub Integration

### Native Notion-GitHub Integration (Free)

1. **Connect GitHub to Notion**
   - Notion workspace owner + GitHub org admin required
   - Settings → Connections → GitHub → Authorize

2. **Create Synced Database**
   - Add new database → GitHub → Select repos
   - Repos to sync: gym-vision, gym-genius, gym-vision-web, gym-vision-inference

3. **What Syncs:**
   - Pull requests with status (Opened, Review Requested, Approved, Merged)
   - Issues (basic info)
   - Repository metadata

4. **Limitations:**
   - Labels don't sync (known limitation)
   - Primarily one-way (GitHub → Notion)
   - Custom fields from Projects V2 don't sync

### Lightweight Manual Linking

When GTM work requires dev:
1. Create GitHub issue in appropriate repo
2. Copy GitHub issue URL
3. Paste in Notion GTM Initiative "Related GitHub Issues" property
4. In GitHub issue description, add: `Business Context: [Notion page URL]`

---

## Views to Create

### CRM Views

**Gyms Database:**
- Table: All Gyms
- Kanban: By Pipeline Stage
- Kanban: By Status
- Table: Follow-up Needed (Last Contact > 7 days)
- Table: High Priority

**Deals Database:**
- Kanban: Pipeline (by Stage)
- Table: This Month's Forecast (Expected Close in current month)
- Table: Won Deals

**Activities Database:**
- Calendar: All Activities
- Table: This Week
- Table: By Gym

### GTM Views

**GTM Initiatives:**
- Table: All Initiatives
- Kanban: By Status
- Kanban: By Workstream
- Table: High Priority
- Table: Needs Update (status:needs-update tag)

---

## Dashboard Pages

### Sales Dashboard
- Pipeline Kanban (Deals by Stage)
- Follow-up Needed (Gyms needing contact)
- This Week's Activities (Calendar)
- Key Metrics (Total Pipeline Value, Deals by Stage)

### GTM Dashboard
- Active Initiatives (In Progress)
- By Workstream breakdown
- Upcoming Deadlines

### Dev Dashboard
- GitHub Synced Database (gym-vision PRs)
- Link to GitHub Projects

---

## Migration Checklist

### Phase 1: Create Notion Workspace
- [ ] Create workspace (or use existing)
- [ ] Create Gyms database with all properties
- [ ] Create Contacts database with all properties
- [ ] Create Deals database with all properties
- [ ] Create Activities database with all properties
- [ ] Create GTM Initiatives database with all properties
- [ ] Set up all Relations between databases
- [ ] Set up Rollups (Last Contact, Total Activities, etc.)
- [ ] Create CRM views (Pipeline Kanban, etc.)
- [ ] Create GTM views (By Workstream, etc.)
- [ ] Create Dashboard pages

### Phase 3: GitHub Integration
- [ ] Connect GitHub to Notion
- [ ] Create synced database for key repos
- [ ] Add to Dev Dashboard page
- [ ] Test link preview works

### Phase 2: Migrate GTM Tickets
- [ ] Create GTM Initiatives in Notion for each open ticket
- [ ] Copy ticket descriptions and context
- [ ] Set correct workstream, priority, status
- [ ] Add GitHub issue URL for reference
- [ ] Close GitHub issues with migration comment
- [ ] Update gym-genius-ops README to reflect new workflow

---

## Cost Summary

| Tool | Cost | Notes |
|------|------|-------|
| Notion | $0 | Free personal plan |
| GitHub | $0 | Already using |
| Sync tools | $0 | Manual linking for now |
| **Total** | **$0/month** | |

Future optional: Make.com free tier or n8n self-hosted

---

## iOS App

Notion iOS app provides:
- Full CRM access on mobile
- Log activities on the go
- Update deal stages
- Quick contact lookup before calls
- Push notifications for reminders

---

*Last updated: 2025-12-20*
