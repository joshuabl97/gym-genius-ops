# Gym Genius Equipment Utilization - Financial Model Specification

## Overview

This document specifies the comprehensive financial model for Gym Genius EU. Use this to build the Google Sheets model.

---

## 1. INPUTS SECTION

### 1.1 Hardware Bill of Materials (Per Gym Installation)

| Component | Low Est | Mid Est | High Est | Notes |
|-----------|---------|---------|----------|-------|
| Edge Compute Box | $400 | $600 | $800 | Needs research - real products |
| Core Cameras (equipment zones) | $200 | $400 | $600 | 2-4 cameras depending on layout |
| Mounting/Cabling | $50 | $100 | $150 | Brackets, ethernet, power |
| Contingency | $100 | $150 | $200 | Unexpected costs |
| **Subtotal Hardware** | **$750** | **$1,250** | **$1,750** | **RESEARCH NEEDED** |

**Installation Options:**
| Method | Cost Range | Notes |
|--------|------------|-------|
| Founder DIY | $0 + travel | Early pilots only |
| Gym IT + Remote Support | $0-200 | Ship hardware, support remotely |
| Local Contractor | $300-600 | Electrician/AV pro |

**UPSELL: Additional Camera Coverage**
| Add-on | Cost | Monthly Addon |
|--------|------|---------------|
| +2 cameras (entrance, classes) | $200-400 | $50-100/mo |
| +4 cameras (full facility) | $400-800 | $100-200/mo |
| Scoping/consultation | $200-500 | One-time |

### 1.2 Monthly Operating Costs (Per Gym)

| Cost Item | Low | Mid | High | Notes |
|-----------|-----|-----|------|-------|
| Cloud/Infrastructure | $10 | $25 | $50 | Edge-first, cloud for dashboards |
| Support Allocation | $25 | $50 | $75 | Remote support, time allocation |
| Software Maintenance | $15 | $25 | $40 | Updates, bug fixes, monitoring |
| **Total Monthly COGS** | **$50** | **$100** | **$165** | Per gym |

### 1.3 Pricing Assumptions

| Parameter | Value | Notes |
|-----------|-------|-------|
| Target Gross Margin | 50% | Industry standard for hardware+SaaS |
| Hardware Payback Target | 12 months | Customer pays upfront |
| Contract Term | 12 months | Annual commitment |
| Annual Churn Rate | 10-15% | Standard B2B SaaS |
| Avg Customer Lifetime | 36-48 months | Based on churn |

### 1.4 Gym Size Segments

| Segment | Sqft Range | Example | Est. Mix |
|---------|------------|---------|----------|
| Small Boutique | 3,000-8,000 | CrossFit box, yoga studio | 20% |
| Mid Independent | 8,000-15,000 | Local gym, small chain | 35% |
| Large Facility | 15,000-30,000 | Regional chain location | 30% |
| Enterprise | 30,000-60,000+ | Large chain, Equinox-type | 15% |

**Weighted Average:** ~15,000 sqft (for modeling)

---

## 2. PRICING MODEL (Sqft-Based)

### 2.1 Recommended Tier Structure

**Option A: Base + Per Sqft (RECOMMENDED)**

| Component | Pricing |
|-----------|---------|
| Base Platform Fee | $200/month |
| Per Sqft Fee | $0.015/sqft/month |
| Hardware | Customer pays upfront at cost + 20% markup |

**Example Pricing:**
| Gym Size | Base | Sqft Fee | Total Monthly | Annual |
|----------|------|----------|---------------|--------|
| 5,000 sqft | $200 | $75 | $275 | $3,300 |
| 10,000 sqft | $200 | $150 | $350 | $4,200 |
| 20,000 sqft | $200 | $300 | $500 | $6,000 |
| 40,000 sqft | $200 | $600 | $800 | $9,600 |

**Option B: Tiered Brackets (Simpler)**

