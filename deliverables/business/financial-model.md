# Gym Genius Equipment Utilization - Financial Model

> **Status:** Final Draft
> **Last Updated:** 2025-12-22
> **Owner:** Business Agent

---

## Executive Summary

Gym Genius provides equipment utilization analytics for fitness facilities using computer vision. This model analyzes two deployment approaches with validated hardware costs and multi-margin pricing scenarios.

### Key Metrics (65% Margin, Hybrid Deployment)

| Metric | Value |
|--------|-------|
| Monthly Software Price (weighted avg) | $476 |
| Hardware Cost (Small Boutique) | $1,137 |
| Year 1 Gross Margin | 58-72% |
| LTV (12% churn) | $39,227 |
| LTV:CAC Ratio | 26:1 |
| Break-even (Growth Phase) | 6 gyms |

---

## 1. Deployment Models

### Overview

| Model | Description | Best For | Hardware Range |
|-------|-------------|----------|----------------|
| **Hybrid** | Leverage existing cameras + supplementary | Gyms with IP/PoE security | $1,137 - $2,419 |
| **Full Install** | Complete camera system | New builds, analog-only | $2,155 - $15,178 |

### Site Assessment Checklist

| Item | What We Check | Why It Matters |
|------|---------------|----------------|
| Existing Camera Inventory | Count, locations, brands/models | Determines hybrid viability |
| Camera Type | IP/PoE vs Analog/Coax | Analog = Full Install only |
| NVR Access | RTSP feed availability | Integration feasibility |
| Equipment Zones | Cardio, weights, machines, functional | Defines coverage needs |
| Coverage Gaps | Which zones need new cameras | Supplementary camera count |
| Network Infrastructure | PoE switch capacity, cabling | Installation complexity |
| Sqft & Layout | Floor plan, sight lines | Camera placement planning |

---

## 2. Technical Architecture

### Inference Requirements

| Parameter | Value |
|-----------|-------|
| Metric | Dwell time per equipment zone |
| Accuracy Target | 99% over 2-minute windows |
| Sampling Rate | 1 FPS |
| Detection Type | Binary presence (someone in zone: yes/no) |

### Compute Capacity

| Device | Price | Capacity @ 1 FPS | Use Case |
|--------|-------|------------------|----------|
| Jetson Orin Nano Super | $249 | 60-90 streams | All Hybrid, most Full Install |
| 2x Orin Nano Super | $498 | 120-180 streams | Enterprise Full Install |

### Camera Requirements

**Full Install (1 camera per 600 sqft)**

| Segment | Avg Sqft | Cameras |
|---------|----------|---------|
| Small Boutique | 5,500 | 9 |
| Mid Independent | 11,500 | 19 |
| Large Facility | 22,500 | 38 |
| Enterprise | 45,000 | 75 |

**Hybrid (Existing + Supplementary)**

| Segment | Existing (est.) | Usable | Supplementary |
|---------|-----------------|--------|---------------|
| Small Boutique | 5 | 2 | 4 |
| Mid Independent | 10 | 4 | 5 |
| Large Facility | 14 | 6 | 7 |
| Enterprise | 20 | 9 | 10 |

---

## 3. Hardware Bill of Materials

### Component Pricing (Validated Dec 2025)

**Edge Compute**

| Device | Price | Specs |
|--------|-------|-------|
| **Jetson Orin Nano Super** | $249 | 67 TOPS, recommended |
| Raspberry Pi 5 + Hailo-8 | $275 | 26 TOPS, budget option |
| Jetson Orin NX | $1,000 | 100+ TOPS, overkill |

**Cameras**

| Camera | Price | Specs |
|--------|-------|-------|
| Reolink RLC-810A | $90 | 8MP, budget |
| **Hikvision DS-2CD2143G2-I** | $140 | 4MP, commercial (default) |
| Axis P1365-E | $400-500 | Premium, overkill |

**Infrastructure**

| Component | Price |
|-----------|-------|
| 8-port PoE Switch | $75 |
| 16-port PoE Switch | $150 |
| 24-port PoE Switch | $250 |

