-- ============================================================
-- PROYECTO: Manufacturing Operations Analysis
-- ARCHIVO: 03_create_analysis_table.sql
-- DESCRIPCIÓN: Creación de tabla para análisis
-- ============================================================


-- ============================================================
-- 1. SELECCIONAR LA BASE DE DATOS
-- ============================================================

USE ManufacturingAnalysis;
GO


-- ============================================================
-- 2. CREAR TABLA DE ANÁLISIS
-- ============================================================

SELECT
    Job_ID,
    Machine_ID,
    Operation_Type,
    Material_Used,
    Processing_Time,
    Energy_Consumption,
    Machine_Availability,
    Scheduled_Start,
    Scheduled_End,
    Actual_Start,
    Actual_End,
    Job_Status,
    Optimization_Category
INTO Manufacturing_Production_Analysis
FROM Manufacturing_Production;
GO


-- ============================================================
-- 3. VALIDAR LA CANTIDAD DE REGISTROS
-- ============================================================

SELECT COUNT(*) AS Total_Registros
FROM Manufacturing_Production_Analysis;
GO


-- ============================================================
-- 4. VALIDAR LOS DATOS
-- ============================================================

SELECT TOP 10 *
FROM Manufacturing_Production_Analysis;
GO