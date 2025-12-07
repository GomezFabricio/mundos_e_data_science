# Biblia Estadística y de Manipulación de Datos en R (Para IA + RStudio)

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

## 5. Prompting para IA (formato estándar)

### 5.1 Prompt para análisis estadístico
```
Realiza un análisis estadístico completo:
- Identifica tipo de variable
- Calcula media, mediana, moda, varianza, sd
- Genera boxplot e interpreta outliers
- Aplica test de hipótesis adecuado
- Explica regla de decisión
- Devuelve conclusiones simples
```

### 5.2 Prompt para manipulación de datos
```
Dado este dataset, realiza:
- Limpieza y tratamiento de NA
- Selección y filtrado
- Mutaciones y transformaciones
- Agrupaciones y resúmenes
- Exportación final
Usa tidyverse y explica cada paso.
```

## 6. Checklist de Análisis Completo

- ¿Importé y exploré los datos?
- ¿Clasifiqué las variables?
- ¿Calculé estadísticos descriptivos?
- ¿Detecté outliers?
- ¿Elegí correctamente H0, H1 y α?
- ¿Apliqué el test adecuado?
- ¿Interpreté el p-valor correctamente?
- ¿Realicé la decisión estadística?
- ¿Generé una conclusión clara?

---

Esta biblia está diseñada para que cualquier IA pueda usar R para análisis estadístico, limpieza de datos y procesos ETL de manera automatizada y guiada.
