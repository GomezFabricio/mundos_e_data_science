###############################################
### CERTIFICACION UNIVERSITARIA EN DATA SCIENCE
###   MANIPULACIO DE DATOS EN R
###############################################


## Myrian Aguilar, 11 de noviembre de 2025 ##

# siempre comienza la sesion limpiando los paneles

rm(list=ls()) # Borrar los datos de entorno cargados en memoria 

setwd("D:/ARRAYANES/MUNDO_E") # Aqui debes indica TU de  directorio de trabajo

#instalando librerias o paquetes-------

#install.packages("tidyverse") # para instalarlo hay que savar el # 

library(tidyverse) # activo el paquete

tidyverse_packages() # indica que paquete instalo del ecosistema Tidyverse



# importar datos desde archivo csv------

## usando funcion read.table()

mis_datos <-read.table("mydata.csv", header = TRUE, sep = ",", dec=",")
mis_datos
?read.table


#usando la funcion read.csv2

mi_csv<-read.csv2("mydata.csv",header = TRUE,sep = ",", dec=",")

# desde excel-------------------
#install.packages("readxl")     # instalo el paquete
library(readxl)

mi_excel<-read_excel("mydata.xlsx")
mi_excel

# Excel con varias hojas ----------
Datos_salud<- read_excel("Datos_salud.xlsx",sheet=1, col_names = T)

# Operaciones basicas con del DF -------

str(mi_csv)  # str()	Devuelve la estructura del dataframe
class(mi_excel$EDAD)
ncol(mi_csv) # ncol()	Devuelve el numero de columnas (variables) del dataframe

nrow(mi_csv) # nrow()	Devuelve el numero de filas (observaciones) del dataframe

dim(mi_csv)  # dim()	Devuelve la dimension del dataframe (filas por columnas)

names(mi_csv)  # names() devuelve el nombre de las variables

## cambiar nombre a variable------
View(mi_csv) # vista de mi DF
names(mi_csv)[4]<-"TALLA"

## eliminar variables o columnas------
mi_csv [,2] <-NULL      # elimino la columna 2, es decir la variable Peso

datos1 <- mi_csv[,2:3]   # quiero un recorte de mi dataset
datos1

## reordenar variables
mi_csv3<-mi_csv[,c(2,1,3)]
mi_csv4<-mi_csv[,c(3,1)]
# guardar archivos---------

write.table(mi_csv,"mi_csv2504.txt",sep=",",row.names = F)

# row.names=F es para que no incorpore una variable con el nombre de las fila

# datos ausentes --------------

sum(is.na(mi_csv))                # cuantos NA tiene mi DF?
colSums(is.na(mi_csv))               # cantidad de NA por columnas
which(is.na(mi_csv$TALLA == T))            # Donde se encuentran los NA?
which(is.na(mi_csv$SEXO == T))
# reemplazr NA por el valor de la media

# para calcular la media debe ser numerica. Entonces la transformo
mean(mis_datos$TALLa)
mean(mis_datos$TALLa, na.rm = T) # na.rm = TRUE que excluye el valor NA
mis_datos[16,4]<-1.68    # cambio el valor NA por 1.68

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
levels(mi_csv$SEXO)

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

summary(mi_csv$TALLA)


# gestion de factores ------------

library(forcats)
str(Datos_salud)

class(Datos_salud$Enfermedad)        # veo la clase de la variable Enfermedad

Datos_salud$Enfermedad <- factor(Datos_salud$Enfermedad) # transformo a factor
levels(Datos_salud$Enfermedad)      # vemos los niveles del factor               

Datos_salud$Sexo <- as_factor(Datos_salud$Sexo)
levels(Datos_salud$Sexo)

Datos_salud$Sexo <- fct_recode(Datos_salud$Sexo,  # recodifico
                               Varon="Masculino",  # donde dice MAsculino cambio por varon
                               Mujer="Femenino")   # donde dice Femenino cambio por Mujer
levels(Datos_salud$Sexo)

levels(Datos_salud$Sexo) # verifico
fct_count(Datos_salud$Sexo) # cuento por nivel del factor

Datos_salud$Civil <- as_factor(Datos_salud$Civil)
levels(Datos_salud$Civil)
table(Datos_salud$Civil)
fct_count(Datos_salud$Civil)

# mostrar la cantidad de valores perdidos o 
# desconocidos que tenemos de la variable Estado Civil

Datos_salud$Civil <- fct_explicit_na(Datos_salud$Civil,na_level = "Desconocido")
levels(Datos_salud$Civil)

table(Datos_salud$Civil)

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
fct_count(Datos_salud$Ciudad)

Datos_salud$Comorbilidades<- as_factor(Datos_salud$Comorbilidades)
levels(Datos_salud$Comorbilidades)

Datos_salud$Comor_agrupadas <- fct_collapse(Datos_salud$Comorbilidades, # creo nueva variable y las agrupo por patologia
                                            Respiratoria = c("EPOC", "TBC",  
                                                             "Neumonia"),
                                            Digestiva = c("Hepatitis", "Gastritis"),
                                            Circulatorio = c("aterosclerosis", 
                                                             "Hipertensión"))
levels(Datos_salud$Comor_agrupadas)
table(Datos_salud$Comor_agrupadas)


########################
### FIN del SCRIPT###
########################

# activar un dataset incorporado en R-----------

data() # muestra todos los dataset de R base

# Trabajar con datasets incorporadas en R u otros paquetes ----

?datasets::Titanic # pedimos descripcion del dataset. Datos de pasajeros del Titanic
ds_titanic <- as.data.frame(Titanic)

?datasets::sleep  # estudio en 10 pacientes con droga que alarga horas de sueño

?datasets::mtcars # Revista Motor Trend US de 1974. Muestra consumo de combustible 
# y 10 aspectos del diseño y rendimiento del automóvil para 32 automóviles 


datos<-iris # dataset de R para fines practicos






