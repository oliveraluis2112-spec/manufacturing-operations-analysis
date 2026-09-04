-- ============================================================
-- PROYECTO: Manufacturing Operations Analysis
-- ARCHIVO: 02_data_cleaning.sql
-- DESCRIPCIÓN: Validación y limpieza de los datos
-- ============================================================

USE ManufacturingAnalysis;
GO


-- ============================================================
-- 1. REVISAR CANTIDAD DE REGISTROS
-- ============================================================

SELECT COUNT(*) AS Total_Registros
FROM Manufacturing_Production;
GO


-- ============================================================
-- 2. REVISAR ESTRUCTURA Y DATOS
-- ============================================================

SELECT TOP 20 *
FROM Manufacturing_Production;
GO


-- ============================================================
-- 3. REVISAR VALORES NULOS
-- ============================================================

SELECT
    SUM(CASE WHEN Job_ID IS NULL THEN 1 ELSE 0 END) AS Job_ID_Nulos,
    SUM(CASE WHEN Machine_ID IS NULL THEN 1 ELSE 0 END) AS Machine_ID_Nulos,
    SUM(CASE WHEN Operation_Type IS NULL THEN 1 ELSE 0 END) AS Operation_Type_Nulos,
    SUM(CASE WHEN Material_Used IS NULL THEN 1 ELSE 0 END) AS Material_Used_Nulos,
    SUM(CASE WHEN Processing_Time IS NULL THEN 1 ELSE 0 END) AS Processing_Time_Nulos,
    SUM(CASE WHEN Energy_Consumption IS NULL THEN 1 ELSE 0 END) AS Energy_Consumption_Nulos,
    SUM(CASE WHEN Machine_Availability IS NULL THEN 1 ELSE 0 END) AS Machine_Availability_Nulos,
    SUM(CASE WHEN Scheduled_Start IS NULL THEN 1 ELSE 0 END) AS Scheduled_Start_Nulos,
    SUM(CASE WHEN Scheduled_End IS NULL THEN 1 ELSE 0 END) AS Scheduled_End_Nulos,
    SUM(CASE WHEN Actual_Start IS NULL THEN 1 ELSE 0 END) AS Actual_Start_Nulos,
    SUM(CASE WHEN Actual_End IS NULL THEN 1 ELSE 0 END) AS Actual_End_Nulos,
    SUM(CASE WHEN Job_Status IS NULL THEN 1 ELSE 0 END) AS Job_Status_Nulos,
    SUM(CASE WHEN Optimization_Category IS NULL THEN 1 ELSE 0 END) AS Optimization_Category_Nulos
FROM Manufacturing_Production;
GO


-- ============================================================
-- 4. REVISAR DUPLICADOS DE JOB_ID
-- ============================================================

SELECT
    Job_ID,
    COUNT(*) AS Cantidad
FROM Manufacturing_Production
GROUP BY Job_ID
HAVING COUNT(*) > 1;
GO


-- ============================================================
-- 5. REVISAR VALORES DISTINTOS DE JOB_STATUS
-- ============================================================

SELECT DISTINCT Job_Status
FROM Manufacturing_Production;
GO


-- ============================================================
-- 6. REVISAR VALORES DISTINTOS DE OPTIMIZATION_CATEGORY
-- ============================================================

SELECT DISTINCT Optimization_Category
FROM Manufacturing_Production;
GO


-- ============================================================
-- 7. REVISAR VALORES DISTINTOS DE OPERATION_TYPE
-- ============================================================

SELECT DISTINCT Operation_Type
FROM Manufacturing_Production;
GO


-- ============================================================
-- 8. REVISAR VALORES DISTINTOS DE MACHINE_ID
-- ============================================================

SELECT DISTINCT Machine_ID
FROM Manufacturing_Production
ORDER BY Machine_ID;
GO