### Model A: Hybrid BOM

| Segment | Compute | Cameras | Switch | Cabling | Contingency | **Total** |
|---------|---------|---------|--------|---------|-------------|-----------|
| Small Boutique | $249 | $560 (4x) | $75 | $150 | $103 | **$1,137** |
| Mid Independent | $249 | $700 (5x) | $75 | $200 | $122 | **$1,346** |
| Large Facility | $249 | $980 (7x) | $150 | $300 | $168 | **$1,847** |
| Enterprise | $249 | $1,400 (10x) | $150 | $400 | $220 | **$2,419** |

### Model B: Full Install BOM

| Segment | Compute | Cameras | Switch | Cabling | Contingency | **Total** |
|---------|---------|---------|--------|---------|-------------|-----------|
| Small Boutique | $249 | $1,260 (9x) | $150 | $300 | $196 | **$2,155** |
| Mid Independent | $249 | $2,660 (19x) | $250 | $500 | $366 | **$4,025** |
| Large Facility | $249 | $5,320 (38x) | $500 | $900 | $697 | **$7,666** |
| Enterprise | $498 (2x) | $10,500 (75x) | $1,000 | $1,800 | $1,380 | **$15,178** |

### Hardware Cost Comparison

| Segment | Hybrid | Full Install | Delta |
|---------|--------|--------------|-------|
| Small Boutique | $1,137 | $2,155 | +90% |
| Mid Independent | $1,346 | $4,025 | +199% |
| Large Facility | $1,847 | $7,666 | +315% |
| Enterprise | $2,419 | $15,178 | +527% |

---

## 4. Monthly Costs (COGS)

| Item | Cost | Notes |
|------|------|-------|
| Cloud (Supabase + Vercel) | $26 | Per gym |
| Support Allocation | $40 | ~1 hr/gym/month |
| Software Maintenance | $20 | Updates, monitoring |
| **Total Monthly COGS** | **$86** | Per gym |

---

## 5. Pricing

### Pricing Formula

```
Monthly Software = Base Fee + (Sqft × Per Sqft Rate)
Hardware Price = Hardware Cost × 1.20 (20% markup)
```

### Software Pricing by Margin Tier

| Margin | Base Fee | Per Sqft Rate | Weighted Avg Price |
|--------|----------|---------------|-------------------|
| 50% | $172 | $0.0086 | $332/mo |
| **65%** | **$246** | **$0.0123** | **$476/mo** |
| 80% | $430 | $0.0215 | $831/mo |

### Software Pricing by Segment (65% Margin)

| Segment | Avg Sqft | Monthly Price | Gross Profit | Margin |
|---------|----------|---------------|--------------|--------|
| Small Boutique | 5,500 | $314 | $228 | 73% |
| Mid Independent | 11,500 | $388 | $302 | 78% |
| Large Facility | 22,500 | $523 | $437 | 84% |
| Enterprise | 45,000 | $799 | $713 | 89% |

### Hardware Pricing

**Hybrid (20% markup)**

| Segment | Cost | Customer Price |
|---------|------|----------------|
| Small Boutique | $1,137 | $1,364 |
| Mid Independent | $1,346 | $1,615 |
| Large Facility | $1,847 | $2,216 |
| Enterprise | $2,419 | $2,903 |

**Full Install (20% markup)**

| Segment | Cost | Customer Price |
|---------|------|----------------|
| Small Boutique | $2,155 | $2,586 |
| Mid Independent | $4,025 | $4,830 |
| Large Facility | $7,666 | $9,199 |
| Enterprise | $15,178 | $18,214 |

**Full Install Lease Option (36-month amortization)**

| Segment | Monthly HW Lease | Software (65%) | Total Monthly |
|---------|------------------|----------------|---------------|
| Small Boutique | $60 | $314 | $374 |
| Mid Independent | $112 | $388 | $500 |
| Large Facility | $213 | $523 | $736 |
| Enterprise | $422 | $799 | $1,221 |

---

## 6. Unit Economics