| Tier | Sqft Range | Monthly Price | Hardware Markup |
|------|------------|---------------|-----------------|
| Starter | Up to 8,000 | $299/mo | +20% |
| Growth | 8,001-20,000 | $449/mo | +20% |
| Scale | 20,001-40,000 | $649/mo | +20% |
| Enterprise | 40,000+ | Custom | Custom |

### 2.2 Margin Calculation Formula

```
Target Price = Total Cost / (1 - Target Margin)

Where Total Cost = Monthly COGS + (Hardware Cost / Payback Months)

Example (Mid estimates):
- Monthly COGS: $100
- Hardware: $1,250 (paid upfront by customer, so $0 amortization for us)
- If customer pays hardware upfront: Price = $100 / 0.50 = $200/mo minimum

BUT we want profit on hardware too:
- Hardware Markup: $1,250 * 1.20 = $1,500 customer pays
- Gross on hardware: $250
```

---

## 3. UNIT ECONOMICS

### 3.1 Per-Gym Economics (Mid-Size 15,000 sqft)

**Revenue:**
| Line Item | Amount | Notes |
|-----------|--------|-------|
| Hardware Sale (upfront) | $1,500 | $1,250 cost + 20% markup |
| Monthly Software | $425 | $200 base + $225 sqft |
| Annual Contract Value | $5,100 | Excludes hardware |
| **Year 1 Total** | **$6,600** | Hardware + software |

**Costs:**
| Line Item | Amount | Notes |
|-----------|--------|-------|
| Hardware COGS | $1,250 | One-time |
| Monthly COGS | $100 | Cloud + support |
| Annual COGS | $1,200 | Monthly * 12 |
| **Year 1 Total Cost** | **$2,450** | Hardware + operating |

**Profit:**
| Metric | Amount | % |
|--------|--------|---|
| Year 1 Gross Profit | $4,150 | 63% |
| Ongoing Annual Gross Profit | $3,900 | 76% (no hardware) |

### 3.2 Lifetime Value (LTV)

| Metric | Conservative | Mid | Optimistic |
|--------|--------------|-----|------------|
| Avg Lifetime (months) | 30 | 42 | 54 |
| Lifetime Revenue | $14,250 | $19,350 | $24,450 |
| Lifetime COGS | $4,250 | $5,450 | $6,650 |
| **LTV** | **$10,000** | **$13,900** | **$17,800** |

### 3.3 Customer Acquisition Cost (CAC) - TBD

| Channel | Est. CAC | Notes |
|---------|----------|-------|
| Founder-led | $500-1,500 | Time + travel |
| Partner referral | $1,000-2,500 | Commission/fee |
| Inbound marketing | $1,500-3,000 | Paid + content |
| **Blended Target** | **$1,500** | **Need to validate** |

