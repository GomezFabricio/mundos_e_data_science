###############################################
### CERTIFICACION UNIVERSITARIA EN DATA SCIENCE
###   MANIPULACIO DE DATOS EN R
###############################################


## Myrian Aguilar, 31 de Enero de 2023 ##

# siempre comienza la sesion limpiando los paneles

rm(list=ls()) # Borrar los datos de entorno cargados en memoria 

setwd("C:/ARRAYANES/MUNDO_E") # Aqui debes indica TU de  directorio de trabajo


# instalando librerias o paquetes-------

install.packages("tidyverse") # instalo el paquete

library(tidyverse) # activo el paquete


tidyverse_packages()

# importar datos desde archivo csv------

# usando funcion read.table()

mis_datos<-read.table("mydata.csv", header = TRUE, sep = ",", dec=",")
mis_datos

#usando la funcion read.csv2
mi_csv<-read.csv2("mydata.csv",header = TRUE,sep = ",", dec=",")


# desde excel-------------------
#install.packages("readxl")     # instalo el paquete
library(readxl)
mi_excel<-read_excel("mydata.xlsx",col_names = TRUE)

# Excel con varias hojas ----------
Datos_salud<- read_excel("Datos_salud.xlsx",sheet=1, col_names = T)


# exploracion de Dataframe-------

 str(mi_csv)  # str()	Devuelve la estructura del dataframe

ncol(mi_csv)  # ncol()	Devuelve el numero de columnas (variables) del dataframe

nrow(mi_csv) # nrow()	Devuelve el numero de filas (observaciones) del dataframe

dim(mi_csv)  # dim()	Devuelve la dimension del dataframe (filas por columnas)

names(mi_csv)  # names() devuelve el nombre de las variables

# cambiar nombre a variable
names(mi_csv)[4]<-"TALLA"

# eliminar variables o columnas
mi_csv [,2] <-NULL      # elimino la columna 2, es decir la variable Peso

datos<-mi_csv[,2:3]   # quiero un recorte de mi dataset

# reordenar variables
mi_csv<-mi_csv[,c(2,3,1)]

# guardar archivos------------
write.table(mi_csv,"mi_csv2205.txt",sep=",",row.names = F)
# row.names=F es para que no incorpore una variable con el nombre de las fila

# datos ausentes--------------

sum(is.na(mi_csv))                # cuantos NA tiene mi DF?
colSums(is.na(mi_csv))               # cantidad de NA por columnas
which(is.na(mi_csv$TALLA == T))            # Donde se encuentran los NA?



# para calcular la media debe ser numerica. Entonces la transformo
mean(mis_datos$TALLa)
mean(mis_datos$TALLa, na.rm = T) # na.rm = TRUE que excluye el valor NA

mean(mi_csv$TALLa)

# Conversion de tipo de datos--------------
# as.numeric	Convierte a tipo numerico
# as.integer	Convierte a tipo entero
# as.character	Convierte a tipo caracter
# as.logical	Convierte a tipo logico o booleano
# as.factor	Convierte a tipo factor
# as.ordered	Convierte a tipo factor ordenado


class(mi_csv$SEXO)      # pido la clase de la variable SEXO

mi_csv$SEXO<-as.factor(mi_csv$SEXO)      # la transformo a factor

class(mi_csv$SEXO)     # verifico

# Dplyr-------

# Las funciones del paquete responden a las siguientes acciones (verbos):

# seleccionar--> select(): devuelve un conjunto de columnas (variables)
# renombrar--> rename(): renombra variables en una conjunto de datos
# filtrar -->filter(): devuelve un conjunto de filas  segÃºn una o varias condiciones lÃ³gicas
# ordenar filas  --> arrange(): reordena filas de un conjunto de datos
# agregar variables/columnas --> mutate(): añade nuevas variables/columnas o transforma variables existentes
# resumir--> summarise() / summarize(): genera resÃºmenes estadisticos de diferentes variables en el conjunto de datos.
# agrupar--> group_by(): agrupa un conjunto de filas seleccionado, en un conjunto de filas de resumen de acuerdo con los valores de una o mÃ¡s columnas o expresiones.


levels(mi_csv$SEXO)      # etiquetas de los niveles

# cambio las etiquetas "femenino" por "Mujer" y "masculino" por "Hombre"

mi_csv$SEXO<-factor(mi_csv$SEXO, labels = c("Mujer","Hombre"))
levels(mi_csv$SEXO)# verifico


# gestion de factores------------
library(forcats)
str(Datos_salud)

class(Datos_salud$Enfermedad)        # veo la clase de la variable Enfermedad

Datos_salud$Enfermedad <- factor(Datos_salud$Enfermedad) # transformo a factor
levels(Datos_salud$Enfermedad)      # vemos los niveles del factor               

Datos_salud$Sexo <- as_factor(Datos_salud$Sexo)
levels(Datos_salud$Sexo)

Datos_salud$Sexo <- fct_recode(Datos_salud$Sexo,  # recodifico
                               Varon="Masculino",  
                               Mujer="Femenino")

levels(Datos_salud$Sexo) # verifico
fct_count(Datos_salud$Sexo) # cuento por nivel del factor

Datos_salud$Civil <- as_factor(Datos_salud$Civil)
levels(Datos_salud$Civil)

# mostrar dentro de una tabla de frecuencia la cantidad de valores perdidos o 
# desconocidos que tenemos de la variable Estado Civil

Datos_salud$Civil <- fct_explicit_na(Datos_salud$Civil,na_level = "Desconocido")
levels(Datos_salud$Civil)


