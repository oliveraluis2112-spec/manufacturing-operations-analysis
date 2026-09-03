-- ============================================================
-- PROYECTO: Manufacturing Operations Analysis
-- ARCHIVO: 06_business_analysis.sql
-- DESCRIPCIÓN: Análisis de indicadores y preguntas de negocio
-- ============================================================

USE ManufacturingAnalysis;
GO


-- ============================================================
-- PREGUNTA 1
-- ¿QUÉ MÁQUINAS PRESENTAN MAYOR RETRASO PROMEDIO?
-- ============================================================

SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay_Minutes
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
GROUP BY Machine_ID
ORDER BY Avg_Start_Delay_Minutes DESC;
GO


-- ============================================================
-- PREGUNTA 2
-- ¿QUÉ TIPOS DE OPERACIÓN PRESENTAN MAYOR RETRASO?
-- ============================================================

SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay_Minutes
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
GROUP BY Operation_Type
ORDER BY Avg_Start_Delay_Minutes DESC;
GO


-- ============================================================
-- PREGUNTA 3
-- ¿QUÉ MÁQUINAS PRESENTAN MAYOR CANTIDAD DE TRABAJOS FALLIDOS?
-- ============================================================

SELECT
    Machine_ID,
    COUNT(*) AS Failed_Jobs
FROM Manufacturing_Production_Analysis
WHERE Job_Status = 'Failed'
GROUP BY Machine_ID
ORDER BY Failed_Jobs DESC;
GO


-- ============================================================
-- PREGUNTA 4
-- ¿QUÉ MÁQUINAS TIENEN MAYOR PORCENTAJE DE TRABAJOS FALLIDOS?
-- ============================================================

SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    SUM(
        CASE
            WHEN Job_Status = 'Failed' THEN 1
            ELSE 0
        END
    ) AS Failed_Jobs,
    CAST(
        SUM(
            CASE
                WHEN Job_Status = 'Failed' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Failed_Percentage
FROM Manufacturing_Production_Analysis
GROUP BY Machine_ID
ORDER BY Failed_Percentage DESC;
GO


-- ============================================================
-- PREGUNTA 5
-- ¿QUÉ OPERACIONES PRESENTAN MAYOR CONSUMO DE ENERGÍA?
-- ============================================================

SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    SUM(Energy_Consumption) AS Total_Energy_Consumption,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2)))
        AS Avg_Energy_Consumption
FROM Manufacturing_Production_Analysis
GROUP BY Operation_Type
ORDER BY Avg_Energy_Consumption DESC;
GO


-- ============================================================
-- PREGUNTA 6
-- ¿QUÉ MÁQUINAS PRESENTAN MAYOR CONSUMO DE ENERGÍA?
-- ============================================================

SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    SUM(Energy_Consumption) AS Total_Energy_Consumption,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2)))
        AS Avg_Energy_Consumption
FROM Manufacturing_Production_Analysis
GROUP BY Machine_ID
ORDER BY Avg_Energy_Consumption DESC;
GO


-- ============================================================
-- PREGUNTA 7
-- ¿QUÉ OPERACIONES PRESENTAN MAYOR DESVIACIÓN DE TIEMPO?
-- ============================================================

SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Duration_Variance_Minutes AS DECIMAL(10,2)))
        AS Avg_Duration_Variance
FROM Manufacturing_Production_Analysis
WHERE Duration_Variance_Minutes IS NOT NULL
GROUP BY Operation_Type
ORDER BY Avg_Duration_Variance DESC;
GO


-- ============================================================
-- PREGUNTA 8
-- ¿QUÉ MÁQUINAS PRESENTAN MAYOR DISPONIBILIDAD Y MENOR RETRASO?
-- ============================================================

SELECT
    Machine_ID,
    AVG(CAST(Machine_Availability AS DECIMAL(10,2)))
        AS Avg_Availability,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
GROUP BY Machine_ID
ORDER BY Avg_Availability DESC,
         Avg_Start_Delay ASC;
GO


-- ============================================================
-- PREGUNTA 9
-- ¿QUÉ COMBINACIONES DE MÁQUINA Y OPERACIÓN PRESENTAN
-- MAYOR RETRASO?
-- ============================================================

SELECT
    Machine_ID,
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay,
    AVG(CAST(Duration_Variance_Minutes AS DECIMAL(10,2)))
        AS Avg_Duration_Variance
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
GROUP BY
    Machine_ID,
    Operation_Type
HAVING COUNT(*) >= 2
ORDER BY Avg_Start_Delay DESC;
GO


-- ============================================================
-- PREGUNTA 10
-- ¿CUÁLES SON LOS TRABAJOS CON MAYOR DESVIACIÓN
-- RESPECTO AL TIEMPO PROGRAMADO?
-- ============================================================

SELECT TOP 20
    Job_ID,
    Machine_ID,
    Operation_Type,
    Job_Status,
    Scheduled_Duration_Minutes,
    Actual_Duration_Minutes,
    Duration_Variance_Minutes
FROM Manufacturing_Production_Analysis
WHERE Duration_Variance_Minutes IS NOT NULL
ORDER BY Duration_Variance_Minutes DESC;
GO