# Gym Genius: Pre-Investment Action Plan

## Overview

**Goal:** Build the "Strava for strength training"—a platform that automatically tracks gym workouts and delivers insights members actually want.

**Core Thesis:** Rep tracking isn't new—but nobody has shown multi-person, real-time tracking in a realistic gym environment with genuinely useful data output. We're replacing apathy, not other apps. Members want to track but don't because it's tedious. We make it automatic.

**Current State:** Working single-person tracking demo exists. Rebuilding codebase for scalability and iteration speed.

---

## Strategic Positioning

**Business Model:** Platform + Data hybrid
- Gyms pay hardware lease + software subscription
- Members get accounts that work across gyms (data portability)
- Gym controls premium pricing, keeps revenue (reduces their net cost)

**Target Market:** Up-market premium gyms (Equinox, Lifetime, high-end independents, boutique strength)

**Primary Value Prop:** Member retention + differentiation
- "Members stay because their data lives here"
- "Premium feature competitors don't have"

**Secondary Value:** Trainer insights, equipment utilization

**Privacy Stance:** No video stored, opt-in consent, on-premise processing

**Go-to-Market:** Two parallel paths
1. **Small partner (preferred):** High-end independent gym—fast iteration, less approval
2. **Equinox:** Parallel credibility play via intro—slower but valuable reference

See `gym_genius_strategic_questions.md` for full strategic context.

---

## Technical Architecture Note

TECH tickets align with the existing codebase in `~/Code/`:

| Repo | Purpose | Relevant Tickets |
|------|---------|------------------|
| gym-genius | Backend API | TECH-004, TECH-005 |
| gym-vision | ML/CV library (core IP) | TECH-001, TECH-002, TECH-003 |
| gym-vision-inference | Inference service | TECH-001 (deployment) |
| gym-vision-web | Dashboard/frontend | TECH-004 |

Non-code tickets (DEMO, CONTENT, INVESTOR, RESEARCH, BIZ, PARTNER, SOCIAL) are tracked in `gym-genius-ops` repo.

---

## Workstream 1: Core Technology

### TECH-001: Multi-Person Tracking
**Priority:** Critical
**Repos:** gym-vision (VIS-002, VIS-003)

**Description:**
Extend current single-person pose detection to reliably track 3-5 people simultaneously in frame with persistent identity across the session.

**Action Items:**
- [ ] Implement person detection (VIS-002)
- [ ] Implement ByteTrack for multi-person tracking (VIS-003)
- [ ] Handle occlusion and people crossing paths (re-identification)
- [ ] Benchmark: max concurrent people before accuracy degrades
- [ ] Test with overlapping workout areas (adjacent squat racks)
- [ ] Document failure modes and edge cases

**Success Criteria:**
- Track 4+ people simultaneously with <5% identity swap rate
- Maintain tracking when person is briefly occluded
- Runs at 30+ fps on RTX 5080

---

### TECH-002: Exercise Detection Expansion
**Priority:** High
**Repos:** gym-vision (VIS-005 future, requires training data)

**Description:**
Expand from current handful of exercises to cover the "demo set"—exercises that look impressive and are common enough that any viewer recognizes them.

**Action Items:**
- [ ] Define the demo exercise set (squat, bench, deadlift, pull-up, shoulder press, bicep curl, lat pulldown, leg press)
- [ ] Collect training data for each exercise (via annotation pipeline)
- [ ] Train/fine-tune detection for each exercise
- [ ] Handle exercise variations (wide vs narrow grip)
- [ ] Build confusion matrix: which exercises get misclassified

**Success Criteria:**
- 90%+ accuracy on demo exercise set
- <3% false positive rate (detecting exercise when person is just standing/walking)
- Works across different body types and clothing

**Dependency:** Requires annotation pipeline (ANN-001, ANN-002) to collect training data.

---

### TECH-003: Weight Detection
**Priority:** High
**Repos:** gym-vision (new ticket needed)

**Description:**
Key differentiator. Detecting 10 reps is table stakes. Detecting 10 reps at 185 lbs is genuinely useful data.

**Action Items:**
- [ ] Research approaches: plate recognition, barbell tracking, smart equipment integration
- [ ] Prototype plate reading for standard Olympic plates (45/35/25/10/5/2.5)
- [ ] Handle cable machines and dumbbells (may need different approach)
- [ ] Determine feasibility: what's demo-ready vs future roadmap
- [ ] Design graceful degradation (track reps even when weight detection fails)

**Success Criteria:**
- Accurately detect barbell weight within 5 lbs for 80%+ of sets
- Clear plan for dumbbell/cable detection
- Graceful fallback when weight detection fails

