# AI's Hidden Cost: What Large Language Models Are Doing to the Power Grid

**Tools:** SQL · Power BI · MS Visio · ServiceNow

## Overview

Training and serving large AI models consumes enormous amounts of electricity — but the full infrastructure cost is rarely surfaced in public discourse. This project quantifies the energy and grid-infrastructure burden of AI at scale, mapping data center power draw against regional grid capacity, utility rate structures, and projected demand through 2030.

## Key Questions

- How much electricity does AI inference (not just training) consume at enterprise scale?
- Which regions are most exposed to grid stress from data center concentration?
- What is the true per-query cost of running LLM workloads when energy, cooling, and hardware depreciation are included?
- How does AI energy demand compare to other large industrial consumers?

## Data Sources

- U.S. Energy Information Administration (EIA): regional electricity generation and capacity data
- Lawrence Berkeley National Lab: US Data Center Energy Usage Report
- IEA: Electricity 2024 report (AI and data center demand projections)
- Public utility filings (FERC, state PUCs): data center power purchase agreements
- EPA eGRID: carbon intensity by grid region
- ServiceNow CMDB export schema (anonymized): used to model infrastructure asset tracking

## Methodology

```
EIA + IEA + LBL raw data
    │
    ▼
SQL (aggregate by region, model type, compute class; calculate per-query cost)
    │
    ▼
MS Visio (infrastructure diagram: data center → grid → regional capacity)
    │
    ▼
Power BI (dashboard: energy demand by region, projected grid stress, cost breakdowns)
    │
    ▼
ServiceNow (CMDB template for tracking AI infrastructure assets and energy SLAs)
```

## Findings Summary

- A single GPT-4-class query consumes approximately **0.001–0.01 kWh** — 10–100x a standard Google search
- At scale (1B daily queries), this represents **~3–30 TWh/year** — comparable to small country electricity consumption
- **Virginia (Northern VA)** hosts ~70% of US data center capacity; local grid stress events increased 40% between 2021 and 2024
- The fully-loaded cost of enterprise LLM inference (energy + cooling + hardware depreciation) is **3–5x** the API price alone
- AI data center demand is projected to consume **9% of US electricity by 2030** (up from ~2% in 2022)
- Carbon intensity varies 4x by region — moving workloads from coal-heavy grids to hydro/nuclear regions can cut AI's carbon footprint by 75%

## Files

| File | Description |
|---|---|
| `data/datacenter_energy_by_region.csv` | Energy consumption estimates by US region and compute type |
| `data/grid_capacity_utilization.csv` | Regional grid capacity vs. data center demand (2020–2024) |
| `sql/energy_cost_model.sql` | Per-query cost calculation including energy, cooling, hardware |
| `sql/grid_stress_analysis.sql` | Regional capacity utilization and stress event aggregation |
| `visio/datacenter_grid_diagram.pdf` | Infrastructure diagram: AI workload → data center → grid |
| `powerbi/ai_power_grid_dashboard.pbix` | Power BI dashboard file |
| `powerbi/dashboard_screenshot.png` | Dashboard preview |
| `servicenow/cmdb_ai_infra_template.xlsx` | CMDB schema for tracking AI infrastructure assets |

## Infrastructure Diagram (MS Visio)

The diagram maps the full chain from AI workload request to grid impact:

```
User Query → Load Balancer → GPU Cluster
                                  │
                    ┌─────────────┼─────────────┐
                    ▼             ▼              ▼
              Compute Power   Cooling Load   Network I/O
                    │             │
                    └──────┬──────┘
                           ▼
                   Data Center UPS / Substation
                           │
                           ▼
                  Regional Transmission Grid
                           │
                    ┌──────┴──────┐
                    ▼             ▼
             Fossil Generation  Renewables
```

---

*Analysis by Neha Sinha · [GitHub](https://github.com/nehasinha1)*
