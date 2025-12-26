# Notion Form Setup Guide

Step-by-step instructions to create submission forms for each workstream database.

**Time Required:** ~15 minutes total (~2 min per form)

---

## Overview

You'll create 7 forms, one for each workstream database:

| Database | Form Purpose |
|----------|--------------|
| GTM Tickets | Sales playbooks, pricing, case studies |
| INVESTOR Tickets | Pitch deck, financial model, VC prep |
| RESEARCH Tickets | Customer discovery, competitive analysis |
| PARTNER Tickets | Gym partnerships, pilot programs |
| BIZ Tickets | Entity formation, budget, compensation |
| DEMO Tickets | Lab space, hardware setup |
| CONTENT Tickets | Demo videos, marketing content |

---

## Form Creation Steps (Repeat for Each Database)

### Step 1: Open the Database

1. Go to **Workstream Tickets** page
2. Click on the database (e.g., **GTM Tickets**)

### Step 2: Create Form

1. Click the **dropdown arrow** next to the database name (top left)
2. Select **+ New form**
3. Notion creates a blank form

### Step 3: Configure Form Settings

1. Click the form name at top → rename to **"New GTM Ticket"** (or appropriate name)
2. Click **⚙️ Settings** (gear icon, top right of form builder)
3. Configure:
   - **Show Notion branding:** Off (optional)
   - **Submit button text:** "Create Ticket"
   - **After submit:** "Show confirmation" or "Redirect to page"

### Step 4: Add/Configure Fields

Drag fields from the left panel or click **+ Add question**

**Required Fields (mark with red asterisk):**

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| Initiative | Title | ✅ Yes | The ticket name |
| Priority | Select | ✅ Yes | Critical, High, Medium, Low |
| Track | Select | ✅ Yes | EU (Primary), WT (Future) |

**Optional Fields:**

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| Due Date | Date | No | When it's needed |
| Deliverables | Text | No | What will be produced |
| Acceptance Criteria | Text | No | How to know it's done |
| Notes | Text | No | Additional context |

**Fields to HIDE from form:**
- ID (auto-generated)
- Status (defaults to "Not Started")
- Github Issue (added later if needed)

### Step 5: Set Field Defaults

1. Click on **Status** field in database properties
2. Set default value: **"Not Started"**

### Step 6: Reorder Fields

Drag fields in the form builder to this order:
1. Initiative (title)
2. Priority
3. Track
4. Due Date
5. Deliverables
6. Acceptance Criteria
7. Notes

### Step 7: Copy Form Link

1. Click **Share** (top right)
2. Toggle **"Anyone with link can submit"** ON
3. Click **Copy link**
4. Save this link for the Submit Ticket hub page

---

## Quick Setup Per Database

### GTM Tickets Form
- **Name:** New GTM Ticket
- **Description:** "Create a new GTM ticket for sales, marketing, or go-to-market initiatives."

### INVESTOR Tickets Form
- **Name:** New INVESTOR Ticket
- **Description:** "Create a new ticket for investor prep, pitch deck, or financial planning."

### RESEARCH Tickets Form
- **Name:** New RESEARCH Ticket
- **Description:** "Create a new research ticket for customer discovery, market analysis, or validation."

### PARTNER Tickets Form
- **Name:** New PARTNER Ticket
- **Description:** "Create a new ticket for gym partnerships, pilots, or deployment."

### BIZ Tickets Form
- **Name:** New BIZ Ticket
- **Description:** "Create a new ticket for business operations, legal, or finance."

### DEMO Tickets Form
- **Name:** New DEMO Ticket
- **Description:** "Create a new ticket for demo environment, hardware, or lab setup."

### CONTENT Tickets Form
- **Name:** New CONTENT Ticket
- **Description:** "Create a new ticket for video production or marketing content."

---

## After Creating Forms

### Update Submit Ticket Hub Page

Once you have form links, update the Submit Ticket page:

1. Open **Submit Ticket** page
2. Replace database links with form links
3. Each bullet becomes: `[+ New GTM Ticket](form-link-here)`

### Alternative: Embed Forms

You can embed forms directly in the Submit Ticket page:

1. Copy form link
2. In Submit Ticket page, type `/embed`
3. Paste form link
4. Form appears inline

---

## Testing

After creating each form:

1. Open the form link in incognito/private browser
2. Fill out a test ticket
3. Verify it appears in the database with correct ID (e.g., GTM-6)
4. Delete the test ticket

---

## Form Links Checklist

Save your form links here as you create them:

- [ ] GTM: `___`
- [ ] INVESTOR: `___`
- [ ] RESEARCH: `___`
- [ ] PARTNER: `___`
- [ ] BIZ: `___`
- [ ] DEMO: `___`
- [ ] CONTENT: `___`

---

*Created: 2025-12-20*
