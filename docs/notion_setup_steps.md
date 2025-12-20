# Notion CRM Setup: Step-by-Step Guide

Complete walkthrough for setting up Gym Genius CRM and GTM workspace in Notion.

**Time Required:** ~45 minutes
**Cost:** Free (Notion personal plan)

---

## Before You Start

1. Go to [notion.so](https://notion.so) and sign up/login
2. Create a new workspace called "Gym Genius HQ" (or use existing)
3. You'll need the Notion desktop or web app (not mobile) for initial setup

---

## Step 1: Create the Gyms Database (15 min)

This is your core CRM database for tracking gym prospects and customers.

### 1.1 Create the Database

1. Click `+ New page` in the sidebar
2. Name it "Gyms"
3. Select "Database - Full page"
4. Choose "Table" view

### 1.2 Add Properties

Delete the default properties and add these (click `+` in the header row):

| Property Name | Type | Configuration |
|---------------|------|---------------|
| Gym Name | Title | (default, already exists) |
| Status | Select | Options: `Lead`, `Contacted`, `Qualified`, `Pilot`, `Customer`, `Lost` |
| Pipeline Stage | Select | Options: `Prospecting`, `Discovery`, `Demo`, `Proposal`, `Negotiating`, `Pilot Active`, `Closed Won`, `Closed Lost` |
| Deal Value (Annual) | Number | Format: US Dollar |
| Gym Type | Select | Options: `Big Box`, `Boutique`, `CrossFit`, `Regional Chain`, `University Rec`, `Corporate` |
| Location | Text | |
| Member Count | Select | Options: `<100`, `100-300`, `300-500`, `500-1000`, `1000+` |
| Equipment Count | Number | |
| Website | URL | |
| Pain Points | Multi-select | Options: `Equipment ROI`, `Peak Crowding`, `Layout Guesswork`, `Member Churn`, `Staffing` |
| Current Software | Text | |
| Lead Source | Select | Options: `Cold Outreach`, `Referral`, `LinkedIn`, `Equinox Intro`, `Trade Show`, `Inbound` |
| Decision Timeline | Select | Options: `Immediate`, `1-3 months`, `3-6 months`, `6+ months` |
| Priority | Select | Options: `High`, `Medium`, `Low` |
| Notes | Text | |

### 1.3 Create Views

Click `+ Add a view` next to the table name:

**View 1: Pipeline Board**
- Type: Board
- Group by: Pipeline Stage
- Useful for: Seeing deals flow through stages

**View 2: By Status**
- Type: Board
- Group by: Status
- Useful for: Quick status overview

**View 3: High Priority**
- Type: Table
- Filter: Priority = High
- Useful for: Focus on hot prospects

**View 4: Follow-up Needed**
- Type: Table
- Filter: (We'll add this after Activities relation is set up)
- Useful for: Daily outreach list

---

## Step 2: Create the Contacts Database (10 min)

Track individual people at each gym.

### 2.1 Create the Database

1. Click `+ New page` in sidebar
2. Name it "Contacts"
3. Select "Database - Full page"
4. Choose "Table" view

### 2.2 Add Properties

| Property Name | Type | Configuration |
|---------------|------|---------------|
| Name | Title | (default) |
| Role | Select | Options: `Owner`, `GM`, `Operations Manager`, `Facilities Manager`, `Trainer` |
| Email | Email | |
| Phone | Phone | |
| LinkedIn | URL | |
| Decision Maker | Checkbox | |
| Champion | Checkbox | |
| Preferred Contact | Select | Options: `Email`, `Phone`, `Text`, `LinkedIn` |
| Last Contact | Date | |
| Next Follow-up | Date | Include time: No |
| Relationship | Select | Options: `Cold`, `Warm`, `Hot` |
| Notes | Text | |

### 2.3 Create Views

**View 1: All Contacts** (default table)

**View 2: Decision Makers**
- Type: Table
- Filter: Decision Maker = Checked

**View 3: Needs Follow-up**
- Type: Table
- Filter: Next Follow-up is on or before Today
- Sort: Next Follow-up ascending

---

## Step 3: Create the Deals Database (10 min)

Track your sales pipeline and opportunities.

### 3.1 Create the Database

1. Click `+ New page` in sidebar
2. Name it "Deals"
3. Select "Database - Full page"
4. Choose "Table" view

### 3.2 Add Properties

| Property Name | Type | Configuration |
|---------------|------|---------------|
| Deal Name | Title | Format: "Gym Name - EU Pilot" |
| Stage | Select | Options: `Lead`, `Discovery`, `Demo Scheduled`, `Demo Completed`, `Proposal Sent`, `Negotiating`, `Pilot Active`, `Closed Won`, `Closed Lost` |
| Monthly Value | Number | Format: US Dollar |
| Probability | Select | Options: `10%`, `25%`, `50%`, `75%`, `90%`, `100%` |
| Expected Close | Date | |
| Actual Close | Date | |
| Product | Select | Options: `EU Only`, `EU + WT`, `Custom` |
| Contract Length | Select | Options: `Monthly`, `Quarterly`, `Annual` |
| Next Step | Text | |
| Lost Reason | Select | Options: `Price`, `No Budget`, `Timing`, `Competitor`, `No Response`, `Not a Fit` |
| Notes | Text | |

### 3.3 Add Formula Properties

**Annual Value:**
1. Add property → Formula
2. Name: "Annual Value"
3. Formula: `prop("Monthly Value") * 12`

**Days in Pipeline:**
1. Add property → Formula
2. Name: "Days in Pipeline"
3. Formula: `dateBetween(now(), prop("Created time"), "days")`

(Note: You'll need to add a "Created time" property first - Type: Created time)

### 3.4 Create Views

**View 1: Pipeline Board**
- Type: Board
- Group by: Stage
- Show properties: Monthly Value, Expected Close, Next Step
- This is your main sales view!

**View 2: This Month**
- Type: Table
- Filter: Expected Close is within "This month"
- Sort: Expected Close ascending

**View 3: Won Deals**
- Type: Table
- Filter: Stage = Closed Won
- Useful for: Case studies, reference customers

---

## Step 4: Create the Activities Database (5 min)

Log all interactions with gyms and contacts.

### 4.1 Create the Database

1. Click `+ New page` in sidebar
2. Name it "Activities"
3. Select "Database - Full page"
4. Choose "Table" view

### 4.2 Add Properties

| Property Name | Type | Configuration |
|---------------|------|---------------|
| Activity | Title | Brief description |
| Type | Select | Options: `Call`, `Email`, `Meeting`, `Demo`, `Proposal`, `Follow-up`, `LinkedIn` |
| Date | Date | Include time: Yes |
| Duration | Number | (minutes) |
| Direction | Select | Options: `Inbound`, `Outbound` |
| Outcome | Select | Options: `Positive`, `Neutral`, `Negative`, `No Response` |
| Demo Completed | Checkbox | |
| Pricing Shared | Checkbox | |
| Next Steps | Text | |
| Notes | Text | |

### 4.3 Create Views

**View 1: Calendar**
- Type: Calendar
- Date property: Date
- Useful for: Seeing schedule

**View 2: This Week**
- Type: Table
- Filter: Date is within "This week"
- Sort: Date descending

**View 3: Recent**
- Type: Table
- Sort: Date descending
- Limit: Show 20 items

---

## Step 5: Create the GTM Initiatives Database (5 min)

This replaces your GitHub GTM tickets.

### 5.1 Create the Database

1. Click `+ New page` in sidebar
2. Name it "GTM Initiatives"
3. Select "Database - Full page"
4. Choose "Table" view

### 5.2 Add Properties

| Property Name | Type | Configuration |
|---------------|------|---------------|
| Initiative | Title | Ticket name |
| Workstream | Select | Options: `GTM`, `INVESTOR`, `RESEARCH`, `PARTNER`, `BIZ`, `CONTENT`, `DEMO` |
| Status | Select | Options: `Not Started`, `In Progress`, `Blocked`, `Done` |
| Priority | Select | Options: `Critical`, `High`, `Medium`, `Low` |
| Track | Select | Options: `EU (Primary)`, `WT (Future)` |
| GitHub Issue | URL | Original issue link |
| Due Date | Date | |
| Notes | Text | |

### 5.3 Create Views

**View 1: Kanban by Status**
- Type: Board
- Group by: Status

**View 2: By Workstream**
- Type: Board
- Group by: Workstream

**View 3: High Priority**
- Type: Table
- Filter: Priority is `Critical` or `High`
- Sort: Priority (you may need to use Status)

---

## Step 6: Connect Databases with Relations (10 min)

This is where Notion becomes powerful - linking everything together.

### 6.1 Gyms ↔ Contacts

1. Open **Gyms** database
2. Add property → Relation
3. Select "Contacts" database
4. Name: "Contacts"
5. Enable "Show on Contacts" - name it "Gym"

### 6.2 Gyms ↔ Deals

1. In **Gyms** database
2. Add property → Relation
3. Select "Deals" database
4. Name: "Deals"
5. Enable "Show on Deals" - name it "Gym"

### 6.3 Gyms ↔ Activities

1. In **Gyms** database
2. Add property → Relation
3. Select "Activities" database
4. Name: "Activities"
5. Enable "Show on Activities" - name it "Gym"

### 6.4 Contacts ↔ Activities

1. In **Contacts** database
2. Add property → Relation
3. Select "Activities" database
4. Name: "Activities"
5. Enable "Show on Activities" - name it "Contact"

### 6.5 Contacts ↔ Deals

1. In **Contacts** database
2. Add property → Relation
3. Select "Deals" database
4. Name: "Deals"
5. Enable "Show on Deals" - name it "Primary Contact"

### 6.6 Deals ↔ Activities

1. In **Deals** database
2. Add property → Relation
3. Select "Activities" database
4. Name: "Activities"
5. Enable "Show on Activities" - name it "Deal"

### 6.7 GTM Initiatives ↔ Deals (optional)

1. In **GTM Initiatives** database
2. Add property → Relation
3. Select "Deals" database
4. Name: "Related Deals"
5. This links business initiatives to specific sales opportunities

---

## Step 7: Add Rollups (5 min)

Rollups pull data from related databases automatically.

### 7.1 In Gyms Database

**Last Contact:**
1. Add property → Rollup
2. Relation: Activities
3. Property: Date
4. Calculate: Latest date

**Total Activities:**
1. Add property → Rollup
2. Relation: Activities
3. Property: Activity (title)
4. Calculate: Count all

**Total Deal Value:**
1. Add property → Rollup
2. Relation: Deals
3. Property: Annual Value
4. Calculate: Sum

### 7.2 In Contacts Database

**Gym Status:**
1. Add property → Rollup
2. Relation: Gym
3. Property: Status
4. Calculate: Show original

### 7.3 In Deals Database

**Contact Email:**
1. Add property → Rollup
2. Relation: Primary Contact
3. Property: Email
4. Calculate: Show original

---

## Step 8: Create Dashboard Pages (5 min)

### 8.1 Sales Dashboard

1. Create new page: "Sales Dashboard"
2. Add icon: 📊
3. Add content:

```
# Sales Dashboard

## Pipeline
[Linked database: Deals - Pipeline Board view]

## Follow-up Needed
[Linked database: Gyms - filtered where Last Contact > 7 days ago]

## This Week's Activities
[Linked database: Activities - Calendar view]

## Quick Add
[Button: + New Gym]
[Button: + Log Activity]
```

To add linked databases:
1. Type `/linked` and select "Linked view of database"
2. Choose the database and view

### 8.2 GTM Dashboard

1. Create new page: "GTM Dashboard"
2. Add icon: 🚀
3. Add content:

```
# GTM Dashboard

## Active Initiatives
[Linked database: GTM Initiatives - Kanban by Status view]

## By Workstream
[Linked database: GTM Initiatives - By Workstream view]

## High Priority
[Linked database: GTM Initiatives - High Priority view]
```

### 8.3 Dev Dashboard

1. Create new page: "Dev Dashboard"
2. Add icon: 💻
3. Content: We'll add the GitHub sync here in Phase 3

---

## Step 9: Organize Sidebar (2 min)

Drag pages in sidebar to organize:

```
📊 Sales Dashboard
🚀 GTM Dashboard
💻 Dev Dashboard
---
📁 CRM
   └── Gyms
   └── Contacts
   └── Deals
   └── Activities
📁 GTM Initiatives
📁 Sales Assets (create empty folder for now)
📁 Research (create empty folder for now)
```

To create a folder: Create a page, then drag other pages into it.

---

## Step 10: Test Your Setup (5 min)

### Add a Test Gym

1. Go to Gyms database
2. Click "+ New"
3. Fill in:
   - Gym Name: "Test Gym"
   - Status: Lead
   - Pipeline Stage: Prospecting
   - Gym Type: Regional Chain
   - Priority: High

### Add a Test Contact

1. Go to Contacts database
2. Click "+ New"
3. Fill in:
   - Name: "John Test"
   - Role: Owner
   - Decision Maker: ✓
4. In the "Gym" relation, select "Test Gym"

### Add a Test Activity

1. Go to Activities database
2. Click "+ New"
3. Fill in:
   - Activity: "Initial outreach email"
   - Type: Email
   - Date: Today
   - Direction: Outbound
4. In relations, select "Test Gym" and "John Test"

### Verify Rollups

1. Go back to Gyms → Test Gym
2. Check that:
   - Last Contact shows today's date
   - Total Activities shows 1
   - Contacts shows "John Test"

### Clean Up

Delete "Test Gym" (the related Contact and Activity will unlink automatically)

---

## You're Done with Phase 1!

Your Notion CRM is ready. Next steps:

1. **Phase 3:** Add GitHub integration (see next section in migration guide)
2. **Phase 2:** Migrate GTM tickets from GitHub

---

## Quick Reference: Property Types

| Type | Use For | Example |
|------|---------|---------|
| Title | Primary name | Gym Name, Contact Name |
| Text | Free-form notes | Notes, Next Steps |
| Number | Quantities, money | Deal Value, Equipment Count |
| Select | Single choice | Status, Stage, Priority |
| Multi-select | Multiple tags | Pain Points |
| Date | Dates/times | Last Contact, Due Date |
| Checkbox | Yes/no | Decision Maker, Demo Completed |
| URL | Links | Website, LinkedIn |
| Email | Email addresses | Contact email |
| Phone | Phone numbers | Contact phone |
| Relation | Link to other DB | Gym → Contacts |
| Rollup | Calculate from relation | Last Contact date, Total count |
| Formula | Computed values | Annual Value, Days in Pipeline |
| Created time | Auto timestamp | When record was created |

---

## Troubleshooting

**Can't see relation in other database:**
- When creating relation, make sure "Show on [other DB]" is enabled

**Rollup shows wrong value:**
- Check that the relation is set correctly first
- Make sure you selected the right property to roll up

**Views not filtering correctly:**
- Click the filter icon and verify conditions
- Check that property values match exactly (case-sensitive for text)

**Database feels slow:**
- Hide properties you don't need in each view
- Limit the number of visible items with filters

---

*Setup guide created: 2025-12-20*
