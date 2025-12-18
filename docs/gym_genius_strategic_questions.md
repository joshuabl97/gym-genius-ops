# Gym Genius: Strategic Questions

Deep business planning questions to strengthen the pre-investment action plan.

---

## Vision & Positioning

### Q1: Why gyms?
You could apply this tech to home fitness, physical therapy clinics, sports training facilities, or corporate wellness. What makes commercial gyms the right wedge? Is it market size, access, or something else?

**Your Answer:**
- Gym members love data about their fitness and actively seek insights
- Gyms are always looking for value-adds to differentiate and justify premium pricing
- Multiple revenue angles: member retention, premium tier subscriptions, operational insights
- Personal passion: I love fitness, love tracking workouts, and want to build complex AI technology
- Talked to many others who want automatic workout tracking with insights

**Primary value prop for first 10 gyms:** Members can track workouts and receive insights automatically—no manual logging.

**Long-term vision:** Member-facing app with personalized insights (recovery, deload timing, progress tracking).

**Implications for Plan:**
- Demo needs to prove the tech works (multi-person, occlusion handling)
- Gym-facing dashboard is the proof point, but member value is the pitch
- Need to validate: will gyms pay for member benefits, or do members pay directly?
- Add ticket: Explore sports training facilities as secondary segment

---

### Q2: Who is the actual customer?
The plan references gym owners, but within a gym there are owners, managers, trainers, and members. Who writes the check? Who champions the purchase internally? Who uses it daily? Are these the same person?

**Your Answer:**
- **Pitch to:** Gym owners (they write the check)
- **Trainers:** Position as champions, not threats. "Trainers teach form, app helps members stay consistent between sessions."
- **Brand strategy:** Gym Genius is a platform brand, not white-labeled. Members have Gym Genius accounts that work across gyms.
- **Data portability:** Members keep their data regardless of gym. Can sync between gyms. Can even use app at non-enabled gyms to maintain insights.

**Implications for Plan:**
- Building a platform, not a white-label tool
- Two products needed: gym-facing dashboard + member-facing app
- Need to test if gyms accept platform model or demand white-label exclusivity
- Trainer pitch: "See what your client did since your last session"
- Potential tension: gyms want lock-in, members want portability—we're siding with members
- Opens B2C revenue possibility (members pay for premium features directly?)

---

### Q3: What business are you really in?
Is Gym Genius a:
- Hardware company that sells camera/compute bundles?
- SaaS company that licenses software?
- Data company that monetizes workout insights?
- Platform that connects gyms, trainers, and members?

Each implies a different valuation multiple, growth trajectory, and competitive moat.

**Your Answer:**
**Platform + Data hybrid.** Similar to Strava model:
- Gyms pay for infrastructure/software (B2B revenue)
- Members have accounts that work across gyms (platform)
- Workout data and insights are the real value (data moat)
- Network effects: more gyms → more valuable for members → more gyms want in

**Key elements confirmed:**
1. **Social/community features:** Yes - leaderboards, PRs, friends' activity
2. **Free vs paid tiers:** Yes - define what's free at enabled gyms, what's premium, what's available at non-enabled gyms
3. **Platform competition:** Yes - gyms compete to be "Gym Genius enabled" (like restaurants wanting good Yelp reviews)
4. **Data licensing (long-term):** Probably - insurance companies, equipment manufacturers, health apps

**Implications for Plan:**
- Need social feature roadmap
- Need pricing/tier structure definition
- Brand building matters (members need to know and want Gym Genius)
- Long-term data strategy worth outlining for investor conversations
- Valuation story: "We're building the Strava of strength training"

---

## Customer & Market

### Q4: What problem are you solving for the gym?
The plan mentions member engagement, trainer efficiency, and equipment utilization—but which one is the *hair-on-fire* problem that makes a gym owner say "I need this now"? Or is this a "nice to have" that struggles to compete with HVAC repairs and payroll?

**Your Answer:**
**Multi-layered value prop.** This is an **up-market sell**.

| Problem | Pain Level | Who Feels It | Our Solution |
|---------|------------|--------------|--------------|
| Member churn | HIGH | Owner (revenue) | "Members stay because their data lives here" |
| Differentiation | HIGH | Owner (competition) | "Premium feature competitors don't have" |
| Trainer utilization | MEDIUM | Manager | "See which members need trainer attention" |
| Equipment ROI | MEDIUM | Owner | "Know which equipment is used vs gathering dust" |

**Primary pitch:** Retention + differentiation (what gets the meeting)
**Secondary value:** Trainer insights + equipment data (what deepens the relationship)

