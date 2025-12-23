# Gym Genius Equipment Utilization - Financial Model v2

> **Status:** Draft - Research Integrated
> **Last Updated:** 2025-12-22
> **Owner:** Business Agent

---

## 1. INPUTS

### 1.1 Hardware Bill of Materials (Per Gym)

#### Edge Compute Options (Validated Dec 2025)

| Device | Price | Specs | Best For |
|--------|-------|-------|----------|
| **Raspberry Pi 5 (8GB) + Hailo-8** | $275 | 26 TOPS ($95 + $180) | Budget deployments |
| **NVIDIA Jetson Orin Nano Super** | $249 | 67 TOPS, dev kit | **Recommended for pilots/production** |
| NVIDIA Jetson Orin NX | $1,000 | 100+ TOPS, module | Large facilities (6-8+ cameras) |
| Intel NUC 13 Pro + Arc A380 | $650-800 | Discrete GPU | Overkill for this use case |
| **Model Default** | **$249** | Jetson Orin Nano Super | |

> **Note:** Previous versions incorrectly listed Orin NX at $249. That price is for the Orin Nano Super. The Orin NX module is ~$1,000. For most gym deployments (4-6 cameras), the Orin Nano Super at 67 TOPS is sufficient.

#### Camera Options (Validated Dec 2025)

| Camera | Price | Specs | Best For |
|--------|-------|-------|----------|
| **Reolink RLC-810A (PoE)** | $90 | 8MP, wide angle, no sub | **Budget - great value** |
| Amcrest UltraHD 4MP | $80-120 | 4MP, PoE, solid low-light | Budget |
| **Hikvision DS-2CD2143G2-I** | $125-156 | 4MP, 110° FOV, IR, PoE | **Recommended commercial** |
| Axis P1365-E | $400-500 | 1080p, Zipstream | Premium (overkill) |
| **Model Default** | **$140** | Hikvision commercial | |

> **Note:** Camera prices validated significantly lower than original estimates. Hikvision at $140 avg vs $300 previously. Reolink at $90 offers excellent 8MP quality for budget deployments.

---

### 1.1.1 Deployment Models

We offer two deployment models based on site assessment:

| Model | Description | Best For |
|-------|-------------|----------|
| **Model A: Hybrid** | Leverage existing gym cameras + supplementary | Gyms with IP/PoE security systems |
| **Model B: Full Install** | Complete camera system, no existing reliance | New builds, analog-only gyms |

---

### 1.1.2 Site Assessment Process

**Pre-Sale Assessment Checklist:**

| Item | What We Check | Why It Matters |
|------|---------------|----------------|
| Existing Camera Inventory | Count, locations, brands/models | Determines hybrid viability |
| Camera Type | IP/PoE vs Analog/Coax | Analog = Full Install only |
| NVR Access | Can we get RTSP feeds? | Integration feasibility |
| Equipment Zones | Map cardio, weights, machines, functional | Defines coverage needs |
| Coverage Gaps | Which zones need new cameras? | Supplementary camera count |
| Network Infrastructure | PoE switch capacity, cabling runs | Installation complexity |
| Sqft & Layout | Floor plan, sight lines, obstructions | Camera placement planning |

**Assessment Output:** Quote for Model A (Hybrid) or Model B (Full Install)

---

### 1.1.3 Inference Architecture (Dwell Time Detection)

**Key Insight:** We measure dwell time in equipment zones, not real-time tracking.

| Requirement | Value | Implication |
|-------------|-------|-------------|
| Metric | Dwell time per zone | Binary: "someone in zone" yes/no |
| Accuracy | 99% over 2-min windows | 1 FPS sufficient for accuracy |
| Sampling Rate | 1 frame per second | 1 FPS vs 30 FPS typical |
| Compute Load | ~30x reduction vs real-time | Orin Nano Super handles ALL tiers |

**Capacity at 1 FPS:**

| Device | Capacity @ 30 FPS | Capacity @ 1 FPS | Notes |
|--------|-------------------|------------------|-------|
| Orin Nano Super | 4-6 streams | **60-90 streams** | Sufficient for all Hybrid deployments |
| 2x Orin Nano Super | 8-12 streams | **120-180 streams** | Required for Enterprise Full Install |

**Why This Matters:** At 1 FPS, a single Orin Nano Super ($249) can process 60-90 camera streams. Enterprise Full Install (75 cameras) uses 2x units for headroom and redundancy.

---

### 1.1.4 Equipment Zones (Typical Gym)

| Zone | Typical Equipment | Priority |
|------|-------------------|----------|
| Cardio | Treadmills, bikes, ellipticals | High |
| Free Weights | Dumbbells, barbells, racks | High |
| Resistance Machines | Cable machines, leg press, etc. | High |
| Functional/Stretching | Mats, TRX, kettlebells | Medium |
| Group Fitness Studio | Open floor | Optional |

**Typical zones to monitor:** 4-8 per gym

---

### 1.1.5 Camera Requirements

#### Full Install (1 camera per 600 sqft)

| Segment | Avg Sqft | Cameras Needed |
|---------|----------|----------------|
| Small Boutique | 5,500 | 9 |
| Mid Independent | 11,500 | 19 |
| Large Facility | 22,500 | 38 |
| Enterprise | 45,000 | 75 |

#### Hybrid (Leverage Existing + Supplement)

| Segment | Existing Cams (est.) | Usable for Zones | Supplementary Needed |
|---------|---------------------|------------------|---------------------|
| Small Boutique | 5 | 2 | 4 |
| Mid Independent | 10 | 4 | 5 |
| Large Facility | 14 | 6 | 7 |
| Enterprise | 20 | 9 | 10 |

---

### 1.1.6 Hardware BOM: Model A — Hybrid (Validated Dec 2025)

**Leverages existing gym cameras + supplementary cameras for equipment zones**

**Small Boutique (5,500 sqft) — Hybrid**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | Handles all streams at low FPS |
| Supplementary Cameras (4x @ $140) | $560 | Fill coverage gaps |
| 8-port PoE Switch | $75 | For new cameras |
| Mounting/Cabling | $150 | |
| Contingency (10%) | $103 | |
| **TOTAL** | **$1,137** | |

**Mid Independent (11,500 sqft) — Hybrid**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | |
| Supplementary Cameras (5x @ $140) | $700 | |
| 8-port PoE Switch | $75 | |
| Mounting/Cabling | $200 | |
| Contingency (10%) | $122 | |
| **TOTAL** | **$1,346** | |

**Large Facility (22,500 sqft) — Hybrid**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | |
| Supplementary Cameras (7x @ $140) | $980 | |
| 16-port PoE Switch | $150 | |
| Mounting/Cabling | $300 | |
| Contingency (10%) | $168 | |
| **TOTAL** | **$1,847** | |

**Enterprise (45,000 sqft) — Hybrid**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | Still sufficient at low FPS |
| Supplementary Cameras (10x @ $140) | $1,400 | |
| 16-port PoE Switch | $150 | |
| Mounting/Cabling | $400 | |
| Contingency (10%) | $220 | |
| **TOTAL** | **$2,419** | |

