-- =====================================================================
-- Solar Energy Data Analysis  |  03_analysis_queries.sql
-- Business questions answered with SQL. These power the Power BI report
-- (each query maps to a visual described in powerbi/REPORT_GUIDE.md).
-- =====================================================================

USE solar_energy;

-- ---------------------------------------------------------------------
-- KPI CARDS (report header)
-- ---------------------------------------------------------------------
-- Q1. Headline KPIs across the whole dataset.
SELECT
    COUNT(*)                                   AS cities,
    COUNT(DISTINCT country)                     AS countries,
    SUM(solar_installations_count)             AS total_installations,
    ROUND(AVG(solar_viability_score), 1)       AS avg_viability_score,
    ROUND(AVG(roi_percentage), 1)              AS avg_roi_pct,
    ROUND(AVG(payback_period_years), 1)        AS avg_payback_years,
    ROUND(SUM(co2_reduction_tons_per_year), 1) AS total_co2_reduction_tons
FROM solar_energy;

-- ---------------------------------------------------------------------
-- REGIONAL ANALYSIS (bar / map visuals)
-- ---------------------------------------------------------------------
-- Q2. Performance by region, ranked by average viability.
SELECT
    region,
    COUNT(*)                              AS cities,
    ROUND(AVG(solar_viability_score), 1)  AS avg_viability,
    ROUND(AVG(roi_percentage), 1)         AS avg_roi_pct,
    ROUND(AVG(payback_period_years), 1)   AS avg_payback_years,
    ROUND(AVG(ghi_kwh_per_m2), 2)         AS avg_ghi,
    SUM(solar_installations_count)        AS total_installations
FROM solar_energy
GROUP BY region
ORDER BY avg_viability DESC;

-- Q3. Country leaderboard (top 10 by average viability score).
SELECT
    country,
    COUNT(*)                              AS cities,
    ROUND(AVG(solar_viability_score), 1)  AS avg_viability,
    ROUND(AVG(roi_percentage), 1)         AS avg_roi_pct
FROM solar_energy
GROUP BY country
ORDER BY avg_viability DESC, avg_roi_pct DESC
LIMIT 10;

-- ---------------------------------------------------------------------
-- CITY-LEVEL RANKINGS (tables)
-- ---------------------------------------------------------------------
-- Q4. Top 10 cities for solar investment.
SELECT city, country, region,
       solar_viability_score, roi_percentage, payback_period_years,
       ghi_kwh_per_m2
FROM solar_energy
ORDER BY solar_viability_score DESC, roi_percentage DESC
LIMIT 10;

-- Q5. Bottom 10 cities (least viable today).
SELECT city, country, region,
       solar_viability_score, roi_percentage, payback_period_years
FROM solar_energy
ORDER BY solar_viability_score ASC, roi_percentage ASC
LIMIT 10;

-- Q6. Fastest payback cities (best short-term economics).
SELECT city, country, payback_period_years, roi_percentage, electricity_price_usd_per_kwh
FROM solar_energy
ORDER BY payback_period_years ASC
LIMIT 10;

-- ---------------------------------------------------------------------
-- DRIVER / RELATIONSHIP ANALYSIS (scatter visuals)
-- ---------------------------------------------------------------------
-- Q7. Does more sunlight (GHI) translate to higher ROI? (scatter source)
SELECT city, region, ghi_kwh_per_m2, daily_peak_sun_hours,
       roi_percentage, solar_viability_score
FROM solar_energy
ORDER BY ghi_kwh_per_m2 DESC;

-- Q8. Pearson-style correlation between GHI and viability score.
SELECT
    ROUND(
        (COUNT(*) * SUM(ghi_kwh_per_m2 * solar_viability_score)
            - SUM(ghi_kwh_per_m2) * SUM(solar_viability_score))
        / SQRT(
            (COUNT(*) * SUM(POW(ghi_kwh_per_m2, 2)) - POW(SUM(ghi_kwh_per_m2), 2)) *
            (COUNT(*) * SUM(POW(solar_viability_score, 2)) - POW(SUM(solar_viability_score), 2))
          ), 3) AS corr_ghi_vs_viability
FROM solar_energy;

-- ---------------------------------------------------------------------
-- SEGMENTATION (donut / matrix visuals)
-- ---------------------------------------------------------------------
-- Q9. Bucket cities into viability tiers.
SELECT
    CASE
        WHEN solar_viability_score >= 65 THEN 'A - Excellent (65+)'
        WHEN solar_viability_score >= 55 THEN 'B - Strong (55-64)'
        WHEN solar_viability_score >= 45 THEN 'C - Moderate (45-54)'
        ELSE 'D - Weak (<45)'
    END AS viability_tier,
    COUNT(*)                             AS cities,
    ROUND(AVG(roi_percentage), 1)        AS avg_roi_pct,
    ROUND(AVG(payback_period_years), 1)  AS avg_payback_years
FROM solar_energy
GROUP BY viability_tier
ORDER BY viability_tier;

-- Q10. Environmental impact by region (CO2 avoided).
SELECT region,
       ROUND(SUM(co2_reduction_tons_per_year), 1) AS total_co2_tons,
       ROUND(AVG(co2_reduction_tons_per_year), 2) AS avg_co2_tons_per_city
FROM solar_energy
GROUP BY region
ORDER BY total_co2_tons DESC;
