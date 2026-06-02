# AI's Hidden Cost: What Large Language Models Are Doing to the Power Grid

**Tools:** SQL · Tableau · MS Visio · ServiceNow

## Overview

U.S. data centers consumed **183 TWh of electricity in 2024** — over 4% of total national supply — and that figure is projected to reach **426 TWh by 2030**, a 133% increase driven almost entirely by AI workload growth. This project quantifies the energy and grid-infrastructure burden of AI at scale, mapping data center power draw against regional grid capacity, state-level concentration, utility rate structures, and carbon intensity through 2026.

## Key Questions

- Which U.S. regions face the most acute grid stress from data center concentration?
- How does AI energy demand vary by region — and what are the carbon implications of geography?
- What is the true per-query cost of running LLM workloads when energy and cooling are included?
- How does the 2024–2026 demand trajectory compare to EIA projections?

## Data Sources

| Dataset | Source | Last Updated |
|---|---|---|
| `datacenter_energy_by_region_2024_2026.csv` | [EIA Annual Energy Outlook 2026](https://www.eia.gov/outlooks/aeo/) · [Pew Research Center Oct 2025](https://www.pewresearch.org/short-reads/2025/10/24/what-we-know-about-energy-use-at-us-data-centers-amid-the-ai-boom/) · [IEA Energy and AI 2025](https://www.iea.org/reports/energy-and-ai/energy-demand-from-ai) | April 2026 |

### Schema: `datacenter_energy_by_region_2024_2026.csv`
`Region` · `State_Country` · `Year` · `Quarter` · `DC_Count` · `DC_Demand_TWh_Annualized` · `Total_Grid_Capacity_TWh` · `DC_Share_Of_Grid_Pct` · `Renewable_Share_Pct` · `Natural_Gas_Share_Pct` · `Nuclear_Share_Pct` · `Coal_Share_Pct` · `Carbon_Intensity_gCO2_kWh` · `Avg_Rate_USD_kWh` · `Grid_Stress_Level` · `Source`

## Methodology

```
EIA AEO 2026 + Pew Research 2025 + IEA Energy and AI 2025
    │
    ▼
SQL (aggregate demand by region/quarter; calculate DC share of grid; flag stress levels)
    │
    ▼
MS Visio (infrastructure diagram: AI query → GPU cluster → substation → grid)
    │
    ▼
Tableau (dashboard: DC demand by region, grid stress over time, carbon intensity map)
    │
    ▼
ServiceNow CMDB template (AI infrastructure asset tracking with energy SLA fields)
```

## Key Findings (2024–2026 Data)

### National Picture
- **U.S. data centers: 183 TWh** consumed in 2024 — over 4% of total U.S. electricity (EIA / Pew Research)
- **Projected: 426 TWh by 2030** — a 133% increase in 6 years (EIA AEO 2026)
- **4,000+ data centers** operating nationally as of 2024

### Regional Concentration & Grid Stress
| State | Data Centers | Share of State Grid | Stress Level (2026 Q1) |
|---|---|---|---|
| Virginia | 668 | **35.7%** | 🔴 CRITICAL |
| Nebraska | 58 | 19.8% | 🟠 HIGH |
| Oregon | 114 | 12.8% | 🟡 MODERATE |
| North Dakota | 26 | 10.0% | 🟡 MODERATE |
| Texas | 453 | 6.9% | 🟠 HIGH |
| California | 345 | 6.5% | 🟠 HIGH |

### Carbon Inequality by Region
- **Worst:** North Dakota — 610 gCO₂/kWh (2026 Q1), 49% coal dependency
- **Best:** Oregon — 70 gCO₂/kWh (2026 Q1), 79% renewable
- **Implication:** Moving AI workloads from Virginia to Oregon reduces per-query carbon footprint by **~80%** with no performance tradeoff

### Per-Query Energy Cost
| Model Tier | kWh per Query | True Cost (energy + cooling) | CO₂ per 1M Queries (Virginia grid) |
|---|---|---|---|
| Small (GPT-3.5 class) | 0.0003 | $0.000042 | 101 kg |
| Medium (GPT-4 class) | 0.003 | $0.00042 | 1,008 kg |
| Large (GPT-4o class) | 0.010 | $0.00140 | 3,360 kg |

### Energy Mix (U.S. Data Centers, 2024)
- Natural gas: **43%** · Renewables: **25%** · Nuclear: **20%** · Coal: **11%**
- Electricity costs rising: average U.S. household bill up **25% since 2014**, with data center-heavy grid regions seeing $16–$18/month increases (Pew Research 2025)

### Global Context (IEA)
- Global data center electricity: **415 TWh in 2024** (~1.5% of global supply)
- IEA base case: **~945 TWh by 2030** (3% of global supply)
- U.S. projected share of global growth: **+240 TWh**, a 130% increase

## Files

| File | Description |
|---|---|
| `data/datacenter_energy_by_region_2024_2026.csv` | Quarterly DC demand, grid share, carbon intensity by US region (2024–2026) |
| `sql/energy_cost_model.sql` | Per-query cost model: compute + cooling + hardware depreciation |
| `sql/grid_stress_analysis.sql` | Regional capacity utilization and stress event aggregation |
| `visio/datacenter_grid_diagram.pdf` | Infrastructure diagram: AI query → data center → regional grid |
| `servicenow/cmdb_ai_infra_template.xlsx` | CMDB schema for AI infrastructure asset tracking with energy SLA fields |

---

**Sources:**
- [EIA Annual Energy Outlook 2026](https://www.eia.gov/outlooks/aeo/)
- [Pew Research Center: US Data Center Energy Use, Oct 2025](https://www.pewresearch.org/short-reads/2025/10/24/what-we-know-about-energy-use-at-us-data-centers-amid-the-ai-boom/)
- [IEA: Energy and AI — Energy Demand from AI, 2025](https://www.iea.org/reports/energy-and-ai/energy-demand-from-ai)
- [Congress.gov CRS: Data Centers and Their Energy Consumption](https://www.congress.gov/crs-product/R48646)
- [Our World in Data: Data Center Electricity Share](https://ourworldindata.org/grapher/data-centers-share-electricity-demand)

*Analysis by Neha Sinha · [GitHub](https://github.com/nehasinha1)*