### Hybrid Model (65% Margin)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total | Y1 Cost | Y1 Profit | Y1 Margin |
|---------|------------|---------------|----------|---------|-----------|-----------|
| Small Boutique | $1,364 | $3,768 | $5,132 | $2,169 | $2,963 | **58%** |
| Mid Independent | $1,615 | $4,656 | $6,271 | $2,378 | $3,893 | **62%** |
| Large Facility | $2,216 | $6,276 | $8,492 | $2,879 | $5,613 | **66%** |
| Enterprise | $2,903 | $9,588 | $12,491 | $3,451 | $9,040 | **72%** |

### Full Install Model (65% Margin)

| Segment | HW Revenue | Y1 SW Revenue | Y1 Total | Y1 Cost | Y1 Profit | Y1 Margin |
|---------|------------|---------------|----------|---------|-----------|-----------|
| Small Boutique | $2,586 | $3,768 | $6,354 | $3,187 | $3,167 | **50%** |
| Mid Independent | $4,830 | $4,656 | $9,486 | $5,057 | $4,429 | **47%** |
| Large Facility | $9,199 | $6,276 | $15,475 | $8,698 | $6,777 | **44%** |
| Enterprise | $18,214 | $9,588 | $27,802 | $16,210 | $11,592 | **42%** |

### Model Comparison

| Segment | Hybrid Margin | Full Install Margin | Delta |
|---------|---------------|---------------------|-------|
| Small Boutique | 58% | 50% | -8% |
| Mid Independent | 62% | 47% | -15% |
| Large Facility | 66% | 44% | -22% |
| Enterprise | 72% | 42% | -30% |

**Recommendation:** Prioritize Hybrid deployments for profitability.

### Lifetime Value

| Metric | 15% Churn | 12% Churn | 8% Churn |
|--------|-----------|-----------|----------|
| Avg Lifetime | 80 mo | 100 mo | 150 mo |
| Lifetime Revenue | $38,080 | $47,600 | $71,400 |
| Lifetime COGS | $6,880 | $8,600 | $12,900 |
| Hardware Profit | $227 | $227 | $227 |
| **LTV** | **$31,427** | **$39,227** | **$58,727** |

### Customer Acquisition Cost

| Channel | CAC | LTV:CAC | Payback |
|---------|-----|---------|---------|
| Founder-led | $1,000 | 39:1 | 2.6 mo |
| Partner referral | $2,000 | 20:1 | 5.1 mo |
| Inbound marketing | $3,000 | 13:1 | 7.7 mo |
| **Blended Target** | **$1,500** | **26:1** | **3.8 mo** |

---

## 7. Company Financials

### Operating Expenses (Monthly)

| Item | Pre-Revenue | Growth (10-25 gyms) | Scale (50+ gyms) |
|------|-------------|---------------------|------------------|
| Founder Salary | $0 | $0 | $10,000 |
| Employee Salaries | $0 | $0 | $13,000 |
| Cloud/Infrastructure | $100 | $300 | $1,000 |
| Tools/Subscriptions | $50 | $150 | $500 |
| Marketing/Sales | $50 | $500 | $2,000 |
| Contractors | $0 | $1,000 | $0 |
| Legal/Accounting | $0 | $200 | $500 |
| **Total OpEx** | **$200** | **$2,150** | **$27,500** |

### One-Time Costs

| Item | Planned |
|------|---------|
| LLC Formation | $500 |
| Operating Agreement | $1,500 |
| Customer Contracts | $2,500 |
| Terms of Service | $1,000 |
| **Total** | **$5,500** |

### Starting Capital

| Item | Amount |
|------|--------|
| Cash Available | $10,000 |
| Less: One-Time Costs | -$5,500 |
| **Net Starting Capital** | **$4,500** |
| Potential (sellable assets) | +$30,000 |
| **Maximum Available** | **$34,500** |

---

## 8. Three-Year Projections

### Year 1: Pilot Phase (10 gyms)