**Implications for Plan:**
- Target segment: Premium/luxury gyms (Equinox, Lifetime, high-end independents, boutique strength gyms)
- NOT budget gyms (Planet Fitness, Crunch) - they compete on price, not features
- Pitch angle: "Premium experience" not "cost reduction"
- Price accordingly - if you're selling to gyms charging $150-300/month, they can afford premium software
- Sales motion: likely slower, more relationship-driven, but higher ACV
- Network effect play: if premium gyms adopt, mid-market follows to compete
- Dashboard should surface trainer utilization + equipment insights for gym-side value

---

### Q5: Have you talked to any gym owners yet?
If so, what surprised you? If not, what's stopping you? The plan has RESEARCH-002 (gym owner conversations) but this seems foundational to everything else.

**Your Answer:**
Not yet. Need a plan for what to talk about and a pathway to get conversations.

**Implications for Plan:**
- Expand RESEARCH-002 into a full customer discovery playbook
- Create conversation guide with specific questions
- Define outreach strategy (how to get meetings)
- This should be high priority—validates everything else

---

### Q6: What's the gym's alternative today?
How do gyms currently solve (or ignore) these problems? What would you be replacing—clipboards, trainer intuition, nothing at all?

**Your Answer:**
**Replacing apathy/nothing.** Most members don't track consistently. The competition isn't other apps—it's member inertia.

Pitch angle: "Your members want to track but don't. We make it automatic."

**Implications for Plan:**
- Don't position against other tracking apps (different battle)
- Position as "zero friction" - member does nothing, data appears
- Emphasize what members miss by not tracking (the pain of no data)

---

### Q7: Why would a gym trust a camera-based system?
Privacy concerns are real. Some members actively avoid gyms with cameras. How do you address this? Is consent opt-in? What data is stored vs. discarded?

**Your Answer:**
- **No video stored** — Only pose/skeleton data extracted, raw video discarded
- **Opt-in consent** — Members must explicitly consent before tracking
- **On-premise processing** — Data processed locally, never leaves gym hardware
- **Existing cameras** — Gyms already have security cameras; members accept this
- **Visual indicators** — Need research on how to communicate this effectively

**Implications for Plan:**
- Add ticket: Research privacy messaging and visual indicators that sell (how do other CV companies communicate this?)
- Technical architecture must support on-prem (no cloud dependency for real-time)
- Consent flow is part of member app onboarding
- Privacy positioning is a selling point, not a weakness

---

## Business Model

### Q8: What's the deployment cost vs. recurring revenue?
You mention hardware potentially costing <$2k—who absorbs that cost? If the gym pays upfront, your sales cycle lengthens. If you eat it, your burn rate increases dramatically.

**Your Answer:**
**Hardware lease + subscription model.**
- Gym pays monthly hardware lease (covers your hardware cost over time)
- Gym pays separate software subscription
- Lower barrier to entry than big upfront cost
- You don't fully eat hardware cost upfront

Example: $300/mo hardware lease + $500/mo software = $800/mo total

**Implications for Plan:**
- Need to model lease terms (how many months to recoup hardware cost?)
- May need equipment financing partner or enough capital to float hardware
- Pricing research should test this specific structure
- Contract terms matter (minimum commitment to recoup hardware)

---

### Q9: What's a gym worth to you annually?
If you charge $X/month, what does your unit economics look like? Hardware amortization, support costs, churn risk?

**Your Answer:**
Needs research and modeling. Ticket it.

**Implications for Plan:**
- Add to RESEARCH-009 or create separate unit economics ticket
- Model: hardware lease terms, software subscription, B2C revenue share
- Calculate: months to recoup hardware, break-even per gym, LTV

---

### Q10: How do you make money from members (if at all)?
Does the gym pay flat rate, per-member, or usage-based? Is there a B2C angle where members pay directly for premium features?

**Your Answer:**
**Gym controls premium pricing. 100% of premium revenue goes back to gym (reduces their bill).**

- Gyms can opt into charging members for premium features
- Gym keeps all premium revenue (or it offsets their subscription cost)
- Aligns incentives: gym is motivated to promote premium adoption
- You don't deal with B2C billing complexity directly
- Effectively: gym's net cost decreases as premium adoption increases

**Implications for Plan:**
- Simpler billing (B2B only, no direct B2C payments)
- Gym becomes your sales channel for premium
- Need to give gyms tools to promote premium to members
- Model this in unit economics (gym net cost at various adoption rates)

---

## Competition & Defensibility