---

### 1.1.7 Hardware BOM: Model B — Full Install (Validated Dec 2025)

**Complete camera system — no reliance on existing infrastructure (1 camera per 600 sqft)**

**Small Boutique (5,500 sqft) — Full Install**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | |
| Cameras (9x @ $140) | $1,260 | |
| 16-port PoE Switch | $150 | |
| Mounting/Cabling | $300 | |
| Contingency (10%) | $196 | |
| **TOTAL** | **$2,155** | |

**Mid Independent (11,500 sqft) — Full Install**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | |
| Cameras (19x @ $140) | $2,660 | |
| 24-port PoE Switch | $250 | |
| Mounting/Cabling | $500 | |
| Contingency (10%) | $366 | |
| **TOTAL** | **$4,025** | |

**Large Facility (22,500 sqft) — Full Install**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super | $249 | |
| Cameras (38x @ $140) | $5,320 | |
| 2x 24-port PoE Switch | $500 | |
| Mounting/Cabling | $900 | |
| Contingency (10%) | $697 | |
| **TOTAL** | **$7,666** | |

**Enterprise (45,000 sqft) — Full Install**

| Component | Cost | Notes |
|-----------|------|-------|
| Jetson Orin Nano Super (x2) | $498 | Redundancy |
| Cameras (75x @ $140) | $10,500 | |
| 4x 24-port PoE Switch | $1,000 | |
| Mounting/Cabling | $1,800 | |
| Contingency (10%) | $1,380 | |
| **TOTAL** | **$15,178** | |

---

### 1.1.8 Hardware BOM Summary

| Segment | Hybrid BOM | Full Install BOM | Delta |
|---------|------------|------------------|-------|
| Small Boutique | $1,137 | $2,155 | +$1,018 (+90%) |
| Mid Independent | $1,346 | $4,025 | +$2,679 (+199%) |
| Large Facility | $1,847 | $7,666 | +$5,819 (+315%) |
| Enterprise | $2,419 | $15,178 | +$12,759 (+527%) |

> **Key Insight:** Hybrid model significantly reduces hardware costs by leveraging existing gym security cameras.

#### Installation Costs (6 Cameras - Professional)

| Level | Total Cost | Includes |
|-------|------------|----------|
| Budget | $4,500-6,000 | Basic labor, standard cabling |
| **Mid-Range** | **$8,000-12,000** | Professional labor, quality cabling, NVR setup |
| Premium | $12,000-18,000 | Custom install, fiber/CAT6a, redundant |

**For Model:** Using contractor install at $800 (labor portion only, hardware separate)

---

### 1.2 Monthly Costs Per Gym (COGS)

#### Cloud Infrastructure Options

| Stack | Cost/Gym/Mo | Setup Time | Best For |
|-------|-------------|------------|----------|
| Supabase + Vercel | $25-30 | 1 hour | **Recommended for 0-250 gyms** |
| AWS Optimized | $20-25 | 8+ hours | 100+ gyms with DevOps |
| Vercel + PlanetScale | $2-3 | 3 hours | Tight budget |

**Cost Breakdown (Supabase Stack):**

| Item | Cost | Notes |
|------|------|-------|
| Supabase Pro | $25 | Postgres + Auth + Storage |
| Vercel Pro (amortized) | $0.40 | Dashboard hosting |
| Domain/monitoring | $0.60 | Per gym share |
| **Total Cloud** | **$26** | Per gym |

#### Monthly COGS Summary

| Item | Cost | Notes |
|------|------|-------|
| Cloud/Infrastructure | $26 | Supabase + Vercel |
| Support Allocation | $40 | ~1 hr/gym/month @ $40/hr |
| Software Maintenance | $20 | Updates, monitoring |
| **TOTAL MONTHLY COGS** | **$86** | Per gym |

---

### 1.3 Pricing Assumptions

#### Multi-Margin Pricing Tiers

| Margin Target | Per Sqft Rate | Base Fee | Notes |
|---------------|---------------|----------|-------|
| 50% Margin | $0.0086 | $172 | Minimum viable |
| **65% Margin** | **$0.0123** | **$246** | **Recommended** |
| 80% Margin | $0.0215 | $430 | Premium positioning |

**Formula:**
```
Monthly COGS = $86
Target Price = COGS / (1 - Margin)

At 50% margin: $86 / 0.50 = $172 minimum
At 65% margin: $86 / 0.35 = $246 minimum
At 80% margin: $86 / 0.20 = $430 minimum

Per Sqft Rate = (Target Price - Base Fee) / Weighted Avg Sqft
```

**Model Default:** 65% margin

| Parameter | Value | Notes |
|-----------|-------|-------|
| Target Gross Margin | 65% | On software revenue |
| Hardware Markup | 20% | On hardware sale |
| Base Platform Fee | $246/mo | Minimum monthly |
| Per Sqft Rate | $0.0123/sqft/mo | Variable component |
| Contract Term | 12 months | Annual commitment |
| Annual Churn Rate | 12% | Expected attrition |
| Avg Customer Lifetime | 100 months | = 1/churn × 12 |

---

### 1.4 Gym Size Segments with Per Sqft Costs

| Segment | Sqft Range | Avg Sqft | Mix % | COGS/Sqft |
|---------|------------|----------|-------|-----------|
| Small Boutique | 3,000-8,000 | 5,500 | 20% | $0.0156 |
| Mid Independent | 8,000-15,000 | 11,500 | 35% | $0.0075 |
| Large Facility | 15,000-30,000 | 22,500 | 30% | $0.0038 |
| Enterprise | 30,000-60,000 | 45,000 | 15% | $0.0019 |
| **Weighted Average** | | **15,625** | 100% | **$0.0055** |

---

### 1.5 Company Operating Expenses (Monthly)

| Item | Pre-Revenue | Growth (10-25 gyms) | Scale (50+ gyms) |
|------|-------------|---------------------|------------------|
| Founder Salary | $0 | $0 | $10,000 |
| Employee Salaries | $0 | $0 | $13,000 |
| Cloud/Infrastructure | $100 | $300 | $1,000 |
| Tools/Subscriptions | $50 | $150 | $500 |
| Marketing/Sales | $50 | $500 | $2,000 |
| Contractors | $0 | $1,000 | $0 |
| Legal/Accounting | $0 | $200 | $500 |
| Office/Workspace | $0 | $0 | $500 |
| **TOTAL MONTHLY OPEX** | **$200** | **$2,150** | **$27,500** |

---

### 1.6 One-Time Costs

| Item | Low | Mid | High | Planned |
|------|-----|-----|------|---------|
| LLC Formation | $200 | $500 | $1,000 | $500 |
| Operating Agreement | $500 | $1,500 | $3,000 | $1,500 |
| Customer Contracts | $1,000 | $2,500 | $5,000 | $2,500 |
| Terms of Service | $500 | $1,000 | $2,000 | $1,000 |
| Provisional Patent | $1,500 | $3,000 | $5,000 | $0 (defer) |
| SOC 2 Certification | $10,000 | $20,000 | $35,000 | $0 (defer) |
| **TOTAL** | **$13,700** | **$28,500** | **$51,000** | **$5,500** |