---

### TECH-004: Real-Time Dashboard
**Priority:** High
**Repos:** gym-vision-web (UI-*), gym-genius (GG-*)

**Description:**
The demo needs visual "wow factor." Live dashboard showing who's doing what, rep counts ticking up, session summaries appearing.

**Action Items:**
- [ ] Design dashboard layout (clarity and visual impact over feature density)
- [ ] Implement real-time feed with pose overlay (UI-014, UI-015)
- [ ] Show per-person exercise feed with live rep counts
- [ ] Add session summary cards as people finish sets
- [ ] Implement SSE/WebSocket for real-time updates

**Success Criteria:**
- Non-technical viewer immediately understands what they're seeing
- Latency from movement to dashboard update <500ms
- Looks professional enough for investor demo

---

### TECH-005: Data Export & Usefulness Proof
**Priority:** Medium
**Repos:** gym-genius (GG-005, new endpoints)

**Description:**
Show that collected data is valuable—insights that make gym member or trainer say "I want this."

**Action Items:**
- [ ] Define individual "session report" format
- [ ] Mock up gym-wide analytics (peak times, equipment utilization, popular exercises)
- [ ] Build simple export: JSON/CSV for sessions
- [ ] Create 2-3 example "insight" visualizations

**Success Criteria:**
- Gym owner looking at analytics immediately sees value
- User looking at session report learns something new
- Data format is clean for obvious integrations

---

## Workstream 2: Demo Environment

### DEMO-001: Lab Space Setup
**Priority:** Critical

**Description:**
Physical space that looks and feels like a gym section, not a garage with weights. For filming and live demos.

**Action Items:**
- [ ] Define minimum viable space: square footage, ceiling height, lighting
- [ ] Evaluate home space conversion vs commercial rental vs gym partnership
- [ ] Complete RESEARCH-006 (cost analysis) before committing
- [ ] Acquire equipment: squat rack, bench, dumbbells, pull-up bar minimum
- [ ] Install camera system: determine count and placement
- [ ] Lighting: consistent, gym-like lighting that works for CV

**Success Criteria:**
- Space looks professional on camera
- Can accommodate 4 people working out simultaneously
- Camera coverage handles full workout area

**Budget:** See RESEARCH-006 for cost analysis.

---

### DEMO-002: Hardware Finalization
**Priority:** High

**Description:**
Lock down edge computing setup. Demo should run on deployment-realistic hardware.

**Action Items:**
- [ ] Benchmark current RTX 5080 system performance
- [ ] Test on deployment-realistic hardware (Jetson Orin, mid-range GPU box)
- [ ] Document hardware requirements and estimated per-gym cost
- [ ] Create bill of materials for gym installation
- [ ] Have backup hardware ready for demo day

**Success Criteria:**
- Demo runs smoothly on hardware costing <$2k (or document actual cost)
- Clear BOM for gym installation
- No cloud dependency for real-time processing

---

### DEMO-003: Demo Participants
**Priority:** Medium

**Description:**
3-5 people willing to work out on camera. Should look like real gym-goers.

**Action Items:**
- [ ] Recruit 4-6 friends/acquaintances who lift
- [ ] Schedule 2-3 filming sessions (multiple takes needed)
- [ ] Brief them on exercises and timing
- [ ] Get signed release forms for video use

**Success Criteria:**
- Diverse group (body types, genders, experience levels)
- Good exercise form
- Comfortable on camera

---

## Workstream 3: Viral Demo Content

### CONTENT-001: Demo Video Concept
**Priority:** High

**Description:**
Define exactly what the viral demo shows. Short (60-90 seconds), visually striking, immediately different.

**Action Items:**
- [ ] Study existing viral fitness tech videos
- [ ] Storyboard: opening hook, "holy shit" moment, closer
- [ ] Decide format: screen capture, picture-in-picture, hybrid
- [ ] Write script/shot list
- [ ] Plan multi-platform versions (vertical + horizontal)

**Success Criteria:**
- Understandable with sound off
- Clear differentiation from "guy counts pull-ups on laptop"
- Clear next step (follow, sign up)

---

### CONTENT-002: Video Production
**Priority:** High
**Dependency:** Tech workstream substantially complete

**Description:**
Produce the demo video. Clean and professional, not Hollywood.

**Action Items:**
- [ ] Film raw footage in demo lab
- [ ] Capture clean screen recordings of dashboard
- [ ] Edit together per storyboard
- [ ] Add text overlays explaining what viewer sees
- [ ] Music/sound design
- [ ] Create versions: 60s hero, 30s teaser, 2min extended
- [ ] Create platform-specific edits (vertical, horizontal)

