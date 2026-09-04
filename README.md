# Manufacturing Operations Analysis

## Descripción del proyecto

Proyecto de análisis de datos enfocado en evaluar el desempeño de máquinas y operaciones dentro de un entorno de manufactura.

El análisis fue desarrollado utilizando **SQL Server y SQL Server Management Studio (SSMS)**, desde la creación de la base de datos y carga del dataset hasta la limpieza, transformación, análisis exploratorio y generación de indicadores de negocio.

El objetivo principal es identificar patrones relacionados con **retrasos, trabajos fallidos, disponibilidad de máquinas y consumo de energía**, con el fin de detectar puntos de atención dentro del proceso productivo.

---

## Problema de negocio

En un proceso de manufactura es importante conocer el desempeño de las máquinas y operaciones para identificar posibles problemas que puedan afectar la eficiencia de la producción.

Entre los principales aspectos analizados se encuentran:

* Retrasos en el inicio de los trabajos.
* Trabajos fallidos.
* Disponibilidad de las máquinas.
* Consumo de energía.
* Operaciones con mayor proporción de trabajos problemáticos.
* Combinaciones de máquina y operación con mayor consumo energético.

A partir de estos indicadores se busca identificar las máquinas, operaciones y trabajos que podrían requerir una revisión más detallada.

---

## Objetivo

Analizar los datos de producción mediante SQL para responder preguntas de negocio relacionadas con:

* Retrasos promedio por máquina.
* Retrasos promedio por tipo de operación.
* Cantidad de trabajos fallidos por máquina.
* Porcentaje de trabajos fallidos por máquina.
* Consumo energético por operación.
* Consumo energético por máquina.
* Proporción de trabajos retrasados o fallidos por operación.
* Relación entre disponibilidad y retrasos.
* Consumo energético según la combinación de máquina y operación.
* Identificación de los trabajos con mayores retrasos.

---

## Dataset

Para el desarrollo del proyecto se utilizó el dataset **Manufacturing Production Data**, disponible en Kaggle.

