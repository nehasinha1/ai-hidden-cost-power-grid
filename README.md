# AI Investment vs Business Outcomes

**Tools:** Excel/Spreadsheets · MS Visio · SharePoint · ServiceNow

## Business Question

**Are companies that invest most in AI actually outperforming those that don't?**

Billions are flowing into enterprise AI — but does higher AI spend translate into measurable business outcomes? This project cross-references AI investment figures against revenue growth, operating margins, employee productivity, and customer satisfaction scores to find out whether the biggest spenders are actually winning.

## Key Questions

- Is there a statistically meaningful correlation between AI investment and revenue growth?
- Do AI-heavy companies show better operating margins — or are costs outpacing returns?
- Which industries show the strongest ROI signal from AI investment?
- What non-financial outcomes (talent retention, customer satisfaction) correlate with AI spend?

## Methodology

```
Public financial filings + AI investment disclosures (Excel)
    │
    ▼
Excel (data cleaning, investment scoring, outcome indexing, pivot analysis)
    │
    ▼
MS Visio (framework diagram: AI investment → business outcome pathways)
    │
    ▼
SharePoint (documentation and stakeholder reporting hub)
    │
    ▼
ServiceNow (CMDB-style documentation template for tracking AI initiative ROI)
```

## Data Sources

| Dataset | Source | Last Updated |
|---|---|---|
| [`ai_investment_business_outcomes_2024_2026.csv`](https://github.com/nehasinha1/ai-hidden-cost-power-grid/blob/main/data/ai_investment_business_outcomes_2024_2026.csv) | S&P 500 filings · Crunchbase · [Stanford HAI AI Index 2026](https://hai.stanford.edu/ai-index/2026-ai-index-report) · [McKinsey State of AI 2025](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) | June 2026 |

### Schema
`Company` · `Industry` · `Region` · `AI_Investment_USD_Millions` · `Revenue_Growth_Pct` · `Profit_Margin_Pct` · `Employee_Productivity_Score` · `AI_ROI_Pct` · `Year` · `Quarter`

---

*Analysis by Neha Sinha · [GitHub](https://github.com/nehasinha1) · [LinkedIn](https://www.linkedin.com/in/nehasinha27788/)*
