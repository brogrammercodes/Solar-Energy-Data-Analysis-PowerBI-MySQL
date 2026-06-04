# Solar Energy — Key Insights

Findings from analysing the `solar_energy_worldwide` dataset
(**48 cities · 30 countries · 7 regions**). All figures are produced by the
queries in [`../sql/03_analysis_queries.sql`](../sql/03_analysis_queries.sql).

## Headline numbers

| Metric | Value |
|--------|-------|
| Cities / Countries / Regions | 48 / 30 / 7 |
| Total solar installations | ~2,328,540 |
| Average viability score | 54.6 (range 36 – 73) |
| Average ROI | ~11.2 % |
| Average payback period | ~9.8 years (range 5.8 – 15.3) |
| Total CO₂ avoided | ~208 tons/year (per representative system set) |

## 1. Sunlight is the dominant driver
GHI (Global Horizontal Irradiance) and the viability score are almost perfectly
correlated (**r ≈ 0.996**), and GHI vs payback period is strongly negative
(**r ≈ −0.972**). In this dataset, irradiance essentially *determines* both how
viable a location is and how fast a system pays for itself — economics follow the
sun. GHI ranges from 2.8 (cloudy northern Europe) to 6.5 kWh/m²/day (desert belt).

## 2. Sun-belt cities lead, northern Europe lags
- **Best:** Phoenix (73), Dubai (70), Cairo (68), Los Angeles & Tel Aviv (67).
  Payback 5.8 – 6.9 years, ROI 14.5 – 17.2 %.
- **Worst:** Manchester (36), London (37), Brussels (38), Amsterdam (39),
  Oslo (39). Payback stretches to 13.5 – 15.3 years.

## 3. Regional ranking
Sorted by average viability score:

| Region | Cities | Avg viability | Avg ROI % |
|--------|:--:|:--:|:--:|
| Middle East | 1 | 67.0 | 14.5 |
| Africa | 3 | 66.3 | 14.3 |
| Oceania | 3 | 60.0 | 12.2 |
| North America | 8 | 58.1 | 12.0 |
| Asia | 12 | 57.2 | 11.4 |
| South America | 5 | 56.0 | 10.5 |
| Europe | 16 | 46.1 | 8.8 |

Europe is the most-represented region (16 cities) yet scores lowest on average —
its northern, higher-latitude cities pull the mean down.

## 4. Viability tiers
Bucketing cities by score: **A – Excellent (65+): 7 · B – Strong (55–64): 20 ·
C – Moderate (45–54): 11 · D – Weak (<45): 10.** A clear majority (27 of 48)
land in the strong-to-excellent band.

## 5. Data caveat
`Electricity_Price_USD_per_kWh` is a constant **0.15** for every city, so price is
held fixed in this dataset — ROI and payback variation comes from irradiance and
production, not from local tariffs. A real-world extension would replace this with
actual retail tariffs, which would meaningfully reshuffle the economics
(e.g. high-tariff, lower-sun European cities could climb the rankings).

## Recommended actions
1. **Prioritise** sun-belt deployments (Middle East, Africa, US Sun Belt, Oceania)
   for the fastest payback and highest ROI.
2. For **northern-Europe** markets, viability depends on incentives/tariffs not in
   this dataset — model those before ruling them out.
3. Use the **viability score** as the primary site-selection KPI; it cleanly
   summarises the irradiance-driven economics (r ≈ 0.996 with GHI).
