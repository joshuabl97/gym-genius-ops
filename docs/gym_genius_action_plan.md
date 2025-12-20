# Gym Genius: Pre-Investment Action Plan

## Overview

**Goal:** Build Equipment Utilization analytics for commercial gyms, with Workout Tracking as a future premium feature.

**Core Thesis:** Gyms have no data on how equipment is actually used. We provide zone-based utilization analytics that help operators optimize equipment ROI, floor layouts, and capacity planning.

**Dual-Track Strategy:**

| Track | Priority | Focus |
|-------|----------|-------|
| **Equipment Utilization (EU)** | PRIMARY | B2B analytics for gym operators—ship for revenue |
| **Workout Tracking (WT)** | SECONDARY | Member experience—build for fun, future upsell |

**Current State:** Working zone-based occupancy detection. Multi-person tracking operational. Dashboard with real-time views.

---

## Strategic Positioning

### Equipment Utilization (Primary)

**Business Model:** B2B SaaS
- Hardware lease + software subscription
- Simple per-gym pricing
- No member-facing complexity

**Target Market:** Regional gym chains and premium independents

**Primary Value Prop:** Equipment ROI and operational insights
- "Know which equipment to buy, where to put it, and when it's used"
- Data-driven capacity planning
- Peak hour optimization

### Workout Tracking (Secondary)

**Business Model:** Platform + Data hybrid (future)
- Gym pays subscription, members get tracking
- Premium member tiers for advanced insights
- Data portability across gyms

**Target Market:** Premium gyms wanting member differentiation (future)

**Privacy Stance:** No video stored, opt-in consent, on-premise processing

See `gym_genius_strategic_questions.md` for full strategic context.

---

## Technical Architecture

Technical tickets are tracked in `gym-vision` repo with the following structure:

| Prefix | Track | Purpose |
|--------|-------|---------|
| DASH-* | Shared | Dashboard components used by both EU and WT |
| EU-* | Primary | Equipment Utilization features |
| WT-* | Secondary | Workout Tracking features (for fun) |

| Repo | Purpose | Tickets |
|------|---------|---------|
| gym-vision | ML/CV library (core IP) | EU-*, WT-*, DASH-* |
| gym-vision-web | Dashboard/frontend | DASH-* (UI components) |
| gym-vision-inference | Inference service | EU-*, WT-* deployment |
| gym-genius | Backend API | Data storage, API endpoints |

Non-code tickets (GTM, INVESTOR, RESEARCH, BIZ, PARTNER) are tracked in `gym-genius-ops` repo.

---

## Workstream 1: Equipment Utilization MVP (PRIMARY)

### EU-001: Zone Configuration UI
**Priority:** P0 (Critical)
**Repos:** gym-vision-web

**Description:**
Interface for gym operators to define equipment zones on camera feeds. Draw rectangles/polygons on video feed, name the zone, and start tracking.

**Action Items:**
- [ ] Zone drawing interface on video feed
- [ ] Zone naming and equipment type assignment
- [ ] Zone persistence to backend
- [ ] Multi-camera zone management
- [ ] Zone editing and deletion

**Success Criteria:**
- Non-technical user can define zones in under 5 minutes
- Zones persist across sessions
- Works with multiple camera feeds

---

### EU-002: Zone Occupancy Detection
**Priority:** P0 (Critical)
**Repos:** gym-vision

**Description:**
Detect when zones are occupied vs empty. Core EU feature.

**Action Items:**
- [ ] Person detection within defined zones
- [ ] Occupancy state tracking (empty/occupied)
- [ ] Timestamp logging for occupancy changes
- [ ] Handle edge cases (person partially in zone)
- [ ] Configurable occupancy thresholds

**Success Criteria:**
- 95%+ accuracy on zone occupancy detection
- Sub-second latency for state changes
- Handles multiple people in same zone

---

### EU-003: Utilization Metrics Backend
**Priority:** P0 (Critical)
**Repos:** gym-genius

