# Power BI Report Build Guide

This guide reproduces the 3-page report shown in the design mockups
(`Page 1 (1).png`, `Page 2 (1).png`, `Page 3 (1).png`) from the
`solar_energy` data. A `.pbix` is a binary file that must be assembled in
**Power BI Desktop**; everything needed to build it is specified here.

## 1. Connect the data

You can use either source — both produce the same model:

- **MySQL (recommended):** Home → Get Data → *MySQL database* → server
  `localhost`, database `solar_energy`, table `solar_energy`. (Run the
  `/sql` scripts first to create and load the table.)
- **CSV:** Home → Get Data → *Text/CSV* → `data/solar_energy_worldwide.csv`.

In Power Query, confirm column types: text for `city`/`country`/`region`,
decimal for lat/long/GHI/ROI/payback, whole number for counts and score.

## 2. Add measures & the tier column

- Paste the measures from [`dax_measures.dax`](dax_measures.dax) (New Measure).
- Add the **`Viability Tier`** calculated column (commented block in the same
  file) — it drives the donut chart and tier slicer.

## 3. Theme / colour palette

Brand colour from `Colour Code (1).xlsx` is **`#6D71BE`**. Combined with the
solar-themed mockups (gold sun + navy panels), use this palette:

| Role            | Hex       |
|-----------------|-----------|
| Primary / brand | `#6D71BE` |
| Accent (sun)    | `#F4A300` |
| Deep panel navy | `#1F3A93` |
| Neutral text    | `#2B2B2B` |
| Light canvas    | `#F5F6FA` |
| Muted / weak    | `#9AA0A6` |

Save these as a custom theme: View → Themes → *Customize current theme*.

## 4. Pages & visuals

### Page 1 — Executive Overview (maps to `Page 1 (1).png`)
- **KPI card row:** `Total Cities`, `Total Countries`, `Total Installations`,
  `Avg Viability Score`, `Avg ROI %`, `Avg Payback (Years)`,
  `Total CO2 Avoided (Tons)`.
- **Filled / bubble Map:** Latitude, Longitude, bubble size = viability score,
  colour = `region`. (Query Q7.)
- **Bar chart:** Avg viability by `region`, sorted descending. (Query Q2.)
- **Slicers:** `region`, `Viability Tier`.

### Page 2 — City Rankings & Economics (maps to `Page 2 (1).png`)
- **Table — Top 10 cities:** city, country, viability, ROI %, payback.
  Conditional-format the viability column with `Viability Colour`. (Query Q4.)
- **Bar chart — Fastest payback:** city vs `payback_period_years`, ascending,
  top 10. (Query Q6.)
- **Donut — Viability tiers:** count of cities by `Viability Tier`. (Query Q9.)
- **Country leaderboard** card/table: top 10 countries. (Query Q3.)

### Page 3 — Drivers & Environmental Impact (maps to `Page 3 (1).png`)
- **Scatter:** X = `ghi_kwh_per_m2`, Y = `solar_viability_score`, legend =
  `region`, tooltip = city. Shows the ~0.996 correlation. (Query Q7/Q8.)
- **Scatter:** X = `ghi_kwh_per_m2`, Y = `payback_period_years` (negative trend).
- **Stacked bar / treemap:** CO₂ avoided by `region`. (Query Q10.)
- **Insight text box:** summarise findings from [`../docs/INSIGHTS.md`](../docs/INSIGHTS.md).

## 5. Export / publish

- Save as `powerbi/Solar_Energy_Report.pbix`.
- (Optional) Publish to the Power BI Service and export a PDF snapshot into
  `docs/` for reviewers who don't have Power BI Desktop.
