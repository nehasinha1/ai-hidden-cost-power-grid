-- ============================================================
-- Regional Grid Stress Analysis: Data Center Demand vs. Capacity
-- ============================================================

-- 1. Data center power demand by region and year
CREATE TABLE dc_demand_gw AS
SELECT * FROM (VALUES
    ('US-VA', 2020, 5.2),  ('US-VA', 2021, 6.8),  ('US-VA', 2022, 9.1),
    ('US-VA', 2023, 12.4), ('US-VA', 2024, 16.0),
    ('US-NE', 2020, 2.1),  ('US-NE', 2021, 2.5),  ('US-NE', 2022, 3.0),
    ('US-NE', 2023, 3.8),  ('US-NE', 2024, 4.5),
    ('US-SW', 2020, 1.8),  ('US-SW', 2021, 2.2),  ('US-SW', 2022, 3.1),
    ('US-SW', 2023, 4.2),  ('US-SW', 2024, 5.8),
    ('US-MW', 2020, 1.5),  ('US-MW', 2021, 1.7),  ('US-MW', 2022, 2.0),
    ('US-MW', 2023, 2.6),  ('US-MW', 2024, 3.2)
) AS t(region_code, year, dc_demand_gw);

-- 2. Regional grid capacity (generation + import headroom in GW)
CREATE TABLE grid_capacity_gw AS
SELECT * FROM (VALUES
    ('US-VA', 42.0),
    ('US-NE', 38.0),
    ('US-SW', 55.0),
    ('US-MW', 95.0)
) AS t(region_code, total_capacity_gw);

-- 3. Utilization rate and stress flag
SELECT
    d.region_code,
    d.year,
    d.dc_demand_gw,
    c.total_capacity_gw,
    ROUND(d.dc_demand_gw / c.total_capacity_gw * 100, 1) AS dc_utilization_pct,
    CASE
        WHEN d.dc_demand_gw / c.total_capacity_gw > 0.30 THEN 'HIGH STRESS'
        WHEN d.dc_demand_gw / c.total_capacity_gw > 0.20 THEN 'MODERATE'
        ELSE 'NORMAL'
    END AS stress_level
FROM dc_demand_gw d
JOIN grid_capacity_gw c USING (region_code)
ORDER BY region_code, year;

-- 4. Year-over-year demand growth rate
SELECT
    region_code,
    year,
    dc_demand_gw,
    LAG(dc_demand_gw) OVER (PARTITION BY region_code ORDER BY year) AS prev_year_gw,
    ROUND(
        (dc_demand_gw - LAG(dc_demand_gw) OVER (PARTITION BY region_code ORDER BY year))
        / LAG(dc_demand_gw) OVER (PARTITION BY region_code ORDER BY year) * 100,
        1
    ) AS yoy_growth_pct
FROM dc_demand_gw
ORDER BY region_code, year;
