###############################################
### CERTIFICACION UNIVERSITARIA EN DATA SCIENCE
###        ANALISIS DE DATOS II
###############################################


## 25 noviembre de 2025 ##

rm(list=ls()) # Borrar los datos de entorno cargados en memoria 

setwd("D:/ARRAYANES/MUNDO_E") # directorio de trabajo de cada estudiante

#install.packages("tiyverse")
library(tidyverse)
library(readxl)


####Test de hipostesis, Ho, H1----

# Para formular una hipótesis en relación a la media poblacional, 
# se debe determinar un valor de prueba (z.test o t.test) dependiendo de la 
# distribución si es normal estandarizada z o t student.

# ¿De qué depende utilizar z o t?

# SI se conoce la desviación estándar de la población σ utilizar z

# Si NO se conoce la desviación estándar de la población σ utilizar t.

# PRUEBA DE HIPOTESIS PARA UNA MEDIA  ----------
# Queremos probar una afirmación con respecto a una media de una población única

# ejemplo 1---------------

#conozco media pero no la desviacion estandar -----------

# verificar si el proceso de llenado de bolsas de cafe con 500 gramos, en una fabrica 
# cumple con las especificaciones de la envoltura, asumiendo una distribucion 
# normal con un nivel de significancia de 5%. Se toman aleatoriamente  diez 
# muestras cada cuatro horas. 

# Ho: mu = 500 gr (el peso medio de llenado con cafe es de 500 gr) 
# (acepto si p-valor > 0.05)

cafe <- c(510, 492, 494, 498, 492,496, 502, 491, 507, 496) 

# no conozca la desviacion estandar, entonces uso t

t.test(cafe, alternative='two.sided',conf.level=0.95, mu=500) # 5% 

#conclusion: Como el p-valor es 30% y mayor que el nivel de significancia 5%, 
#no se rechaza la hipótesis nula, es decir, las evidencias no son suficientes 
#para afirmar que el proceso de llenando no está cumpliendo con lo impreso en 
#la envoltura


t.test(cafe, alternative='less',conf.level=0.95, mu=500) # 5%

t.test(cafe, alternative='two.sided',conf.level=0.90, mu=500) #10%

t.test(cafe, alternative='two.sided',conf.level=0.97, mu=500) #3%

# conclusion? 

#Ejemplo 2 ------
library(readxl)
estudiantes2 <- read_xlsx("estudiantes2.xlsx") # 370 0bservaciones y 6 variables

str(estudiantes2)

summary(estudiantes2) # resumen de todas las variables 

## transformar muchas variables de character a factor juntas-----

# función sapply permite iterar sobre una lista o vector sin necesidad de 
# usar el bucle for 

character_cols <- sapply(estudiantes2, is.character)
estudiantes2[character_cols] <- lapply(estudiantes2[character_cols], as.factor)
str(estudiantes2)

# cambio de etiquetas en la variable sexo

class(estudiantes2$sexo)
levels(estudiantes2$sexo)

estudiantes2$sexo<- factor(estudiantes2$sexo, labels = c("Mujer","Hombre"))

levels(estudiantes2$sexo)

# hacemos un EDA grafico y analítico: puede darnos una idea de la distribucion 
# de probabilidad de la variable altura.

hist(estudiantes2$altura, freq = F)
lines(density(estudiantes2$altura))

### analizo la normalidad de la variable altura (variable cuantitativa, continua)

# shapiro.test-------

# Las hipótesis estadísticas son las siguientes:
  
  #H0: La variable presenta una distribución normal
  #H1: La variable presenta una distribución no normal
  
  #Toma de decisión:
  #p valor > alfa: No rechazar H0 (normal).
  #p valor < alfa: Rechazar H0 (no normal)

# Me pregunto: la variable altura está normalmente distribuida?

# Ho:la variable analizada (altura) presenta distribucion normal   (la acepto si p-valor>0.1)

shapiro.test(estudiantes2$altura)

resultado_shap = shapiro.test(estudiantes2$altura)

if (resultado_shap[2] < 0.1){
  print("rechazo la hipótesis nula")
  print(resultado_shap[2])
}

# la distribucion no es normal, lo cual concuerda con el histograma

# altura segun sexo---- variable continua vs categórica

boxplot(altura ~ sexo, data=estudiantes2, las=1,
        xlab='Sexo', ylab='Altura, cm')

boxplot(altura ~ sexo, data=estudiantes2, las=1,
        xlab='Sexo', ylab='Altura, cm', 
        col=c("pink","lightblue"))


# test de hipostesis para comparacion de medias

#H0: las varianzas son iguales
#H1: las varianzas son diferentes

var.test(estudiantes2$altura ~ estudiantes2$sexo) 

# Prueba de madias para una muestra sin conocer la desviacion estandar ----------

# Ho:las dos medias de la variable altura son mayor o iguales
# H1: la media de la altura de mujeres es menor que la de hombres

#Otra forma de plantear
# H0:la media de hombre - media de mujeres >=0
# H1:la media de hombre - media de mujeres < 0

t.test(data_F$altura,data_M$altura,var.equal = T,alternative = "less")

# recordar: "greater"= mayor, "less"= menor,  "two.sided" = a dos lados
# p-valor= 2.2e-16  < 0.05 rechazo H0 se concluye que las medias no son iguales


 
### Prueba de hipotesis para varianzas iguales --------------