---

### 1.7 Partner Deal Terms

| Parameter | Value | Notes |
|-----------|-------|-------|
| Design Partner Revenue Share | 10% | Of net profit |
| **Design Partner Cap** | **$1,000,000** | Total payout limit |
| Sales Partner (Best Friend) | Equity-based | See section 4.2 |
| **Sales Partner Y1 Revenue Share** | **20%** | First year revenue |

---

### 1.8 Starting Capital

| Item | Amount |
|------|--------|
| Cash Available | $10,000 |
| Less: One-Time Costs | -$5,500 |
| **Net Starting Capital** | **$4,500** |
| Potential (sellable assets) | +$30,000 |
| **Maximum Available** | **$34,500** |

---

## 2. PRICING CALCULATOR

### 2.1 Pricing Formula

```
Monthly Software Price = Base Fee + (Sqft × Per Sqft Rate)
Hardware Price = Hardware Cost × (1 + Markup)

Margin Validation:
Gross Profit = Price - COGS
Gross Margin = Gross Profit / Price
```

### 2.2 Price by Gym Size (65% Margin - Recommended)

| Gym Size | Base Fee | Sqft Fee | **Monthly Price** | COGS | Gross Profit | **Margin** |
|----------|----------|----------|-------------------|------|--------------|------------|
| 5,000 sqft | $246 | $62 | **$308** | $86 | $222 | **72%** |
| 10,000 sqft | $246 | $123 | **$369** | $86 | $283 | **77%** |
| 15,000 sqft | $246 | $185 | **$431** | $86 | $345 | **80%** |
| 20,000 sqft | $246 | $246 | **$492** | $86 | $406 | **83%** |
| 30,000 sqft | $246 | $369 | **$615** | $86 | $529 | **86%** |
| 40,000 sqft | $246 | $492 | **$738** | $86 | $652 | **88%** |
| 50,000 sqft | $246 | $615 | **$861** | $86 | $775 | **90%** |
| **Weighted Avg** | | | **$438** | $86 | $352 | **80%** |

**Hardware Pricing: Model A — Hybrid (20% markup):**

| Segment | Hardware Cost | Customer Price |
|---------|---------------|----------------|
| Small Boutique | $1,137 | $1,364 |
| Mid Independent | $1,346 | $1,615 |
| Large Facility | $1,847 | $2,216 |
| Enterprise | $2,419 | $2,903 |

**Hardware Pricing: Model B — Full Install (20% markup):**

| Segment | Hardware Cost | Customer Price |
|---------|---------------|----------------|
| Small Boutique | $2,155 | $2,586 |
| Mid Independent | $4,025 | $4,830 |
| Large Facility | $7,666 | $9,199 |
| Enterprise | $15,178 | $18,214 |

**Full Install with Hardware Lease (36-month amortization):**

For Full Install, we offer a lease option to reduce upfront customer cost:

| Segment | HW Cost | Monthly HW Lease | SW (65%) | **Total Monthly** |
|---------|---------|------------------|----------|-------------------|
| Small Boutique | $2,155 | $60 | $314 | **$374** |
| Mid Independent | $4,025 | $112 | $388 | **$500** |
| Large Facility | $7,666 | $213 | $523 | **$736** |
| Enterprise | $15,178 | $422 | $799 | **$1,221** |

> **Impact:** Hybrid model offers 47-84% lower hardware cost. Full Install lease option smooths cash flow for larger deployments.

### 2.3 Weighted Average Pricing (Based on Customer Mix)

| Segment | Avg Sqft | Monthly Price | COGS | Gross Profit | Margin | Mix % | Weighted Price |
|---------|----------|---------------|------|--------------|--------|-------|----------------|
| Small Boutique | 5,500 | $314 | $86 | $228 | 73% | 20% | $63 |
| Mid Independent | 11,500 | $388 | $86 | $302 | 78% | 35% | $136 |
| Large Facility | 22,500 | $523 | $86 | $437 | 84% | 30% | $157 |
| Enterprise | 45,000 | $799 | $86 | $713 | 89% | 15% | $120 |
| **Blended Average** | **15,625** | | | | | | **$476/mo** |
| **Weighted Margin** | | | | | **80%** | | |

### 2.4 Multi-Margin Pricing Comparison

#### 50% Margin Tier (Competitive)

| Segment | Avg Sqft | Monthly Price | COGS | Gross Profit | Margin |
|---------|----------|---------------|------|--------------|--------|
| Small Boutique | 5,500 | $219 | $86 | $133 | 61% |
| Mid Independent | 11,500 | $271 | $86 | $185 | 68% |
| Large Facility | 22,500 | $365 | $86 | $279 | 76% |
| Enterprise | 45,000 | $558 | $86 | $472 | 85% |
| **Weighted Avg** | | **$332/mo** | | $246 | **74%** |

#### 65% Margin Tier (Recommended)

| Segment | Avg Sqft | Monthly Price | COGS | Gross Profit | Margin |
|---------|----------|---------------|------|--------------|--------|
| Small Boutique | 5,500 | $314 | $86 | $228 | 73% |
| Mid Independent | 11,500 | $388 | $86 | $302 | 78% |
| Large Facility | 22,500 | $523 | $86 | $437 | 84% |
| Enterprise | 45,000 | $799 | $86 | $713 | 89% |
| **Weighted Avg** | | **$476/mo** | | $390 | **82%** |

#### 80% Margin Tier (Premium)

| Segment | Avg Sqft | Monthly Price | COGS | Gross Profit | Margin |
|---------|----------|---------------|------|--------------|--------|
| Small Boutique | 5,500 | $548 | $86 | $462 | 84% |
| Mid Independent | 11,500 | $677 | $86 | $591 | 87% |
| Large Facility | 22,500 | $913 | $86 | $827 | 91% |
| Enterprise | 45,000 | $1,395 | $86 | $1,309 | 94% |
| **Weighted Avg** | | **$831/mo** | | $745 | **90%** |

---

## 3. UNIT ECONOMICS

### 3.1 Model A: Hybrid — Unit Economics by Segment (65% Margin)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | HW Cost | SW COGS | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------|---------|---------------|-----------------|-----------|
| Small Boutique | $1,364 | $3,768 | $5,132 | $1,137 | $1,032 | $2,169 | $2,963 | **58%** |
| Mid Independent | $1,615 | $4,656 | $6,271 | $1,346 | $1,032 | $2,378 | $3,893 | **62%** |
| Large Facility | $2,216 | $6,276 | $8,492 | $1,847 | $1,032 | $2,879 | $5,613 | **66%** |
| Enterprise | $2,903 | $9,588 | $12,491 | $2,419 | $1,032 | $3,451 | $9,040 | **72%** |