| Quarter | Gyms | MRR | HW Revenue | COGS | OpEx | Net |
|---------|------|-----|------------|------|------|-----|
| Q1 | 2 | $952 | $4,618 | $172 | $200 | $580 |
| Q2 | 4 | $1,904 | $4,618 | $344 | $2,150 | -$590 |
| Q3 | 7 | $3,332 | $6,927 | $602 | $2,150 | $580 |
| Q4 | 10 | $4,760 | $6,927 | $860 | $2,150 | $1,750 |

**Year 1 Total:** $55,934 revenue, $28,722 net profit

### Year 2: Expansion Phase (35 gyms)

| Quarter | Gyms | MRR | HW Revenue | COGS | OpEx | Net |
|---------|------|-----|------------|------|------|-----|
| Q1 | 15 | $7,140 | $11,545 | $1,290 | $2,150 | $3,700 |
| Q2 | 22 | $10,472 | $16,163 | $1,892 | $2,150 | $6,430 |
| Q3 | 28 | $13,328 | $13,854 | $2,408 | $3,650 | $7,270 |
| Q4 | 35 | $16,660 | $16,163 | $3,010 | $3,650 | $9,900 |

**Year 2 Total:** $200,525 revenue, $130,725 net profit

### Year 3: Scale Phase (100 gyms)

| Quarter | Gyms | MRR | HW Revenue | COGS | OpEx | Net |
|---------|------|-----|------------|------|------|-----|
| Q1 | 50 | $23,800 | $34,635 | $4,300 | $7,150 | $12,350 |
| Q2 | 65 | $30,940 | $34,635 | $5,590 | $7,150 | $18,200 |
| Q3 | 80 | $38,080 | $34,635 | $6,880 | $15,000 | $16,200 |
| Q4 | 100 | $47,600 | $46,180 | $8,600 | $20,000 | $19,000 |

**Year 3 Total:** $571,345 revenue, $321,965 net profit

### Three-Year Summary

| Metric | Year 1 | Year 2 | Year 3 | Total |
|--------|--------|--------|--------|-------|
| Ending Gyms | 10 | 35 | 100 | — |
| Revenue | $55,934 | $200,525 | $571,345 | **$827,804** |
| COGS | $7,912 | $34,400 | $101,480 | $143,792 |
| OpEx | $19,300 | $35,400 | $147,900 | $202,600 |
| **Net Profit** | **$28,722** | **$130,725** | **$321,965** | **$481,412** |

---

## 9. Break-Even Analysis

### By Phase

| Phase | Monthly OpEx | GP/Gym | Gyms to Break-Even |
|-------|--------------|--------|-------------------|
| Pre-Revenue | $200 | $390 | 1 |
| Growth | $2,150 | $390 | 6 |
| Scale | $27,500 | $390 | 71 |

### By Margin Tier

| Margin | GP/Gym | Break-Even (Growth) | Break-Even (Scale) |
|--------|--------|---------------------|-------------------|
| 50% | $246 | 9 gyms | 112 gyms |
| **65%** | **$390** | **6 gyms** | **71 gyms** |
| 80% | $745 | 3 gyms | 37 gyms |

---

## 10. Sensitivity Analysis

### Margin Impact

| Metric | 50% Margin | 65% Margin | 80% Margin |
|--------|------------|------------|------------|
| Monthly Price (avg) | $332 | $476 | $831 |
| Monthly GP/Gym | $246 | $390 | $745 |
| Break-even (Scale) | 112 gyms | 71 gyms | 37 gyms |
| LTV | $24,600 | $39,000 | $74,500 |
| LTV:CAC | 16:1 | 26:1 | 50:1 |

### Churn Impact

| Annual Churn | Avg Lifetime | LTV (65%) | LTV:CAC |
|--------------|--------------|-----------|---------|
| 5% | 240 mo | $93,600 | 62:1 |
| 8% | 150 mo | $58,500 | 39:1 |
| **12%** | **100 mo** | **$39,000** | **26:1** |
| 15% | 80 mo | $31,200 | 21:1 |
| 20% | 60 mo | $23,400 | 16:1 |

---

## 11. Customer Value Proposition

### The Core Pitch

