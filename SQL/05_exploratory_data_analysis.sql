-- ============================================================
-- PROYECTO: Manufacturing Operations Analysis
-- ARCHIVO: 05_exploratory_data_analysis.sql
-- DESCRIPCIÓN: Análisis exploratorio inicial de los datos
-- ============================================================


-- ============================================================
-- 1. SELECCIONAR LA BASE DE DATOS
-- ============================================================

USE ManufacturingAnalysis;
GO


-- ============================================================
-- 2. CANTIDAD TOTAL DE TRABAJOS
-- ============================================================

SELECT
    COUNT(*) AS Total_Jobs
FROM Manufacturing_Production_Analysis;
GO


-- ============================================================
-- 3. CANTIDAD DE MÁQUINAS
-- ============================================================

SELECT
    COUNT(DISTINCT Machine_ID) AS Total_Machines
FROM Manufacturing_Production_Analysis;
GO


-- ============================================================
-- 4. TIPOS DE OPERACIÓN
-- ============================================================

SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs
FROM Manufacturing_Production_Analysis
GROUP BY Operation_Type
ORDER BY Total_Jobs DESC;
GO


-- ============================================================
-- 5. DISTRIBUCIÓN POR ESTADO DEL TRABAJO
-- ============================================================

SELECT
    Job_Status,
    COUNT(*) AS Total_Jobs,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS Percentage
FROM Manufacturing_Production_Analysis
GROUP BY Job_Status
ORDER BY Total_Jobs DESC;
GO


-- ============================================================
-- 6. DISTRIBUCIÓN POR CATEGORÍA DE OPTIMIZACIÓN
-- ============================================================

SELECT
    Optimization_Category,
    COUNT(*) AS Total_Jobs,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS Percentage
FROM Manufacturing_Production_Analysis
GROUP BY Optimization_Category
ORDER BY Total_Jobs DESC;
GO


-- ============================================================
-- 7. DESEMPEÑO POR MÁQUINA
-- ============================================================

SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Machine_Availability AS DECIMAL(10,2))) AS Avg_Availability,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2))) AS Avg_Energy_Consumption,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2))) AS Avg_Start_Delay
FROM Manufacturing_Production_Analysis
GROUP BY Machine_ID
ORDER BY Avg_Start_Delay DESC;
GO


-- ============================================================
-- 8. DESEMPEÑO POR TIPO DE OPERACIÓN
-- ============================================================

SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Processing_Time AS DECIMAL(10,2))) AS Avg_Processing_Time,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2))) AS Avg_Energy_Consumption,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2))) AS Avg_Start_Delay
FROM Manufacturing_Production_Analysis
GROUP BY Operation_Type
ORDER BY Avg_Start_Delay DESC;
GO


-- ============================================================
-- 9. RESUMEN DE TIEMPOS DE OPERACIÓN
-- ============================================================

SELECT
    AVG(CAST(Scheduled_Duration_Minutes AS DECIMAL(10,2)))
        AS Avg_Scheduled_Duration,

    AVG(CAST(Actual_Duration_Minutes AS DECIMAL(10,2)))
        AS Avg_Actual_Duration,

    AVG(CAST(Duration_Variance_Minutes AS DECIMAL(10,2)))
        AS Avg_Duration_Variance,

    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay
FROM Manufacturing_Production_Analysis;
GO


-- ============================================================
-- 10. CONSUMO DE ENERGÍA POR MÁQUINA
-- ============================================================

SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    SUM(Energy_Consumption) AS Total_Energy_Consumption,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2)))
        AS Avg_Energy_Consumption
FROM Manufacturing_Production_Analysis
GROUP BY Machine_ID
ORDER BY Total_Energy_Consumption DESC;
GO


-- ============================================================
-- 11. DISPONIBILIDAD PROMEDIO POR MÁQUINA
-- ============================================================

SELECT
    Machine_ID,
    AVG(CAST(Machine_Availability AS DECIMAL(10,2)))
        AS Avg_Machine_Availability
FROM Manufacturing_Production_Analysis
GROUP BY Machine_ID
ORDER BY Avg_Machine_Availability DESC;
GO


-- ============================================================
-- 12. TRABAJOS CON MAYOR RETRASO DE INICIO
-- ============================================================

SELECT TOP 20
    Job_ID,
    Machine_ID,
    Operation_Type,
    Job_Status,
    Start_Delay_Minutes,
    Duration_Variance_Minutes
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
ORDER BY Start_Delay_Minutes DESC;
GO