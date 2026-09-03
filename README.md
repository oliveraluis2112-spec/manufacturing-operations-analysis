# Manufacturing Operations Analysis

## 1. Overview

This project analyzes manufacturing operations using SQL Server. The objective is to evaluate operational performance based on production times, machine availability, energy consumption, delays and job status.

The analysis compares scheduled and actual execution times to identify delays, deviations and potential areas for operational improvement. The project also evaluates machine and operation performance to understand which areas may require further attention.

The entire analysis was developed using SQL Server and SQL queries, from data loading and validation to exploratory analysis and business-oriented analysis.

---

## 2. Business Problem

Manufacturing operations generate large amounts of operational data that can be used to evaluate production performance.

The main objective of this analysis is to answer questions such as:

* Which machines have the highest average delays?
* Which operations experience the greatest delays?
* Which machines have the highest failure rates?
* Which operations have the highest energy consumption?
* How different are actual processing times from scheduled times?
* Which machines combine high availability with lower delays?
* Which machine-operation combinations show the greatest operational deviations?

The analysis aims to transform operational records into information that can support the identification of performance issues and optimization opportunities.

---

## 3. Project Structure

```text
manufacturing-sql-analysis/
│
├── data/
│   └── hybrid_manufacturing_categorical.csv
│
├── sql/
│   ├── 01_create_database_and_load_data.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_create_analysis_table.sql
│   ├── 04_create_calculated_columns.sql
│   ├── 05_exploratory_data_analysis.sql
│   └── 06_business_analysis.sql
│
└── README.md
```

### SQL Scripts

`01_create_database_and_load_data.sql`

Creates the database and main table and loads the CSV file into SQL Server using `BULK INSERT`.

`02_data_cleaning.sql`

Performs initial data quality checks, including null values, duplicated Job IDs and categorical values.

`03_create_analysis_table.sql`

Creates a separate analysis table based on the original production data.

`04_create_calculated_columns.sql`

Creates calculated variables related to scheduled and actual production times.

`05_exploratory_data_analysis.sql`

Performs an initial exploration of the dataset, including machines, operations, job status, availability, energy consumption and delays.

`06_business_analysis.sql`

Contains the queries developed to answer the main business questions.

---

## 4. Dataset

The dataset contains manufacturing production records associated with different machines and operation types.

Each row represents a manufacturing job or operation.

### Main Variables

| Column                  | Description                                |
| ----------------------- | ------------------------------------------ |
| `Job_ID`                | Unique identifier of the manufacturing job |
| `Machine_ID`            | Machine assigned to the job                |
| `Operation_Type`        | Type of manufacturing operation            |
| `Material_Used`         | Amount of material used                    |
| `Processing_Time`       | Processing time of the operation           |
| `Energy_Consumption`    | Energy consumed during the operation       |
| `Machine_Availability`  | Availability percentage of the machine     |
| `Scheduled_Start`       | Scheduled start time                       |
| `Scheduled_End`         | Scheduled end time                         |
| `Actual_Start`          | Actual start time                          |
| `Actual_End`            | Actual end time                            |
| `Job_Status`            | Status of the manufacturing job            |
| `Optimization_Category` | Efficiency or optimization category        |

---

## 5. Data Preparation

The first stage of the project consisted of loading the CSV file into SQL Server and validating the structure and quality of the data.

The following checks were performed:

* Total number of records.
* Null values by column.
* Duplicated `Job_ID` values.
* Distinct job statuses.
* Distinct operation types.
* Distinct optimization categories.
* Available machines.

### Null Values

Null values were not automatically removed from the dataset.

Some null values are valid from an operational perspective. For example, a failed job may not have an `Actual_Start` or `Actual_End` value because the operation was not completed.

Therefore, these values are maintained as `NULL` and are excluded only from calculations where the required information is unavailable.

---

## 6. Calculated Variables

Additional variables were created to support the operational analysis.

### Start Delay

Measures the difference between the scheduled and actual start time.

```sql
DATEDIFF(MINUTE, Scheduled_Start, Actual_Start)
```

Column:

`Start_Delay_Minutes`

### Scheduled Duration

Measures the planned duration of the operation.

```sql
DATEDIFF(MINUTE, Scheduled_Start, Scheduled_End)
```

Column:

`Scheduled_Duration_Minutes`

### Actual Duration

Measures the actual duration of the operation.

```sql
DATEDIFF(MINUTE, Actual_Start, Actual_End)
```

Column:

`Actual_Duration_Minutes`

### Duration Variance

