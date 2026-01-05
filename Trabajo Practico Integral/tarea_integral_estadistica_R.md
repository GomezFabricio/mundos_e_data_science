# Tarea Integral — Estadística y Manipulación de Datos en R

## Contexto
Eres analista de datos en una organización que desea entender **cómo se relacionan variables demográficas y de salud** (por ejemplo: edad, sexo, peso) y producir un **reporte reproducible** con limpieza, estadística descriptiva, inferencia y análisis de correlación.

Vas a trabajar con un archivo tipo CSV llamado `mydata.csv` (ubicado en tu carpeta de trabajo). Si tu `mydata.csv` no tiene exactamente las columnas mencionadas, adapta el enunciado manteniendo la **misma lógica** (edad/sexo/peso o equivalentes).

## Objetivo
Construir un flujo completo en R que:
1) Prepare el entorno y cargue los datos.
2) Limpie y explore el dataset.
3) Aplique estadística descriptiva.
4) Ejecute pruebas de inferencia.
5) Construya tablas de contingencia y porcentajes.
6) Resuma variables cuantitativas por grupos.
7) Estudie correlación y matriz de correlación con visualización.
8) Exporte resultados y deje trazabilidad (reproducibilidad).

## Datos
- Dataset principal: `mydata.csv`
- Columnas esperadas (o equivalentes):
  - `EDAD` (cuantitativa)
  - `SEXO` (cualitativa)
  - `PESO` (cuantitativa)

## Requisitos generales (obligatorios)
- Trabaja con una **semilla fija** (`set.seed(123)` o equivalente).
- Deja el análisis **reproducible**:
  - Limpia el entorno al inicio: `rm(list = ls())`.
  - Define directorio de trabajo (si aplica): `setwd("...")`.
  - Carga librerías necesarias (por ejemplo: `tidyverse`, `readxl`, `lubridate`, `corrplot`, `EnvStats`).
- Todo resultado importante debe quedar **guardado** en archivos (tablas) y **resumido** en un reporte.

## Parte A — Setup e importación
1. Inicia un script y agrega:
   - `rm(list = ls())`
   - `set.seed(123)`
   - `setwd("...")` (si corresponde)
2. Carga librerías:
   - Opción A (recomendada): `pacman::p_load(...)`
   - Opción B: `library(...)`
3. Importa el dataset:
   - Usa `read.csv2()` con argumentos adecuados para separador y decimales.
4. Verifica estructura:
   - `head()`, `str()`, `summary()`.

## Parte B — Exploración y calidad de datos
1. Identifica tipos de variables (cualitativa vs cuantitativa) y justifica.
2. Revisa valores faltantes y duplicados.
   - Decide si imputas o descartas y **justifica**.
3. Detecta outliers en al menos una variable numérica (`EDAD` o `PESO`) usando `boxplot()` y describe lo observado.

## Parte C — Estadística descriptiva (fundamentos)
Para `EDAD` y `PESO` (o las cuantitativas que correspondan):
- Calcula:
  - Media (`mean`)
  - Mediana (`median`)
  - Moda (función custom)
  - Varianza (`var`)
  - Desvío estándar (`sd`)
  - Rango (`range`)
  - IQR (`IQR`)
- Interpreta brevemente (1–3 líneas por variable): qué te dice cada medida sobre el comportamiento de los datos.

## Parte D — Inferencia estadística
1. Plantea un test t de una media:
   - Define `H0`, `H1`, α (por ejemplo 0.05) y regla de decisión.
   - Ejecuta `t.test(x, mu = ...)` sobre una variable numérica.
2. Plantea un test t de dos muestras:
   - Compara `PESO` (o equivalente) entre 2 grupos (por ejemplo `SEXO` si tiene 2 niveles).
   - Define hipótesis y ejecuta `t.test(x, y)` (o `t.test(PESO ~ SEXO, data=...)`).
3. Test de varianza:
   - Usa `EnvStats::varTest()` sobre una variable numérica con una varianza teórica propuesta.
4. Interpreta p-valor y decisión para cada prueba.

## Parte E — Cualitativa vs cualitativa: bins + tabla de contingencia
1. Convierte `SEXO` a factor:
   - `datos$SEXO <- as.factor(datos$SEXO)` y revisa `levels()`.
2. Crea una variable de grupos de edad con `cut()`:
   - `breaks = seq(20, 35, by = 3)` (ajusta según rango real de `EDAD`).
   - Genera 2 versiones:
     - `include.lowest = TRUE`
     - `include.lowest = FALSE`
   - Explica en 1–2 líneas qué cambia y por qué.
   - Muestra un ejemplo mínimo con `cut(1:10, ...)` que evidencie `right` e `include.lowest`.
