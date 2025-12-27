# Uzzage Financial Model - Google Sheets Setup Guide

> **Last Updated:** December 2025
> **Matches:** financial-model.md (current version)

---

## Sheet Structure

Create these tabs in your Google Sheet:

| Tab | Purpose |
|-----|---------|
| **Inputs** | All editable assumptions (yellow cells) |
| **Pricing** | Software and hardware pricing by segment |
| **Unit Economics** | Per-gym profitability by deployment model |
| **Projections** | Path to $1M ARR with milestones |
| **Cash Flow** | Monthly runway and break-even |

---

## Tab 1: Inputs

### Layout

| Row | A (Label) | B (Value) | C (Unit) | D (Notes) |
|-----|-----------|-----------|----------|-----------|
| 1 | **INPUTS** | | | Highlight yellow = editable |
| 2 | | | | |
| 3 | **Hardware Costs** | | | |
| 4 | Jetson Orin Nano Super | 249 | $ | Edge compute |
| 5 | Ubiquiti AI 360 Camera | 419 | $ | Per camera |
| 6 | 8-port PoE Switch | 75 | $ | |
| 7 | 16-port PoE Switch | 150 | $ | |
| 8 | Contingency % | 0.10 | % | 10% buffer |
| 9 | Hardware Markup | 0.20 | % | 20% margin |
| 10 | | | | |
| 11 | **Monthly Costs (COGS)** | | | |
| 12 | Cloud (Supabase + Vercel) | 26 | $/gym | |
| 13 | Support Allocation | 40 | $/gym | ~1 hr/gym/mo |
| 14 | Software Maintenance | 20 | $/gym | Updates |
| 15 | **Total Monthly COGS** | =SUM(B12:B14) | $/gym | Should = $86 |
| 16 | | | | |
| 17 | **Pricing Parameters** | | | |
| 18 | Target Margin | 0.65 | % | 65% gross |
| 19 | Base Fee | 246 | $ | |
| 20 | Per Sqft Rate | 0.0123 | $ | |
| 21 | | | | |
| 22 | **Assumptions** | | | |
| 23 | Annual Churn Rate | 0.12 | % | 12% |
| 24 | Avg Customer Lifetime | 100 | months | =12/B23 |
| 25 | Contract Term | 12 | months | Annual |
| 26 | | | | |
| 27 | **Segment Sqft** | | | |
| 28 | Small Boutique | 5500 | sqft | |
| 29 | Mid Independent | 11500 | sqft | |
| 30 | Large Facility | 22500 | sqft | |
| 31 | Enterprise | 45000 | sqft | |

---

## Tab 2: Pricing

### Software Pricing (rows 1-15)

| Row | A | B | C | D | E |
|-----|---|---|---|---|---|
| 1 | **SOFTWARE PRICING** | | | | |
| 2 | Segment | Sqft | Monthly Price | Gross Profit | Margin |
| 3 | Small Boutique | =Inputs!B28 | =Inputs!$B$19+(B3*Inputs!$B$20) | =C3-Inputs!$B$15 | =D3/C3 |
| 4 | Mid Independent | =Inputs!B29 | =Inputs!$B$19+(B4*Inputs!$B$20) | =C4-Inputs!$B$15 | =D4/C4 |
| 5 | Large Facility | =Inputs!B30 | =Inputs!$B$19+(B5*Inputs!$B$20) | =C5-Inputs!$B$15 | =D5/C5 |
| 6 | Enterprise | =Inputs!B31 | =Inputs!$B$19+(B6*Inputs!$B$20) | =C6-Inputs!$B$15 | =D6/C6 |
| 7 | **Weighted Avg** | | =AVERAGE(C3:C6) | =AVERAGE(D3:D6) | =D7/C7 |

**Expected values:**
- Small Boutique: $314/mo, $228 GP, 73% margin
- Mid Independent: $388/mo, $302 GP, 78% margin
- Large Facility: $523/mo, $437 GP, 84% margin
- Enterprise: $799/mo, $713 GP, 89% margin
- Weighted Avg: ~$476/mo

### Hardware Pricing - BYOC (rows 17-25)

| Row | A | B | C | D |
|-----|---|---|---|---|
| 17 | **BYOC (Connect)** | Cost | Customer Price | |
| 18 | Segment | =formula | =B*1.2 | |
| 19 | Small Boutique | =Inputs!B4+50 | =B19*(1+Inputs!$B$9) | $299 → $359 |
| 20 | Mid Independent | =Inputs!B4+50 | =B20*(1+Inputs!$B$9) | $299 → $359 |
| 21 | Large Facility | =Inputs!B4+100 | =B21*(1+Inputs!$B$9) | $349 → $419 |
| 22 | Enterprise | =(Inputs!B4*2)+100 | =B22*(1+Inputs!$B$9) | $598 → $718 |

