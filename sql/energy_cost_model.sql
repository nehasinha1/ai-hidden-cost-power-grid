-- ============================================================
-- AI Inference: True Per-Query Cost Model
-- ============================================================

-- 1. Base energy consumption by model tier
CREATE TABLE model_energy_profile AS
SELECT * FROM (VALUES
    ('small',  'GPT-3.5 class',  0.0003, 0.0001, 0.00005),
    ('medium', 'GPT-4 class',    0.0030, 0.0010, 0.00050),
    ('large',  'GPT-4o / Opus',  0.0100, 0.0030, 0.00150)
) AS t(tier, example_model, kwh_per_query_compute, kwh_per_query_cooling, kwh_per_query_network);

-- 2. Regional electricity rates and carbon intensity ($/kWh, gCO2/kWh)
CREATE TABLE regional_grid AS
SELECT * FROM (VALUES
    ('US-NE',  'Northeast US',     0.18, 210),
    ('US-SE',  'Southeast US',     0.11, 480),
    ('US-MW',  'Midwest US',       0.10, 560),
    ('US-SW',  'Southwest US',     0.10, 320),
    ('US-NW',  'Northwest US',     0.08,  85),
    ('US-VA',  'Virginia (NOVA)',  0.07, 390)
) AS t(region_code, region_name, usd_per_kwh, gco2_per_kwh);

-- 3. Hardware depreciation cost per query (amortized over 3yr server lifecycle)
-- Assumes: $30K/GPU, 8 GPUs/server, 50M queries/server/year
CREATE TABLE hardware_depreciation AS
SELECT
    tier,
    CASE tier
        WHEN 'small'  THEN 0.000048
        WHEN 'medium' THEN 0.000240
        WHEN 'large'  THEN 0.000960
    END AS usd_per_query_hardware
FROM model_energy_profile;

-- 4. Full per-query cost model
SELECT
    m.tier,
    m.example_model,
    r.region_name,
    -- Energy cost
    (m.kwh_per_query_compute + m.kwh_per_query_cooling + m.kwh_per_query_network)
        * r.usd_per_kwh                              AS usd_per_query_energy,
    -- Hardware depreciation
    h.usd_per_query_hardware,
    -- Total true cost
    (m.kwh_per_query_compute + m.kwh_per_query_cooling + m.kwh_per_query_network)
        * r.usd_per_kwh + h.usd_per_query_hardware   AS usd_per_query_total,
    -- Carbon footprint
    (m.kwh_per_query_compute + m.kwh_per_query_cooling)
        * r.gco2_per_kwh                             AS gco2_per_query,
    -- At 1B queries/day scale: annual energy cost
    (m.kwh_per_query_compute + m.kwh_per_query_cooling + m.kwh_per_query_network)
        * r.usd_per_kwh * 1000000000 * 365           AS annual_energy_cost_1b_daily
FROM model_energy_profile m
JOIN regional_grid r ON TRUE
JOIN hardware_depreciation h ON h.tier = m.tier
ORDER BY m.tier, r.usd_per_kwh DESC;
