-- =====================================================================
-- Solar Energy Data Analysis  |  02_load_data.sql
-- Loads data/solar_energy_worldwide.csv into the solar_energy table.
--
-- Option A (LOAD DATA INFILE) is fastest but requires the file to live in
-- MySQL's secure_file_priv directory and local_infile enabled.
-- Option B (MySQL Workbench Table Data Import Wizard) needs no SQL: right-click
-- the table -> "Table Data Import Wizard" -> pick the CSV.
-- =====================================================================

USE solar_energy;

-- ---------------------------------------------------------------------
-- Option A: bulk load from CSV.
-- 1) Find your allowed folder:   SHOW VARIABLES LIKE 'secure_file_priv';
-- 2) Copy solar_energy_worldwide.csv there, or use LOCAL (client-side).
-- 3) Adjust the path below (use forward slashes, even on Windows).
-- ---------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'data/solar_energy_worldwide.csv'
INTO TABLE solar_energy
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'      -- use '\r\n' if the file has Windows line endings
IGNORE 1 LINES
(city, country, latitude, longitude, annual_sunlight_hours, daily_peak_sun_hours,
 ghi_kwh_per_m2, electricity_price_usd_per_kwh, solar_installations_count,
 avg_system_cost_usd, avg_annual_production_kwh, estimated_annual_savings_usd,
 payback_period_years, roi_percentage, co2_reduction_tons_per_year,
 solar_viability_score, region);

-- Sanity checks -------------------------------------------------------
SELECT COUNT(*)               AS rows_loaded   FROM solar_energy;  -- expect 48
SELECT COUNT(DISTINCT country) AS countries     FROM solar_energy; -- expect 30
SELECT COUNT(DISTINCT region)  AS regions       FROM solar_energy; -- expect 7