**Description:**
Store and calculate utilization metrics from zone occupancy data.

**Action Items:**
- [ ] Time-series storage for occupancy events
- [ ] Utilization rate calculation (% time occupied)
- [ ] Peak hour detection
- [ ] Daily/weekly/monthly aggregations
- [ ] API endpoints for dashboard

**Success Criteria:**
- Query utilization for any time range
- Sub-second API response times
- Data retention configurable per gym

---

### EU-004: Utilization Dashboard
**Priority:** P0 (Critical)
**Repos:** gym-vision-web

**Description:**
Dashboard showing equipment utilization metrics for gym operators.

**Action Items:**
- [ ] Zone utilization overview (current state)
- [ ] Heatmaps by time of day/week
- [ ] Peak hour visualizations
- [ ] Equipment comparison charts
- [ ] Date range filtering

**Success Criteria:**
- Gym owner immediately understands which equipment is used
- Data loads in under 2 seconds
- Mobile-friendly views

---

### EU-005: Real-Time Zone Status
**Priority:** P1 (High)
**Repos:** gym-vision-web, gym-vision-inference

**Description:**
Live view showing current occupancy of all zones.

**Action Items:**
- [ ] WebSocket/SSE for real-time updates
- [ ] Visual indicators (green/red) for zone status
- [ ] Camera feed with zone overlays
- [ ] Latency optimization

**Success Criteria:**
- Updates within 500ms of state change
- Works reliably for 8+ hours continuously

---

### EU-006: Historical Reports
**Priority:** P1 (High)
**Repos:** gym-vision-web, gym-genius

**Description:**
Downloadable reports for equipment utilization.

**Action Items:**
- [ ] PDF/CSV export for utilization data
- [ ] Weekly summary reports
- [ ] Equipment ROI calculations
- [ ] Scheduled email reports (future)

**Success Criteria:**
- Reports generate in under 30 seconds
- Data is accurate and well-formatted

---

### EU-007: Multi-Camera Support
**Priority:** P1 (High)
**Repos:** gym-vision-inference

**Description:**
Handle multiple camera feeds for full gym coverage.

**Action Items:**
- [ ] Camera registration and management
- [ ] Unified zone namespace across cameras
- [ ] Camera health monitoring
- [ ] Graceful degradation if camera fails

**Success Criteria:**
- Support 4+ cameras per gym
- No duplicate counting at camera boundaries

---

### EU-008: Deployment Package
**Priority:** P1 (High)

**Description:**
Packaged deployment for gym installations.

**Action Items:**
- [ ] Docker/containerized deployment
- [ ] Hardware requirements documentation
- [ ] Installation checklist
- [ ] Remote monitoring/alerting
- [ ] Update mechanism

**Success Criteria:**
- New gym deployment in under 2 hours
- Remote troubleshooting capability

---

### EU-009: Alert System
**Priority:** P2 (Medium)
**Repos:** gym-genius, gym-vision-web

**Description:**
Configurable alerts for operators.

**Action Items:**
- [ ] Capacity threshold alerts
- [ ] Unusual usage pattern detection
- [ ] Equipment idle alerts
- [ ] Email/SMS notification options

**Success Criteria:**
- Alerts trigger within 5 minutes of condition
- Configurable per zone

---

## Workstream 2: Shared Dashboard Components

### DASH-001: Authentication & Multi-Tenant
**Priority:** P0 (Critical)
**Repos:** gym-vision-web, gym-genius

**Description:**
User auth and gym-level data isolation.

**Action Items:**
- [ ] User authentication (email/password or OAuth)
- [ ] Gym organization model
- [ ] Role-based access (admin, viewer)
- [ ] Data isolation between gyms

**Success Criteria:**
- Secure authentication
- No data leakage between gyms

---

### DASH-002: Navigation & Layout
**Priority:** P0 (Critical)
**Repos:** gym-vision-web

**Description:**
Dashboard navigation with EU and WT tabs.