### Hardware Pricing - Hybrid (rows 27-35)

| Row | A | B (Cameras) | C (Cost) | D (Price) |
|-----|---|-------------|----------|-----------|
| 27 | **Hybrid (Enhance)** | Cameras | Cost | Customer Price |
| 28 | Small Boutique | 4 | =Inputs!B4+(B28*Inputs!B5)+Inputs!B6+150+((Inputs!B4+(B28*Inputs!B5)+Inputs!B6+150)*Inputs!B8) | =C28*(1+Inputs!$B$9) |
| 29 | Mid Independent | 5 | ... | ... |
| 30 | Large Facility | 7 | ... | ... |
| 31 | Enterprise | 10 | ... | ... |

**Expected hardware costs:**
- Small Boutique: $2,365 cost → $2,838 price
- Mid Independent: $2,881 cost → $3,457 price
- Large Facility: $3,995 cost → $4,794 price
- Enterprise: $5,488 cost → $6,586 price

### Hardware Pricing - Full Install (rows 37-45)

| Row | A | B (Cameras) | C (Cost) | D (Price) |
|-----|---|-------------|----------|-----------|
| 37 | **Full Install (Complete)** | Cameras | Cost | Customer Price |
| 38 | Small Boutique | 9 | =formula | =C38*(1+Inputs!$B$9) |
| 39 | Mid Independent | 19 | ... | ... |
| 40 | Large Facility | 38 | ... | ... |
| 41 | Enterprise | 75 | ... | ... |

**Camera count formula:** `=ROUNDUP(Sqft/600, 0)`

**Expected hardware costs:**
- Small Boutique: $4,917 cost → $5,900 price
- Mid Independent: $9,856 cost → $11,827 price
- Large Facility: $19,328 cost → $23,194 price
- Enterprise: $38,195 cost → $45,834 price

---

## Tab 3: Unit Economics

### Core Formulas

**Lifetime Value (LTV):**
```
=Monthly_Price * Avg_Lifetime_Months
```
Example: $476 × 100 months = $47,600 revenue
Less lifetime COGS: $86 × 100 = $8,600
Plus hardware profit: ~$473
**LTV = ~$39,473**

**LTV:CAC Ratio:**
```
=LTV / CAC
```
At $1,500 blended CAC: $39,473 / $1,500 = **26:1**

**Payback Period:**
```
=CAC / Monthly_Gross_Profit
```
At $1,500 CAC, $390 GP: $1,500 / $390 = **3.8 months**

### Unit Economics Table Layout

| Row | A | B | C | D | E | F | G |
|-----|---|---|---|---|---|---|---|
| 1 | **UNIT ECONOMICS** | | | | | | |
| 2 | Model | HW Revenue | Y1 SW Revenue | Y1 Total | Y1 Cost | Y1 Profit | Y1 Margin |
| 3 | BYOC - Small | =Pricing!C19 | =Pricing!C3*12 | =B3+C3 | =Pricing!B19+(Inputs!B15*12) | =D3-E3 | =F3/D3 |
| 4 | Hybrid - Small | =Pricing!D28 | =Pricing!C3*12 | =B4+C4 | =Pricing!C28+(Inputs!B15*12) | =D4-E4 | =F4/D4 |
| 5 | Full - Small | =Pricing!D38 | =Pricing!C3*12 | =B5+C5 | =Pricing!C38+(Inputs!B15*12) | =D5-E5 | =F5/D5 |

**Expected Y1 margins:**
- BYOC: 68-84% (best margins)
- Hybrid: 49-60%
- Full Install: 29-38%

---

## Tab 4: Projections (Path to $1M ARR)

### Milestone Table

| Row | A | B | C | D | E | F | G | H |
|-----|---|---|---|---|---|---|---|---|
| 1 | **PATH TO $1M ARR** | | | | | | | |
| 2 | Milestone | Total Gyms | BYOC (30%) | Hybrid (50%) | Full (20%) | MRR | ARR | Valuation |
| 3 | Pilot | 10 | =ROUND(B3*0.3,0) | =ROUND(B3*0.5,0) | =ROUND(B3*0.2,0) | =B3*Pricing!$C$7 | =F3*12 | =G3*5 |
| 4 | Traction | 25 | =ROUND(B4*0.3,0) | =ROUND(B4*0.5,0) | =ROUND(B4*0.2,0) | =B4*Pricing!$C$7 | =F4*12 | =G4*7 |
| 5 | Growth | 50 | ... | ... | ... | ... | ... | =G5*8 |
| 6 | Scale | 100 | ... | ... | ... | ... | ... | =G6*10 |
| 7 | $1M ARR | 175 | 53 | 87 | 35 | =$1000000/12 | 1000000 | =G7*12 |