### 3.2 Model B: Full Install — Unit Economics by Segment (65% Margin)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | HW Cost | SW COGS | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------|---------|---------------|-----------------|-----------|
| Small Boutique | $2,586 | $3,768 | $6,354 | $2,155 | $1,032 | $3,187 | $3,167 | **50%** |
| Mid Independent | $4,830 | $4,656 | $9,486 | $4,025 | $1,032 | $5,057 | $4,429 | **47%** |
| Large Facility | $9,199 | $6,276 | $15,475 | $7,666 | $1,032 | $8,698 | $6,777 | **44%** |
| Enterprise | $18,214 | $9,588 | $27,802 | $15,178 | $1,032 | $16,210 | $11,592 | **42%** |

> **Key Insight:** Full Install has lower Y1 margins because hardware cost dominates. Hybrid model is significantly more profitable.

### 3.3 Model Comparison: Hybrid vs Full Install

| Segment | Hybrid Y1 Margin | Full Install Y1 Margin | Delta |
|---------|------------------|------------------------|-------|
| Small Boutique | 58% | 50% | -8% |
| Mid Independent | 62% | 47% | -15% |
| Large Facility | 66% | 44% | -22% |
| Enterprise | 72% | 42% | -30% |

**Recommendation:** Prioritize Hybrid deployments. Use Full Install only when:
- Gym has no existing cameras or analog-only system
- Customer prefers all-new equipment
- Lease model smooths the margin impact

### 3.4 Multi-Margin Analysis: Hybrid Model

#### 50% Margin (Competitive)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------------|-----------------|-----------|
| Small Boutique | $1,364 | $2,628 | $3,992 | $2,169 | $1,823 | 46% |
| Mid Independent | $1,615 | $3,252 | $4,867 | $2,378 | $2,489 | 51% |
| Large Facility | $2,216 | $4,380 | $6,596 | $2,879 | $3,717 | 56% |
| Enterprise | $2,903 | $6,696 | $9,599 | $3,451 | $6,148 | 64% |

#### 65% Margin (Recommended)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------------|-----------------|-----------|
| Small Boutique | $1,364 | $3,768 | $5,132 | $2,169 | $2,963 | 58% |
| Mid Independent | $1,615 | $4,656 | $6,271 | $2,378 | $3,893 | 62% |
| Large Facility | $2,216 | $6,276 | $8,492 | $2,879 | $5,613 | 66% |
| Enterprise | $2,903 | $9,588 | $12,491 | $3,451 | $9,040 | 72% |

#### 80% Margin (Premium)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------------|-----------------|-----------|
| Small Boutique | $1,364 | $6,576 | $7,940 | $2,169 | $5,771 | 73% |
| Mid Independent | $1,615 | $8,124 | $9,739 | $2,378 | $7,361 | 76% |
| Large Facility | $2,216 | $10,956 | $13,172 | $2,879 | $10,293 | 78% |
| Enterprise | $2,903 | $16,740 | $19,643 | $3,451 | $16,192 | 82% |

### 3.5 Multi-Margin Analysis: Full Install Model

#### 50% Margin

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------------|-----------------|-----------|
| Small Boutique | $2,586 | $2,628 | $5,214 | $3,187 | $2,027 | 39% |
| Mid Independent | $4,830 | $3,252 | $8,082 | $5,057 | $3,025 | 37% |
| Large Facility | $9,199 | $4,380 | $13,579 | $8,698 | $4,881 | 36% |
| Enterprise | $18,214 | $6,696 | $24,910 | $16,210 | $8,700 | 35% |

#### 65% Margin (Recommended)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------------|-----------------|-----------|
| Small Boutique | $2,586 | $3,768 | $6,354 | $3,187 | $3,167 | 50% |
| Mid Independent | $4,830 | $4,656 | $9,486 | $5,057 | $4,429 | 47% |
| Large Facility | $9,199 | $6,276 | $15,475 | $8,698 | $6,777 | 44% |
| Enterprise | $18,214 | $9,588 | $27,802 | $16,210 | $11,592 | 42% |

#### 80% Margin (Premium)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total Rev | Y1 Total Cost | Y1 Gross Profit | Y1 Margin |
|---------|------------|---------------|--------------|---------------|-----------------|-----------|
| Small Boutique | $2,586 | $6,576 | $9,162 | $3,187 | $5,975 | 65% |
| Mid Independent | $4,830 | $8,124 | $12,954 | $5,057 | $7,897 | 61% |
| Large Facility | $9,199 | $10,956 | $20,155 | $8,698 | $11,457 | 57% |
| Enterprise | $18,214 | $16,740 | $34,954 | $16,210 | $18,744 | 54% |

> **Key Insight:** Full Install requires 80% margin tier to achieve comparable profitability to Hybrid at 65%.

### 3.6 Lifetime Value (LTV)

| Metric | Conservative (15% churn) | Base (12% churn) | Optimistic (8% churn) |
|--------|--------------------------|------------------|----------------------|
| Avg Lifetime (months) | 80 | 100 | 150 |
| Lifetime Software Revenue | $38,080 | $47,600 | $71,400 |
| Lifetime COGS | $6,880 | $8,600 | $12,900 |
| Hardware Profit | $227 | $227 | $227 |
| **LTV** | **$31,427** | **$39,227** | **$58,727** |

### 3.7 Customer Acquisition Cost (CAC) Scenarios

| Channel | Est. CAC | LTV:CAC | Payback (months) |
|---------|----------|---------|------------------|
| Founder-led | $1,000 | 39:1 | 2.6 |
| Partner referral | $2,000 | 20:1 | 5.1 |
| Inbound marketing | $3,000 | 13:1 | 7.7 |
| **Blended Target** | **$1,500** | **26:1** | **3.8** |

---

## 4. PARTNER ECONOMICS

### 4.1 Design Partner Deal

**Terms:** 10% of net profit until $1,000,000 cap

#### Scenario Analysis by Scale

| Scale | Gyms | Monthly Gross Profit | Monthly OpEx | Monthly Net Profit | Partner 10% | Annual Partner |
|-------|------|---------------------|--------------|-------------------|-------------|----------------|
| Early | 10 | $3,900 | $2,150 | $1,750 | $175 | $2,100 |
| Growth | 25 | $9,750 | $2,150 | $7,600 | $760 | $9,120 |
| Scale | 50 | $19,500 | $27,500 | -$8,000 | $0 | $0 |
| Scale | 100 | $39,000 | $27,500 | $11,500 | $1,150 | $13,800 |
| Mature | 250 | $97,500 | $50,000 | $47,500 | $4,750 | $57,000 |
| **Large** | **1,000** | $390,000 | $150,000 | $240,000 | $24,000 | $288,000 |

**At 1,000 Gyms:**
- Monthly Revenue: 1,000 × $476 = $476,000
- Monthly COGS: 1,000 × $86 = $86,000
- Monthly Gross Profit: $390,000
- Monthly OpEx (estimated): $150,000
- Monthly Net Profit: $240,000
- Partner 10%: $24,000/month
- **Time to $1M cap:** 42 months (3.5 years)

#### Large Chain Scenarios

