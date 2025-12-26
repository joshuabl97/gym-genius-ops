# Financial Model - Google Sheets Formula Guide

## Setup Instructions

1. **Import CSV:** File → Import → Upload `financial-model.csv`
2. **Clean up:** Delete column A (SECTION), adjust headers
3. **Add formulas:** Replace placeholder zeros with formulas below
4. **Format:** Highlight input cells yellow so you know what to edit

---

## Sheet Structure (After Cleanup)

| Col A | Col B | Col C | Col D |
|-------|-------|-------|-------|
| Item | Value | Unit | Notes |

**Input cells to highlight yellow:**
- All HARDWARE COSTS values
- All MONTHLY COSTS values
- All ASSUMPTIONS values
- Starting cash
- Monthly burn items

---

## Core Formulas

### Cell References (adjust row numbers to match your sheet)

Assuming your layout starts at row 1:

```
HARDWARE COSTS section: rows ~4-8
- B4: Edge compute box = 650
- B5: Cameras = 400
- B6: Installation = 300
- B7: Contingency = 150
- B8: TOTAL HARDWARE = =SUM(B4:B7)

MONTHLY COSTS section: rows ~11-15
- B11: Cloud/hosting = 25
- B12: Support = 50
- B13: Maintenance = 25
- B14: TOTAL MONTHLY COST = =SUM(B11:B13)

ASSUMPTIONS section: rows ~17-21
- B17: Target Margin = 0.40
- B18: Payback Months = 12
- B19: Churn Rate = 0.10
- B20: Customer Lifetime = 36
```

### Pricing Calculation (THE KEY FORMULA)

**Logic:** To achieve 40% gross margin, price must cover costs with margin:
```
Price = Total Cost / (1 - Target Margin)
```

**Monthly Hardware Amortization:**
```
=B8/B18
```
(Total Hardware Cost / Payback Months)

**Total Monthly Cost Basis:**
```
=B14 + (B8/B18)
```
(Monthly Costs + Hardware Amortization)

**Monthly Price at Target Margin:**
```
=(B14 + (B8/B18)) / (1 - B17)
```

Example with defaults:
- Monthly costs: $100
- Hardware amortization: $1500/12 = $125
- Total cost basis: $225
- At 40% margin: $225 / 0.60 = **$375/month**

### Unit Economics

**Monthly Revenue:**
```
=PRICE_CELL
```

**Monthly COGS:**
```
=B14 + (B8/B18)
```

**Monthly Gross Profit:**
```
=REVENUE - COGS
```

**Gross Margin % (verification - should equal B17):**
```
=GROSS_PROFIT / REVENUE
```

**Lifetime Value (LTV):**
```
=MONTHLY_PRICE * B20
```

**Lifetime Cost:**
```
=B8 + (B14 * B20)
```

**Lifetime Gross Profit:**
```
=LTV - LIFETIME_COST
```

---

## Scale Projections Section

Create columns for Month 3, 6, 12, 24:

| Metric | M3 | M6 | M12 | M24 |
|--------|----|----|-----|-----|
| Active Gyms | 5 | 15 | 40 | 100 |
| Monthly Revenue | =PRICE*Gyms | | | |
| Monthly COGS | =COST*Gyms | | | |
| Gross Profit | =Rev-COGS | | | |
| Cumulative HW Spend | =HW_COST*Gyms | | | |

**Formulas (assuming gym counts in row 35, price in B25):**
```
Monthly Revenue: =B25*B35
Monthly COGS: =(B14+(B8/B18))*B35
Gross Profit: =B36-B37
Cumulative HW: =B8*B35
```

---

## Cash Flow / Runway

**Monthly Net (at N gyms):**
```
=(MONTHLY_PRICE * N_GYMS) - (MONTHLY_COGS * N_GYMS) - MONTHLY_BURN
```

**Months of Runway:**
```
=STARTING_CASH / MAX(0.01, MONTHLY_BURN - MONTHLY_NET)
```

**Break-even Gyms (to cover burn):**
```
=MONTHLY_BURN / GROSS_PROFIT_PER_GYM
```

---

## Sensitivity Analysis (Optional Tab)

Create a data table varying:
1. **Margin scenarios:** 30%, 40%, 50% → see price impact
2. **Hardware cost scenarios:** $1200, $1500, $1800
3. **Churn scenarios:** 5%, 10%, 15% → LTV impact

**Price at different margins:**
```
| Margin | 30% | 40% | 50% |
| Price | =225/0.70 | =225/0.60 | =225/0.50 |
| Result | $321 | $375 | $450 |
```

---

## Quick Reference: Default Values

| Input | Default | Your Value |
|-------|---------|------------|
| Hardware Cost | $1,500 | |
| Monthly Costs | $100 | |
| Target Margin | 40% | |
| Payback Period | 12 mo | |
| Churn Rate | 10% | |
| Customer Lifetime | 36 mo | |
| **Calculated Price** | **$375/mo** | |

---

## Validation Checks

Add these to verify your model:

1. **Margin check:** `=GROSS_PROFIT/REVENUE` should equal Target Margin
2. **Payback check:** `=HARDWARE_COST/GROSS_PROFIT` should be reasonable
3. **LTV:CAC check:** If you add CAC, `=LTV/CAC` should be >3x
