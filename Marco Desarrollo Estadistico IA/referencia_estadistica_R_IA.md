# Biblia Estadística y de Manipulación de Datos en R (Para IA + RStudio)

## Tabla de Contenidos
- [0. Guía Rápida para IA](#0-guía-rápida-para-ia)
- [1. Fundamentos Estadísticos](#1-fundamentos-estadísticos)
- [2. Inferencia Estadística](#2-inferencia-estadística)
- [3. Manipulación de Datos (Tidyverse + Base R)](#3-manipulación-de-datos-tidyverse--base-r)
- [4. Flujo ETL en R](#4-flujo-etl-en-r)
- [5. Correlación y Causalidad](#5-correlación-y-causalidad)
- [Plantillas de Prompting para IA](#plantillas-de-prompting-para-ia)
- [6. Checklist Integral de Proyecto](#6-checklist-integral-de-proyecto)
- [7. Notas Operativas y Buenas Prácticas](#7-notas-operativas-y-buenas-prácticas)

## 0. Guía Rápida para IA

Esta biblia se usa junto con `vision.md` (objetivo del negocio), `aieye.md` (observaciones del analista) y las fuentes de datos que documentan los diccionarios de variables. El flujo recomendado para cualquier proyecto estadístico con R es:

1. **Definir el objetivo**: resume el problema y la métrica de éxito en `vision.md`.
2. **Inventariar datos**: enlaza fuentes, claves y supuestos en `aieye.md` y en la carpeta `data/`.
3. **Configurar entorno**: carga librerías críticas antes de cualquier script.
4. **Explorar y limpiar**: aplica secciones 1-3 de esta biblia.
5. **Modelar y validar**: usa pruebas de la sección 2 y correlaciones de la sección 5.
6. **Comunicar y automatizar**: apóyate en las plantillas de prompting y en el checklist integral.

```r
pacman::p_load(tidyverse, readxl, lubridate, corrplot, EnvStats)
set.seed(123)
```

Opcional (recomendado para scripts “desde cero”): limpiar el entorno y definir directorio de trabajo.

```r
rm(list = ls())  # Borrar objetos del entorno

# Define tu directorio de trabajo (mejor si usas RStudio Projects)
setwd("D:/ARRAYANES/MUNDO_E")
```

Documenta cada decisión clave (supuestos, variables descartadas, parámetros) para que la IA pueda encadenar scripts y reproducir el análisis en nuevos datasets.

## 1. Fundamentos Estadísticos

### 1.1 Media
**Definición:** Promedio de los valores.
**R:**
```r
mean(x)
```

### 1.2 Mediana
Valor central de los datos ordenados.
```r
median(x)
```

### 1.3 Moda
Valor más frecuente (R no tiene función base).
```r
mode_val <- function(x) { ux <- unique(x); ux[which.max(tabulate(match(x, ux)))] }
mode_val(x)
```

### 1.4 Varianza
Medida de dispersión.
```r
var(x)
```

### 1.5 Desviación estándar
Raíz de la varianza.
```r
sd(x)
```

### 1.6 Rango e IQR
```r
range(x)
IQR(x)
```

### 1.7 Outliers
Detectados por boxplot.
```r
boxplot(x)
```

## 2. Inferencia Estadística

### 2.1 Hipótesis
- **H0:** afirmación inicial.
- **H1:** alternativa.

### 2.2 Nivel de significancia α
Valor definido por el analista (ej: 0.05).

### 2.3 p-valor
Probabilidad de obtener datos igual o más extremos asumiendo que H0 es verdadera.

### 2.4 Regla de decisión
- Si `p < α` ⇒ Rechazar H0
- Si `p ≥ α` ⇒ No rechazar H0

### 2.5 Test t de una media
```r
t.test(x, mu = 50)
```

### 2.6 Test t de dos muestras
```r
t.test(x, y)
```

### 2.7 Test de varianza
```r
library(EnvStats)
varTest(x, sigma.squared = 25)
```

## 3. Manipulación de Datos (Tidyverse + Base R)

### 3.1 Importación

#### CSV
```r
df <- read.csv("archivo.csv")
```

#### Excel
```r
library(readxl)
df <- read_excel("archivo.xlsx")
```

### 3.2 Exportación
```r
write.csv(df, "salida.csv", row.names = FALSE)
saveRDS(df, "datos.rds")
```

### 3.3 Exploración
```r
head(df)
str(df)
summary(df)
```

### 3.4 Limpieza
Reemplazar NA:
```r
df$col[is.na(df$col)] <- mean(df$col, na.rm = TRUE)
```
Eliminar NA:
```r
df <- na.omit(df)
```
Duplicados:
```r
df <- distinct(df)
```

### 3.5 Transformación (dplyr)
```r
library(dplyr)

df %>% select(col1, col2)
df %>% filter(col > 10)
df %>% arrange(desc(col))
df %>% mutate(nueva = col * 2)
df %>% group_by(cat) %>% summarise(prom = mean(valor))
```

### 3.6 Manejo de fechas
```r
library(lubridate)
df$fecha <- ymd(df$fecha)
df$anio <- year(df$fecha)
df$mes <- month(df$fecha)
```

### 3.7 Agrupar (binning) con `cut()`

`cut()` divide una variable numérica en intervalos (bins).

Parámetros clave:
- `breaks`: un número (n bins iguales) o un vector con los puntos de corte.
- `right`: por defecto `TRUE` (intervalos cerrados a la derecha y abiertos a la izquierda: (a, b]). Si `FALSE`: [a, b).
- `include.lowest`: incluye el valor más extremo del primer intervalo.

Ejemplos:

```r
# ejemplo con secuencia de cortes
range(datos$EDAD)

# `right = TRUE` (default): (a,b] y por eso el valor mínimo puede quedar fuera
datos$GRUPO <- cut(
	datos$EDAD,
	breaks = seq(20, 35, by = 3),
	include.lowest = TRUE
)

datos$GRUPO1 <- cut(
	datos$EDAD,
	breaks = seq(20, 35, by = 3),
	include.lowest = FALSE
)

# ejemplo simple para ver el efecto de include.lowest
cut(1:10, right = TRUE, breaks = c(1, 5, 10))
cut(1:12, right = TRUE, breaks = c(1, 5, 10), include.lowest = TRUE)

# si right = FALSE: [a,b) (cerrado a la izquierda)
cut(1:10, right = FALSE, breaks = c(1, 5, 10))
```

### 3.8 Tablas de contingencia con `table()` + proporciones

`table()` construye tablas de frecuencia cruzada entre variables categóricas.

```r
# ejemplo: cualitativa vs cualitativa
datos <- read.csv2("mydata.csv", header = TRUE, sep = ",", dec = ",")

datos$SEXO <- as.factor(datos$SEXO)
levels(datos$SEXO)

tabla2 <- table(datos$GRUPO, datos$SEXO)
tabla2

# invertir orden (solo cambia la forma de leer la tabla)
table(datos$SEXO, datos$GRUPO)

# sumatorias marginales (totales por filas y columnas)
tabla1 <- addmargins(tabla2)
tabla1

# proporciones (sobre el total)
prop.table(tabla2)

# porcentajes por fila (margin = 1 => denominador: total de la fila)
round(100 * prop.table(tabla2, margin = 1), 2)

# porcentajes por columna (margin = 2 => denominador: total de la columna)
round(100 * prop.table(tabla2, margin = 2), 2)

# guardar resultados
tablacontingencia <- round(100 * prop.table(tabla2, margin = 2), 2)
write.table(tablacontingencia, "tablacontingencia.txt", sep = ",", row.names = FALSE)
write.csv(tablacontingencia, "tablacontingencia.csv")
```

### 3.9 Resumen por grupos: `tapply()`, `by()` y `aggregate()`

```r
## VARIABLE CUANTITATIVA vs CUALITATIVA
tapply(datos$PESO, datos$SEXO, mean, na.rm = TRUE)
tapply(datos$PESO, datos$GRUPO, max, na.rm = TRUE)

by(datos$PESO, datos$SEXO, mean)  # similar a tapply, salida distinta

aggregate(PESO ~ SEXO, data = datos, FUN = mean)

# múltiples variables categóricas
aggregate(PESO ~ GRUPO + SEXO, data = datos, mean)
aggregate(PESO ~ SEXO + GRUPO, data = datos, mean)
```

## 4. Flujo ETL en R

### 4.1 Extracción
Leer múltiples archivos:
```r
files <- list.files("data/", full.names = TRUE)
lapply(files, read.csv)
```

### 4.2 Transformación
- Limpieza
- Normalización
- Unificación de tipos

### 4.3 Carga
Exportar a CSV/SQL/Parquet:
```r
write.csv(df, "final.csv")
```

## 5. Correlación y Causalidad 

### 5.1 Conceptos Fundamentales
- La correlación mide asociación (no causalidad).
- r ∈ [-1,1] indica relación negativa, sin relación o positiva.
- Métodos más usados: Pearson, Spearman y Kendall.

### 5.2 Pearson, Spearman y Kendall en R
```r
cor(x, y, method = "pearson")
cor(x, y, method = "spearman")
cor(x, y, method = "kendall")
```

### 5.3 Test de Hipótesis para Correlación
- H0: ρ = 0 (no hay correlación).
- H1: ρ ≠ 0.
- Regla: si p < α se rechaza H0.

```r
cor.test(x, y)
cor.test(x, y, method = "spearman")
```

### 5.4 Gráficos
```r
plot(x, y)
library(corrplot)
corrplot(cor(df), method = "color")
```

### 5.5 Causalidad
- Correlación no implica causalidad.
- Considerar variables confusoras, ocultas o correlaciones espurias.
- Para inferir causalidad se necesitan diseños experimentales y temporalidad clara.

### 5.6 Covarianza y correlación (cuantitativa vs cuantitativa)

```r
# covarianza (R base)
cov(datos$PESO, datos$EDAD)
cov(datos$EDAD, datos$PESO)

# coeficiente de correlación (R base)
cor(datos$PESO, datos$EDAD)
```

Notas:
- `cov()` indica cómo varían conjuntamente dos variables respecto a sus medias.
- `cor()` devuelve $r \in [-1,1]$ (dirección e intensidad de asociación).

### 5.7 Test de hipótesis para correlación (`cor.test`) y $r^2$

```r
test_cor <- cor.test(datos$PESO, datos$EDAD, method = "pearson")
test_cor

# r^2 (coeficiente de determinación) = porcentaje de variación explicada en un modelo lineal simple
r <- unname(test_cor$estimate)
r2 <- r^2
r2
```

### 5.8 Matriz de correlación (ejemplo con `mtcars`) + visualización

```r
data("mtcars")

my_data <- mtcars[, c(1, 3, 4, 5, 6, 7)]
head(my_data, 8)

matriz1 <- cor(my_data)
matriz1
round(matriz1, 2)

# 1) symnum(): reemplaza coeficientes por símbolos
symnum(matriz1, abbr.colnames = FALSE)
symnum(matriz1, abbr.colnames = TRUE)

# 2) corrplot(): correlograma
# install.packages("corrplot")
library(corrplot)

corrplot(matriz1, method = "circle")
corrplot(matriz1, method = "number")
corrplot(matriz1, type = "upper")
corrplot(matriz1, type = "upper", order = "hclust")

# paletas
# install.packages("RColorBrewer")
library(RColorBrewer)

paleta <- colorRampPalette(c("red", "white", "blue"))(20)
corrplot(matriz1, type = "upper", order = "hclust", col = paleta)

corrplot(matriz1, type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "RdBu"))
```





## Plantillas de Prompting para IA

Estas plantillas describen pasos, no solo resultados. Inserta siempre: objetivo, dataset, ruta de salida y librerías deseadas.

### Diagnóstico estadístico completo
```
Analiza este dataset paso a paso:
- Identifica el tipo de cada variable y posibles escalas.
- Calcula media, mediana, moda, varianza y desviación estándar cuando aplique.
- Genera un boxplot por variable numérica e interpreta outliers.
- Selecciona y ejecuta el test de hipótesis adecuado (explica la elección).
- Define H0, H1, α y la regla de decisión.
- Resume hallazgos en lenguaje sencillo y vincula con el objetivo de negocio.
```

### Manipulación y ETL en tidyverse
```
Con el dataset indicado realiza:
- Limpieza y tratamiento explícito de NA (imputación vs. descarte).
- Selección y filtrado con criterios justificados.
- Mutaciones/transformaciones necesarias para el modelo.
- Agrupaciones y resúmenes clave.
- Exporta el resultado (CSV/RDS) indicando ruta y columnas clave.
Describe cada paso y al final lista las decisiones asumidas.
```

### Flujo end-to-end para IA
```
Usa la biblia estadística junto con vision.md, aieye.md y las fuentes de datos para:
- Validar que el objetivo esté claro y que existan datos suficientes.
- Encadenar exploración (sección 1-3), pruebas (sección 2 y 5) y ETL (sección 4).
- Generar un reporte final con: contexto, metodología, resultados, riesgos y próximos pasos.
- Documentar supuestos, rutas de archivos y librerías en comentarios reproducibles.
```

## 6. Checklist Integral de Proyecto

### 7.1 Descubrimiento y calidad de datos
- ¿Importaste y exploraste todas las fuentes descritas en `vision.md` y `aieye.md`?
- ¿Clasificaste variables por tipo y escala?
- ¿Documentaste valores faltantes, duplicados y outliers críticos?

### 7.2 Estadísticos, inferencia y validación
- ¿Calculaste estadísticos descriptivos clave?
- ¿Definiste correctamente H0, H1 y α antes de correr pruebas?
- ¿Elegiste y justificaste cada test (t, varianza, correlación)?
- ¿Interpretaste el p-valor y la magnitud del efecto (no solo si es significativo)?

### 7.3 Correlación y causalidad
- ¿Seleccionaste el método de correlación apropiado?
- ¿Revisaste outliers que puedan distorsionar r?
- ¿Combinaste r, p-valor y gráficos antes de concluir?
- ¿Anotaste posibles confusores o variables omitidas?

### 7.4 Comunicación y entrega
- ¿Generaste datasets finales y rutas claras (`data/processed/`)?
- ¿Incluiste scripts o notebooks reproducibles (semillas, versiones)?
- ¿Resumiste hallazgos, riesgos y próximos pasos en términos de negocio?
- ¿Sincronizaste conclusiones con `vision.md` para cerrar el loop?

## 7. Notas Operativas y Buenas Prácticas

- **Librerías base**: `tidyverse`, `readxl`, `lubridate`, `corrplot`, `EnvStats`. Usa `pacman::p_load` para asegurar instalación.
- **Estructura de carpetas**: `data/raw`, `data/processed`, `reports/`, `scripts/`. Referencia rutas relativas para portabilidad.
- **Semillas y reproducibilidad**: fija `set.seed()` y registra versión de R y paquetes (`sessionInfo()` o `renv::snapshot()`).
- **Nomenclatura**: nombres snake_case, columnas descriptivas, fechas en ISO-8601.
- **Trazabilidad**: cada transformación relevante debe citar la fuente de datos y el motivo; guarda logs o comentarios para que la IA pueda continuar el hilo en nuevos proyectos.

---

Esta biblia, en conjunto con `vision.md`, `aieye.md` y las fuentes de datos, permite que cualquier IA encadene exploración, inferencia, limpieza, correlación y entrega final en proyectos de ciencia de datos con R.