| Chain | Est. Locations | Monthly Revenue | Monthly Net Profit | Partner 10%/mo | Annual Partner |
|-------|----------------|-----------------|-------------------|----------------|----------------|
| City Fitness (Philly) | ~10 | $4,760 | $1,510 | $151 | $1,812 |
| LA Fitness | ~700 | $333,200 | $168,200 | $16,820 | $201,840 |
| Planet Fitness | ~2,600 | $1,237,600 | $890,600 | $89,060 | $1,068,720 |

**Note:** LA Fitness or Planet Fitness as a customer would hit the $1M partner cap in:
- LA Fitness: 5 months
- Planet Fitness: 1.1 months

### 4.2 Founding Contributor Program

> Anyone who helps land a major chain deal when the company is early-stage is a founding contributor, not a salesperson. This program compensates accordingly.

---

#### Program Overview

**Applies to:** Nathan, family members, close network - anyone who opens doors to enterprise deals during the critical early phase.

**Trigger:** Lands a chain (10+ locations) when Gym Genius has < $1M ARR

---

#### Equity Grants

| Deal Size | Equity | Vesting | Additional |
|-----------|--------|---------|------------|
| 10-24 locations | 10% | Immediate | — |
| 25-49 locations | 15% | Immediate | — |
| 50-99 locations | 18% | Immediate | Board observer seat |
| 100+ locations | 20% | Immediate | Board observer seat |

**Equity Value at Growth Milestones:**

| Company Stage | Valuation | 15% Value | 20% Value |
|---------------|-----------|-----------|-----------|
| Post-deal close | $3-5M | $450K-$750K | $600K-$1M |
| 100 gyms | $5-10M | $750K-$1.5M | $1M-$2M |
| 250 gyms | $15-25M | $2.25M-$3.75M | $3M-$5M |
| Exit scenario | $50-100M | $7.5M-$15M | $10M-$20M |

---

#### Cash Compensation

**Three components, all additive:**

**1. Signing Bonus** (paid on contract execution)

| Deal Size | Bonus |
|-----------|-------|
| 10-24 locations | $15,000 |
| 25-49 locations | $35,000 |
| 50-74 locations | $75,000 |
| 75-99 locations | $125,000 |
| 100+ locations | $150,000 |

**2. Per-Location Fee** (paid as each location goes live)

| Company Stage | Per Location | Cap |
|---------------|--------------|-----|
| 0-25 existing locations | $3,000 | First 50 locations from deal |

**3. Revenue Share** (ongoing)

| Year | Share of Revenue from Deal |
|------|---------------------------|
| Year 1 | 30% |
| Year 2 | 20% |
| Year 3 | 15% |
| Year 4+ | 10% (perpetual until cap) |

**Cash Cap:** $1,500,000 lifetime per contributor

---

#### Nathan: Equinox Scenario (100 Locations)

| Component | Calculation | Amount |
|-----------|-------------|--------|
| **Equity** | 20% (100+ locations) | 20% ownership |
| | | |
| **Signing Bonus** | 100+ locations | $150,000 |
| **Per-Location Fees** | 50 × $3,000 | $150,000 |
| **Y1 Revenue Share** | 30% × ($800 × 100 × 12) | $288,000 |
| **Y2 Revenue Share** | 20% × $960K | $192,000 |
| **Y3 Revenue Share** | 15% × $960K | $144,000 |
| **Y4+ Revenue Share** | 10% × $960K until cap | $576,000 |
| | | |
| **Total Cash** | (capped) | **$1,500,000** |

**Total Value (at $25M valuation):**

| Component | Value |
|-----------|-------|
| Cash | $1,500,000 |
| Equity (20% of $25M) | $5,000,000 |
| **Total** | **$6,500,000** |

---

#### Scenario: 30-Location Regional Chain

| Component | Calculation | Amount |
|-----------|-------------|--------|
| **Equity** | 15% (25-49 locations) | 15% ownership |
| | | |
| **Signing Bonus** | 25-49 locations | $35,000 |
| **Per-Location Fees** | 30 × $3,000 | $90,000 |
| **Y1 Revenue Share** | 30% × ($500 × 30 × 12) | $54,000 |
| **Year 1 Cash** | | **$179,000** |

---

#### Scenario: 15-Location Chain

| Component | Calculation | Amount |
|-----------|-------------|--------|
| **Equity** | 10% (10-24 locations) | 10% ownership |
| | | |
| **Signing Bonus** | 10-24 locations | $15,000 |
| **Per-Location Fees** | 15 × $3,000 | $45,000 |
| **Y1 Revenue Share** | 30% × ($450 × 15 × 12) | $24,300 |
| **Year 1 Cash** | | **$84,300** |

---

#### Why This Structure

| What They Bring | Value Created |
|-----------------|---------------|
| Enterprise relationship | Years of trust, impossible to replicate |
| Credibility transfer | Their reputation validates us |
| Accelerated timeline | Skip 2-3 years of cold outreach |
| Fundraising leverage | "We have [Major Chain]" changes every conversation |
| Reference account | Every future sale becomes easier |

Landing a major chain at the early stage is a founding-level contribution. The equity reflects that.

---

#### Terms & Conditions

| Term | Detail |
|------|--------|
| Contract required | Compensation triggers on signed deal, not introduction |
| Minimum threshold | 10+ locations to qualify for this program |
| ARR ceiling | Program applies when company < $1M ARR |
| Exclusivity | 24-month exclusivity on fitness/gym deals |
| Cash cap | $1,500,000 lifetime per contributor |
| Equity cap | 20% maximum per contributor |
| Stacking | Multiple contributors can earn on same deal (split terms) |

---

## 5. PROJECTIONS (Revised - Realistic)

### 5.1 Year 1: Pilot Phase (Target: 10 gyms)

**Assumptions:**
- Target: City Fitness-sized regional chain (10 locations)
- City Fitness (Philadelphia): ~10 locations
- Similar chains to target:
  - Snap Fitness (franchises, regional clusters of 5-15)
  - Gold's Gym (regional franchisees)
  - Crunch Fitness (regional operators)
- Start with 1-2 pilot locations, expand within chain

| Quarter | Gyms | New | MRR | Hardware Rev | Monthly COGS | Monthly OpEx | Monthly Net |
|---------|------|-----|-----|--------------|--------------|--------------|-------------|
| Q1 | 2 | 2 | $952 | $4,618 | $172 | $200 | $580 |
| Q2 | 4 | 2 | $1,904 | $4,618 | $344 | $2,150 | -$590 |
| Q3 | 7 | 3 | $3,332 | $6,927 | $602 | $2,150 | $580 |
| Q4 | 10 | 3 | $4,760 | $6,927 | $860 | $2,150 | $1,750 |

**Year 1 Summary:**

| Metric | Amount |
|--------|--------|
| Total Software Revenue | $32,844 |
| Total Hardware Revenue | $23,090 |
| **Total Revenue** | **$55,934** |
| Total COGS | $7,912 |
| Total OpEx | $19,300 |
| **Net Profit** | **$28,722** |
| Design Partner Share (10%) | $2,872 |

