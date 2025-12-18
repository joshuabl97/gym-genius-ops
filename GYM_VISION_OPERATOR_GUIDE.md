# Gym Vision Development - Operator Guide

This guide walks you through executing the Gym Vision technical development using multiple concurrent Claude Code agents.

**Last Updated:** 2025-12-18

---

## Current State

### Project Overview
- **Project Board:** [Gym Vision Development](https://github.com/users/joshuabl97/projects/1)
- **Total Tickets:** 67
- **Repositories:** 4 (gym-genius, gym-vision, gym-vision-web, gym-vision-inference)

### Ticket Status
| Status | Count | Notes |
|--------|-------|-------|
| **In Progress** | 1 | INF-001: Development Environment |
| **Todo** | 8 | Ready to start |
| **Blocked** | 41 | Waiting for dependencies |
| **Backlog** | 15 | Future work |
| **Done** | 2 | VIS-001, CFG-001 |

### Priority Breakdown
| Priority | Count |
|----------|-------|
| Critical | 7 |
| High | 5 |
| Medium | 39 |
| Low | 15 |

### Current Blockers
Most tickets (41) are **Blocked** waiting for:
- **INF-001: Development Environment** (in progress) - unblocks infrastructure
- **INF-003: Docker Compose Stack** - unblocks most services
- Phase dependencies (each phase unblocks the next)

---

## Agent Assignments

| Agent | Focus | Repo(s) | Tickets |
|-------|-------|---------|---------|
| **A-Vision** | CV/ML pipeline, annotations | gym-vision | 24 |
| **B-Web** | Dashboard UI | gym-vision-web | 16 |
| **C-Infra** | Infrastructure, Docker, storage | gym-vision | 7 |
| **D-Inference** | Inference service | gym-vision-inference | 4 |
| **E-Hub** | API hub, orchestration | gym-genius | 15 |

---

## Development Phases

| Phase | Name | Description | Status |
|-------|------|-------------|--------|
| 0-Infra | Infrastructure | Dev environment, Docker, storage | **In Progress** |
| 1-Core | Core | Camera input, config, base modules | Blocked |
| 2-PreAnn | Pre-Annotation | Person detection, tracking, annotation prep | Blocked |
| 3-Enhanced | Enhanced | Pose estimation, exercise detection | Blocked |
| 4-RTSP | RTSP | Live camera streaming | Blocked |
| 4.5-Services | Services | Inference service setup | Blocked |
| 5-Dashboard | Dashboard | Web UI for management | Blocked |
| Hub | Hub | API hub and orchestration | Blocked |

---

## Actionable Tickets (Ready to Work)

### Currently In Progress
| Agent | Issue | Ticket | Repo |
|-------|-------|--------|------|
| C-Infra | #1 | INF-001: Development Environment | gym-vision |

### Ready (Todo)
| Agent | Issue | Ticket | Repo | Phase |
|-------|-------|--------|------|-------|
| A-Vision | #6 | VIS-002: Person Detection Module | gym-vision | 2-PreAnn |
| A-Vision | #12 | VIS-008: Threaded Video Source | gym-vision | 4-RTSP |
| B-Web | #1 | UI-001: Go + HTMX Project Setup | gym-vision-web | 5-Dashboard |
| D-Inference | #1 | SVC-001: gym-vision-inference Python Setup | gym-vision-inference | 4.5-Services |
| E-Hub | #6 | GG-001: Webhook Infrastructure | gym-genius | Hub |
| E-Hub | #2 | GG-003: Service-to-Service Auth | gym-genius | Hub |
| E-Hub | #3 | GG-004: Health Aggregation Endpoint | gym-genius | Hub |

---

## Workflow: Running 2-3 Concurrent Agents

### Step 1: Open Terminal Windows

Open 2-3 separate terminal windows. Each runs an independent Claude Code session working on a different repository/agent.

### Step 2: Start Priority Work

**Terminal 1 - C-Infra (Continue INF-001):**
```bash
cd ~/Code/gym-vision
claude "I'm working on Gym Vision Development. Continue issue #1 (INF-001: Development Environment). This is critical infrastructure that unblocks other work. Check current progress and complete remaining tasks."
```

**Terminal 2 - A-Vision:**
```bash
cd ~/Code/gym-vision
claude "I'm working on Gym Vision Development. Help me complete issue #6 (VIS-002: Person Detection Module). This is a High priority computer vision task for person detection using pose estimation."
```

**Terminal 3 - B-Web:**
```bash
cd ~/Code/gym-vision-web
claude "I'm working on Gym Vision Development. Help me complete issue #1 (UI-001: Go + HTMX Project Setup). Set up the base Go project with HTMX for the dashboard."
```

### Step 3: Alternative Configurations

**If focusing on Hub/Backend:**
```bash
# Terminal for E-Hub
cd ~/Code/gym-genius
claude "I'm working on Gym Vision Development. Help me complete issue #6 (GG-001: Webhook Infrastructure). This is the API hub for the Gym Genius system."
```

**If focusing on Inference Service:**
```bash
# Terminal for D-Inference
cd ~/Code/gym-vision-inference
claude "I'm working on Gym Vision Development. Help me complete issue #1 (SVC-001: gym-vision-inference Python Service Setup). Set up the Python inference service."
```

### Step 4: Monitor Progress

**Check remaining tickets:**
```bash
gh project item-list 1 --owner joshuabl97 --limit 100 --format json | jq -r '.items[] | select(.status == "Todo" or .status == "In Progress") | "#\(.content.number): \(.title) | \(.status) | \(.agent)"'
```

**View project board:**
Open https://github.com/users/joshuabl97/projects/1

### Step 5: After Each Ticket Completes

1. **Close the issue:**
   ```bash
   gh issue close <number> --repo joshuabl97/<repo-name>
   ```

2. **Unblock dependent tickets** - Move newly unblocked tickets from Blocked → Todo:
   ```bash
   # In GitHub UI or via API - update Status field
   ```

3. **Start next ticket** in that terminal

---

## Recommended Execution Order

### Phase 0: Infrastructure (Current)
Complete these first - they unblock everything else:

| Priority | Agent | Issue | Ticket |
|----------|-------|-------|--------|
| 1 | C-Infra | #1 | INF-001: Development Environment |
| 2 | C-Infra | #2 | INF-003: Docker Compose Stack |
| 3 | C-Infra | #3 | INF-004: Persistent Storage Setup |

### Parallel Work (Can Start Now)
These have fewer dependencies:

| Agent | Issue | Ticket | Repo |
|-------|-------|--------|------|
| B-Web | #1 | UI-001: Go + HTMX Project Setup | gym-vision-web |
| D-Inference | #1 | SVC-001: Python Service Setup | gym-vision-inference |
| E-Hub | #6 | GG-001: Webhook Infrastructure | gym-genius |

### After Infrastructure Completes
Once INF-001 → INF-003 are done:

| Agent | Issue | Ticket |
|-------|-------|--------|
| A-Vision | #6 | VIS-002: Person Detection Module |
| A-Vision | #15 | ANN-001: CVAT Setup & Configuration |
| E-Hub | #2-3 | GG-003, GG-004: Service auth & health |

---

## Quick Reference Commands

### Start agent for specific repo
```bash
# Vision (CV/ML)
cd ~/Code/gym-vision && claude "Help me with issue #<NUM> (<TICKET>)"

# Web Dashboard
cd ~/Code/gym-vision-web && claude "Help me with issue #<NUM> (<TICKET>)"

# API Hub
cd ~/Code/gym-genius && claude "Help me with issue #<NUM> (<TICKET>)"

# Inference Service
cd ~/Code/gym-vision-inference && claude "Help me with issue #<NUM> (<TICKET>)"
```

### Check tickets by agent
```bash
gh project item-list 1 --owner joshuabl97 --limit 100 --format json | jq -r '.items | group_by(.agent) | .[] | "\n\(.[0].agent // "Unassigned"):", (.[] | select(.status == "Todo" or .status == "In Progress") | "  #\(.content.number): \(.title)")'
```

### Check blocked tickets
```bash
gh project item-list 1 --owner joshuabl97 --limit 100 --format json | jq -r '.items[] | select(.status == "Blocked") | "#\(.content.number): \(.title) | \(.agent)"' | head -20
```

### Count by status
```bash
gh project item-list 1 --owner joshuabl97 --limit 100 --format json | jq -r '[.items[] | .status] | group_by(.) | map({status: .[0], count: length}) | .[] | "\(.status): \(.count)"'
```

---

## Repository Structure

| Repo | Purpose | Primary Agent |
|------|---------|---------------|
| [gym-vision](https://github.com/joshuabl97/gym-vision) | CV/ML library, infrastructure | A-Vision, C-Infra |
| [gym-vision-web](https://github.com/joshuabl97/gym-vision-web) | Dashboard UI (Go + HTMX) | B-Web |
| [gym-genius](https://github.com/joshuabl97/gym-genius) | Backend API hub | E-Hub |
| [gym-vision-inference](https://github.com/joshuabl97/gym-vision-inference) | Inference service (Python) | D-Inference |

---

## Agent Workloads

### A-Vision (24 tickets)
- Person detection, tracking, pose estimation
- Annotation pipeline (CVAT, FiftyOne)
- Video processing, RTSP streaming

### B-Web (16 tickets)
- Go + HTMX dashboard
- Video library, upload, playback
- Annotation management UI
- Live camera views

### C-Infra (7 tickets)
- Docker Compose stack
- Storage, backups
- RTSP camera network
- Development environment

### D-Inference (4 tickets)
- Python inference service
- gRPC server
- Redis job consumer
- Health/config API

### E-Hub (15 tickets)
- Webhook infrastructure
- Service-to-service auth
- Event streaming (SSE)
- Detection results API
- Camera registry

---

## Tips

1. **Unblock dependencies** - Focus on INF-001 first, it unblocks 40+ tickets
2. **Work across repos** - Each terminal can work on a different repo
3. **Check phase order** - Phase 0 → 1 → 2 → etc. Some work can parallelize
4. **Use the board** - Filter by Agent or Phase to see workload
5. **Move tickets** - When work unblocks, move from Blocked → Todo

---

## Related Documents

- GTM Operator Guide: `~/Code/gym-genius-ops/OPERATOR_GUIDE.md`
- GTM Strategy Docs: `~/Code/gym-genius-ops/docs/`