**Action Items:**
- [ ] Sidebar navigation
- [ ] EU tab (primary, default)
- [ ] WT tab (secondary, "coming soon" initially)
- [ ] Settings/config section

**Success Criteria:**
- Clean, intuitive navigation
- WT tab visible but secondary

---

### DASH-003: Camera Feed Display
**Priority:** P0 (Critical)
**Repos:** gym-vision-web

**Description:**
Display live camera feeds with overlays.

**Action Items:**
- [ ] RTSP/WebRTC stream display
- [ ] Zone overlay rendering
- [ ] Person detection overlay
- [ ] Feed quality/latency indicators

**Success Criteria:**
- Smooth video playback
- Overlays sync with detection

---

### DASH-004: Settings & Configuration
**Priority:** P1 (High)
**Repos:** gym-vision-web

**Description:**
Gym configuration interface.

**Action Items:**
- [ ] Gym profile settings
- [ ] Camera management
- [ ] User management
- [ ] Notification preferences

**Success Criteria:**
- Self-service configuration
- Changes apply immediately

---

### DASH-005: Mobile Responsive
**Priority:** P1 (High)
**Repos:** gym-vision-web

**Description:**
Dashboard works on mobile devices.

**Action Items:**
- [ ] Responsive layout
- [ ] Touch-friendly controls
- [ ] Critical metrics on mobile
- [ ] Simplified zone view

**Success Criteria:**
- Usable on phone/tablet
- Key data accessible quickly

---

## Workstream 3: Demo Environment (Simplified for EU)

### DEMO-001: Lab Space Setup
**Priority:** High

**Description:**
Physical space for demos. EU demo is simpler than WT—doesn't need multiple people exercising, just equipment zones.

**Action Items:**
- [ ] Define minimum space for EU demo (can be smaller)
- [ ] Set up 2-3 camera angles
- [ ] Create mock equipment zones
- [ ] Lighting for CV performance

**Success Criteria:**
- Can demonstrate zone detection clearly
- Professional enough for investor/gym demos

---

### DEMO-002: Hardware Setup
**Priority:** High

**Description:**
Edge computing and camera setup.

**Action Items:**
- [ ] Benchmark current hardware
- [ ] Document hardware requirements
- [ ] Bill of materials for gym installation
- [ ] Backup hardware ready

**Success Criteria:**
- Demo runs on sub-$2k hardware
- Clear BOM for gyms

---

## Workstream 4: Investor Preparation

### INVESTOR-001: Pitch Deck
**Priority:** High
**Status:** Needs EU reframe

**Description:**
10-12 slide deck. Update for EU-first strategy.

**Action Items:**
- [ ] Reframe problem: gym equipment utilization
- [ ] Update solution: zone-based analytics
- [ ] Revise business model for EU
- [ ] Add EU competitive landscape
- [ ] Update go-to-market for EU pilots
- [ ] Keep WT as "future roadmap" slide

**Success Criteria:**
- Coherent EU-first story
- WT positioned as expansion, not core

---

### INVESTOR-002: Financial Model
**Priority:** Medium

**Description:**
Unit economics for EU model.

**Action Items:**
- [ ] EU pricing model
- [ ] Hardware cost per gym
- [ ] Software subscription pricing
- [ ] 3-year projection
- [ ] Break-even analysis

**Success Criteria:**
- Clear EU unit economics
- Defensible assumptions

---

### INVESTOR-003: Equinox/Gym Prep
**Priority:** High
**Status:** Needs EU pivot

**Description:**
Prepare for gym meetings with EU pitch.

**Action Items:**
- [ ] Reframe pitch for EU value
- [ ] Research equipment/utilization pain points
- [ ] Prepare EU-specific demo
- [ ] ROI calculator for equipment decisions

**Success Criteria:**
- EU pitch ready for gym meetings
- Can demonstrate clear value

---

### INVESTOR-004: VC Meeting Prep
**Priority:** High

**Description:**
Prepare for VC conversations.

