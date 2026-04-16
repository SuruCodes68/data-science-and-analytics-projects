# Global Superstore Strategic Analysis
### Python EDA + Power BI Dashboard - Retail Profitability & Customer Intelligence

![Python](https://img.shields.io/badge/Python-3.10-blue)
![PowerBI](https://img.shields.io/badge/PowerBI-Dashboard-yellow)
![Pandas](https://img.shields.io/badge/Pandas-EDA-green)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## Project Overview

A full-cycle business intelligence project analyzing the Global Superstore
dataset (2011-2014, 51,290 orders across 7 global markets). The analysis
moves beyond surface-level metrics to uncover actionable profit drivers,
pricing strategy failures, logistics inefficiencies, and customer behavior
patterns - delivering boardroom-ready recommendations backed by data.

---

## Live Dashboard

- [View Power BI Dashboard PDF](https://github.com/SuruCodes68/data-science-and-analytics-projects/blob/main/Global-superstore-analysis/Global_Superstore_Dashboard.pdf)
- [Download Interactive .pbix File](https://github.com/SuruCodes68/data-science-and-analytics-projects/blob/main/Global-superstore-analysis/Global_Superstore_Dashboard.pbix)
- [View Python Analysis Notebook](https://github.com/SuruCodes68/data-science-and-analytics-projects/blob/main/Global-superstore-analysis/Global_Superstore_Analysis.ipynb)

---

## Key Findings

**1. The Tables Crisis**
- Tables generate $717K in sales but lose **-$66,847** in gross profit
- After shipping costs: **-$143,944** - the single biggest profit drain
- Tables is the only sub-category with negative margin (-8.46%)
- **Recommendation:** Review pricing, eliminate discounts, or delist

**2. Discount Strategy is Destroying Margins**
- Discounts above **20% first cause losses**
- Beyond **27% there is no recovery** - margins never return to positive
- 30-40% discount band averages **-25% profit margin**
- **Recommendation:** Hard cap discounts at 15% for most products

**3. Two Types of Shipping Problems**
**Structurally broken:**
- Tables loses money even BEFORE shipping costs

**Logistics-destroyed:**
- Chairs, Machines, Storage, Supplies are profitable before shipping
- Shipping cost exceeds their gross profit entirely
- **Recommendation:** Implement shipping surcharges for bulky items

**4. Customer Intelligence - RFM Segmentation**
| Segment | Count | Avg Spend |
|---------|-------|-----------|
| Champions | 428 | $15,077 |
| At Risk | 54 | $14,272 |
| Loyal Customers | 352 | $10,449 |
| Needs Attention | 179 | $2,314 |
| Lost Customers | 466 | $927 |

- **466 Lost Customers** is the largest segment - urgent recovery needed
- **At Risk customers spend nearly as much as Champions** ($14K vs $15K)
- Recovering 50% of At Risk = **$385,000 in recoverable revenue**
- **Recommendation:** Targeted re-engagement campaign for At Risk segment

**5. Manager Performance is Unbalanced**
- **Nicole Hansen:** 27% margin - most efficient but smallest market
- **Alejandro Ballentine:** 2% margin - busiest but deeply unprofitable
- **Anna Andreadi:** $3M sales but below company average margin
- **Recommendation:** Share best practices from top-efficiency managers

**6. Market Performance**
- **APAC leads all markets** in total profit
- **Canada contributes least** - smallest market by far
- Return rate consistent across all ship modes (~2.3-2.6%)
- **Finding:** Returns are product-driven, not logistics-driven

---

## Dashboard Pages

| Page | Title | Key Visual |
|------|-------|------------|
| 1 | Executive Summary | KPIs, Monthly trend, Market bar chart |
| 2 | Profitability Crisis | BCG scatter, Profit before/after shipping |
| 3 | Discount & Shipping Impact | Tipping point line, True profitability scatter |
| 4 | Customer Segmentation | RFM donut, Monetary value by segment |
| 5 | Operational Performance | Manager scatter, Fulfillment analysis |

---

## Technical Approach

### Data Model
- **Orders** (51,290 rows) - main fact table
- **Returns** (1,173 rows) - supplementary
- **People** (13 rows) - regional manager mapping
- Joined via left merge (Orders+Returns) and inner merge (Orders+People)

### Feature Engineering
| Feature | Formula | Purpose |
|---------|---------|---------|
| Profit Margin | Profit / Sales | Efficiency metric |
| Profit After Shipping | Profit - Shipping Cost | True profitability |
| Order Fulfillment Time | Ship Date - Order Date | Logistics KPI |
| Is_Returned | Binary flag | Return rate calculation |
| RFM Score | Recency + Frequency + Monetary | Customer segmentation |

### Analytical Methods
- BCG Matrix quadrant analysis (Sales vs Profit Margin)
- RFM Customer Segmentation (6 behavioral segments)
- Market Basket Analysis (itertools combinations)
- Discount tipping point analysis (pd.cut binning)
- Manager performance scorecard

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Python 3.10 | Core analysis |
| Pandas | Data manipulation |
| NumPy | Numerical operations |
| Matplotlib/Seaborn | Static visualizations |
| Power BI Desktop | Interactive dashboard |
| DAX | Custom measures |
| Google Colab | Development environment |

---

## Actionable Recommendations Summary

1. **Fix or remove Tables** - losing $143K after shipping
2. **Cap discounts at 15%** - beyond 20% is consistently unprofitable
3. **Add shipping surcharges** for Chairs, Machines, Storage
4. **Re-engage At Risk customers** - $385K recoverable revenue
5. **Grow Paper sales** - highest margin (25%) but underutilized
6. **Share Nicole Hansen's practices** with low-efficiency managers

---

## Author

**Suranjana Aryal** - MSBA, Saint Mary's College of California

[LinkedIn](https://www.linkedin.com/in/suranjana-aryal) |
[GitHub](https://github.com/SuruCodes68)