#Ejemplo 3 -------------

# Se realiza un estudio para comparar dos tratamientos que se aplicaran a frijoles 
# crudos con el objetivo de reducir el tiempo de coccion. El tratamiento T1 es a 
# base de bicarbonato de sodio, el T2 es a base de cloruro de sodio. 
# La variable respuesta es el tiempo de coccion en minutos. 

# Me pregunto: ¿ Son las varianzas de los tiempos iguales o diferentes?
# Usar  alfa = 0.05

# comparacion de varianzas

T1 <- c(76, 85, 74, 78, 82, 75, 82) # coccion a base de bicarbonato

T2 <- c(57, 67, 55, 64, 61, 63, 63) # coccion a base de cloruro

# debo explorar si viene de una distribucion normal. 

shapiro.test(T1) #p-valor> 0.1
shapiro.test(T2) # p-valor> 0.1

# Lo puedo hacer graficamente

q1 <- qqnorm(T1, plot.it=FALSE)

q2 <- qqnorm(T2, plot.it=FALSE)

plot(range(q1$x, q2$x), range(q1$y, q2$y), type="n", las=1,
     xlab='cuantiles teoricos', ylab='cuantiles de muestra')

points(q1, pch=19)

points(q2, col="red", pch=19)

qqline(T1, lty='dashed')

qqline(T2, col="red", lty="dashed")

legend('topleft', legend=c('T1', 'T2'), bty='n',  # topleft= arriba a la izquierda
       col=c('black', 'red'), pch=19)

# planteo test de hipotesis:

# Me pregunto: hay alguna variacion segun el tratamientos de cocccion?
  
# Ho=  las varianzas son iguales  (acepto si p-valor > 0.05)
# H1= las varianzas no son iguales

var.test(T1, T2, alternative="two.sided",conf.level=0.95)

# conclusion?

# ¿existe diferencia entre los tiempos de conccion de los dos tratamientos?

# Hago el test para comparar las medias

datos4 <- data.frame(Tratamiento = c(T1, T2), abase=rep(c('Carbonato', 'Cloruro'),each=7))
datos4

boxplot(Tratamiento ~ abase, data=datos4, las=1,
        xlab='A base de ', ylab='Tratamiento para reducir tiempo de coccion')

# planteo hipotesis
# Ho la diferencia de medias es igual a 0, (mu1-mu2=0), 
# la acepto si p-valor>0.05

# Ha la diferencia de medias es diferente de 0, (mu1-mu2!=0)

t.test(x=T1, y=T2, alternative="two.sided", mu=0, 
       paired=FALSE, var.equal=FALSE, conf.level=0.95)

# p-valor( 4.738e-06) < 0.05, entonces acepto la Ha

# conclusion: hay diferencia significativa entre  los dos tratamientos.

# El Tratamiento T1, a base de bicarbonato, presenta mayor tiempo de coccion (media de 78,85).


## Fin del Script ##
####################

####Extra####

# DISTRICUBION NORMAL ESTANDAR Z----- 

# ejemplo --------------- 
# conozco media y la desviacion estandar -----------

# voy a Simular una población y una muestra

# Supongamos que la media de la población es 35 y el desviación estándar (sd) de 3. 
# Usamos la función rnorm() para generar y simular una distribución normal.

N <- 500 # Población
poblacion <- rnorm(n = N, mean = 35, sd = 3)
poblacion

range(poblacion)

# Determinamos los parámetros de población

media.p <- mean(poblacion)
media.p
desv.p <- sd(poblacion)
desv.p

# obtener 30 elementos como muestra a partir de esa población generada.

n <- 30 # mi muestra
muestra <- sample(x = poblacion, size = 30, replace = FALSE) 
muestra

# cuidado con la funcion sample() cambian los valores cada vez que corro el código

# Determinamos los estadísticos de la muestra

media.m <- mean(muestra)
media.m
desv.m <- sd(muestra)
desv.m

# Pongamos esto en un data.frame, es decir, hacemos una tabla

tabla <- data.frame(Nn = c(N, n), "medias" = c(media.p, media.m), "desv.std" = c(desv.p, desv.m))
rownames(tabla) <- c("Población", "Muestra")
tabla

# Nos preguntamos: ¿es la media aritmética es diferente de 35?

# Entonces la H0: la media es igual a 35 a un 95% de confianza 
#   H0:μ=35     Ha:μ≠35

#install.packages("BSDA") # para z.test()
library(BSDA)

prueba_hip <- z.test(x = muestra, alternative = "two.sided", 
                     mu = media.m, 
                     sigma.x = desv.m, 
                     sigma.y = desv.p, 
                     conf.level = 0.95)

prueba_hip

#El valor de la media debe estar en el intervalo 34.58522 y 37.30463 en un 95% 
# de nivel de confianza, habiendo hecho la prueba de dos colas (two.sided).

# Ahora me pregunto: ¿la media es menor que 35?

# Entonces H0: la media es mayor o igual que 35
#   H0:μ≥35   Ha:μ<35

prueba_hip <- z.test(x = muestra, alternative = "less", 
                     mu = media.m, 
                     sigma.x = desv.m, 
                     sigma.y = desv.p, 
                     conf.level = 0.95)
prueba_hip