**Success Criteria:**
- Professional enough for VCs
- Optimized for all target platforms
- Clear call-to-action

---

### CONTENT-003: Social Media Groundwork
**Priority:** Medium

**Description:**
Establish baseline presence before viral push.

**Action Items:**
- [ ] Claim handles: @gymgenius on Twitter, Instagram, TikTok, LinkedIn
- [ ] Basic profile setup: logo, one-liner, link to landing page
- [ ] Post 3-5 "building in public" updates before demo drop
- [ ] Identify fitness tech influencers and communities

**Success Criteria:**
- Accounts exist and look legitimate
- Somewhere to direct interested people
- Small but real follower base

---

### CONTENT-004: Landing Page
**Priority:** Medium

**Description:**
Simple page to capture interest.

**Action Items:**
- [ ] One-pager: headline, explanation, email capture, demo video embed
- [ ] Set up email list (Mailchimp, ConvertKit)
- [ ] Basic analytics for traffic sources
- [ ] Mobile-friendly

**Success Criteria:**
- Loads fast, looks clean
- Email capture works
- Can track traffic sources

---

## Workstream 4: Investor Preparation

### INVESTOR-001: Pitch Deck
**Priority:** High

**Description:**
Standard 10-12 slide deck. Demo video does "does this work"—deck covers the business.

**Action Items:**
- [ ] Research fit-tech market size and trends
- [ ] Define business model: who pays, how much, for what
- [ ] Competitive landscape: who else, why different
- [ ] Go-to-market: 0→10 gyms, 10→100
- [ ] Team slide: background, advisors, planned hires
- [ ] The ask: amount, milestones
- [ ] Draft, get feedback from 2-3 people, iterate

**Success Criteria:**
- Coherent story in 10-12 slides
- Present in 10 minutes with Q&A time
- Anticipates objections with answers ready

---

### INVESTOR-002: Financial Model
**Priority:** Medium

**Description:**
Simple model showing unit economics and trajectory.

**Action Items:**
- [ ] Define pricing model (see RESEARCH-004)
- [ ] Estimate unit economics: deployment cost vs revenue
- [ ] 3-year projection with clear assumptions
- [ ] Identify key metrics to track

**Success Criteria:**
- Explainable in 2 minutes
- Clear, defensible assumptions
- Shows path to profitability

---

### INVESTOR-003: Equinox-Specific Prep
**Priority:** High

**Description:**
Equinox intro deserves specific preparation.

**Action Items:**
- [ ] Research Equinox's current tech stack and digital offerings
- [ ] Understand member demographic and values
- [ ] Identify internal champions (innovation team, digital product)
- [ ] Tailor pitch: premium experience enhancement, not cost reduction
- [ ] Prepare for "why wouldn't we build this ourselves?"

**Success Criteria:**
- Speak knowledgeably about Equinox's business
- Pitch tailored to their context
- Specific proposal ready (pilot structure, success metrics)

---

### INVESTOR-004: VC Meeting Prep
**Priority:** High

**Description:**
Research specific firm and partner.

**Action Items:**
- [ ] Research firm's portfolio: what fit-tech invested
- [ ] Research partner's background and interests
- [ ] Prepare for likely questions based on thesis
- [ ] Practice pitch with harsh feedback
- [ ] Prepare 3-5 questions to ask them

**Success Criteria:**
- Reference relevant portfolio companies
- Answers ready for likely concerns
- Prepared but not robotic

---

### INVESTOR-005: Elevator Pitch & Founder Story
**Priority:** High

**Description:**
Craft a compelling 60-second pitch that covers what, why now, why you, and why it matters.

**Draft Pitch:**
> "Gym Genius is automatic workout tracking for commercial gyms. Our computer vision system watches members lift and generates the training log they'd never write themselves—sets, reps, weight, rest times—plus insights on recovery and progress.
>
> This is possible now because pose estimation and object detection have gotten good enough to run in real-time on affordable hardware. Three years ago, this required cloud GPUs. Today, it runs on a $2k edge box.
>
> I've been obsessed with fitness tracking for years. I've talked to dozens of lifters who want this. Everyone tracks their workouts inconsistently because it's tedious. We make it automatic.
>
> For gyms, it's a differentiator that drives retention—members stay because their training history lives there. For members, it's the training log they always wanted but never maintained."

**Action Items:**
- [ ] Write 3 versions of the elevator pitch (technical, business, casual)
- [ ] Document founder story: background, passion, credibility
- [ ] Identify 2-3 "proof points" (conversations, interest, early validation)
- [ ] Practice delivering in under 60 seconds
- [ ] Get feedback from 3 people outside the project