### 5.2 Year 2: Expansion Phase (Target: 35 gyms)

**Assumptions:**
- Expand from 10 to 35 gyms
- Add 2-3 new regional chains
- Focus on 5-15 location operators
- **Stay lean** - founder still employed, no full-time hires yet
- Maybe add part-time contractor for installs ($1,500/mo in Q3-Q4)

| Quarter | Gyms | New | MRR | Hardware Rev | Monthly COGS | Monthly OpEx | Monthly Net |
|---------|------|-----|-----|--------------|--------------|--------------|-------------|
| Q1 | 15 | 5 | $7,140 | $11,545 | $1,290 | $2,150 | $3,700 |
| Q2 | 22 | 7 | $10,472 | $16,163 | $1,892 | $2,150 | $6,430 |
| Q3 | 28 | 6 | $13,328 | $13,854 | $2,408 | $3,650 | $7,270 |
| Q4 | 35 | 7 | $16,660 | $16,163 | $3,010 | $3,650 | $9,900 |

**Year 2 Summary:**

| Metric | Amount |
|--------|--------|
| Total Software Revenue | $142,800 |
| Total Hardware Revenue | $57,725 |
| **Total Revenue** | **$200,525** |
| Total COGS | $34,400 |
| Total OpEx | $35,400 |
| **Net Profit** | **$130,725** |
| Design Partner Share (10%) | $13,073 |
| **Cumulative Partner Payout** | **$15,945** |

**Key insight:** Stay in Growth OpEx mode until you hit 70+ gyms. Don't quit your job or hire until the math works.

### 5.3 Year 3: Go-Live / Scale Phase (Target: 100 gyms)

**Assumptions:**
- Grow from 35 to 100 gyms
- Land 1-2 larger regional chains (20-50 locations each)
- **Q1-Q2:** Still lean, add 1 part-time hire ($5K/mo)
- **Q3:** Hit 80 gyms → founder considers quitting job
- **Q4:** At 100 gyms → transition to Scale OpEx (founder full-time + 1 employee)

| Quarter | Gyms | New | MRR | Hardware Rev | Monthly COGS | Monthly OpEx | Monthly Net |
|---------|------|-----|-----|--------------|--------------|--------------|-------------|
| Q1 | 50 | 15 | $23,800 | $34,635 | $4,300 | $7,150 | $12,350 |
| Q2 | 65 | 15 | $30,940 | $34,635 | $5,590 | $7,150 | $18,200 |
| Q3 | 80 | 15 | $38,080 | $34,635 | $6,880 | $15,000 | $16,200 |
| Q4 | 100 | 20 | $47,600 | $46,180 | $8,600 | $20,000 | $19,000 |

**OpEx Breakdown by Quarter:**
- Q1-Q2: $7,150 (Growth + part-time hire)
- Q3: $15,000 (Founder takes partial salary, 1 contractor)
- Q4: $20,000 (Founder full salary, 1 part-time employee)

**Year 3 Summary:**

| Metric | Amount |
|--------|--------|
| Total Software Revenue | $421,260 |
| Total Hardware Revenue | $150,085 |
| **Total Revenue** | **$571,345** |
| Total COGS | $101,480 |
| Total OpEx | $147,900 |
| **Net Profit** | **$321,965** |
| Design Partner Share (10%) | $32,197 |
| **Cumulative Partner Payout** | **$48,142** |

### 5.4 3-Year Summary

| Metric | Year 1 | Year 2 | Year 3 | Total |
|--------|--------|--------|--------|-------|
| Ending Gyms | 10 | 35 | 100 | - |
| Total Revenue | $55,934 | $200,525 | $571,345 | **$827,804** |
| Total COGS | $7,912 | $34,400 | $101,480 | $143,792 |
| Total OpEx | $19,300 | $35,400 | $147,900 | $202,600 |
| **Net Profit** | **$28,722** | **$130,725** | **$321,965** | **$481,412** |
| Design Partner (10%) | $2,872 | $13,073 | $32,197 | $48,142 |

**The key:** Stay lean. Don't scale OpEx until revenue supports it.

| When to Scale | Trigger | Action |
|---------------|---------|--------|
| Part-time help | 25+ gyms | Add install contractor ($1,500/mo) |
| First hire | 50+ gyms | Part-time ops/support ($5K/mo) |
| Founder quits job | 70-80 gyms | Take salary, MRR covers it |
| Full team | 100+ gyms | Founder + 1-2 employees |

---

## 6. CASH FLOW & RUNWAY

### 6.1 Monthly Cash Flow by Phase

| Phase | Gyms | Monthly Revenue | Monthly Costs | Monthly Net | Status |
|-------|------|-----------------|---------------|-------------|--------|
| Pre-Revenue | 0 | $0 | $200 | -$200 | Burning |
| Early Pilots | 2-5 | $950-2,400 | $600-2,700 | $350-($300) | Break-even |
| Growth | 10-35 | $4,800-16,700 | $3,000-30,500 | $1,800-($13,800) | Variable |
| Scale | 50-100 | $23,800-47,600 | $32,000-38,600 | ($8,200)-$9,000 | Variable |

### 6.2 Runway Analysis

**Starting Position:**
- Net Starting Capital: $4,500
- Potential from selling assets: +$30,000
- Monthly Burn (Pre-Revenue): $200

**Runway Scenarios (with $4,500):**

| Scenario | Time to Revenue | Burn | Remaining |
|----------|-----------------|------|-----------|
| Fast (2 mo) | 2 months | $400 | $4,100 |
| Normal (4 mo) | 4 months | $800 | $3,700 |
| Slow (6 mo) | 6 months | $1,200 | $3,300 |

**Note:** Being employed means runway is effectively infinite for operating costs. Capital needed for hardware float.

### 6.3 Hardware Float Requirement (Updated Dec 2025)

| Gyms in Pipeline | Hardware Cost | Float Needed | Old Estimate |
|------------------|---------------|--------------|--------------|
| 2 | $2,274 | $2,274 | ~~$3,848~~ |
| 5 | $5,685 | $5,685 | ~~$9,620~~ |
| 10 | $11,370 | $11,370 | ~~$19,240~~ |

> **Improvement:** Float requirement reduced by 41% due to validated lower hardware costs.

**Solution Options:**
1. **50% customer deposit** - Reduces float to ~$5.7K for 10 gyms
2. **Sell assets** - Access $30K if needed
3. **Revenue from early customers** - Self-fund growth
4. **Small friends/family round** - $25-50K (now covers 20+ gyms)

---

## 7. BREAK-EVEN ANALYSIS

### 7.1 Break-Even by Phase

| Phase | Monthly OpEx | Gross Profit/Gym | Gyms to Break-Even |
|-------|--------------|------------------|-------------------|
| Pre-Revenue | $200 | $390 | 1 |
| Growth | $2,150 | $390 | 6 |
| Scale | $27,500 | $390 | 71 |

### 7.2 Break-Even by Margin Tier