**Valuation multiples:**
- Pilot: 3-5x ARR (pre-PMF)
- Traction: 5-7x ARR (early PMF)
- Growth: 7-10x ARR (clear PMF)
- Scale: 8-12x ARR (efficient growth)
- $1M ARR: 10-15x ARR (proven model)

### Cumulative Hardware Revenue

| Row | A | B | C | D | E |
|-----|---|---|---|---|---|
| 10 | **Cumulative HW Revenue** | Connect | Enhance | Complete | Total |
| 11 | Pilot | =C3*Pricing!$C$19 | =D3*Pricing!$D$28 | =E3*Pricing!$D$38 | =SUM(B11:D11) |
| 12 | Traction | =C4*Pricing!$C$19 | ... | ... | ... |

---

## Tab 5: Cash Flow

### Operating Expenses

| Row | A | B | C | D |
|-----|---|---|---|---|
| 1 | **MONTHLY OPEX** | Pre-Revenue | Growth (10-25) | Scale (50+) |
| 2 | Founder Salary | 0 | 0 | 10000 |
| 3 | Employees | 0 | 0 | 13000 |
| 4 | Cloud/Infra | 100 | 300 | 1000 |
| 5 | Tools/Subs | 50 | 150 | 500 |
| 6 | Marketing | 50 | 500 | 2000 |
| 7 | Contractors | 0 | 1000 | 0 |
| 8 | Legal/Accounting | 0 | 200 | 500 |
| 9 | **Total OpEx** | =SUM(B2:B8) | =SUM(C2:C8) | =SUM(D2:D8) |

**Expected totals:** $200 → $2,150 → $27,500

### Break-Even Analysis

| Row | A | B | C |
|-----|---|---|---|
| 12 | **BREAK-EVEN** | Monthly OpEx | Gyms Needed |
| 13 | Pre-Revenue | =B9 | =B13/Pricing!$D$7 |
| 14 | Growth | =C9 | =B14/Pricing!$D$7 |
| 15 | Scale | =D9 | =B15/Pricing!$D$7 |

**Formula:** `Gyms to Break-Even = Monthly OpEx / Gross Profit per Gym`

**Expected:** 1 gym (pre-revenue) → 6 gyms (growth) → 71 gyms (scale)

### Profitability at $1M ARR

| Row | A | B | C |
|-----|---|---|---|
| 18 | **AT $1M ARR (175 gyms)** | Monthly | Annual |
| 19 | Software MRR | =175*Pricing!C7 | =B19*12 |
| 20 | COGS | =175*Inputs!B15 | =B20*12 |
| 21 | Gross Profit | =B19-B20 | =B21*12 |
| 22 | Gross Margin | =B21/B19 | |
| 23 | OpEx (Scale) | =D9 | =B23*12 |
| 24 | **Net Profit** | =B21-B23 | =B24*12 |
| 25 | Net Margin | =B24/B19 | |

**Expected:** $83K MRR, $68K gross profit, $41K net profit, 49% net margin

---

## Quick Setup Checklist

1. [ ] Create Google Sheet with 5 tabs
2. [ ] Set up Inputs tab with all yellow-highlighted editable cells
3. [ ] Build Pricing tab with software formula: `=Base_Fee + (Sqft × Per_Sqft_Rate)`
4. [ ] Add hardware BOMs for each deployment model
5. [ ] Create Unit Economics with Y1 profitability calcs
6. [ ] Build Projections with milestone table
7. [ ] Add Cash Flow with OpEx and break-even

## Validation Checks

Add these formulas to verify your model:

```
Margin Check: =Gross_Profit/Revenue (should = 73-89% by segment)
COGS Check: =SUM(Cloud+Support+Maintenance) (should = $86)
LTV:CAC Check: =LTV/CAC (should be >20:1)
Payback Check: =CAC/Monthly_GP (should be <6 months)
```

---

## Key Formulas Reference

| Calculation | Formula |
|-------------|---------|
| Monthly Price | `=Base_Fee + (Sqft × Per_Sqft_Rate)` |
| Gross Profit | `=Monthly_Price - Monthly_COGS` |
| Gross Margin | `=Gross_Profit / Monthly_Price` |
| LTV | `=(Monthly_Price × Lifetime_Months) - (COGS × Lifetime_Months) + HW_Profit` |
| Payback Period | `=CAC / Monthly_Gross_Profit` |
| Break-even Gyms | `=Monthly_OpEx / Gross_Profit_per_Gym` |
| Hardware Price | `=Hardware_Cost × (1 + Markup%)` |
| Cameras Needed | `=ROUNDUP(Sqft / 600, 0)` |

---

*Document matches financial-model.md as of December 2025*