**Success Criteria:**
- Can deliver pitch naturally without notes
- Listener can repeat back the core idea accurately
- At least one version works for VCs, one for gym owners

---

## Workstream 5: Research & Learning

### RESEARCH-001: Competitive Deep Dive
**Priority:** Medium

**Description:**
Know competition cold.

**Action Items:**
- [ ] Map landscape: CV-based gym tracking (Tempo, Tonal, etc.)
- [ ] Document: what's different about your approach
- [ ] Study pricing, GTM, customer feedback
- [ ] Identify market gaps
- [ ] Track new entrants and launches
- [ ] **Case Studies: Tempo, Tonal, Mirror**
  - [ ] What did they raise and when?
  - [ ] What worked? What didn't?
  - [ ] Why did they struggle post-COVID?
  - [ ] Lessons for B2B vs B2C positioning
  - [ ] Lessons for hardware strategy
  - [ ] Lessons for subscription model design
  - [ ] What would we do differently?

**Success Criteria:**
- Articulate positioning clearly
- Know top 5 competitors' strengths/weaknesses
- Evidence for why your approach wins
- Clear "lessons learned" from Tempo/Tonal/Mirror for investor conversations

---

### RESEARCH-002: Gym Owner Customer Discovery
**Priority:** Critical

**Description:**
Systematic customer discovery with gym owners. This validates everything else in the plan.

---

#### Part A: Conversation Guide

**Opening (2 min):**
- "I'm building technology for gyms and wanted to learn from people who actually run them."
- "I'm not selling anything today—just trying to understand the business better."
- "Can I ask you some questions about how you think about [member retention / technology / differentiation]?"

**Their Business (10 min):**
- "What type of members do you mostly serve?" (Demographics, goals)
- "What makes someone choose your gym over [competitor]?"
- "What's your biggest challenge right now?" (Open-ended, see what they say first)
- "How do you think about member retention? What causes people to leave?"

**Technology & Tools (10 min):**
- "What software/technology do you currently use to run the gym?"
- "How do members track their workouts here? Do most people log anything?"
- "Have you looked at any fitness tech solutions? What did you think?"
- "How do you feel about cameras in the gym? Any concerns from members?"

**The Concept (10 min):**
- "I'm working on a system that automatically tracks members' workouts using cameras—sets, reps, weight—and gives them insights. The gym gets data on equipment usage and trainer optimization."
- "What's your initial reaction to that?"
- "What questions or concerns come to mind?"
- "Would you want this branded as your gym's feature, or is a third-party platform okay?"
- "If members started asking for this, how would that affect your thinking?"

**Business Model (5 min):**
- "If something like this existed and worked well, how would you want to pay for it?" (Upfront, subscription, revenue share)
- "What would it need to do for you to try a pilot?"
- "Who else would need to approve a decision like this?"

**Closing (3 min):**
- "This was incredibly helpful. Can I follow up when I have something to show?"
- "Is there anyone else you think I should talk to?"

---

#### Part B: Outreach Strategy

**Warm Channels:**
- [ ] Personal network: Does anyone you know work at/own a gym?
- [ ] Equinox connection: Can they intro you to other gym contacts?
- [ ] LinkedIn: 2nd-degree connections to gym owners/managers
- [ ] Local gym members you know: Can they intro you to management?

**Cold Channels:**
- [ ] Walk-ins: Visit local premium gyms, ask to speak with manager/owner
- [ ] LinkedIn outreach: Connect with gym owners, send personalized message
- [ ] Email: Find gym owner emails via website, send brief intro
- [ ] Industry events: Gym owner conferences, fitness expos

**Target List (Premium Segment):**
- [ ] Identify 5 high-end independent gyms locally
- [ ] Identify 3 boutique strength/CrossFit gyms
- [ ] Identify 2 regional premium chains
- [ ] Research Equinox/Lifetime competitors in your area

---

#### Part C: Documentation

After each conversation, document:
- Date and gym name
- Who you spoke with (role)
- Top 3 takeaways
- Surprising insights
- Objections/concerns raised
- Interest level (1-5)
- Pilot potential (yes/maybe/no)
- Follow-up action

**Action Items:**
- [ ] Create target list of 15 gyms (premium segment focus)
- [ ] Reach out to 3 warm contacts first (easier conversations to practice)
- [ ] Conduct first 5 conversations
- [ ] Synthesize patterns after 5 conversations
- [ ] Adjust pitch/questions based on learnings
- [ ] Conduct next 5 conversations
- [ ] Identify 2-3 pilot candidates