[Manufacturing Production Data – Kaggle](https://www.kaggle.com/datasets/ziya07/manufacturing-production-data?utm_source=chatgpt.com)

El dataset contiene información relacionada con trabajos de manufactura, máquinas, operaciones, materiales utilizados, tiempos de procesamiento, consumo de energía, disponibilidad, tiempos programados y reales, estado de los trabajos y categorías de optimización.

### Principales variables

| Variable                | Descripción                  |
| ----------------------- | ---------------------------- |
| `Job_ID`                | Identificador del trabajo    |
| `Machine_ID`            | Identificador de la máquina  |
| `Operation_Type`        | Tipo de operación            |
| `Material_Used`         | Material utilizado           |
| `Processing_Time`       | Tiempo de procesamiento      |
| `Energy_Consumption`    | Consumo de energía           |
| `Machine_Availability`  | Disponibilidad de la máquina |
| `Scheduled_Start`       | Inicio programado            |
| `Scheduled_End`         | Fin programado               |
| `Actual_Start`          | Inicio real                  |
| `Actual_End`            | Fin real                     |
| `Job_Status`            | Estado del trabajo           |
| `Optimization_Category` | Categoría de optimización    |

---

## Estructura del proyecto

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

---

# Proceso de análisis

## 1. Creación de la base de datos y carga de información

Se creó la base de datos:

```text
ManufacturingAnalysis
```

Posteriormente se creó la tabla `Manufacturing_Production` y se realizó la carga del archivo CSV utilizando `BULK INSERT`.

---

## 2. Limpieza y validación

Se realizaron diferentes validaciones para conocer la calidad y estructura de los datos.

Entre las validaciones realizadas se encuentran:

* Cantidad total de registros.
* Revisión de valores nulos.
* Identificación de posibles registros duplicados.
* Estados disponibles de los trabajos.
* Categorías de optimización.
* Tipos de operación.
* Máquinas disponibles.

Los valores nulos presentes en `Actual_Start` y `Actual_End` fueron conservados cuando correspondían a trabajos que no llegaron a ejecutarse, evitando modificar información válida del dataset.

---

## 3. Creación de tabla para análisis

Se creó una tabla independiente para trabajar el análisis:

```text
Manufacturing_Production_Analysis
```

Esto permitió mantener la información original y realizar las transformaciones sobre una tabla destinada específicamente al análisis.

---

## 4. Variables calculadas

Se crearon variables adicionales relacionadas con los tiempos de producción.

### Start_Delay_Minutes

Representa el retraso entre el inicio programado y el inicio real.

```text
Actual_Start - Scheduled_Start
```

### Scheduled_Duration_Minutes

Representa la duración programada del trabajo.

### Actual_Duration_Minutes

Representa la duración real del trabajo cuando existen los tiempos de inicio y finalización.

### Duration_Variance_Minutes

Representa la diferencia entre la duración real y la duración programada.

Durante la validación se observó que esta variable presentó una variación de **0 minutos** en los registros donde pudo ser calculada. Por este motivo, no fue utilizada como indicador principal en las preguntas de negocio.

---

# Análisis exploratorio

Se realizaron consultas exploratorias para conocer el comportamiento general de los datos.

Los principales análisis fueron:

* Total de trabajos.
* Total de máquinas.
* Tipos de operación.
* Distribución de estados de los trabajos.
* Distribución de categorías de optimización.
* Desempeño por máquina.
* Desempeño por tipo de operación.
* Consumo energético.
* Disponibilidad de máquinas.
* Trabajos con mayores retrasos.

---

# Análisis de negocio

Se plantearon diez preguntas para analizar los principales indicadores del proceso productivo.

## Pregunta 1. ¿Qué máquinas presentan mayor retraso promedio?

| Máquina | Trabajos | Retraso promedio |
| ------- | -------: | ---------------: |
| M05     |      172 |         5.34 min |
| M04     |      164 |         4.68 min |
| M03     |      157 |         4.34 min |
| M02     |      189 |         4.20 min |
| M01     |      189 |         3.87 min |

**Hallazgo:** M05 presenta el mayor retraso promedio, con **5.34 minutos**, mientras que M01 registra el menor, con **3.87 minutos**.

---

## Pregunta 2. ¿Qué tipos de operación presentan mayor retraso?

| Operación | Trabajos | Retraso promedio |
| --------- | -------: | ---------------: |
| Lathe     |      181 |         4.96 min |
| Grinding  |      183 |         4.63 min |
| Milling   |      174 |         4.61 min |
| Drilling  |      168 |         4.46 min |
| Additive  |      165 |         3.61 min |

**Hallazgo:** Lathe presenta el mayor retraso promedio, con **4.96 minutos**, mientras que Additive registra el menor, con **3.61 minutos**.

---

## Pregunta 3. ¿Qué máquinas presentan mayor cantidad de trabajos fallidos?

| Máquina | Trabajos fallidos |
| ------- | ----------------: |
| M04     |                35 |
| M03     |                29 |
| M01     |                23 |
| M02     |                21 |
| M05     |                21 |

**Hallazgo:** M04 concentra la mayor cantidad de trabajos fallidos, con **35 casos**, seguida de M03 con **29**.

---

## Pregunta 4. ¿Qué máquinas tienen mayor porcentaje de trabajos fallidos?

| Máquina | Total trabajos | Trabajos fallidos | Porcentaje |
| ------- | -------------: | ----------------: | ---------: |
| M04     |            199 |                35 |     17.59% |
| M03     |            186 |                29 |     15.59% |
| M05     |            193 |                21 |     10.88% |
| M01     |            212 |                23 |     10.85% |
| M02     |            210 |                21 |     10.00% |

**Hallazgo:** M04 presenta el mayor porcentaje de trabajos fallidos, con **17.59%**, mientras que M02 presenta el menor porcentaje, con **10.00%**.

M04 destaca tanto por la cantidad absoluta de trabajos fallidos como por su porcentaje de fallos.

---

## Pregunta 5. ¿Qué operaciones presentan mayor consumo de energía?

| Operación | Trabajos | Consumo total | Consumo promedio |
| --------- | -------: | ------------: | ---------------: |
| Drilling  |      189 |      1,674.68 |             8.86 |
| Additive  |      190 |      1,624.45 |             8.55 |
| Grinding  |      208 |      1,766.05 |             8.49 |
| Lathe     |      212 |      1,797.49 |             8.48 |
| Milling   |      201 |      1,658.67 |             8.25 |

**Hallazgo:** Drilling presenta el mayor consumo promedio de energía, con **8.86**, mientras que Milling registra el menor, con **8.25**.

Para comparar las operaciones se considera principalmente el consumo promedio, ya que la cantidad de trabajos es diferente entre ellas.

---

## Pregunta 6. ¿Qué máquinas presentan mayor consumo de energía?

| Máquina | Trabajos | Consumo total | Consumo promedio |
| ------- | -------: | ------------: | ---------------: |
| M03     |      186 |      1,629.34 |             8.76 |
| M04     |      199 |      1,699.16 |             8.54 |
| M05     |      193 |      1,631.98 |             8.46 |
| M01     |      212 |      1,791.94 |             8.45 |
| M02     |      210 |      1,768.92 |             8.42 |

**Hallazgo:** M03 presenta el mayor consumo promedio de energía, con **8.76**, mientras que M02 registra el menor, con **8.42**.

---

## Pregunta 7. ¿Qué operaciones presentan mayor proporción de trabajos retrasados o fallidos?

| Operación | Trabajos | Retrasados/Fallidos | Tasa de problemas |
| --------- | -------: | ------------------: | ----------------: |
| Lathe     |      212 |                  75 |            35.38% |
| Grinding  |      208 |                  71 |            34.13% |
| Milling   |      201 |                  67 |            33.33% |
| Drilling  |      189 |                  58 |            30.69% |
| Additive  |      190 |                  56 |            29.47% |

**Hallazgo:** Lathe presenta la mayor proporción de trabajos retrasados o fallidos, con **35.38%**, mientras que Additive registra la menor, con **29.47%**.

Este resultado coincide con el análisis de Q2, donde Lathe también presentó el mayor retraso promedio.

---

## Pregunta 8. ¿Qué máquinas presentan mayor disponibilidad y menor retraso?

| Máquina | Disponibilidad promedio | Retraso promedio |
| ------- | ----------------------: | ---------------: |
| M05     |                  89.49% |         5.34 min |
| M03     |                  89.34% |         4.34 min |
| M02     |                  89.28% |         4.20 min |
| M01     |                  89.12% |         3.87 min |
| M04     |                  88.66% |         4.68 min |

**Hallazgo:** M05 presenta la mayor disponibilidad promedio, con **89.49%**, pero también presenta el mayor retraso promedio, con **5.34 minutos**.

M01 presenta el menor retraso promedio, con **3.87 minutos**, aunque no tiene la mayor disponibilidad.

Por lo tanto, dentro del dataset analizado, una mayor disponibilidad no necesariamente implica un menor retraso en el inicio de los trabajos.

---

## Pregunta 9. ¿Qué combinaciones de máquina y operación presentan mayor consumo promedio de energía?

| Máquina | Operación | Trabajos | Consumo promedio |
| ------- | --------- | -------: | ---------------: |
| M04     | Lathe     |       38 |             9.44 |
| M03     | Drilling  |       29 |             9.35 |
| M01     | Additive  |       40 |             9.26 |
| M03     | Grinding  |       36 |             9.16 |
| M05     | Drilling  |       34 |             9.14 |
| M01     | Drilling  |       40 |             9.02 |
| M02     | Grinding  |       39 |             8.98 |
| M05     | Lathe     |       34 |             8.87 |
| M03     | Additive  |       30 |             8.82 |
| M02     | Additive  |       40 |             8.76 |
| M02     | Drilling  |       47 |             8.76 |
| M01     | Milling   |       45 |             8.75 |
| M04     | Grinding  |       43 |             8.69 |
| M03     | Lathe     |       60 |             8.65 |
| M05     | Milling   |       45 |             8.63 |
| M04     | Additive  |       36 |             8.45 |
| M05     | Grinding  |       36 |             8.24 |
| M04     | Drilling  |       39 |             8.22 |
| M04     | Milling   |       43 |             7.96 |
| M03     | Milling   |       31 |             7.90 |
| M02     | Milling   |       37 |             7.82 |
| M02     | Lathe     |       47 |             7.81 |
| M01     | Grinding  |       54 |             7.70 |
| M01     | Lathe     |       33 |             7.61 |
| M05     | Additive  |       44 |             7.60 |

**Hallazgo:** La combinación **M04 + Lathe** presenta el mayor consumo promedio de energía, con **9.44**.

Este análisis permite observar diferencias en el consumo que no serían visibles al analizar únicamente la máquina o la operación de forma independiente.

---

## Pregunta 10. ¿Qué trabajos presentan los mayores retrasos respecto al inicio programado?

Los mayores retrasos identificados fueron de **30 minutos**.

Los trabajos con este retraso fueron:

| Job_ID | Máquina | Operación | Estado  | Retraso |
| ------ | ------- | --------- | ------- | ------: |
| J096   | M05     | Milling   | Delayed |  30 min |
| J138   | M03     | Grinding  | Delayed |  30 min |
| J400   | M02     | Grinding  | Delayed |  30 min |
| J439   | M02     | Drilling  | Delayed |  30 min |
| J474   | M04     | Grinding  | Delayed |  30 min |
| J530   | M04     | Milling   | Delayed |  30 min |
| J568   | M03     | Grinding  | Delayed |  30 min |
| J625   | M01     | Drilling  | Delayed |  30 min |
| J641   | M01     | Grinding  | Delayed |  30 min |
| J660   | M01     | Milling   | Delayed |  30 min |
| J794   | M05     | Milling   | Delayed |  30 min |
| J944   | M02     | Additive  | Delayed |  30 min |

También se identificaron trabajos con retrasos de **29 y 28 minutos**.

Estos registros permiten identificar casos específicos que pueden ser revisados posteriormente para determinar posibles causas operativas.

---

# Principales hallazgos

A partir de las diez preguntas de negocio se identificaron los siguientes puntos:

* **M05** presenta el mayor retraso promedio entre las máquinas, con **5.34 minutos**.
* **Lathe** presenta el mayor retraso promedio entre las operaciones, con **4.96 minutos**.
* **M04** concentra la mayor cantidad de trabajos fallidos, con **35 casos**.
* **M04** también presenta el mayor porcentaje de trabajos fallidos, con **17.59%**.
* **Lathe** presenta la mayor proporción de trabajos retrasados o fallidos, con **35.38%**.
* **Drilling** presenta el mayor consumo promedio de energía entre las operaciones, con **8.86**.
* **M03** presenta el mayor consumo promedio de energía entre las máquinas, con **8.76**.
* La combinación **M04 + Lathe** presenta el mayor consumo promedio de energía, con **9.44**.
* **M05** presenta la mayor disponibilidad promedio, con **89.49%**, pero también el mayor retraso promedio.
* El mayor retraso individual identificado fue de **30 minutos**, registrado en varios trabajos clasificados como `Delayed`.

---

# Conclusiones

El análisis permitió identificar diferencias en el comportamiento de las máquinas y operaciones del proceso de manufactura.

En términos de retrasos, **M05** presenta el mayor retraso promedio entre las máquinas, mientras que **Lathe** presenta el mayor retraso promedio entre las operaciones. Además, Lathe concentra la mayor proporción de trabajos retrasados o fallidos, alcanzando un **35.38%**.

En relación con los trabajos fallidos, **M04** presenta el mayor número de casos y también el mayor porcentaje de fallos. Este comportamiento la convierte en una máquina que podría ser priorizada para una revisión más detallada.

Respecto al consumo energético, **Drilling** presenta el mayor consumo promedio entre las operaciones y **M03** el mayor consumo promedio entre las máquinas. Al analizar las combinaciones, **M04 + Lathe** presenta el mayor consumo promedio, con **9.44**.

El análisis de disponibilidad también muestra que una mayor disponibilidad no necesariamente se traduce en menores retrasos. M05 registra la disponibilidad más alta, pero también el mayor retraso promedio.

Finalmente, los resultados permiten identificar máquinas, operaciones y trabajos específicos que podrían ser analizados con mayor profundidad. Sin embargo, los resultados obtenidos muestran asociaciones y patrones dentro del dataset, por lo que no permiten establecer por sí solos las causas de los retrasos, fallos o consumo energético.

Como siguiente paso, el análisis podría complementarse con información adicional sobre **mantenimiento, turnos, operadores, causas de fallos y condiciones de producción**, permitiendo profundizar en los factores relacionados con el desempeño operativo.

---

# Tecnologías y funciones utilizadas

## Herramientas

* SQL Server
* SQL Server Management Studio (SSMS)

## SQL

* SQL
* `BULK INSERT`
* `SELECT`
* `WHERE`
* `CASE`
* `GROUP BY`
* `ORDER BY`
* `COUNT`
* `SUM`
* `AVG`
* `CAST`
* `DATEDIFF`

---

# Autor

**Luis Olivera García**

Análisis de datos, Business Intelligence y automatización de procesos.
