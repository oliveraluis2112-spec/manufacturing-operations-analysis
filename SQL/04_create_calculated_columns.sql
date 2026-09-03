-- ============================================================
-- PROYECTO: Manufacturing Operations Analysis
-- ARCHIVO: 04_create_calculated_columns.sql
-- DESCRIPCIÓN: Creación de variables calculadas para el análisis
-- ============================================================


-- ============================================================
-- 1. SELECCIONAR LA BASE DE DATOS
-- ============================================================

USE ManufacturingAnalysis;
GO


-- ============================================================
-- 2. AGREGAR COLUMNAS CALCULADAS
-- ============================================================

ALTER TABLE Manufacturing_Production_Analysis
ADD Start_Delay_Minutes INT,
    Scheduled_Duration_Minutes INT,
    Actual_Duration_Minutes INT,
    Duration_Variance_Minutes INT;
GO


-- ============================================================
-- 3. CALCULAR RETRASO DE INICIO
-- ============================================================

UPDATE Manufacturing_Production_Analysis
SET Start_Delay_Minutes =
    CASE
        WHEN Actual_Start IS NOT NULL
             AND Scheduled_Start IS NOT NULL
        THEN DATEDIFF(MINUTE, Scheduled_Start, Actual_Start)
        ELSE NULL
    END;
GO


-- ============================================================
-- 4. CALCULAR DURACIÓN PROGRAMADA
-- ============================================================

UPDATE Manufacturing_Production_Analysis
SET Scheduled_Duration_Minutes =
    CASE
        WHEN Scheduled_Start IS NOT NULL
             AND Scheduled_End IS NOT NULL
        THEN DATEDIFF(MINUTE, Scheduled_Start, Scheduled_End)
        ELSE NULL
    END;
GO


-- ============================================================
-- 5. CALCULAR DURACIÓN REAL
-- ============================================================

UPDATE Manufacturing_Production_Analysis
SET Actual_Duration_Minutes =
    CASE
        WHEN Actual_Start IS NOT NULL
             AND Actual_End IS NOT NULL
        THEN DATEDIFF(MINUTE, Actual_Start, Actual_End)
        ELSE NULL
    END;
GO


-- ============================================================
-- 6. CALCULAR DESVIACIÓN DE DURACIÓN
-- ============================================================

UPDATE Manufacturing_Production_Analysis
SET Duration_Variance_Minutes =
    CASE
        WHEN Actual_Duration_Minutes IS NOT NULL
             AND Scheduled_Duration_Minutes IS NOT NULL
        THEN Actual_Duration_Minutes - Scheduled_Duration_Minutes
        ELSE NULL
    END;
GO


-- ============================================================
-- 7. VALIDAR LAS NUEVAS VARIABLES
-- ============================================================

SELECT TOP 20
    Job_ID,
    Machine_ID,
    Operation_Type,
    Scheduled_Start,
    Scheduled_End,
    Actual_Start,
    Actual_End,
    Scheduled_Duration_Minutes,
    Actual_Duration_Minutes,
    Start_Delay_Minutes,
    Duration_Variance_Minutes,
    Job_Status
FROM Manufacturing_Production_Analysis;
GO