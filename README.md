# Análisis de Operaciones de Manufactura

## 1. Descripción del proyecto

Este proyecto analiza datos de operaciones de manufactura utilizando SQL Server. El objetivo es evaluar el desempeño de las máquinas y operaciones a partir de información relacionada con tiempos de producción, retrasos, disponibilidad, consumo de energía y estado de los trabajos.

El análisis permite identificar patrones de comportamiento operativo y posibles oportunidades de mejora mediante consultas SQL.

## 2. Problema de negocio

En una operación de manufactura es importante conocer qué máquinas y procesos presentan mayores retrasos, niveles de fallas o consumos de energía, así como identificar diferencias en el desempeño entre máquinas y tipos de operación.

A partir de los datos disponibles, se plantearon preguntas de negocio orientadas a evaluar:

* Retrasos en el inicio de los trabajos.
* Desempeño de las máquinas.
* Cantidad y proporción de trabajos fallidos.
* Consumo de energía.
* Disponibilidad de las máquinas.
* Trabajos retrasados o fallidos según el tipo de operación.
* Consumo energético según el estado de los trabajos.

## 3. Estructura del proyecto

```text
manufacturing-operations-analysis/
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
├── results/
│   ├── question_01.png
│   ├── question_02.png
│   ├── question_03.png
│   ├── question_04.png
│   ├── question_05.png
│   ├── question_06.png
│   ├── question_07.png
│   ├── question_08.png
│   ├── question_09.png
│   └── question_10.png
│
└── README.md
```

## 4. Dataset

El proyecto utiliza el dataset **Manufacturing Production Data**, que contiene información relacionada con trabajos de manufactura, máquinas, tipos de operación, tiempos de procesamiento, consumo de energía, disponibilidad y estado de los trabajos.

### Principales campos

| Campo                 | Descripción                  |
| --------------------- | ---------------------------- |
| Job_ID                | Identificador del trabajo    |
| Machine_ID            | Identificador de la máquina  |
| Operation_Type        | Tipo de operación            |
| Material_Used         | Material utilizado           |
| Processing_Time       | Tiempo de procesamiento      |
| Energy_Consumption    | Consumo de energía           |
| Machine_Availability  | Disponibilidad de la máquina |
| Scheduled_Start       | Inicio programado            |
| Scheduled_End         | Fin programado               |
| Actual_Start          | Inicio real                  |
| Actual_End            | Fin real                     |
| Job_Status            | Estado del trabajo           |
| Optimization_Category | Categoría de eficiencia      |

## 5. Preparación y validación de datos

Antes del análisis se realizaron consultas SQL para revisar la estructura y calidad de los datos.

Las principales validaciones fueron:

* Cantidad total de registros.
* Revisión de posibles registros duplicados.
* Identificación de valores nulos.
* Estados de los trabajos.
* Tipos de operación.
* Máquinas registradas.
* Categorías de optimización.

Los valores nulos encontrados en `Actual_Start` y `Actual_End` fueron conservados cuando correspondían a trabajos que no llegaron a ejecutarse. No fueron reemplazados, ya que representan información válida del dataset.

## 6. Variables calculadas

Para facilitar el análisis se crearon variables relacionadas con los tiempos de operación.

### Retraso de inicio

Permite identificar cuánto tiempo después del inicio programado comenzó realmente un trabajo.

```text
Retraso de inicio = Actual_Start - Scheduled_Start
```

### Duración programada

Representa el tiempo planificado para completar un trabajo.

```text
Duración programada = Scheduled_End - Scheduled_Start
```

### Duración real

Representa el tiempo efectivo de ejecución cuando existen los tiempos reales de inicio y finalización.

```text
Duración real = Actual_End - Actual_Start
```

Las variables relacionadas con tiempos reales se mantienen como `NULL` cuando no existe información real de ejecución.

## 7. Análisis exploratorio

Se realizaron consultas de análisis exploratorio para obtener una visión general de los datos.

Entre los principales análisis se encuentran:

* Cantidad total de trabajos.
* Cantidad de máquinas.
* Distribución de tipos de operación.
* Distribución de estados de los trabajos.
* Distribución de categorías de eficiencia.
* Disponibilidad promedio por máquina.
* Consumo de energía.
* Retrasos promedio.
* Tiempos programados y reales.

## 8. Análisis de negocio

Se plantearon diez preguntas para analizar el desempeño de las operaciones de manufactura:

### 1. ¿Qué máquinas presentan el mayor retraso promedio de inicio?

Permite identificar las máquinas con mayores retrasos respecto al horario programado.

### 2. ¿Qué tipos de operación presentan mayores retrasos?

Permite comparar los retrasos promedio entre los diferentes tipos de operación.

### 3. ¿Qué máquinas tienen mayor cantidad de trabajos fallidos?

Permite identificar las máquinas con mayor número de trabajos cuyo estado fue registrado como `Failed`.

### 4. ¿Qué máquinas presentan la mayor tasa de fallas?

Permite comparar la proporción de trabajos fallidos respecto al total de trabajos de cada máquina.

### 5. ¿Qué tipos de operación presentan mayor consumo de energía?

Permite identificar qué operaciones tienen un mayor consumo energético promedio y total.

### 6. ¿Qué máquinas presentan mayor consumo de energía?

Permite comparar el consumo energético entre las diferentes máquinas.

### 7. ¿Qué tipos de operación presentan mayor proporción de trabajos retrasados o fallidos?

Permite identificar los tipos de operación que concentran una mayor proporción de trabajos con problemas operativos.

### 8. ¿Qué máquinas presentan menor disponibilidad promedio?

Permite identificar las máquinas con menor nivel de disponibilidad dentro de la operación.

### 9. ¿Qué estados de trabajo presentan mayor consumo promedio de energía?

Permite comparar el consumo energético según el estado registrado de cada trabajo.

### 10. ¿Qué trabajos presentan los mayores retrasos respecto al inicio programado?

Permite identificar los trabajos individuales con mayor retraso respecto a su horario de inicio.

Los resultados de cada pregunta se encuentran en la carpeta `results/`.

## 9. Resultados y hallazgos

Los resultados finales se determinarán a partir de las consultas de negocio ejecutadas en SQL Server.

El análisis se enfocará principalmente en:

* Máquinas con mayores retrasos.
* Operaciones con mayor incidencia de problemas.
* Máquinas con mayor cantidad y proporción de fallas.
* Consumo energético por máquina y operación.
* Disponibilidad de las máquinas.
* Consumo energético según el estado de los trabajos.
* Trabajos individuales con mayores retrasos.

Las conclusiones específicas serán incorporadas después de revisar los resultados obtenidos en cada consulta.

## 10. Conclusiones

El proyecto demuestra el uso de SQL Server para analizar información de operaciones de manufactura y convertir datos operativos en información útil para la toma de decisiones.

A través de consultas de validación, transformación, análisis exploratorio y análisis de negocio, es posible evaluar el desempeño de las máquinas y operaciones considerando variables como retrasos, disponibilidad, consumo de energía y estado de los trabajos.

Los resultados obtenidos permiten identificar áreas de la operación que pueden requerir una revisión más detallada y servir como punto de partida para futuras iniciativas de mejora.

## 11. Tecnologías utilizadas

* SQL Server
* SQL Server Management Studio (SSMS)
* SQL
* BULK INSERT
* SELECT
* WHERE
* CASE
* GROUP BY
* HAVING
* ORDER BY
* COUNT
* SUM
* AVG
* CAST
* DATEDIFF