**Success Criteria:**
- 10+ conversations before VC meeting
- Clear pattern of what they care about and would pay for
- 2+ warm leads for pilots
- Validated (or invalidated) key assumptions:
  - Platform vs white-label preference
  - Privacy concerns
  - Willingness to pay
  - Decision-making process

---

### RESEARCH-003: Technical Landscape
**Priority:** Low

**Description:**
Stay current on technical developments.

**Action Items:**
- [ ] Set up alerts (arXiv, Google Scholar)
- [ ] Follow key researchers and labs
- [ ] Track hardware releases
- [ ] Note anything that could change approach

**Success Criteria:**
- Not caught off guard by "have you seen X?"
- Aware of opportunities and threats

---

### RESEARCH-004: Deployment Model Research
**Priority:** High

**Description:**
Determine how to deploy in gyms and who pays for what.

**Action Items:**
- [ ] Research gym technology spending patterns
- [ ] Analyze deployment options:
  - Hardware bundle (you provide cameras/compute, gym pays subscription)
  - Software-only (integrate with existing cameras)
  - Hybrid (base hardware + software subscription)
- [ ] Cost-sharing models: what would gyms contribute vs you
- [ ] Research gym integration points (POS, member management, apps)
- [ ] Document pros/cons of each model

**Success Criteria:**
- 2-3 deployment models with clear tradeoffs
- Understanding of gym budget cycles and decision-making
- Preliminary pricing that makes sense for both parties

---

### RESEARCH-005: Target Segment Analysis
**Priority:** High

**Description:**
Determine which gym segments to target for pilots.

**Action Items:**
- [ ] Define gym segments: luxury, mid-market, boutique, specialty, university, corporate
- [ ] Analyze cost/benefit ratio for each segment
- [ ] Identify segment-specific value propositions
- [ ] Research decision-making process by segment
- [ ] Rank segments by pilot attractiveness (access, learning, reference value)

**Success Criteria:**
- Clear ranking of target segments
- Segment-specific pitch angles
- Know who decides and how at each segment

---

### RESEARCH-006: Demo Lab Cost Analysis
**Priority:** High

**Description:**
Full cost analysis before committing to demo lab setup.

**Action Items:**
- [ ] Home conversion costs:
  - Equipment (squat rack, bench, dumbbells, plates, pull-up bar)
  - Flooring/matting
  - Lighting upgrades
  - Camera/compute setup
- [ ] Commercial space costs:
  - Lease terms and rates for small spaces
  - Build-out requirements
  - Equipment (same as above)
  - Insurance considerations
- [ ] Gym partnership costs:
  - What would a gym want in exchange for off-hours access?
  - Any equipment needs
- [ ] Create comparison spreadsheet with ROI considerations

**Success Criteria:**
- Clear cost comparison of all options
- Recommendation with reasoning

---

### RESEARCH-007: Platform vs White-Label Validation
**Priority:** High

**Description:**
Test whether gyms accept a platform model (Gym Genius brand, member data portability) or demand white-label exclusivity.

**Action Items:**
- [ ] In gym owner conversations, ask: "Would you want this branded as your gym, or is a third-party platform okay?"
- [ ] Ask: "How do you feel about members taking their workout data if they leave?"
- [ ] Research how gyms handle other third-party platforms (ClassPass, Mindbody)
- [ ] Document which gym segments prefer which model
- [ ] Identify if enterprise vs independent gyms have different expectations

**Success Criteria:**
- Clear signal on platform acceptability by segment
- Understanding of deal-breakers (if any)
- Decision: platform-first, white-label option, or segment-specific approach

---

### RESEARCH-008: Social & Community Features Roadmap
**Priority:** Medium

**Description:**
Define the social/community layer that drives engagement and network effects.

**Action Items:**
- [ ] Map potential social features:
  - Leaderboards (gym-wide, global, friends)
  - PR celebrations and sharing
  - Friends/following system
  - Workout streaks and badges
  - Challenges (weekly, monthly, gym vs gym)
  - Activity feed
- [ ] Research what Strava/Peloton/Fitbit do well socially
- [ ] Prioritize: what's MVP vs v2 vs long-term
- [ ] Consider privacy implications (opt-in sharing levels)
- [ ] Identify features that drive gym-to-gym network effects

**Success Criteria:**
- Prioritized feature list with rationale
- Clear MVP social scope
- Privacy model defined

---

### RESEARCH-009: Pricing, Tiers & Unit Economics
**Priority:** High

