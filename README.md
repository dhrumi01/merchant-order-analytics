# Merchant Order Analytics Pipeline

End-to-end data engineering project: Python → Snowflake → dbt → Power BI

---

## Project Overview

Built a complete analytics pipeline ingesting 50,000+ simulated merchant order records, transforming them with dbt, analyzing SLA performance with complex SQL, and delivering self-serve BI dashboards.

**Key Results:**
- 50,000+ order records ingested into Snowflake via staged CSV loads
- dbt transformation models with 6/6 data quality tests passing
- SLA anomaly detection identifying underperforming merchants
- 7-day rolling KPI monitoring for real-time operational reporting
- Tablet replacement ROI analysis reducing simulated SLA breach rate by 23%

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Python (pandas, scikit-learn) | Data generation, ML forecasting, ROI analysis |
| Snowflake | Cloud data warehouse |
| dbt | Data transformation and testing |
| SQL (CTEs, window functions) | SLA anomaly detection, rolling KPIs |
| Power BI | Self-serve BI dashboards |
| Google Colab | Notebook environment |
| GitHub | Version control |

---

## Project Structure
```
merchant-order-analytics/
├── models/
│   ├── staging/
│   │   ├── stg_orders.sql        # Cleans raw order data
│   │   ├── stg_merchants.sql     # Cleans merchant master data
│   │   └── sources.yml           # Source definitions + tests
│   └── marts/
│       └── fct_orders.sql        # Final fact table with KPI flags
├── dbt_project.yml               # dbt project config
└── README.md
```

---

## Pipeline Architecture
```
Google Colab     →     Snowflake     →     dbt          →     Power BI
─────────────          ─────────────       ────────           ────────
Generate 50k           ORDERS_RAW          stg_orders         KPI Dashboard
orders.csv             MERCHANT_MASTER     stg_merchants      SLA Alerts
                                           fct_orders         Trend Charts
```

---

## Key SQL Features

### SLA Anomaly Detection
- CTEs to calculate per-merchant breach rates
- Benchmarked against category averages
- RANK() window function to rank merchants within category
- Flags: ANOMALY / WARNING / NORMAL

### 7-Day Rolling KPI Monitoring
- SUM() OVER (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
- Daily order volume, revenue, breach rate
- Real-time operational alerting baseline

### Order Volume Forecasting
- LAG() for month-over-month growth
- 3-month moving average with AVG() OVER window
- YTD cumulative totals with UNBOUNDED PRECEDING

---

## ROI Analysis Results

| Metric | Value |
|--------|-------|
| Current SLA breach rate | 43.5% |
| Post-replacement breach rate | 33.2% |
| Breach reduction | 23.6% |
| Annual savings | $18,783 |
| Replacement cost | $17,500 |
| Net ROI (Year 1) | $1,283 |
| Payback period | 11.2 months |

---

## How to Run

1. Clone this repo
2. Install dbt: `pip install dbt-snowflake`
3. Configure your Snowflake credentials in `~/.dbt/profiles.yml`
4. Run `dbt run` to build all models
5. Run `dbt test` to validate data quality

---

## Author

**Dhrumi** · [github.com/dhrumi01](https://github.com/dhrumi01)
