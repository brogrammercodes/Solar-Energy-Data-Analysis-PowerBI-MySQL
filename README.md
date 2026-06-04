# Solar Energy Data Analysis and Reporting with Power BI & MySQL

An intermediate data-analytics project that explores worldwide solar-energy
viability — combining a curated dataset, **MySQL** for data storage/querying, and
**Power BI** for interactive reporting and visualization.

> **Project status: 🚧 In progress (source materials only).**
> This repository currently contains the dataset and project brief/design assets.
> The MySQL scripts and the Power BI report (`.pbix`) are **not yet built** — see
> [Roadmap](#roadmap) below.

---

## 📌 Overview

The goal of the project is to analyze how suitable different cities around the
world are for solar-power adoption, and to surface the economic and environmental
factors that drive that suitability. The workflow is:

1. **Ingest** the `solar_energy_worldwide` dataset into a MySQL database.
2. **Query & transform** the data with SQL (aggregations by region, ROI ranking,
   payback analysis, etc.).
3. **Visualize** the results in a Power BI dashboard following the supplied
   colour palette and page layouts.

## 📂 Repository Contents

| File | Description |
|------|-------------|
| `solar_energy_worldwide.zip` | The dataset (`solar_energy_worldwide.csv`, 47 cities). |
| `Column Definitions (1).xlsx` | Data dictionary describing every column. |
| `Colour Code (1).xlsx` | Brand colour palette for the Power BI report. |
| `Solar Dataset.pdf` | Project brief / dataset documentation. |
| `Page 1 (1).png`, `Page 2 (1).png`, `Page 3 (1).png` | Report page design mockups. |

## 📊 Dataset

The dataset covers **47 cities** across multiple continents with the following fields:

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

- **MySQL** — data storage and SQL-based analysis.
- **Power BI** — interactive dashboards and reporting.
- **Excel** — data dictionary and design reference.

## 🚀 Getting Started

1. Unzip `solar_energy_worldwide.zip` to obtain `solar_energy_worldwide.csv`.
2. Create a MySQL database and load the CSV (e.g. via `LOAD DATA INFILE` or the
   MySQL Workbench import wizard).
3. Open Power BI Desktop, connect to the MySQL database, and build the report
   using the layouts in the `Page *.png` mockups and the `Colour Code` palette.

## 🗺️ Roadmap

- [ ] MySQL schema (`CREATE TABLE`) and data-load scripts.
- [ ] SQL analysis queries (regional aggregates, ROI/payback rankings, viability).
- [ ] Power BI report (`.pbix`) matching the design mockups.
- [ ] Key insights / findings write-up.

## 📄 License

Released under the [MIT License](LICENSE).