### Q11: What happens when Peloton, Apple, or Google enters this space?
They have the capital, distribution, and brand trust. What's your moat? Is it:
- Proprietary models? (Can be replicated)
- Gym relationships? (Takes time but not impossible)
- Data flywheel? (Requires scale first)
- Regulatory/compliance expertise? (Underrated moat)

**Your Answer:**
"They could, but they won't prioritize it because [X], and by the time they do, we'll have [Y]."

Need to research and articulate the specific moats. Focus on medium/strong:
- Gym relationships (Medium)
- Data flywheel (Strong if scaled)
- Vertical focus (Medium)
- Speed (Medium)
- Brand with members (Strong long-term)

**Implications for Plan:**
- Add ticket: Moat & Defensibility Research
- Need clear answer for VC conversations
- Build moat-strengthening activities into roadmap

---

### Q12: Why hasn't this been done already?
The components (pose estimation, object detection) are available. What's the insight that makes this possible *now* that wasn't possible 3 years ago?

**Your Answer:**
1. **Tech cost reduced** — Edge compute and cameras now affordable for gym-scale deployment
2. **AI accuracy crossed threshold** — Pose estimation and object detection now reliable enough
3. **Big players focused elsewhere** — Enterprise CV companies chasing bigger markets (retail analytics, warehouse utilization, people counting) not gym-specific use cases

The niche is too small for big CV companies but perfect for a focused startup.

**Implications for Plan:**
- "Why now" slide in pitch deck should hit all three points
- Ties into moat research (vertical focus)

---

### Q13: What do Tempo, Tonal, and Mirror teach you?
They raised hundreds of millions but some have struggled. What's the lesson? Is it that hardware is hard? That consumer fitness is fickle? That B2B is the right model?

**Your Answer:**
Needs deeper research. Ticket it.

**Implications for Plan:**
- Add ticket: Case study research on Tempo, Tonal, Mirror
- Extract lessons for B2B positioning, hardware strategy, subscription models

---

## Risk & Contingency