**Avoid ONE bad equipment purchase per year.**

### Real Equipment Costs

| Equipment | Price | Lifespan |
|-----------|-------|----------|
| Commercial treadmill | $5,000-12,000 | 7-10 yrs |
| Elliptical | $4,000-8,000 | 7-10 yrs |
| Cable machine | $3,000-8,000 | 10-15 yrs |
| Squat rack | $1,500-4,000 | 15+ yrs |

**Typical annual equipment budget:** $10,000-50,000

### ROI Calculation

| Gym Size | Annual Cost (65%) | Break-Even Requires |
|----------|-------------------|---------------------|
| 5,000 sqft | ~$4,000 | Avoid one $4K mistake |
| 10,000 sqft | ~$5,000 | Avoid one $5K mistake |
| 20,000 sqft | ~$6,500 | Avoid one $6.5K mistake |

### Ideal Customer Profile

| Works For | Doesn't Work For |
|-----------|------------------|
| Growing gyms buying equipment | Struggling gyms with no budget |
| Multi-location chains | Brand new gyms (no baseline) |
| Premium facilities | 24/7 unmanned gyms |
| Investor/landlord reporting needs | — |

---

## 12. Partner Economics

### Design Partner Deal

- **Revenue Share:** 10% of net profit
- **Cap:** $1,000,000 lifetime

| Scale | Gyms | Monthly Net Profit | Partner 10% | Annual |
|-------|------|--------------------|-------------|--------|
| Growth | 25 | $7,600 | $760 | $9,120 |
| Scale | 100 | $11,500 | $1,150 | $13,800 |
| Mature | 250 | $47,500 | $4,750 | $57,000 |

### Founding Contributor Program

For landing major chain deals (10+ locations) when < $1M ARR:

| Deal Size | Equity | Signing Bonus |
|-----------|--------|---------------|
| 10-24 locations | 10% | $15,000 |
| 25-49 locations | 15% | $35,000 |
| 50-99 locations | 18% | $75,000 |
| 100+ locations | 20% | $150,000 |

**Additional compensation:**
- Per-location fee: $3,000 (first 50 locations)
- Revenue share: 30% Y1, 20% Y2, 15% Y3, 10% Y4+
- Cash cap: $1,500,000 lifetime

---

## 13. Target Markets

### Regional Chains (Primary Target)

| Chain | Locations | Avg Size | Annual Contract |
|-------|-----------|----------|-----------------|
| City Fitness | ~10 | 15,000 sqft | $51,720 |
| Snap Fitness (regional) | 10-20 | 8,000 sqft | $41,880-83,760 |
| Gold's Gym (franchisee) | 5-15 | 25,000 sqft | $34,740-104,220 |
| Crunch Fitness (regional) | 10-25 | 20,000 sqft | $59,040-147,600 |

### Enterprise (Future)

| Chain | Locations | Annual Contract |
|-------|-----------|-----------------|
| LA Fitness | ~700 | $6,199,200 |
| Planet Fitness | ~2,600 | $15,350,400 |
| Equinox | ~100 | $793,200 |

---

## 14. Scaling Triggers

| Milestone | Trigger | Action |
|-----------|---------|--------|
| Part-time help | 25+ gyms | Add install contractor ($1,500/mo) |
| First hire | 50+ gyms | Part-time ops/support ($5K/mo) |
| Founder quits job | 70-80 gyms | Take salary, MRR covers it |
| Full team | 100+ gyms | Founder + 1-2 employees |

---

## 15. Hardware Float

| Gyms in Pipeline | Float Needed |
|------------------|--------------|
| 2 | $2,274 |
| 5 | $5,685 |
| 10 | $11,370 |

**Solutions:**
1. 50% customer deposit — reduces float to ~$5.7K for 10 gyms
2. Revenue from early customers — self-fund growth
3. Friends/family round — $25-50K covers 20+ gyms

---

## 16. Key Assumptions