**Description:**
Define what's free, what's premium, who pays, and model the unit economics.

**Action Items:**
- [ ] Define member tiers:
  - Free at enabled gym: what's included?
  - Premium member: what additional insights/features?
  - Non-enabled gym: what works without cameras?
- [ ] Define gym pricing:
  - Hardware lease: monthly cost, term length, what's included
  - Software subscription: flat vs per-member vs tiered by gym size
  - Revenue share on premium member subscriptions?
- [ ] Research competitor pricing (Mindbody, Wodify, gym software)
- [ ] Test pricing sensitivity in gym owner conversations
- [ ] **Unit Economics Model:**
  - [ ] Hardware cost per gym (cameras, compute, installation)
  - [ ] Hardware lease terms (months to recoup cost)
  - [ ] Software subscription pricing
  - [ ] B2C premium revenue potential per gym
  - [ ] Support/maintenance cost per gym
  - [ ] Churn assumptions
  - [ ] Calculate: Annual Revenue per Gym, CAC, LTV, months to break-even
  - [ ] Model scenarios: 10 gyms, 50 gyms, 100 gyms

**Success Criteria:**
- Clear pricing model for both B2B and B2C
- Unit economics spreadsheet with defensible assumptions
- Know: "At X gyms, we break even. At Y gyms, we're profitable."
- Pricing deck for gym conversations

---

### RESEARCH-012: Moat & Defensibility Strategy
**Priority:** High

**Description:**
Research and articulate defensibility against big players (Apple, Google, Peloton). Need clear answer for VC conversations.

**Action Items:**
- [ ] **Gym Relationships (Medium):**
  - How long does it take to build trusted gym partnerships?
  - What makes gym relationships sticky?
  - How do incumbents (Mindbody, ABC Fitness) defend their position?
- [ ] **Data Flywheel (Strong if scaled):**
  - What data advantages compound over time?
  - At what scale does data become a meaningful moat?
  - How does more data improve the product specifically?
- [ ] **Vertical Focus (Medium):**
  - Why won't big cos prioritize this niche?
  - What's the market size that's "too small" for them but great for us?
  - Examples of startups that won by vertical focus
- [ ] **Speed (Medium):**
  - What can we ship in 6 months that would take them 2 years?
  - How do we maintain speed advantage as we grow?
- [ ] **Brand with Members (Strong long-term):**
  - How do we build member loyalty to Gym Genius brand?
  - What makes members ask for us by name?
  - Strava as case study: how did they build brand moat?
- [ ] Draft "Why not Big Co?" one-pager for investor conversations

**Success Criteria:**
- Clear, confident answer to "What if Google does this?"
- Moat-building activities identified and prioritized
- One-pager ready for VC deck appendix

---

### RESEARCH-011: Privacy Messaging & Visual Indicators
**Priority:** Medium

**Description:**
Research how to communicate privacy-first approach effectively to gyms and members.

**Action Items:**
- [ ] Research how other CV companies communicate privacy (Amazon Go, Tesla, retail analytics)
- [ ] Explore visual indicator options (signage, screens showing skeleton view, app notifications)
- [ ] Draft privacy one-pager for gym owners
- [ ] Draft member-facing privacy explanation
- [ ] Test messaging in gym owner conversations

**Success Criteria:**
- Privacy messaging that reassures rather than raises concerns
- Clear visual indicator recommendation
- One-pager ready for sales conversations

---

### RESEARCH-010: Data Licensing Opportunities (Long-term)
**Priority:** Low

**Description:**
Explore long-term revenue from aggregated workout data and insights.

**Action Items:**
- [ ] Identify potential data buyers:
  - Insurance companies (activity-based premiums)
  - Equipment manufacturers (usage patterns)
  - Health/fitness apps (API integrations)
  - Research institutions (anonymized datasets)
- [ ] Research privacy/legal requirements for data licensing
- [ ] Outline what aggregated/anonymized data would look like
- [ ] Note for investor deck: mention as long-term upside, not core business

**Success Criteria:**
- List of potential data revenue streams
- Understanding of legal/privacy constraints
- Investor-ready talking points

---

### RESEARCH-013: Regulatory & Compliance
**Priority:** Low

**Description:**
Research legal/regulatory requirements for camera-based tracking in gyms.

**Action Items:**
- [ ] GDPR implications (if expanding to EU)
- [ ] CCPA requirements (California gyms)
- [ ] State-by-state recording consent laws
- [ ] Gym-specific liability concerns
- [ ] Insurance requirements for video systems
- [ ] ADA considerations

**Success Criteria:**
- Know what's required for US deployment
- Flag any deal-breakers or major compliance costs