**Action Items:**
- [ ] Research firm's relevant portfolio
- [ ] Prepare for EU-specific questions
- [ ] Practice pitch
- [ ] Prepare questions for them

**Success Criteria:**
- Ready for EU-focused questions
- Clear "why EU first" answer

---

### INVESTOR-005: Elevator Pitch
**Priority:** High
**Status:** Needs EU rewrite

**Description:**
60-second pitch for EU-first strategy.

**Action Items:**
- [ ] Write EU-focused elevator pitch
- [ ] Practice delivery
- [ ] Get feedback

**Success Criteria:**
- Clear EU value prop in 60 seconds

---

## Workstream 5: Research & Validation

### RESEARCH-001: Competitive Deep Dive
**Priority:** Medium
**Status:** Add EU competitors

**Description:**
Know competition for equipment analytics.

**Action Items:**
- [ ] Map EU competitors (gym analytics space)
- [ ] Research: IoT sensor solutions, manual counting, Mindbody analytics
- [ ] Document differentiation
- [ ] Add to WT competitor analysis (secondary)

**Success Criteria:**
- Know top 5 EU competitors
- Clear positioning

---

### RESEARCH-002: Gym Owner Discovery
**Priority:** Critical
**Status:** Expand for EU

**Description:**
Customer discovery focused on equipment/utilization pain points.

**Action Items:**
- [ ] Add EU-specific questions to conversation guide
- [ ] Ask about equipment purchasing decisions
- [ ] Ask about utilization tracking (if any)
- [ ] Validate EU pricing
- [ ] Identify EU pilot candidates

**Success Criteria:**
- 10+ conversations with EU focus
- Validated EU pain points
- 2+ EU pilot leads

---

### RESEARCH-009: Pricing & Unit Economics
**Priority:** High
**Status:** Focus on EU

**Description:**
Define EU pricing model.

**Action Items:**
- [ ] Research gym software pricing (Mindbody, Wodify)
- [ ] Define EU hardware + software pricing
- [ ] Test in gym conversations
- [ ] Model EU unit economics

**Success Criteria:**
- Clear EU pricing ready for sales
- Unit economics make sense

---

### RESEARCH-011: Privacy Messaging
**Priority:** Medium

**Description:**
Privacy messaging for EU (simpler than WT).

**Action Items:**
- [ ] EU privacy is simpler: no individual tracking
- [ ] Draft privacy one-pager for EU
- [ ] Test messaging with gym owners

**Success Criteria:**
- Privacy not a blocker for EU sales

---

### RESEARCH-013: Regulatory & Compliance
**Priority:** Low

**Description:**
Legal requirements for EU deployment.

**Action Items:**
- [ ] EU privacy requirements (simpler than WT)
- [ ] State recording laws
- [ ] Gym liability considerations

**Success Criteria:**
- No legal blockers for EU pilots

---

### RESEARCH-014: Data Retention
**Priority:** Low

**Description:**
Data retention policy for EU.

**Action Items:**
- [ ] Define EU data retention (aggregated only)
- [ ] No PII in EU product
- [ ] Document policy

**Success Criteria:**
- Clear, simple EU data policy

---

## Workstream 6: Business Operations

### BIZ-001: Entity Formation
**Priority:** Medium

**Description:**
Legal entity for investment.

**Action Items:**
- [ ] Delaware C-Corp
- [ ] EIN, bank account
- [ ] IP assignment

**Success Criteria:**
- Ready for investment

---

### BIZ-002: Budget & Runway
**Priority:** Medium
**Status:** Update for EU

**Description:**
Budget for EU-first approach.

**Action Items:**
- [ ] EU demo costs (simpler than WT)
- [ ] EU pilot costs
- [ ] Runway calculation

**Success Criteria:**
- Clear EU costs

---

### BIZ-004: Sales Compensation
**Priority:** Medium

**Description:**
Compensation for sales help.

**Action Items:**
- [ ] Commission structure
- [ ] Agreement template