Datos_salud$Esalud <- ordered(Datos_salud$Esalud) 
levels(Datos_salud$Esalud)

Datos_salud$Esalud <- fct_relevel(Datos_salud$Esalud,# ordeno la variable categorica ordinal
                                  "Muy buena", "Buena",
                                  "Regular","Mala", "Muy mala")
levels(Datos_salud$Esalud)


Datos_salud$Ciudad<- as_factor(Datos_salud$Ciudad)
fct_count(Datos_salud$Ciudad) # cuento cuantas por nivel

# hay varias categorias con poca frecuencia, es mejor agruparlas en un "otras/os". 
# Eso lo podemos con la funcion fct_other(). En keep especificamos las variables 
# que deseamos que se conserven y en other_level definimos como queremos que se llamen las otras.

Datos_salud$Ciudad <- fct_other(Datos_salud$Ciudad,
                                keep = "La Plata",
                                other_level = "Otras")
levels(Datos_salud$Ciudad)

Datos_salud$Comorbilidades<- as_factor(Datos_salud$Comorbilidades)
levels(Datos_salud$Comorbilidades)

Datos_salud$Comor_agrupadas <- fct_collapse(Datos_salud$Comorbilidades, # creo nueva variable y las agrupo por patologia
                                            Respiratoria = c("EPOC", "TBC",  
                                                             "Neumonia"),
                                            Digestiva = c("Hepatitis", "Gastritis"),
                                            Circulatorio = c("aterosclerosis", 
                                                             "Hipertensión"))
levels(Datos_salud$Comor_agrupadas)

# trabajar con fechas---------

# de character >>> Date
mi_cumple <-  as.Date("1973-2-2")
mi_cumple
class(mi_cumple)

# el argumento format usa otros formatos para codificar fechas

# operaciones con clase Date
dia1 <- as.Date("25/12/2017", format = "%d/%m/%Y")
dia1

dia2 <- as.Date("20/1/2018", format = "%d/%m/%Y")
dia2 

dias_transc<- dia2 - dia1  # diferencia entre ambos días me da por defecto en días
dias_transc

difftime(dia2, dia1)
difftime(dia2, dia1, units = "weeks")
 
Sys.Date() # fecha actual

# paquete lubridate-----------
#install.packages("lubridate")
library(lubridate)

# extraer dia de la semana
fecha_cumple <- c(mi_cumple = as.Date("Febrero 02, 1973", format = "%B %d, %Y"),
            Luciano = as.Date("Diciembre 14, 2003", format = "%B %d, %Y"),
            Marta = as.Date("15ENERO1998", format = "%d %b %Y"),
            Paola = as.Date('1998-09-15'),
            today = as.Date("2023/01/31"))
fecha_cumple

weekdays(fecha_cumple)

#extraer el mes
months(fecha_cumple)

# que dia de la semana fue el 20 de julio de 1969? (llegada del hombre a la luna)

luna <-  as.Date("1969-07-20")
as.character( luna, format="%A")


# que dia de la semana naciste?
nacimiento<-as.Date("1973-02-02")
as.character(nacimiento,format="%A")

# calcular de mi edad -----------------

FecNac <- as.Date("Febrero 02, 1973", format = "%B %d, %Y")
FecNac

Edad_cal<- (Sys.Date()- FecNac)/365
Edad_cal

Edad_cal<-round((Sys.Date()- FecNac)/365)
Edad_cal

paste("mi edad es:", Edad_cal, "años")

###

# ejercicio 1---------------

Inicio<-as.Date("1914-07-28") #fecha de incio de la Primera Guerra Mundial
Inicio

Fin<-as.Date("1918-11-11")    # fecha de finalizacion de la Primera Guerra Mundial
Fin

difftime(Fin, Inicio, units = "weeks") # casi 224 semanas 


# dataset IRIS-------
data("iris")
# contiene las mediciones en centimetros de las variables longitud (Length) y 
# ancho (Width) de los petalos (Petal) y sepalos (Sepal) de 50 flores de cada una 
# de las 3 especies (Species) del gÃ©nero Iris: Iris setosa, Iris versicolor e Iris virginica


# comienzo con un analisis exploratorio:

str(iris)       # estructura
names(iris)     # nombre de columnas
dim(iris)       # dimensiones

iris %>% select(Sepal.Length, Sepal.Width) # selecciona variables largo y ancho del sepalo

iris %>% select(-Species)    # selecciono todas las variables menos Species

iris %>% select(1,3)     # selecciono columna 1 y 3


# renombranos variables a espanol

iris %>% rename("Especie"= "Species", "Long Sepalo"="Sepal.Length", "Ancho Sepalo"= "Sepal.Width") 

# filtrar solo especie setosa
filter(iris, Species == 'setosa')

# filrar especie setosa o virginica
filter(iris, Species == 'setosa' | Species == 'virginica')

# especie setosa con longitud de sepalo menor a 5 mm
filter(iris, Species == 'setosa', Sepal.Length < 5)

# ordenemos Iris por la variable longitud del petalo (Petal.Length):
iris %>% arrange(Petal.Length) # ascendente por defecto

iris %>% arrange(desc(Petal.Length)) # descendente


# longitud de petalo ascendente y ancho descendente
iris %>% arrange(Petal.Length,desc(Petal.Width) )

# creacion de variables
iris %>%
  mutate(Petal.Shape = Petal.Width / Petal.Length,
         Sepal.Shape = Sepal.Width / Sepal.Length) %>%
  select(Species, Petal.Shape, Sepal.Shape)



########################
### FIN del SCRIPT###
########################
data() # muestra todos los dataset de R base