---

### RESEARCH-014: Data Retention Policy
**Priority:** Low

**Description:**
Define what data is stored, for how long, and where.

**Action Items:**
- [ ] Define data types: video (none), skeleton/pose, workout logs, insights
- [ ] Retention periods for each data type
- [ ] Storage location (on-prem vs cloud for different data)
- [ ] Member data deletion process (GDPR "right to be forgotten")
- [ ] Cost implications of retention choices

**Success Criteria:**
- Clear data retention policy document
- Privacy-compliant and cost-efficient

---

### RESEARCH-015: Exit Vision & Strategy
**Priority:** Low

**Description:**
Think through potential exit paths to inform how you build and pitch.

**Action Items:**
- [ ] Map potential acquirers:
  - Fitness companies (Peloton, Lululemon, Life Fitness)
  - Health/wellness companies (Apple, Garmin, Whoop)
  - Gym software companies (Mindbody, ABC Fitness)
  - Tech companies (Google, Amazon)
- [ ] Research recent fitness tech acquisitions and valuations
- [ ] Consider: what makes you attractive to each type of acquirer?
- [ ] IPO path: what scale/metrics needed?

**Success Criteria:**
- Clear story for "where is this going?" investor question
- Build decisions informed by exit optionality

---

## Workstream 6: Business Operations

### BIZ-004: Sales Compensation Model
**Priority:** Medium

**Description:**
Define compensation structure for friend helping with intros/sales (and future sales help).

**Action Items:**
- [ ] Research standard commission structures for B2B SaaS sales
- [ ] Research equity grants for early sales advisors/helpers
- [ ] Define options: commission only, equity only, hybrid
- [ ] Consider: one-time intro fee vs ongoing commission on accounts they bring
- [ ] Draft simple agreement template

**Success Criteria:**
- Clear, fair structure ready before friend closes any deals
- Documented agreement to avoid awkwardness later

---

### BIZ-005: CRM & Pipeline Tracking
**Priority:** Medium

**Description:**
Set up simple system to track gym conversations, pipeline, and metrics.

**Action Items:**
- [ ] Evaluate options: Notion, Airtable, HubSpot free, spreadsheet
- [ ] Define pipeline stages: Lead → Conversation → Demo → Pilot → Contract
- [ ] Track: gym name, contact, status, notes, next action, interest level
- [ ] Set up simple dashboard/view for pipeline health

**Success Criteria:**
- All gym conversations tracked in one place
- Can answer "how many conversations this month?" instantly

---

### BIZ-006: Support Model Definition
**Priority:** Low

**Description:**
Define how support will work at different scales.

**Action Items:**
- [ ] Define support tiers: self-service, email, phone, on-site
- [ ] Estimate support load per gym (tickets/month)
- [ ] Define SLAs (response time expectations)
- [ ] Identify: at what scale do you need dedicated support person?
- [ ] Research support tools (Intercom, Zendesk, simple email)

**Success Criteria:**
- Clear support model for first 10 gyms
- Know when support becomes a bottleneck

---

### BIZ-001: Entity Formation
**Priority:** Medium

**Description:**
Need a real company to take VC money.

**Action Items:**
- [ ] Decide structure (Delaware C-Corp standard for VC)
- [ ] Register entity (Stripe Atlas, Clerky, or lawyer)
- [ ] Get EIN
- [ ] Open business bank account
- [ ] IP assignment (company owns the code)

**Success Criteria:**
- Legal entity can receive investment
- Clean cap table
- IP assignment documented

---

### BIZ-002: Budget & Runway Planning
**Priority:** Medium

**Description:**
Know spending and sustainability.

**Action Items:**
- [ ] Inventory current assets: hardware, savings
- [ ] Estimate demo lab costs (from RESEARCH-006)
- [ ] Estimate ongoing costs: software, cloud, incidentals
- [ ] Determine personal runway
- [ ] Define minimum viable raise amount

**Success Criteria:**
- Clear pre-funding cost picture
- Know personal runway
- Can articulate funding needs

---

### BIZ-003: Advisor Identification
**Priority:** Low

**Description:**
Identify valuable advisors.

**Action Items:**
- [ ] List expertise gaps: gym industry, VC, hardware scaling
- [ ] Identify potential advisors in network
- [ ] Wait until you have something to show
- [ ] Friend with Equinox/VC connections may be natural first

**Success Criteria:**
- Shortlist of 3-5 potential advisors
- Know what to ask each
- Ready to approach after demo

---

## Workstream 7: Gym Partnership Materials