| Assumption | Value | Basis |
|------------|-------|-------|
| Monthly COGS | $86 | Supabase + support |
| Hardware markup | 20% | Industry standard |
| Target margin | 65% | Balance of value and profitability |
| Churn rate | 12% | B2B SaaS benchmark |
| Contract term | 12 months | Annual commitment |
| Camera coverage | 1 per 600 sqft | Full Install standard |
| Inference rate | 1 FPS | Accuracy requirement |

---

## 17. Open Items

| Item | Priority | Owner |
|------|----------|-------|
| Validate Supabase costs at 100 gyms | High | Tech |
| City Fitness pilot intro | Critical | Founder |
| Site assessment template | Medium | Operations |
| SOC 2 timeline for enterprise | Low | Operations |

---

## Appendix A: Multi-Margin Unit Economics

### Hybrid Model — All Margin Tiers

**50% Margin**

| Segment | Y1 Revenue | Y1 Cost | Y1 Profit | Margin |
|---------|------------|---------|-----------|--------|
| Small Boutique | $3,992 | $2,169 | $1,823 | 46% |
| Mid Independent | $4,867 | $2,378 | $2,489 | 51% |
| Large Facility | $6,596 | $2,879 | $3,717 | 56% |
| Enterprise | $9,599 | $3,451 | $6,148 | 64% |

**65% Margin**

| Segment | Y1 Revenue | Y1 Cost | Y1 Profit | Margin |
|---------|------------|---------|-----------|--------|
| Small Boutique | $5,132 | $2,169 | $2,963 | 58% |
| Mid Independent | $6,271 | $2,378 | $3,893 | 62% |
| Large Facility | $8,492 | $2,879 | $5,613 | 66% |
| Enterprise | $12,491 | $3,451 | $9,040 | 72% |

**80% Margin**

| Segment | Y1 Revenue | Y1 Cost | Y1 Profit | Margin |
|---------|------------|---------|-----------|--------|
| Small Boutique | $7,940 | $2,169 | $5,771 | 73% |
| Mid Independent | $9,739 | $2,378 | $7,361 | 76% |
| Large Facility | $13,172 | $2,879 | $10,293 | 78% |
| Enterprise | $19,643 | $3,451 | $16,192 | 82% |

### Full Install Model — All Margin Tiers

**50% Margin**

| Segment | Y1 Revenue | Y1 Cost | Y1 Profit | Margin |
|---------|------------|---------|-----------|--------|
| Small Boutique | $5,214 | $3,187 | $2,027 | 39% |
| Mid Independent | $8,082 | $5,057 | $3,025 | 37% |
| Large Facility | $13,579 | $8,698 | $4,881 | 36% |
| Enterprise | $24,910 | $16,210 | $8,700 | 35% |

**65% Margin**

| Segment | Y1 Revenue | Y1 Cost | Y1 Profit | Margin |
|---------|------------|---------|-----------|--------|
| Small Boutique | $6,354 | $3,187 | $3,167 | 50% |
| Mid Independent | $9,486 | $5,057 | $4,429 | 47% |
| Large Facility | $15,475 | $8,698 | $6,777 | 44% |
| Enterprise | $27,802 | $16,210 | $11,592 | 42% |

**80% Margin**

| Segment | Y1 Revenue | Y1 Cost | Y1 Profit | Margin |
|---------|------------|---------|-----------|--------|
| Small Boutique | $9,162 | $3,187 | $5,975 | 65% |
| Mid Independent | $12,954 | $5,057 | $7,897 | 61% |
| Large Facility | $20,155 | $8,698 | $11,457 | 57% |
| Enterprise | $34,954 | $16,210 | $18,744 | 54% |

---

## Appendix B: Hardware Sources

| Component | Source | Price | Link |
|-----------|--------|-------|------|
| Jetson Orin Nano Super | Seeed Studio | $249 | seeedstudio.com |
| Hikvision DS-2CD2143G2-I | HIKD | $125-156 | hikdistribution.com |
| Reolink RLC-810A | Reolink | $90 | reolink.com |
| Hailo-8 M.2 | Waveshare | $180 | waveshare.com |

---

*Document generated from validated research conducted December 2025.*