Measures the difference between actual and scheduled duration.

```sql
Actual_Duration_Minutes - Scheduled_Duration_Minutes
```

Column:

`Duration_Variance_Minutes`

---

## 7. Exploratory Data Analysis

The exploratory analysis provides an initial overview of the manufacturing operations.

The analysis focuses on:

* Number of jobs.
* Number of machines.
* Distribution of operation types.
* Job status distribution.
* Optimization categories.
* Average machine availability.
* Energy consumption.
* Average start delays.
* Differences between scheduled and actual durations.

These results provide the initial context required for the subsequent business analysis.

---

## 8. Business Analysis

The following questions were defined to evaluate the operational performance of the manufacturing process.

### Question 1. Which machines have the highest average start delay?

The objective is to identify machines with the greatest deviation from the scheduled start time.

```sql
SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay_Minutes
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
GROUP BY Machine_ID
ORDER BY Avg_Start_Delay_Minutes DESC;
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 2. Which operation types have the highest average delay?

This analysis compares average start delays across different manufacturing operations.

```sql
SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Start_Delay_Minutes AS DECIMAL(10,2)))
        AS Avg_Start_Delay_Minutes
FROM Manufacturing_Production_Analysis
WHERE Start_Delay_Minutes IS NOT NULL
GROUP BY Operation_Type
ORDER BY Avg_Start_Delay_Minutes DESC;
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 3. Which machines have the highest number of failed jobs?

```sql
SELECT
    Machine_ID,
    COUNT(*) AS Failed_Jobs
FROM Manufacturing_Production_Analysis
WHERE Job_Status = 'Failed'
GROUP BY Machine_ID
ORDER BY Failed_Jobs DESC;
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 4. Which machines have the highest failure rate?

The failure rate is calculated relative to the total number of jobs processed by each machine.

```sql
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
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 5. Which operation types have the highest energy consumption?

```sql
SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    SUM(Energy_Consumption) AS Total_Energy_Consumption,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2)))
        AS Avg_Energy_Consumption
FROM Manufacturing_Production_Analysis
GROUP BY Operation_Type
ORDER BY Avg_Energy_Consumption DESC;
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 6. Which machines have the highest energy consumption?

```sql
SELECT
    Machine_ID,
    COUNT(*) AS Total_Jobs,
    SUM(Energy_Consumption) AS Total_Energy_Consumption,
    AVG(CAST(Energy_Consumption AS DECIMAL(10,2)))
        AS Avg_Energy_Consumption
FROM Manufacturing_Production_Analysis
GROUP BY Machine_ID
ORDER BY Avg_Energy_Consumption DESC;
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 7. Which operation types have the greatest duration variance?

This analysis compares actual and scheduled duration.

```sql
SELECT
    Operation_Type,
    COUNT(*) AS Total_Jobs,
    AVG(CAST(Duration_Variance_Minutes AS DECIMAL(10,2)))
        AS Avg_Duration_Variance
FROM Manufacturing_Production_Analysis
WHERE Duration_Variance_Minutes IS NOT NULL
GROUP BY Operation_Type
ORDER BY Avg_Duration_Variance DESC;
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 8. Which machines combine high availability with lower delays?

```sql
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
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 9. Which machine-operation combinations have the highest delays?

```sql
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
```

**Result and interpretation:** To be completed based on the query results.

---

### Question 10. Which jobs have the greatest deviation from scheduled duration?

```sql
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
```

**Result and interpretation:** To be completed based on the query results.

---

## 9. Key Findings

The main findings will be documented after analyzing the results of the business queries.

The analysis will focus on four areas:

**Operational delays**

Identification of machines and operations with significant delays compared with scheduled production times.

**Machine performance**

Comparison of machine availability, delays, failures and workload.

**Energy consumption**

Analysis of energy consumption across machines and operation types.

**Production efficiency**

Evaluation of differences between scheduled and actual processing times to identify operational deviations.

---

## 10. Conclusions

This project demonstrates the use of SQL Server to analyze manufacturing operations and transform operational records into business-oriented information.

The analysis combines data validation, calculated operational metrics, exploratory analysis and business questions to evaluate machine performance, delays, failures, energy consumption and production time deviations.

The final conclusions will be based on the results obtained from the SQL analysis and will identify the main operational patterns and potential areas for improvement.

---

## 11. Technologies

* SQL Server
* SQL Server Management Studio (SSMS)
* SQL
* BULK INSERT
* Aggregate Functions
* CASE
* GROUP BY
* HAVING
* DATEDIFF
* Window Functions