3. Construye tabla de contingencia:
   - `table(datos$GRUPO, datos$SEXO)` y también en orden inverso.
4. Agrega marginales:
   - `addmargins(tabla)`.
5. Proporciones y porcentajes:
   - `prop.table(tabla)` (sobre el total)
   - Por filas: `prop.table(tabla, margin = 1)`
   - Por columnas: `prop.table(tabla, margin = 2)`
   - Porcentajes con redondeo:
     - `round(100 * prop.table(tabla, margin = 1), 2)`
     - `round(100 * prop.table(tabla, margin = 2), 2)`
6. Exporta la tabla porcentual:
   - `write.table(..., "tablacontingencia.txt", ...)`
   - `write.csv(..., "tablacontingencia.csv")`

## Parte F — Cuantitativa vs cualitativa: resumen por grupos
Calcula resúmenes de `PESO` (o equivalente) por `SEXO` y por `GRUPO`:
- `tapply(datos$PESO, datos$SEXO, mean, na.rm = TRUE)`
- `tapply(datos$PESO, datos$GRUPO, max, na.rm = TRUE)`
- `by(datos$PESO, datos$SEXO, mean)` (explica en 1 línea cómo difiere la salida)
- `aggregate(PESO ~ SEXO, data = datos, FUN = mean)`
- `aggregate(PESO ~ SEXO + GRUPO, data = datos, mean)`

## Parte G — Cuantitativa vs cuantitativa: covarianza y correlación
1. Calcula covarianza y correlación:
   - `cov(datos$PESO, datos$EDAD)`
   - `cor(datos$PESO, datos$EDAD)`
2. Interpreta:
   - Signo y magnitud de `r`.
3. Prueba de hipótesis de correlación:
   - `cor.test(datos$PESO, datos$EDAD, method = "pearson")`
   - Explica `H0`, `H1`, α y decisión.
4. Calcula $r^2$ a partir de `r` y explica su interpretación (en contexto simple).

## Parte H — Matriz de correlación y visualización
1. Usa `mtcars` para practicar matriz (aunque tu dataset tenga pocas columnas numéricas):
   - Selecciona al menos 6 variables numéricas.
2. Calcula matriz de correlación y redondea.
3. Visualiza con:
   - `symnum(...)`
   - `corrplot(...)` con al menos:
     - `method = "circle"`
     - `method = "number"`
     - `type = "upper"`
     - `order = "hclust"`
   - Aplica una paleta con `RColorBrewer` o `colorRampPalette`.

## Parte I — ETL y export
1. Genera un dataset “procesado” (por ejemplo `datos_procesados`) que incluya:
   - `GRUPO` (edad por bins)
   - Tipos corregidos (`SEXO` como factor)
   - NA tratados (según tu decisión)
2. Exporta:
   - `write.csv(datos_procesados, "datos_procesados.csv", row.names = FALSE)`

## Parte J — Prompting para IA (sección sin numerar)
Usa las plantillas de prompting de la biblia y escribe **2 prompts**:
1) Un prompt para diagnóstico estadístico completo de tu `mydata.csv`.
2) Un prompt para un flujo end-to-end que produzca un reporte final con riesgos y próximos pasos.

(Entregas los prompts como texto en tu reporte; no hace falta ejecutarlos).

## Entregables
- Un **reporte** (Markdown o PDF) que incluya:
  - Descripción del dataset
  - Decisiones de limpieza
  - Resultados de descriptiva
  - Resultados e interpretación de inferencia
  - Tablas de contingencia con porcentajes (explicando `margin`)
  - Resúmenes por grupo
  - Correlación y conclusiones
  - Visualizaciones (boxplot, scatter/corrplot)ba
- Archivos exportados:
  - `tablacontingencia.txt`
  - `tablacontingencia.csv`
  - `datos_procesados.csv`

## Criterios de evaluación (checklist)
- Reproducibilidad (semilla, librerías, entorno limpio)
- Correcta aplicación de descriptiva e interpretación
- Correcta formulación de hipótesis e interpretación del p-valor
- Uso correcto de `cut()`, `include.lowest`, `right`
- Uso correcto de `table()`, `addmargins()`, `prop.table()` y `margin`
- Correlación: `cov`, `cor`, `cor.test`, $r^2$ y matriz + visualización
- Export y trazabilidad de resultados