### Q14: What's your single point of failure?
If you had to identify one thing that could kill this, what is it? Technical (can't hit accuracy)? Market (gyms don't care)? Funding (can't raise)?

**Your Answer:**
"Not much lol, just having fun making tech and learning stuff."

Honest founder energy: low stress, enjoying the build. Not fear-driven.

**Implications for Plan:**
- Great mindset for endurance and creativity
- For VC conversations: still need to articulate awareness of risks (they'll ask)
- Frame it as: "I'm clear-eyed about risks but not paralyzed by them"

---

### Q15: What if the Equinox meeting doesn't lead anywhere?
Is the entire plan dependent on that intro? What's Plan B for your first pilot?

**Your Answer:**
One of many paths. Not dependent on Equinox. Other options: Lifetime, high-end independents, boutique gyms, university rec centers.

---

### Q16: What if the tech works but sales are slow?
Do you have 12-18 months of runway to grind through a long enterprise sales cycle? Or do you need viral consumer pull to survive?

**Your Answer:**
Have a job, not quitting. Fine developing slowly unless investor wants to accelerate. No runway pressure.

---

## Founder-Market Fit

### Q17: Why are you the right person to build this?
What's your unfair advantage—domain expertise, technical skills, relationships, or something else? VCs will ask.

**Your Answer:**
- Understand complexities of technical deployments
- Experience in IoT and Vision Intelligence space from MachineQ/Comcast
- Personal passion for fitness and tracking

---

### Q18: What would make you quit?
Not the optimistic case—the realistic threshold where you'd walk away. Understanding this helps scope the raise and the commitment.

**Your Answer:**
- Someone beating me to it definitively
- Resounding "nobody wants this" signal from market

---

### Q19: Can you sell?
The tech might be the easy part. Can you walk into a gym, build trust with the owner, and close a pilot? If not, how do you acquire this skill or find someone who has it?

**Your Answer:**
- Can try, willing to learn
- Friend making Equinox intros is good at selling
- Could offer commission to friend for initial sales
- Need ticket: explore equity/commission structure for early sales help

**Implications for Plan:**
- Add ticket: Sales compensation model (commission vs equity for early sales help)

---

## Go-to-Market

### Q20: Is viral content actually the right strategy?
The plan bets heavily on a demo video creating inbound interest. But B2B sales often don't work this way—gym owners aren't scrolling TikTok for software. Is viral content for VCs/talent/credibility, or genuinely for customer acquisition?

**Your Answer:**
Who knows, but posting content can't hurt. Worth trying.

---

### Q21: What's your 0→1→10 plan?
First gym (probably free or heavily subsidized), first 10 gyms (maybe discounted pilots), first 100 gyms (real sales motion). How does each phase differ?

**Your Answer:**
**Two parallel paths:**
1. **Small partner (preferred):** High-end independent gym. Less approval, faster iteration, hands-on access. Allows full focus on product development.
2. **Equinox:** Parallel credibility play via intro. Slower but valuable for brand/reference.

**Phases:**
- 0→1: Land one small premium gym partner (fast iteration focus)
- 1→10: Individual sales/pilots + leverage Equinox intro if successful
- 10→100: Expand successful pilots to chains/regions

---

### Q22: What's the sales cycle length?
Enterprise gym chains might take 6-12 months. Independent gyms might decide in a week. Which are you targeting first, and why?

**Your Answer:**
Doesn't matter for now. Pilots to commercial will take ~year. Graph out what each would look like and track metrics in simple CRM tool.

**Implications for Plan:**
- Add ticket: CRM/pipeline tracking setup

---

## Success Metrics

### Q23: What does "working" look like for the demo?
Is it 90% accuracy? 95%? What's the threshold where a gym owner goes "okay, I'll try this" vs. "interesting, but not ready"?

**Your Answer:**
Demo works and looks impressive. That's the bar.

---

### Q24: What's your north star metric post-launch?
Active gyms? Monthly active members tracked? Accuracy scores? Revenue?

**Your Answer:**
Gym owner wants more than 2 meetings regarding partnership (shows genuine interest).

---

### Q25: How do you measure product-market fit?
What signal would tell you "we have something" vs. "we're still searching"?

**Your Answer:**
Quantity of north star metric (repeat interest from gym owners). TBD on specific threshold.

---

## Missing from the Plan

### Q26: Where's the team slide?
You're solo now, but what hires are needed post-funding? CTO, sales lead, ML engineer? What's the org chart at $1M ARR?

**Your Answer:**
No need to worry about team needs now. Solo for foreseeable future.

---

### Q27: What about ongoing support?
Gyms will have issues. Who handles support calls? At what scale does this become a bottleneck?

**Your Answer:**
Needs definition. Ticket it - define support model and options.

**Implications for Plan:**
- Add ticket: Support model definition

---

### Q28: Is there a regulatory angle?
GDPR, CCPA, or gym-specific liability concerns? Insurance requirements for video systems in gyms?

**Your Answer:**
Needs research. Ticket it.

---

### Q29: What's the data retention policy?
Do you store video? Just skeleton data? How long? This affects costs and privacy posture.

**Your Answer:**
Needs research. Ticket it.

---

### Q30: What's your exit vision?
Acquisition by fitness company, health company, or tech company? IPO? This shapes how you build and who you pitch.

**Your Answer:**
Needs research. Ticket it.

---

## Summary

### Key Strategic Decisions Made
1. **Business model:** Platform + Data hybrid (like Strava for strength training)
2. **Target market:** Up-market premium gyms (Equinox, Lifetime, high-end independents)
3. **Primary value prop:** Member retention + differentiation (secondary: trainer insights, equipment ROI)
4. **Pricing model:** Hardware lease + software subscription (gym controls premium pricing for members)
5. **Privacy stance:** No video stored, opt-in consent, on-premise processing
6. **Brand strategy:** Gym Genius platform (not white-label), member data portability
7. **Go-to-market:** Two paths—small partner (fast iteration) + Equinox (credibility); prefer small first

### Founder Context
- Has job, not quitting—no runway pressure
- Background: IoT/Vision Intelligence at MachineQ/Comcast
- Solo for foreseeable future
- Friend helping with Equinox intro (need compensation structure)

### Tickets Added From This Session
- INVESTOR-005: Elevator Pitch & Founder Story
- RESEARCH-007: Platform vs White-Label Validation
- RESEARCH-008: Social & Community Features Roadmap
- RESEARCH-009: Pricing, Tiers & Unit Economics (expanded)
- RESEARCH-010: Data Licensing Opportunities
- RESEARCH-011: Privacy Messaging & Visual Indicators
- RESEARCH-012: Moat & Defensibility Strategy
- RESEARCH-013: Regulatory & Compliance
- RESEARCH-014: Data Retention Policy
- RESEARCH-015: Exit Vision & Strategy
- BIZ-004: Sales Compensation Model
- BIZ-005: CRM & Pipeline Tracking
- BIZ-006: Support Model Definition
- RESEARCH-002 expanded into full customer discovery playbook

### Biggest Uncertainties (Need Validation)
- Will gyms accept platform model vs demand white-label?
- Actual willingness to pay (pricing sensitivity)
- Privacy messaging that sells vs scares

### North Star Metric
Gym owner wants 2+ meetings (shows genuine interest)

---

*Completed: 2025-12-18*
