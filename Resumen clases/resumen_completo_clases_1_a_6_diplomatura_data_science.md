# Resumen completo – Diplomatura en Data Science (Clases 1 a 6)

Este documento resume **todo lo aprendido hasta la Clase 6**, de forma clara, estructurada y orientada a trabajar con **R + IA**, no a memorizar código sin sentido.

---

## CLASE 1 – Introducción a la Ciencia de Datos

### 1. ¿Qué es Data Science?
La Ciencia de Datos es la disciplina que combina:
- Estadística
- Programación
- Conocimiento del dominio
- Comunicación

para **extraer conocimiento a partir de datos**.

### 2. Tipos de análisis
- **Descriptivo**: qué pasó
- **Diagnóstico**: por qué pasó
- **Predictivo**: qué puede pasar
- **Prescriptivo**: qué debería hacerse

### 3. Rol de R en la diplomatura
R se utiliza como:
- Herramienta de análisis estadístico
- Lenguaje para exploración de datos
- Plataforma para prototipos rápidos

No se busca ser programador experto, sino **saber qué pedirle a R (o a la IA usando R)**.

---

## CLASE 2 – Programación para la Ciencia de Datos (R básico)

### 1. R y RStudio
- **R**: lenguaje
- **RStudio**: entorno de trabajo

Componentes clave:
- Console
- Script (.R)
- Environment
- Plots / Files / Packages

### 2. Tipos de datos básicos

```r
numeric
integer
character
logical
```

Ver tipo:
```r
class(x)
```

### 3. Estructuras de datos

#### Vectores
```r
x <- c(1, 2, 3)
```

#### Matrices
```r
m <- matrix(1:6, nrow = 2)
```

#### Data Frames (los más importantes)
```r
df <- data.frame(edad = c(20, 25), peso = c(70, 80))
```

### 4. Operaciones básicas
```r
x + 1
x * 2
x[x > 2]
```

### 5. Funciones

```r
mean(x)
sum(x)
length(x)
```

Funciones propias:
```r
mi_funcion <- function(x) {
  mean(x)
}
```

---

## CLASE 3 – Manipulación de Datos en R

### 1. Importación de datos

```r
read.csv("datos.csv")
read.table()
```

Excel:
```r
library(readxl)
read_excel("archivo.xlsx")
```

### 2. Exploración inicial

```r
head(df)
str(df)
summary(df)
```

### 3. Limpieza de datos

Valores faltantes:
```r
is.na(df)
na.omit(df)
```

Reemplazo:
```r
df$edad[is.na(df$edad)] <- mean(df$edad, na.rm = TRUE)
```

Duplicados:
```r
df <- distinct(df)
```

### 4. dplyr (librería clave)

```r
library(dplyr)
```

Funciones principales:

```r
select()
filter()
mutate()
arrange()
group_by()
summarise()
```

Ejemplo:
```r
df %>%
  group_by(sexo) %>%
  summarise(promedio = mean(edad))
```

---

## CLASE 4 – Estadística Descriptiva

### 1. Medidas de tendencia central

- **Media**
```r
mean(x)
```

- **Mediana**
```r
median(x)
```

- **Moda** (no existe nativa)

### 2. Medidas de dispersión

- Varianza
```r
var(x)
```

- Desviación estándar
```r
sd(x)
```

- Rango
```r
range(x)
```

- IQR
```r
IQR(x)
```

### 3. Visualización

```r
hist(x)
boxplot(x)
plot(x, y)
```

Outliers se detectan visualmente con boxplot.

---

## CLASE 5 – Inferencia Estadística y Test de Hipótesis

### 1. Hipótesis

- **H0 (hipótesis nula)**: afirmación inicial
- **H1 (alternativa)**: lo que queremos probar

Ejemplo:
> H0: la media es 50

### 2. Nivel de significancia (α)

- Lo define el analista
- Valores comunes: 0.05, 0.01

Representa el riesgo aceptado de equivocarse.

### 3. p-valor

El p-valor indica:
> Qué tan raro sería obtener una muestra como la observada **si H0 fuera verdadera**.

No es:
- la probabilidad de que H0 sea verdadera

### 4. Regla de decisión

- Si p < α → se rechaza H0
- Si p ≥ α → no se rechaza H0

### 5. Test t

```r
t.test(x, mu = 50)
```

R devuelve:
- estadístico
- p-valor
- intervalo de confianza

---

## CLASE 6 – Correlación y Causalidad

### 1. Correlación

Mide **asociación**, no causa.

Coeficiente entre -1 y 1:
- positivo
- negativo
- nulo

### 2. Tipos de correlación

#### Pearson
Relación lineal
```r
cor(x, y, method = "pearson")
```

#### Spearman
Relación monotónica
```r
cor(x, y, method = "spearman")
```

#### Kendall
```r
cor(x, y, method = "kendall")
```

### 3. Test de correlación

```r
cor.test(x, y)
```

Hipótesis:
- H0: no hay correlación

Interpretación igual que en test t.

### 4. Correlación vs causalidad

- Correlación ≠ causa
- Puede haber variables ocultas
- Coincidencias

Para causalidad se requieren experimentos o diseños controlados.

---

## CIERRE GENERAL

Hasta este punto aprendiste:

- Qué es Data Science
- Cómo usar R como herramienta
- Importar, limpiar y transformar datos
- Calcular estadísticos descriptivos
- Aplicar inferencia estadística
- Interpretar p-valor y α correctamente
- Analizar correlaciones sin caer en errores conceptuales

Este conocimiento es suficiente para:
- análisis exploratorios
- informes estadísticos básicos
- preparar datasets
- trabajar con IA como copiloto analítico

---

**Estado actual:** Clases 1 a 6 COMPLETADAS

