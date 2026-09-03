# Análisis de Operaciones de Manufactura

## 1. Descripción del proyecto

Este proyecto analiza datos de operaciones de manufactura utilizando SQL Server. El objetivo es evaluar el desempeño de las máquinas y operaciones a partir de indicadores relacionados con tiempos de producción, retrasos, disponibilidad, consumo de energía y estado de los trabajos.

El análisis compara los tiempos programados con los tiempos reales de ejecución para identificar desviaciones y oportunidades de mejora en la operación.

## 2. Problema de negocio

En una operación de manufactura es importante conocer qué máquinas y procesos presentan mayores retrasos, niveles de fallas o consumos de energía, así como identificar diferencias entre los tiempos planificados y los tiempos reales.

A partir de los datos disponibles, se plantearon preguntas de negocio orientadas a evaluar:

* Retrasos en el inicio de los trabajos.
* Desempeño de las máquinas.
* Porcentaje de trabajos fallidos.
* Consumo de energía.
* Desviaciones entre tiempos programados y reales.
* Relación entre disponibilidad y retrasos.
* Desempeño según el tipo de operación.

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

Principales campos utilizados:

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

Se realizaron consultas SQL para revisar la estructura y calidad de los datos antes del análisis.

Las principales validaciones fueron:

* Cantidad total de registros.
* Revisión de registros duplicados.
* Valores nulos.
* Valores distintos de estado del trabajo.
* Tipos de operación existentes.
* Máquinas registradas.
* Categorías de optimización.

Los valores nulos en `Actual_Start` y `Actual_End` fueron conservados cuando correspondían a trabajos que no llegaron a ejecutarse. Estos valores no fueron reemplazados, ya que forman parte del comportamiento real registrado en los datos.

## 6. Variables calculadas

Para facilitar el análisis se crearon las siguientes variables:

### Retraso de inicio

Calcula la diferencia entre el inicio real y el inicio programado.

```text
Retraso de inicio = Actual_Start - Scheduled_Start
```

### Duración programada

Calcula el tiempo planificado para cada trabajo.

```text
Duración programada = Scheduled_End - Scheduled_Start
```

### Duración real

Calcula el tiempo real de ejecución cuando existen los tiempos reales de inicio y finalización.

```text
Duración real = Actual_End - Actual_Start
```

### Variación de duración

Permite identificar si un trabajo tomó más o menos tiempo del programado.

```text
Variación = Duración real - Duración programada
```

## 7. Análisis exploratorio

Se realizaron consultas para obtener una visión general de las operaciones de manufactura, considerando:

* Cantidad de trabajos.
* Cantidad de máquinas.
* Distribución de operaciones.
* Estado de los trabajos.
* Categorías de eficiencia.
* Disponibilidad promedio por máquina.
* Consumo de energía.
* Retrasos promedio.
* Diferencias entre duración programada y real.

## 8. Análisis de negocio

Se plantearon las siguientes preguntas:

1. ¿Qué máquinas presentan el mayor retraso promedio de inicio?
2. ¿Qué tipos de operación presentan mayores retrasos?
3. ¿Qué máquinas tienen mayor cantidad de trabajos fallidos?
4. ¿Qué máquinas presentan la mayor tasa de fallas?
5. ¿Qué tipos de operación presentan mayor consumo de energía?
6. ¿Qué máquinas presentan mayor consumo de energía?
7. ¿Qué tipos de operación presentan mayor variación respecto al tiempo programado?
8. ¿Qué máquinas combinan una alta disponibilidad con menores retrasos?
9. ¿Qué combinaciones de máquina y operación presentan mayores retrasos?
10. ¿Qué trabajos presentan las mayores desviaciones respecto a la duración programada?

Los resultados obtenidos para cada pregunta se encuentran en la carpeta `results/`.

## 9. Principales hallazgos

Los principales hallazgos del análisis se determinarán a partir de los resultados obtenidos en las consultas de negocio.

Se evaluarán principalmente cuatro aspectos:

* Desempeño y retrasos operativos.
* Desempeño de las máquinas.
* Consumo de energía.
* Cumplimiento de los tiempos programados.

## 10. Conclusiones

El análisis permite utilizar SQL Server para transformar datos operativos en información útil para evaluar el desempeño de una operación de manufactura.

La comparación entre tiempos programados y reales permite identificar desviaciones, mientras que el análisis de disponibilidad, fallas y consumo de energía permite detectar posibles oportunidades de mejora en máquinas y procesos.

Los resultados finales y las conclusiones específicas se encuentran sustentados en las consultas SQL desarrolladas en el proyecto.

## 11. Tecnologías utilizadas

* SQL Server
* SQL Server Management Studio (SSMS)
* SQL
* BULK INSERT
* CASE
* GROUP BY
* HAVING
* DATEDIFF
* Funciones de agregación
* CTE
* Funciones de ventana
* Consultas de análisis y validación de datos