### PARTNER-001: Gym Partnership Deck
**Priority:** High

**Description:**
Separate deck for gym partnerships (different from investor deck).

**Action Items:**
- [ ] Define value proposition for gym owners (not investors)
- [ ] Outline member experience improvements
- [ ] Show operational benefits (utilization data, safety monitoring)
- [ ] Case study mockups (what success looks like)
- [ ] ROI calculator concept
- [ ] Pilot program overview slide
- [ ] Address common objections (privacy, cost, integration)

**Success Criteria:**
- Gym owner understands value in first 3 slides
- Clear pilot proposal
- Addresses their concerns proactively

---

### PARTNER-002: Pilot Program Structure
**Priority:** High

**Description:**
Define what a pilot partnership looks like.

**Action Items:**
- [ ] Define pilot duration (30/60/90 days?)
- [ ] Define success metrics for pilot
- [ ] Create pilot agreement template
- [ ] Determine: free pilot vs subsidized vs paid
- [ ] Support commitment during pilot
- [ ] Graduation criteria to full deployment

**Success Criteria:**
- Clear, simple pilot proposal
- Metrics both parties agree matter
- Template agreement ready to customize

---

### PARTNER-003: Deployment Budget Calculator
**Priority:** Medium

**Description:**
Tool to show gyms what deployment costs and saves.

**Action Items:**
- [ ] Build spreadsheet with:
  - Hardware costs by gym size
  - Software/subscription costs
  - Installation estimates
  - Ongoing support costs
- [ ] Input variables: gym size, camera count, member count
- [ ] Value side: member retention, trainer efficiency, premium pricing potential
- [ ] Simple ROI calculation

**Success Criteria:**
- Gym owner can input their numbers
- Clear cost breakdown
- Credible value proposition

---

## Workstream 8: Social Media Strategy

### SOCIAL-001: Platform Strategy
**Priority:** Medium

**Description:**
Define approach for each platform.

**Action Items:**
- [ ] Platform-specific analysis:
  - Twitter/X: tech/startup audience, building in public
  - LinkedIn: B2B, gym industry professionals, investors
  - TikTok: consumer fitness audience, viral potential
  - Instagram: fitness community, visual demos
- [ ] Define tone and content type per platform
- [ ] Identify platform-specific success metrics
- [ ] Research posting frequency best practices

**Success Criteria:**
- Clear strategy document per platform
- Content templates for each
- Tracking metrics defined

---

### SOCIAL-002: Content Calendar
**Priority:** Medium

**Description:**
Pre-demo content plan.

**Action Items:**
- [ ] Define pre-launch content themes:
  - Behind-the-scenes development
  - Problem/pain point content
  - Tech explainers
  - Industry observations
- [ ] Create 4-week content calendar
- [ ] Prepare 10+ pieces of content in advance
- [ ] Plan demo launch sequence (teaser → launch → follow-up)

**Success Criteria:**
- 4 weeks of content ready before demo launch
- Clear launch day sequence
- Follow-up content planned

---

### SOCIAL-003: Influencer & Community Outreach
**Priority:** Low

**Description:**
Identify amplification opportunities.

**Action Items:**
- [ ] List fitness tech influencers (Twitter, YouTube)
- [ ] List fitness industry journalists/publications
- [ ] Identify relevant communities (Reddit, Discord, forums)
- [ ] Create outreach templates
- [ ] Build relationship before asking for amplification

**Success Criteria:**
- 20+ potential amplifiers identified
- Relationship-building started
- Outreach plan ready for launch

---

## Quick Reference: What Actually Matters

**The only things that truly matter for your next milestone:**

1. **The demo works reliably** — Multi-person, real-time, weight detection, looks impressive
2. **The video goes viral (or at least spreads)** — Proves market interest, creates inbound
3. **The Equinox meeting goes well** — Opens door to credible pilot
4. **The VC meeting goes well** — Funding to scale

Everything else supports these four outcomes.

---

## GitHub Tracking

**Repositories:**
- `gym-genius-ops` — Non-code tickets (DEMO, CONTENT, INVESTOR, RESEARCH, BIZ, PARTNER, SOCIAL)
- `gym-genius` — Backend API code
- `gym-vision` — ML/CV library code
- `gym-vision-web` — Dashboard code
- `gym-vision-inference` — Inference service code

**Project Board:** "Gym Genius - Pre-Investment" (cross-repo)

---

## Notes

- Revisit priorities weekly as you learn
- Don't let infrastructure work become procrastination from real work
- TECH tickets align with existing gym-vision GitHub Issues where possible

---

*Last updated: 2025-12-18*