| Margin | Monthly GP/Gym | Break-Even (Growth) | Break-Even (Scale) |
|--------|----------------|---------------------|-------------------|
| 50% | $246 | 9 gyms | 112 gyms |
| **65%** | **$390** | **6 gyms** | **71 gyms** |
| 80% | $745 | 3 gyms | 37 gyms |

---

## 8. SENSITIVITY ANALYSIS

### 8.1 Margin Tier Comparison (Full Analysis)

| Metric | 50% Margin | 65% Margin | 80% Margin |
|--------|------------|------------|------------|
| Monthly Price (avg) | $332 | $476 | $831 |
| Monthly GP/Gym | $246 | $390 | $745 |
| Break-even (Scale) | 112 gyms | 71 gyms | 37 gyms |
| Y3 Net Profit (100 gyms) | -$50K | $125K | $548K |
| LTV | $24,600 | $39,000 | $74,500 |
| LTV:CAC (@$1,500) | 16:1 | 26:1 | 50:1 |

### 8.2 Churn Sensitivity

| Annual Churn | Avg Lifetime | LTV (65% margin) | LTV:CAC |
|--------------|--------------|------------------|---------|
| 5% | 240 mo | $93,600 | 62:1 |
| 8% | 150 mo | $58,500 | 39:1 |
| 10% | 120 mo | $46,800 | 31:1 |
| **12%** | **100 mo** | **$39,000** | **26:1** |
| 15% | 80 mo | $31,200 | 21:1 |
| 20% | 60 mo | $23,400 | 16:1 |

### 8.3 Hardware Cost Sensitivity (Updated Dec 2025)

| Hardware Cost | Customer Price | Hardware Margin | Float (10 gyms) | Notes |
|---------------|----------------|-----------------|-----------------|-------|
| $890 | $1,068 | $178 | $8,900 | Budget (Reolink cameras) |
| **$1,137** | **$1,364** | **$227** | **$11,370** | **Standard (Validated)** |
| $1,500 | $1,800 | $300 | $15,000 | Premium cameras |
| $1,872 | $2,246 | $374 | $18,720 | 8-camera Tier 3 |

---

## 9. GYM VALUE / ROI ANALYSIS

### 9.1 The Honest Value Proposition

**The core pitch is simple:** Avoid ONE bad equipment purchase per year.

That's it. Everything else is gravy.

---

### 9.2 Real Equipment Costs (What Gyms Actually Spend)

| Equipment Type | Commercial Price | Lifespan | Notes |
|----------------|------------------|----------|-------|
| Commercial treadmill | $5,000-12,000 | 7-10 yrs | Life Fitness, Precor |
| Elliptical | $4,000-8,000 | 7-10 yrs | |
| Stationary bike | $2,000-4,000 | 5-8 yrs | Spin bikes higher |
| Cable machine | $3,000-8,000 | 10-15 yrs | Functional trainers |
| Smith machine | $2,000-5,000 | 15+ yrs | |
| Dumbbell set (5-100lb) | $3,000-6,000 | 20+ yrs | |
| Squat rack | $1,500-4,000 | 15+ yrs | |
| Leg press | $3,000-7,000 | 10-15 yrs | |

**Typical annual equipment budget:** $10,000-50,000 depending on gym size

---

### 9.3 The Real Conversation

**You:** "When was the last time you bought new equipment?"

**Gym Owner:** "We just bought 3 treadmills for $24,000."

**You:** "How did you decide you needed treadmills specifically?"

**Gym Owner:** "Members were complaining about wait times during peak hours."

**You:** "Did you know which equipment actually had the wait times?"

**Gym Owner:** "Honestly... gut feeling and a few complaints."

**You:** "What if your treadmills are only 50% utilized, but your cable machines are at 95%? You might have spent $24,000 on equipment you didn't need, while the real bottleneck was a $6,000 functional trainer."

**Gym Owner:** "..."

**You:** "Our system costs $400/month. If it saves you ONE bad $8,000 decision per year, you're ahead. And you'll make better decisions every year after that."

---

### 9.4 Realistic ROI Scenarios

#### Scenario A: Avoided Bad Purchase (Most Common)

| Item | Value |
|------|-------|
| Gym was going to buy | 2 treadmills @ $6,000 each |
| Planned spend | $12,000 |
| Data shows | Treadmills at 45% utilization, free weights at 92% |
| Actual need | Dumbbell expansion + bench ($3,000) |
| **Money saved** | **$9,000** |
| Annual Gym Genius cost | $5,000 |
| **Net benefit** | **$4,000 + ongoing data** |

#### Scenario B: Right-Sized Purchase

| Item | Value |
|------|-------|
| Gym was going to buy | 1 cable machine @ $5,000 |
| Data shows | Cable area at 95% utilization in peak, 30% off-peak |
| Actual decision | Buy 2 machines, stagger placement |
| Result | Reduced peak complaints, better member experience |
| **Value** | **Retention of frustrated members** |

This one is harder to quantify - but losing even 5 members at $50/month = $3,000/year.

#### Scenario C: No Major Purchase That Year

| Item | Value |
|------|-------|
| Equipment budget | $0 (no purchases planned) |
| Gym Genius cost | $5,000/year |
| Immediate ROI | **Negative** |
| But... | Data accumulates for next purchase decision |
| Long-term value | Better decisions in Year 2, 3, 4... |

**Honest truth:** If a gym isn't buying equipment and doesn't care about utilization data, we're not a fit.

---

### 9.5 Who This Actually Works For

| Customer Type | Why It Works | Why It Doesn't |
|---------------|--------------|----------------|
| **Growing gyms** | Buying equipment regularly, data prevents mistakes | — |
| **Multi-location chains** | Standardize decisions across locations, compare performance | — |
| **Premium facilities** | Members expect modern, data-driven experience | — |
| **Gyms with investor/landlord reporting** | Need utilization data for stakeholders | — |
| Struggling gyms | — | No budget for equipment OR software |
| Brand new gyms | — | No baseline data to compare against |
| 24/7 unmanned gyms | — | No staff to act on insights |

---

### 9.6 The Honest ROI Math

| Gym Size | Annual Cost (65%) | Break-Even Scenario |
|----------|-------------------|---------------------|
| 5,000 sqft | ~$4,000 | Avoid one $4,000+ bad purchase |
| 10,000 sqft | ~$5,000 | Avoid one $5,000+ bad purchase |
| 20,000 sqft | ~$6,500 | Avoid one $6,500+ bad purchase |
| 40,000 sqft | ~$9,500 | Avoid one $9,500+ bad purchase |

**Given typical equipment costs ($3,000-12,000 per piece), breaking even requires avoiding ONE medium-sized mistake per year.**

---

### 9.7 What We Can't Honestly Claim

| Claim | Reality |
|-------|---------|
| "Save $43,000/year" | Unrealistic for most gyms |
| "Reduce churn by X%" | We can't prove causation |
| "Optimize staffing" | Most gyms know peak hours already |
| "Space optimization savings" | Hard to quantify in dollars |

