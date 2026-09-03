-- ============================================================
-- PROYECTO: Manufacturing Operations Analysis
-- ARCHIVO: 01_create_database_and_load_data.sql
-- DESCRIPCIÓN: Creación de la base de datos, tabla y carga inicial
-- ============================================================


-- ============================================================
-- 1. CREACIÓN DE LA BASE DE DATOS
-- ============================================================

CREATE DATABASE ManufacturingAnalysis;
GO


-- ============================================================
-- 2. SELECCIÓN DE LA BASE DE DATOS
-- ============================================================

USE ManufacturingAnalysis;
GO


-- ============================================================
-- 3. CREACIÓN DE LA TABLA
-- ============================================================

CREATE TABLE Manufacturing_Production (
    Job_ID VARCHAR(20),
    Machine_ID VARCHAR(20),
    Operation_Type VARCHAR(50),
    Material_Used DECIMAL(10,2),
    Processing_Time INT,
    Energy_Consumption DECIMAL(10,2),
    Machine_Availability INT,
    Scheduled_Start DATETIME,
    Scheduled_End DATETIME,
    Actual_Start DATETIME,
    Actual_End DATETIME,
    Job_Status VARCHAR(30),
    Optimization_Category VARCHAR(50)
);
GO


-- ============================================================
-- 4. CARGA DE DATOS
-- ============================================================

BULK INSERT Manufacturing_Production
FROM 'C:\Especializacion Data Analytics\CLASES SQL\PROYECTO FINAL\hybrid_manufacturing_categorical.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- ============================================================
-- 5. VALIDACIÓN DE LA CARGA
-- ============================================================

SELECT COUNT(*) AS Total_Registros
FROM Manufacturing_Production;

SELECT TOP 10 *
FROM Manufacturing_Production;
GO