**Target LTV:CAC Ratio:** >5:1 (We're at 9:1 with $1,500 CAC)

---

## 4. DESIGN PARTNER DEAL

### 4.1 Structure

| Term | Detail |
|------|--------|
| Partner Status | Pays for product (not free pilot) |
| Revenue Share | 10% of net profit from ALL customers |
| Cap | Until $500,000 total paid out |
| Calculation | Net Profit = Revenue - COGS - Operating Expenses |

### 4.2 Model Impact

**Scenario: 100 gyms at $425/mo avg**
| Line | Amount |
|------|--------|
| Monthly Revenue | $42,500 |
| Monthly COGS (~$100/gym) | $10,000 |
| Monthly Operating Costs | $15,000 |
| Net Profit | $17,500 |
| Partner 10% Share | $1,750/mo |
| Months to $500k Cap | ~286 months |

**Reality:** At scale, the cap gets hit faster. At $100k/mo profit, cap hit in 5 months.

---

## 5. SALES PARTNER COMPENSATION (Recommendation)

### 5.1 For the Equinox Intro (One-Time Relationship)

**Recommended: Hybrid Structure**

| Component | Amount | Notes |
|-----------|--------|-------|
| Upfront Referral Fee | $2,500 | On signed contract |
| First-Year Revenue Share | 10% | Of Year 1 revenue |
| **Equinox Example** | | |
| If 5 locations @ $500/mo | | |
| Upfront | $2,500 | One-time |
| Year 1 Share | $3,000 | 10% of $30k |
| **Total Comp** | **$5,500** | |

### 5.2 For Ongoing Sales Partners

| Tier | Commission | Notes |
|------|------------|-------|
| Referral Only | 10% Year 1 | Just intro, we close |
| Assisted Close | 15% Year 1 | Help through sales process |
| Full Sale | 20% Year 1 | Partner closes deal |
| Recurring | 5% ongoing | For strategic partners only |

---

## 6. ONE-TIME COSTS (Setup Phase)

| Category | Low | Mid | High | Priority |
|----------|-----|-----|------|----------|
| **Legal** | | | | |
| LLC Formation | $200 | $500 | $1,000 | High |
| Operating Agreement | $500 | $1,500 | $3,000 | High |
| Customer Contracts | $1,000 | $2,500 | $5,000 | High |
| Terms of Service | $500 | $1,000 | $2,000 | High |
| **Legal Subtotal** | **$2,200** | **$5,500** | **$11,000** | |
| | | | | |
| **IP/Patents** | | | | |
| Provisional Patent | $1,500 | $3,000 | $5,000 | Medium |
| Trademark | $500 | $1,000 | $2,000 | Low |
| **IP Subtotal** | **$2,000** | **$4,000** | **$7,000** | |
| | | | | |
| **Certifications** | | | | |
| SOC 2 Type 1 | $10,000 | $20,000 | $35,000 | Medium |
| Privacy Audit | $2,000 | $5,000 | $10,000 | Medium |
| **Cert Subtotal** | **$12,000** | **$25,000** | **$45,000** | |
| | | | | |
| **TOTAL ONE-TIME** | **$16,200** | **$34,500** | **$63,000** | |

**Recommendation:** Start with legal only (~$5k). Defer patents and certs until post-pilot validation.

---

## 7. OPERATING EXPENSES (Monthly)

### 7.1 Current State (Pre-Revenue)

| Item | Amount | Notes |
|------|--------|-------|
| Cloud/Dev Tools | $100 | AWS, Notion, domains |
| Subscriptions | $50 | Software tools |
| Marketing | $50 | Minimal |
| **Total** | **$200** | Low burn |

### 7.2 Growth State (10-25 gyms)

| Item | Amount | Notes |
|------|--------|-------|
| Founder Salary | $0 | Still employed |
| Cloud Infrastructure | $300 | Scaling up |
| Tools/Subscriptions | $150 | More software |
| Marketing/Sales | $500 | Content, ads, travel |
| Contractors | $1,000 | Dev/design help |
| Legal/Accounting | $200 | Monthly retainer |
| **Total** | **$2,150** | |

### 7.3 Scale State (50+ gyms)

| Item | Amount | Notes |
|------|--------|-------|
| Founder Salary | $10,000 | Quit day job |
| Employee #1 (Sales) | $8,000 | Base + commission |
| Employee #2 (Support) | $5,000 | Customer success |
| Cloud Infrastructure | $1,000 | |
| Office/Workspace | $500 | Coworking |
| Tools/Software | $500 | |
| Marketing | $2,000 | |
| Legal/Accounting | $500 | |
| **Total** | **$27,500** | |

---

## 8. PROJECTIONS

### 8.1 Year 1: Pilot Phase (5-10 Gyms)

| Quarter | Gyms | MRR | Hardware Rev | COGS | Gross Profit | OpEx | Net |
|---------|------|-----|--------------|------|--------------|------|-----|
| Q1 | 2 | $850 | $3,000 | $200 | $3,650 | $600 | $3,050 |
| Q2 | 5 | $2,125 | $4,500 | $500 | $6,125 | $600 | $5,525 |
| Q3 | 7 | $2,975 | $3,000 | $700 | $5,275 | $800 | $4,475 |
| Q4 | 10 | $4,250 | $4,500 | $1,000 | $7,750 | $1,000 | $6,750 |
| **Y1 Total** | | $40,800 | $15,000 | $9,600 | $46,200 | $12,000 | $19,800 |

### 8.2 Year 2: Scale Phase (50-100 Gyms)

| Quarter | Gyms | MRR | Cumulative HW | Monthly COGS | OpEx | Net Profit |
|---------|------|-----|---------------|--------------|------|------------|
| Q1 | 25 | $10,625 | $37,500 | $2,500 | $15,000 | -$6,875 |
| Q2 | 45 | $19,125 | $30,000 | $4,500 | $20,000 | -$5,375 |
| Q3 | 70 | $29,750 | $37,500 | $7,000 | $25,000 | -$2,250 |
| Q4 | 100 | $42,500 | $45,000 | $10,000 | $27,500 | $5,000 |

### 8.3 Sensitivity Analysis

**Price Sensitivity (15k sqft gym):**
| Scenario | Monthly Price | Annual Rev | Y1 Margin |
|----------|---------------|------------|-----------|
| Low Price ($350) | $350 | $4,200 | 44% |
| Target ($425) | $425 | $5,100 | 56% |
| Premium ($550) | $550 | $6,600 | 66% |

**Churn Sensitivity:**
| Churn Rate | Avg Lifetime | LTV | Impact |
|------------|--------------|-----|--------|
| 5% | 60 mo | $25,500 | +84% |
| 10% | 42 mo | $13,900 | Baseline |
| 15% | 30 mo | $10,000 | -28% |
| 20% | 24 mo | $7,600 | -45% |

---

## 9. KEY METRICS DASHBOARD

| Metric | Target | Formula |
|--------|--------|---------|
| Gross Margin | 50%+ | (Revenue - COGS) / Revenue |
| LTV:CAC | >5:1 | LTV / CAC |
| Payback Period | <6 mo | CAC / Monthly Gross Profit |
| Net Revenue Retention | >100% | (Revenue + Expansion - Churn) / Prior Revenue |
| MRR Growth | >15%/mo | (Current MRR - Prior MRR) / Prior MRR |
| Hardware Attach Rate | 100% | HW Sales / New Customers |
| Upsell Rate | >20% | Customers with add-ons / Total Customers |

---

## 10. RESEARCH NEEDED

| Item | Owner | Priority | Deliverable |
|------|-------|----------|-------------|
| Hardware BOM (real products) | Research Agent | High | Product list with prices |
| Cloud cost modeling | Tech/Research | High | AWS/inference estimates |
| Competitor pricing validation | Research Agent | Medium | Market pricing data |
| Privacy compliance requirements | Research Agent | Medium | GDPR/CCPA/BIPA checklist |
| SOC 2 timeline/cost | Operations | Low | Vendor quotes |

---

## 11. GOOGLE SHEETS STRUCTURE

### Tab 1: Inputs (Yellow Cells = Editable)
- Hardware BOM
- Monthly costs
- Assumptions (margin, churn, etc.)
- Gym size segments
- Operating expenses

### Tab 2: Pricing Calculator
- Sqft input
- Auto-calculate pricing
- Margin validation

### Tab 3: Unit Economics
- Per-gym economics
- LTV/CAC calculations
- Payback period

### Tab 4: Projections
- Year 1 quarterly
- Year 2 quarterly
- Gym growth assumptions

### Tab 5: Scenarios
- Price sensitivity
- Churn sensitivity
- Cost sensitivity

### Tab 6: Partner Deals
- Design partner economics
- Sales partner commissions
- Cap tracking

### Tab 7: Runway
- Cash flow
- Burn rate
- Months of runway
- Break-even analysis

### Tab 8: Dashboard
- Key metrics summary
- Charts/visualizations
