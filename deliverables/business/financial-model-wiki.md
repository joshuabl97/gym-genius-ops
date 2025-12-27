# Uzzage Financial Model

## Quick Links

**Google Sheets:** [INSERT LINK HERE]

> **Notion Embed Instructions:**
> 1. Copy your Google Sheets link
> 2. In Notion, type `/embed`
> 3. Paste the Sheets link
> 4. Alternatively, use `/google drive` for native integration

---

## Overview

The Uzzage Financial Model is a comprehensive tool for understanding unit economics, pricing, growth projections, and path to profitability. It's designed to be dynamic—change an input and watch calculations cascade through the entire model.

### Model Structure

| Tab | Purpose |
|-----|---------|
| **Inputs** | All editable parameters (single source of truth) |
| **Pricing** | Software + Hardware pricing for all tiers |
| **Economics** | Unit economics, LTV, and CAC analysis |
| **Growth** | Path to $1M ARR, OpEx, break-even analysis |
| **Projections** | 3-year quarterly forecast |

---

## Tab Details

### Inputs Tab

The central hub for all model parameters. **Edit yellow cells only.**

| Section | What It Controls |
|---------|------------------|
| Hardware Costs | Jetson, cameras, switches, cabling, contingency %, markup % |
| Monthly Costs (COGS) | Cloud, support, software maintenance per gym |
| Pricing Parameters | Base fee, per-sqft rate |
| Assumptions | Churn rate, customer lifetime, CAC |
| Segment Definitions | Sqft and camera counts for each gym size |

**Key Inputs to Adjust:**
- `Base Fee` - Minimum monthly software price
- `Per Sqft Rate` - Price scaling factor
- `Annual Churn Rate` - Customer retention assumption
- `Blended CAC` - Average acquisition cost

---

### Pricing Tab

Shows how pricing is calculated for each segment and hardware tier.

#### Software Pricing

| Segment | Sqft | Monthly Price | Monthly COGS | Gross Profit | Gross Margin |
|---------|------|---------------|--------------|--------------|--------------|
| Small Boutique | 5,500 | $313.65 | $86.00 | $227.65 | 72.58% |
| Mid Independent | 11,500 | $387.45 | $86.00 | $301.45 | 77.80% |
| Large Facility | 22,500 | $522.75 | $86.00 | $436.75 | 83.55% |
| Enterprise | 45,000 | $799.50 | $86.00 | $713.50 | 89.24% |
| **Weighted Average** | - | **$505.84** | **$86.00** | **$419.84** | **83.00%** |

**Formula:** `Monthly Price = Base Fee + (Sqft × Per Sqft Rate)`

#### Hardware Tiers

| Tier | Small Boutique | Mid Independent | Large Facility | Enterprise |
|------|----------------|-----------------|----------------|------------|
| **Connect (BYOC)** | $300 | $300 | $350 | $599 |
| **Enhance (Hybrid)** | $2,838 | $3,457 | $4,728 | $6,914 |
| **Complete (Full)** | $5,900 | $11,827 | $23,194 | $45,834 |

---

### Economics Tab

Analyzes profitability at the per-customer level.

#### Lifetime Value (LTV)

| Churn Rate | Avg Lifetime | LTV |
|------------|--------------|-----|
| 15% | 80 months | $34,334 |
| 12% | 100 months | $42,731 |
| 8% | 150 months | $63,723 |

#### Customer Acquisition

| Channel | CAC | LTV:CAC | Payback |
|---------|-----|---------|---------|
| Founder-led | $1,000 | 43:1 | 2.4 mo |
| Partner referral | $2,000 | 21:1 | 4.8 mo |
| Inbound marketing | $3,000 | 14:1 | 7.1 mo |
| **Blended Target** | **$1,500** | **28:1** | **3.6 mo** |

---

### Growth Tab

Maps the path from pilot to $1M ARR.

#### Milestones

| Milestone | Gyms | MRR | ARR | Valuation (Mid) |
|-----------|------|-----|-----|-----------------|
| Pilot | 10 | $5,058 | $60,701 | $242,802 |
| Traction | 25 | $12,646 | $151,751 | $910,508 |
| Growth | 50 | $25,292 | $303,503 | $2,579,771 |
| Scale | 100 | $50,584 | $607,005 | $6,070,050 |
| **$1M ARR** | **175** | **$88,522** | **$1,062,259** | **$13,278,234** |

#### Customer Mix Assumption
- 30% Connect (BYOC)
- 50% Enhance (Hybrid)
- 20% Complete (Full Install)

#### Break-Even Analysis

| Phase | Monthly OpEx | Gyms to Break-Even |
|-------|--------------|-------------------|
| Pre-Revenue | $200 | 1 |
| Growth (10-25 gyms) | $2,150 | 6 |
| Scale (50+ gyms) | $27,000 | 65 |

---

### Projections Tab

Quarterly breakdown of revenue and profitability over 3 years.

#### Year-End Targets

| Metric | Year 1 | Year 2 | Year 3 | **3-Year Total** |
|--------|--------|--------|--------|------------------|
| Ending Gyms | 10 | 35 | 100 | - |
| Revenue | $79,745 | $228,449 | $440,698 | **$748,892** |
| Net Profit | $65,561 | $194,049 | $165,878 | **$425,488** |

---

## Key Metrics Summary

| Metric | Value |
|--------|-------|
| Weighted Avg Monthly Price | $505.84 |
| Monthly COGS per Gym | $86.00 |
| Gross Profit per Gym | $419.84 |
| Gross Margin | 83.00% |
| LTV (12% churn) | $42,731 |
| LTV:CAC Ratio | 28:1 |
| Payback Period | 3.6 months |
| Break-even (Growth Phase) | 6 gyms |
| Gyms to $1M ARR | 175 |

---

## How to Use This Model

### Scenario Planning

1. **Adjust pricing:** Change `Base Fee` or `Per Sqft Rate` in Inputs
2. **Model churn scenarios:** Change `Annual Churn Rate` to see LTV impact
3. **Hardware cost changes:** Update camera/compute prices to see margin impact
4. **OpEx planning:** Adjust operating expenses in Growth tab

### Common Scenarios to Test

| Scenario | What to Change |
|----------|----------------|
| Price increase | Inputs → Base Fee (+$50) |
| Better retention | Inputs → Annual Churn Rate (12% → 8%) |
| Camera price drop | Inputs → Ubiquiti AI 360 Camera |
| Higher support costs | Inputs → Support Allocation |

---

## Version History

| Date | Version | Changes |
|------|---------|---------|
| 2025-12-27 | 1.0 | Initial model with 5 tabs |
