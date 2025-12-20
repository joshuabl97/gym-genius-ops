# Phase 3: GitHub Integration Setup

Connect GitHub to Notion for dev visibility without complex syncing.

**Time Required:** 10 minutes
**Cost:** Free

---

## Strategy: Lightweight Integration

We're NOT syncing GTM tickets bidirectionally. Instead:

1. **Native Notion-GitHub integration** for viewing dev work in Notion
2. **Manual linking** when GTM work needs dev support
3. **Keep it simple** - add automation later only if needed

---

## Step 1: Connect GitHub to Notion

### Prerequisites

- You must be a Notion workspace owner
- You must have GitHub organization admin access (or be repo owner for personal repos)

### Connect the Integration

1. In Notion, go to **Settings & members** (bottom-left gear icon)
2. Click **Connections** in the sidebar
3. Find **GitHub** and click **Connect**
4. Authorize Notion to access your GitHub account
5. Select which repositories to connect:
   - `joshuabl97/gym-vision`
   - `joshuabl97/gym-genius`
   - `joshuabl97/gym-vision-web`
   - `joshuabl97/gym-vision-inference`
6. Click **Allow access**

---

## Step 2: Create Synced GitHub Database

### Add to Dev Dashboard

1. Open your **Dev Dashboard** page in Notion
2. Type `/github` and select **GitHub - Synced database**
3. Select the repositories you want to track
4. Choose what to sync:
   - **Pull Requests** (recommended for dev visibility)
   - **Issues** (optional - your dev issues)

### Configure the View

The synced database will show:

| Property | Description |
|----------|-------------|
| Title | PR/Issue title |
| Status | Open, Merged, Closed |
| Repository | Which repo |
| Author | Who created it |
| Created | When created |
| Updated | Last update |

Create useful views:

**View 1: Open PRs**
- Filter: Status = Open
- Sort: Updated descending

**View 2: Recently Merged**
- Filter: Status = Merged
- Sort: Updated descending
- Useful for: What shipped recently

**View 3: By Repository**
- Group by: Repository
- Useful for: See work across repos

---

## Step 3: Link Preview Setup

Notion automatically creates rich previews when you paste GitHub URLs.

### How It Works

1. Copy any GitHub URL (issue, PR, commit, file)
2. Paste it into a Notion page
3. Notion shows a rich preview with:
   - Title
   - Status (open/closed/merged)
   - Description preview
   - Assignees
   - Labels

### Use Cases

- Paste GitHub issue URL in a GTM Initiative to show related dev work
- Paste PR URL in meeting notes to reference what was discussed
- Paste in Activity notes when logging dev-related conversations

---

## Step 4: Manual Linking Workflow

When a GTM Initiative requires development work:

### From Notion → GitHub

1. Open the GTM Initiative in Notion
2. Determine what dev work is needed
3. Create a GitHub issue in the appropriate repo:
   ```
   Title: [Brief description]

   ## Business Context
   Notion GTM Initiative: [paste Notion page URL]

   ## Requirements
   [Technical requirements]

   ## Acceptance Criteria
   - [ ] Criteria 1
   - [ ] Criteria 2
   ```
4. Copy the GitHub issue URL
5. In Notion, add a property or paste in notes:
   - Either add "Related GitHub Issues" (URL property) to GTM Initiatives
   - Or paste the link in the Notes section

### From GitHub → Notion

When creating dev issues that relate to business goals:

1. In GitHub issue description, add:
   ```markdown
   ## Business Context
   Related GTM Initiative: [Notion page URL]
   ```
2. This creates a clickable link for anyone on the dev side

---

## Step 5: What Gets Synced (and What Doesn't)

### Synced Automatically

| Data | GitHub → Notion |
|------|-----------------|
| PR/Issue title | ✅ |
| Status (open/closed/merged) | ✅ |
| Author | ✅ |
| Repository | ✅ |
| Created/Updated dates | ✅ |
| Description (in preview) | ✅ |
| Comments (partial) | ✅ |

### NOT Synced

| Data | Status |
|------|--------|
| Labels | ❌ Not supported |
| Custom fields from Projects V2 | ❌ Not supported |
| Milestones | ❌ Limited |
| Assignees (in database) | ❌ Limited |

### Implication

Since labels don't sync, you can't automatically filter "only EU-* issues" into Notion. This is fine because:
- Dev tickets stay in GitHub (no need to see them all in Notion)
- You manually link only when GTM work needs dev support
- The synced database gives you visibility into what's being worked on

---

## Step 6: Dev Dashboard Final Setup

Your Dev Dashboard page should now look like:

```
# 💻 Dev Dashboard

Quick links to development work across all Gym Genius repositories.

## GitHub Repositories
- [gym-vision](https://github.com/joshuabl97/gym-vision) - ML/CV library
- [gym-genius](https://github.com/joshuabl97/gym-genius) - Backend API
- [gym-vision-web](https://github.com/joshuabl97/gym-vision-web) - Dashboard
- [gym-vision-inference](https://github.com/joshuabl97/gym-vision-inference) - Inference service

## Open Pull Requests
[Synced GitHub database - Open PRs view]

## Recently Merged
[Synced GitHub database - Recently Merged view]

## Project Boards
- [Gym Vision Development](https://github.com/users/joshuabl97/projects/1)

---
*Dev tickets remain in GitHub. Link to Notion GTM Initiatives when business context is needed.*
```

---

## Optional: Future Automation

If manual linking becomes tedious, consider these automations later:

### Zapier (Free tier: 100 tasks/month)

**Trigger:** New GitHub issue with label "needs-gtm-context"
**Action:** Create Notion page in GTM Initiatives with GitHub link

### Make.com (Free tier: 1,000 ops/month)

**Trigger:** GitHub issue labeled "customer-request"
**Action:** Create Notion page in Feature Requests database

### GitHub Actions + Notion API (Free)

Create a workflow that:
1. Triggers on issue labeled "gtm"
2. Uses Notion API to create/update a page
3. Requires coding but maximum control

**Recommendation:** Start manual. Add automation only when you're doing 10+ links per week.

---

## Troubleshooting

### "Can't connect to GitHub"

- Ensure you're a Notion workspace owner
- Ensure you have admin access to the GitHub repos
- Try disconnecting and reconnecting

### "Synced database not updating"

- Notion syncs periodically, not instantly
- Click the sync icon (↻) to force refresh
- Check that the repository is still connected in Settings → Connections

### "Can't see my repository"

- The repo must be in an organization you have admin access to
- OR be a personal repo you own
- Private repos require explicit permission during connection

### "Link previews not showing"

- Make sure the GitHub connection is active
- Try pasting the URL again
- Check that the URL is a valid GitHub URL (issues, PRs, files)

---

## Phase 3 Complete!

Your GitHub integration is set up. You now have:

- ✅ Synced database showing PRs across all repos
- ✅ Link previews for GitHub URLs in Notion
- ✅ Dev Dashboard for quick visibility
- ✅ Manual linking workflow documented

**Next:** Phase 2 - Migrate GTM tickets from GitHub to Notion

---

*Created: 2025-12-20*