**Success Criteria:**
- Ready before first deal

---

### BIZ-005: CRM & Pipeline
**Priority:** Medium

**Description:**
Track gym conversations.

**Action Items:**
- [ ] Simple CRM setup
- [ ] Pipeline stages for EU sales

**Success Criteria:**
- All conversations tracked

---

## Workstream 7: Partnership Materials

### PARTNER-001: Partnership Deck
**Priority:** High
**Status:** Update for EU

**Description:**
Deck for gym partnerships focused on EU.

**Action Items:**
- [ ] Reframe for equipment utilization
- [ ] ROI examples for equipment decisions
- [ ] Case study mockups
- [ ] Pilot proposal

**Success Criteria:**
- Gym owner sees EU value immediately

---

### PARTNER-002: Pilot Program
**Priority:** High
**Status:** Update for EU

**Description:**
EU pilot structure.

**Action Items:**
- [ ] 30-60 day EU pilot
- [ ] Success metrics for EU
- [ ] Pilot agreement template

**Success Criteria:**
- Clear EU pilot proposal

---

### PARTNER-003: Deployment Calculator
**Priority:** Medium
**Status:** EU-only costs

**Description:**
Cost calculator for EU deployment.

**Action Items:**
- [ ] EU hardware costs
- [ ] EU software pricing
- [ ] ROI calculation

**Success Criteria:**
- Gym can see EU costs clearly

---

## Workstream 8: Workout Tracking (SECONDARY)

*These tickets are for the passion project. Work on them when EU is blocked or for fun.*

### WT-001: Exercise Detection
**Priority:** Secondary
**Repos:** gym-vision

**Description:**
Expand from zone occupancy to actual exercise detection.

**Action Items:**
- [ ] Define demo exercise set
- [ ] Collect training data
- [ ] Train detection models

**Success Criteria:**
- 90%+ accuracy on demo exercises

---

### WT-002: Rep Counting
**Priority:** Secondary
**Repos:** gym-vision

**Description:**
Count reps for detected exercises.

**Action Items:**
- [ ] Pose-based rep detection
- [ ] Handle variations
- [ ] Accuracy testing

**Success Criteria:**
- Reliable rep counting

---

### WT-003: Weight Detection
**Priority:** Secondary
**Repos:** gym-vision

**Description:**
Detect weight being used.

**Action Items:**
- [ ] Plate recognition research
- [ ] Barbell tracking
- [ ] Dumbbell detection

**Success Criteria:**
- Weight detection for barbells

---

### WT-004: Member App/Dashboard
**Priority:** Secondary
**Repos:** gym-vision-web

**Description:**
Member-facing workout tracking interface.

**Action Items:**
- [ ] Workout history view
- [ ] Session summaries
- [ ] Progress charts

**Success Criteria:**
- Members can see their workouts

---

## Quick Reference: What Actually Matters

**For EU MVP (PRIMARY):**
1. **Zone detection works reliably** — Core feature, must be solid
2. **Dashboard shows clear value** — Gym owners see ROI immediately
3. **2-3 pilot partnerships** — Prove it works in real gyms
4. **Convert pilots to paid** — Revenue validates model

**For WT (SECONDARY):**
- Build when EU is blocked or for fun
- Future upsell to EU customers

---

## GitHub Tracking

**Repositories:**
- `gym-genius-ops` — GTM tickets (INVESTOR, RESEARCH, BIZ, PARTNER)
- `gym-vision` — ML/CV code (EU-*, WT-*, DASH-*)
- `gym-vision-web` — Dashboard code
- `gym-vision-inference` — Inference service
- `gym-genius` — Backend API

**Project Boards:**
- [Gym Vision Development](https://github.com/users/joshuabl97/projects/1) — Technical tickets
- [Gym Genius GTM Strategy](https://github.com/users/joshuabl97/projects/2) — Business tickets

---

*Strategy: Ship EU for revenue, build WT for fun.*

*Last updated: 2025-12-20*
