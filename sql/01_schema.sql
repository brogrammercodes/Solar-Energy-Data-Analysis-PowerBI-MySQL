-- =====================================================================
-- Solar Energy Data Analysis  |  01_schema.sql
-- Creates the database and the solar_energy table that mirrors
-- solar_energy_worldwide.csv (48 cities, 30 countries, 7 regions).
-- Engine: MySQL 8.x
-- =====================================================================

CREATE DATABASE IF NOT EXISTS solar_energy
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE solar_energy;

DROP TABLE IF EXISTS solar_energy;

CREATE TABLE solar_energy (
    id                              INT AUTO_INCREMENT PRIMARY KEY,
    city                            VARCHAR(80)   NOT NULL,
    country                         VARCHAR(80)   NOT NULL,
    latitude                        DECIMAL(8,4)  NOT NULL,
    longitude                       DECIMAL(8,4)  NOT NULL,
    annual_sunlight_hours           INT           NOT NULL,   -- usable sunlight hours / year
    daily_peak_sun_hours            DECIMAL(5,2)  NOT NULL,   -- peak sun hours / day
    ghi_kwh_per_m2                  DECIMAL(6,2)  NOT NULL,   -- Global Horizontal Irradiance (kWh/m2/yr)
    electricity_price_usd_per_kwh   DECIMAL(6,3)  NOT NULL,   -- retail price USD/kWh
    solar_installations_count       INT           NOT NULL,   -- installed PV systems
    avg_system_cost_usd             DECIMAL(12,2) NOT NULL,   -- upfront install cost USD
    avg_annual_production_kwh       DECIMAL(12,2) NOT NULL,   -- generation kWh/yr
    estimated_annual_savings_usd    DECIMAL(12,2) NOT NULL,   -- bill savings USD/yr
    payback_period_years            DECIMAL(5,2)  NOT NULL,   -- years to recover cost
    roi_percentage                  DECIMAL(6,2)  NOT NULL,   -- return on investment %
    co2_reduction_tons_per_year     DECIMAL(8,2)  NOT NULL,   -- CO2 avoided metric tons/yr
    solar_viability_score           INT           NOT NULL,   -- composite suitability (higher = better)
    region                          VARCHAR(40)   NOT NULL    -- continental classification
);

-- Helpful indexes for the analytical queries / Power BI slicers.
CREATE INDEX idx_solar_region   ON solar_energy (region);
CREATE INDEX idx_solar_country  ON solar_energy (country);
CREATE INDEX idx_solar_viability ON solar_energy (solar_viability_score);