**What we CAN claim:**
- See exactly which equipment is used vs. ignored
- Make data-driven purchasing decisions
- Stop guessing, start knowing
- Compare zones and time periods
- Justify equipment requests to owners/investors

---

### 9.8 Additional Value (Not Quantified)

These are real benefits but we don't have data to put dollar figures on them yet. Use as supporting points, not primary pitch.

#### Layout Optimization

| Insight | Action | Potential Value |
|---------|--------|-----------------|
| Zone A is 20% utilized, Zone B is 90% | Move equipment from A to B, or reconfigure floor | Better member flow, reduced complaints |
| Cardio area empty in mornings, packed evenings | Consider 24/7 access or morning promotions | Spread demand, reduce peak crowding |
| New equipment placement underperforming | Move to higher-traffic area | Get ROI on equipment investment |

**How to talk about it:** "You'll see exactly which areas are dead zones and which are bottlenecks. That lets you make smarter layout decisions - but you'll need to quantify the value yourself based on your specific situation."

#### Staffing Optimization

| Insight | Action | Potential Value |
|---------|--------|-----------------|
| Equipment area empty 6-9am | Reduce morning staff or reassign | Labor savings |
| Peak utilization 5-7pm in free weights | Ensure trainer coverage during peak | Better member experience |
| Sunday utilization 40% lower than weekdays | Adjust hours or staffing | Operational efficiency |

**How to talk about it:** "Most gym owners already know their busy times from check-in data. What we add is *where* people are in the gym, not just *when* they're there. If you're overstaffing certain areas, you'll see it."

**Honest caveat:** Many gyms already have a good feel for peak hours. This is incremental value, not transformational.

---

### 9.9 Pricing Reality Check by Margin Tier

| Tier | Monthly (15K sqft) | Annual Cost | Break-Even Requires |
|------|-------------------|-------------|---------------------|
| 50% | $330 | $3,960 | Avoid one $4K mistake |
| **65%** | **$430** | **$5,160** | **Avoid one $5K mistake** |
| 80% | $680 | $8,160 | Avoid one $8K mistake |

**At 65% margin:** A gym needs to avoid ONE bad equipment decision worth $5,000+ to break even. Given that a single commercial treadmill costs $6,000-12,000, this is achievable for any gym that buys equipment.

**At 80% margin:** Harder sell. Need to avoid a bigger mistake or sell on additional value (reporting, member experience, benchmarking).

---

## 10. LARGE CLIENT ANALYSIS

### 10.1 Regional Chain Targets (Research)

| Chain | Est. Locations | Avg Size | Monthly Revenue | Annual Contract |
|-------|----------------|----------|-----------------|-----------------|
| City Fitness (Philly) | ~10 | 15,000 sqft | $4,310 | $51,720 |
| Snap Fitness (regional) | 10-20 | 8,000 sqft | $3,490-6,980 | $41,880-83,760 |
| Gold's Gym (franchisee) | 5-15 | 25,000 sqft | $2,895-8,685 | $34,740-104,220 |
| Crunch Fitness (regional) | 10-25 | 20,000 sqft | $4,920-12,300 | $59,040-147,600 |

### 10.2 Enterprise Targets

| Chain | Est. Locations | Avg Size | Monthly Revenue | Annual Contract |
|-------|----------------|----------|-----------------|-----------------|
| LA Fitness | ~700 | 40,000 sqft | $516,600 | $6,199,200 |
| Planet Fitness | ~2,600 | 20,000 sqft | $1,279,200 | $15,350,400 |
| Equinox | ~100 | 35,000 sqft | $66,100 | $793,200 |
| Life Time Fitness | ~170 | 100,000 sqft | $170,340 | $2,044,080 |

**Note:** Enterprise deals would require custom pricing, multi-year contracts, and dedicated support.

---

## 11. OPEN QUESTIONS / RESEARCH NEEDED

| Item | Owner | Priority | Status |
|------|-------|----------|--------|
| ~~Validate hardware BOM with quotes~~ | Research | ~~High~~ | **DONE** - Validated Hybrid at $1,137-$2,419 |
| ~~Can we leverage existing gym cameras?~~ | Research | ~~Medium~~ | **DONE** - Yes, Hybrid model created |
| ~~Dwell time inference requirements~~ | Research | ~~High~~ | **DONE** - 1 FPS for accuracy, Orin Nano Super works for all tiers |
| Supabase actual costs at 100 gyms | Tech | High | Open |
| City Fitness intro (pilot) | Founder | Critical | Open |
| Site assessment template/checklist | Operations | Medium | Open |
| SOC 2 timeline for enterprise | Operations | Low | Open |

---

## 12. NOTION TICKETS (Related)

| Ticket | Title | Relevance |
|--------|-------|-----------|
| TKT-13 | Deployment Model Research | Hardware architecture |
| TKT-30 | Current Gym Camera Systems Research | Leverage existing cameras |
| TKT-15 | Pricing and Unit Economics | Validates this model |
| TKT-14 | Target Segment Analysis | Regional chain data |
| TKT-7 | Financial Model | This document |

---

## 13. REVISION HISTORY

| Version | Date | Changes |
|---------|------|---------|
| v1.0 | 2025-12-22 | Initial model |
| v2.0 | 2025-12-22 | Added: Real hardware research, cloud cost analysis, multi-margin tiers, large client scenarios, equity partner structure, revised projections, gym ROI analysis |
| v2.1 | 2025-12-22 | **Hardware BOM validated with real quotes:** Tier 1 reduced from $1,924 to $1,137 (-41%). Key changes: Jetson Orin Nano Super at $249 (not Orin NX), Hikvision cameras at $140 (not $300), PoE switch at $75 (not $150). Updated unit economics, float requirements, and sensitivity analysis. |
| v2.2 | 2025-12-22 | **Major restructure: Two deployment models.** Added Model A (Hybrid - leverage existing cameras) and Model B (Full Install). Key findings: (1) Dwell time detection at 1 FPS — Orin Nano Super (60-90 stream capacity) handles ALL tiers; (2) Hybrid model has 58-72% Y1 margins vs 42-50% for Full Install; (3) Added site assessment process; (4) Full Install lease option for larger deployments; (5) Complete multi-margin analysis for both models. |

---

## 14. NEXT STEPS

1. [x] Research hardware BOM with real products
2. [x] Analyze cloud infrastructure costs
3. [x] Create multi-margin pricing tiers
4. [x] **Validate hardware BOM with real quotes** (Dec 2025 - Hybrid $1,137-$2,419)
5. [x] **Research: Can we leverage existing gym cameras?** (Dec 2025 - Yes, Hybrid model created)
6. [x] **Analyze dwell time inference requirements** (Dec 2025 - 1 FPS for accuracy, Orin Nano Super handles 60-90 streams)
7. [x] **Create two deployment models** (Dec 2025 - Hybrid + Full Install with margin analysis)
8. [ ] Create site assessment template/checklist
9. [ ] Validate pricing with target customer conversations
10. [ ] Build Google Sheets version for live scenario planning
11. [ ] Create investor-facing summary
12. [ ] Pursue City Fitness pilot intro
