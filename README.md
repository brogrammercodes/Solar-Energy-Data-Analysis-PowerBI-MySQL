# Solar Energy Data Analysis and Reporting with Power BI & MySQL

An intermediate data-analytics project that explores worldwide solar-energy
viability — combining a curated dataset, **MySQL** for data storage/querying, and
**Power BI** for interactive reporting and visualization.

> **Project status: ✅ Complete.** The dataset is loaded via MySQL scripts,
> analysed with SQL, documented as written-up insights, and specified as a
> ready-to-build Power BI report (DAX measures + page-by-page guide).

---

## 📌 Overview

The goal is to analyze how suitable different cities around the world are for
solar-power adoption and to surface the economic and environmental factors that
drive that suitability. The workflow:

1. **Ingest** the `solar_energy_worldwide` dataset into a MySQL database.
2. **Query & transform** the data with SQL — regional aggregates, ROI/payback
   rankings, correlation, and segmentation.
3. **Visualize** the results in a Power BI dashboard following the supplied
   colour palette and page layouts.
4. **Report** the findings (see [`docs/INSIGHTS.md`](docs/INSIGHTS.md)).

## 📂 Project Structure

```
.
├── data/
│   └── solar_energy_worldwide.csv     # dataset (48 cities) — extracted, analysis-ready
├── sql/
│   ├── 01_schema.sql                  # database + table definition
│   ├── 02_load_data.sql               # CSV load + sanity checks
│   └── 03_analysis_queries.sql        # 10 analytical queries (KPIs, rankings, drivers)
├── powerbi/
│   ├── dax_measures.dax               # KPI measures, tier column, colour helper
│   └── REPORT_GUIDE.md                # page-by-page build guide for the .pbix
├── docs/
│   └── INSIGHTS.md                    # findings & recommendations
├── Solar Dataset.pdf                  # original project brief
├── Column Definitions (1).xlsx        # data dictionary (source)
├── Colour Code (1).xlsx               # brand colour (#6D71BE)
├── Page 1/2/3 (1).png                 # report design mockups
└── solar_energy_worldwide.zip         # original dataset archive
```

## 📊 Dataset

**48 cities · 30 countries · 7 regions**, with these fields:

| Column | Description |
|--------|-------------|
| `City` | Name of the city where the solar data is measured or estimated. |
| `Country` | Country in which the city is located. |
| `Latitude` | Geographic latitude of the city in decimal degrees. |
| `Longitude` | Geographic longitude of the city in decimal degrees. |
| `Annual_Sunlight_Hours` | Total number of hours per year the city receives usable sunlight. |
| `Daily_Peak_Sun_Hours` | Average peak sun hours per day (irradiance ~1,000 W/m²). |
| `GHI_kWh_per_m2` | Global Horizontal Irradiance — average annual solar energy per m² (kWh/m²/year). |
| `Electricity_Price_USD_per_kWh` | Average local retail electricity price (USD/kWh). |
| `Solar_Installations_Count` | Number of installed solar PV systems in the city/region. |
| `Avg_System_Cost_USD` | Average upfront cost of installing a solar PV system (USD). |
| `Avg_Annual_Production_kWh` | Average annual electricity generation of a solar system (kWh/year). |
| `Estimated_Annual_Savings_USD` | Estimated yearly savings on electricity bills from solar (USD). |
| `Payback_Period_Years` | Years required for savings to recover the initial system cost. |
| `ROI_Percentage` | Return on investment from the solar system (%). |
| `CO2_Reduction_Tons_per_Year` | Estimated annual CO₂ emission reduction (metric tons). |
| `Solar_Viability_Score` | Composite suitability score for solar power (higher = better). |
| `Region` | Geographic/continental classification (e.g., Europe, Asia, North America). |

## 🛠️ Tech Stack

- **MySQL 8.x** — data storage and SQL-based analysis.
- **Power BI Desktop** — interactive dashboards and reporting.
- **Excel** — data dictionary and design reference.

## 🚀 Getting Started

### 1. Build the database
```sql
SOURCE sql/01_schema.sql;       -- creates `solar_energy` DB + table
SOURCE sql/02_load_data.sql;    -- loads data/solar_energy_worldwide.csv
```
> If `LOAD DATA` is blocked by `secure_file_priv`/`local_infile`, use the MySQL
> Workbench **Table Data Import Wizard** instead (see notes in the script).

### 2. Run the analysis
```sql
SOURCE sql/03_analysis_queries.sql;   -- KPIs, regional & city rankings, drivers
```

### 3. Build the report
Follow [`powerbi/REPORT_GUIDE.md`](powerbi/REPORT_GUIDE.md): connect Power BI to
the MySQL database (or the CSV), paste the measures from
[`powerbi/dax_measures.dax`](powerbi/dax_measures.dax), apply the colour theme,
and build the three pages that mirror the `Page *.png` mockups.

## 🔑 Key Insights (full write-up in [`docs/INSIGHTS.md`](docs/INSIGHTS.md))

- **Sunlight dominates:** GHI correlates almost perfectly with the viability
  score (**r ≈ 0.996**) and strongly negatively with payback (**r ≈ −0.972**).
- **Leaders:** Phoenix (73), Dubai (70), Cairo (68) — payback under 7 years.
- **Laggards:** Manchester (36), London (37) — payback 14–15 years.
- **By region:** Middle East & Africa lead (avg viability 66–67); Europe trails
  (46) despite having the most cities.
- **Caveat:** electricity price is a constant 0.15 USD/kWh, so economics here are
  irradiance-driven; real tariffs would reshuffle the rankings.

## 📄 License

Released under the [MIT License](LICENSE).
