###############################################
### CERTIFICACIÓN UNIVERSITARIA EN DATA SCIENCE

##  PROGRAMACIÓN PARA LA CIENCIA DE DATOS I

## Prof. Myrian Aguilar, 4 de noviembre de 2025 ##

###############################################

rm(list=ls())# Borrar los datos de entorno cargados en memoria

# Conociendo y personalizando R Studio----


## script, comentarios, asignacion ----

   # Un script es un archivo que contiene un listado secuencial de lineas de codigo. 
   # Debe estar ordenado

   # Todo lo escrito luego de un # es entendido como un COMENTARIO y no será tenido 
   # en cuenta cuando se ejecute el código.

   # La combinación del signo menor con el guión medio ( <- ) es llamado el símbolo de asignación

## asignando directorio----

# aqui debes indica TU de  directorio de trabajo

setwd("D:/NOTEBOOK-HP/ARRAYANES")# cambiar a su directorio personal

getwd() # verifico cual es directorio de trabajo. Lo veo en la consola


# OPERADORES EN R ----
 
## OPERADORES ARITMETICOS- R como calculadora: -----------

5 + 2
2 / 3
5 ^ 2
((10-3)*(4+8)) ^ 3

## OPERADORES RELACIONALES--------

  # Son simbolos mediante los cuales podemos realizar operaciones. 
  # Como resultado obtenemos objetos de clase logical. Pueden adoptar los valores TRUE o FALSE

8 > 1 # (8 es mayor que 1?)
3 < 2 # (3 es menor que 2?)
3 == 2 # (3 es igual a 2?)
7 == 7 # (7 es igual a 7?)
5 != 5 # (5 es distinto de 5?)


# OBJETOS ----

## Variables u Objetos. Asignaciones (<-) ----

casa <- 2
casa
y = 3
 #Siempre hay diferentes maneras de lograr el mismo resultado:

x = 3
x
X # no lo encuentra porque lo pedimos en mayuscula
Y<-5

# OPERADORES LOGICOS---------

m <- 10:15 # un vector
p <- c(10,11,12,13,14,15)
t <- 16:11
t
n<-c(0,1,2,3,4)
n<- 0:5
m <- 234

m ==p   # Compara dos vectores, es decir, cada elemento de 'm' con el de 'p'


# TIPS para nombrar objetos-------

   # Se pueden usar combinaciones de letras, numeros y algunos 
   # simbolos, como el punto . , el guion medio - y el guion bajo _ .
   # Los nombres no pueden comenzar con un numero.
   # R distingue minisculas de mayusculas. Por ejemplo: Casa y casa pueden ser 2 variables distintas
   # R tiene una lista de nombres y simbolos reservados que no pueden utilizarse 
   # para crear nuevos objetos. Por ejemplo: "function", "if", !

## TIPOS DE DATOS que puede contener un Objeto ----

# Los tipos de datos más comúnmente incluídos en los objetos son de tipo:
# numeric, character (string), factor (categorical) y lógica (TRUE/FALSE)

### Datos numéricos: ----

x <- 5
x
class(t) # Función para chequear el tipo de dato que contiene el objeto.

### Datos de tipo character o cualitativos: ----

palabra <- "Aprendiendo a usar R"
palabra
class(palabra)

# TIPO DE OBJETOS-------

dato1 <- 24 # al objeto llamado dato1 le asigno el valor 24
dato1       # lo llamo, es decir verifico, le pido que me lo muestre

datos2 <- dato1 * 234 # puedo hacer calculos con operadores arirmeticos
datos2
24*234

## VECTORES--------

# Colección de elementos, todos del mismo tipo (ejemplo, elementos numéricos o de tipo character), y que mantienen un orden determinado.

mis_datos <- c(2, 5, 6, 7, 2) # la función "c()" se utiliza para combinar los elementos en un vector. 
mis_datos

mis_datos2 <- -2:2 # atajo para crear un vector con valores consecutivos.
mis_datos2

# Para averiguar la longitud del vector (cantidad de elementos), usamos la función lenght():

length(mis_datos)

length(mis_datos3)

# Para acceder a los elementos individuales de un vector se usan los corchetes "[ ]":

mis_datos[2] # el elemento del vector que está en el segundo lugar.

mis_datos[1:2] # los primeros dos elementos.
mis_datos[c(3,5)] # para elementos no consecutivos: el que está en tercer y quinto lugar. 

mis_datos4<-mis_datos[c(3,5)]
mis_datos4
mis_datos


### Operaciones con Vectores ----  

mis_datos * 2 # al ser R un lenguaje vectorizado, la operación se realiza para cada 
           #elemento del vector de manera automática sin necesidad de crear un loop o ciclo.

# Si tengo dos vectores de igual tamaño (o de distinto tamaño pero siendo el vector
 #de mayor tamaño múltiplo del de menor tamaño): 

mis_datos + mis_datos2


# Clase de Objeto: DATA FRAME----

# grupo de vectores ordenados en forma tabular, donde cada vector conforma una columna del dataframe

## creacion de un DF

# creamos 4 vectores con 4 valores cada uno

id <- 1:4          
edad <- c(28, 43, 12,65)
sexo <- c("M", "F", "F", "M")
trabaja <- c(T, T, F, F)
trabaja
datos <- data.frame( id, edad, sexo, trabaja)
datos

class(datos) # verifico la clase de objeto
str(datos) # miro estructura del conjunto de datos

datos$sexo # selecciono la variable sexo del DF. se trata de un factor, 
          # veremos aparecer sus niveles.

datos[1,2] # indexamos, [FILAS,COLUMNAS]

# combinacion de Dataframe-----

id <- 1:5
edad <- c(37, 45, 52, 25, 32)
sexo <- c("F", "F", "F", "M", "M")
trabaja <- c(T, F, T, F, F)

datos_nuevos <- data.frame( id, edad, sexo, trabaja)
datos_nuevos

datos_todos <- rbind(datos, datos_nuevos) # union de los dos Df
datos_todos                               # verifico

View(datos_nuevos)

# agregar columna a DF----
estudia <- c(T, F, T, F, F, T, T, F, NA) #  creo la nueva variable

datos_estudia <- cbind(datos_todos, estudia)# union del Df y la nueva variable
datos_estudia2 <- cbind(estudia,datos_todos, estudia)
head(datos_estudia) # miro ( encabezado) los primeros valores

##########################
# el resto del código se los dejo para que lo interpreten solos y anoten sus 
# dudas para la proxima clase

# funciones-----

# Una función puede entenderse como un conjunto de operaciones sistematizadas.
# La función necesita datos de entrada y devuelve una salida o conjunto de salidas/resultados.

class(vector) # funcion class() me dice la clase de atributo del objeto
class(vector2)

x <- seq( from = 1, to = 100, by = 3) # funcion seq(), secuencia de numeros
x

y <- seq( from = 1, to = 6, length = 4) # lenght divide el intervalo en segmentos iguales
y

yy <- seq( from = 1, to = 6, length = 3)
yy

z <- rep("casa", time=30) # rep() crea un vector repitiendo el numero o caracter
z          


### Datos de tipo factor o categóricos: ----

# Los niveles de un factor son los valores únicos contenidos en el vector.

dias_v <- c("lunes", "martes", "miércoles", "jueves", "viernes", "lunes", "viernes") 
# esto es un vector
dias_v
class(dias_v)

dias_t <- factor(dias_v, levels = c("lunes", "martes", "miércoles", "jueves", "viernes"))
dias_t

# Otro ejemplo, datos nominales:

genero_v <- c("masculino", "femenino", "no binario")
genero_v

genero_f <- factor(genero_v)
genero_f
class(genero_f)

# Clase de objeto: LISTA----

   # Lista: coleccion ordenada de otros objetos, llamados componentes de la lista

milista <- list(numeros = 1:5,
                ciudades = c("Buenos Aires", "Rosario", "Neuquen"))
milista

familia <- list(padre = "Juan", 
                madre = "Maria",
                numero.hijos = 3,
                nombre.hijos = c("Luis", "Carlos", "Paola"),
                edades.hijos = c(7, 5, 3),
                ciudad = "La Plata")
familia

names(familia) # obtengo vector con nombre de los componentes
familia$ciudad
familia$nombre.hijos

# Clase de objeto: MATRIZ-----
   # es un vector bidimensional, que se visualiza como una tabla conformada por 
   # columnas y filas ordenadas y donde todos los elementos son del mismo tipo

matrix(1:6) # creo una matriz

matrix(1:6, nrow = 3) #  si especifico numero de filas la secuencia 1:6 se acomodan por columnas

matrix( 1:6, nrow = 2, byrow = TRUE) # con byrow = TRUE, lee por filas

   #data: datos que forman la matriz
   #nrow: numero de filas
   #ncol: numero de columnas
   #byrow: Los datos se colocan por filas o por columnas según se van 
   #leyendo. Por defecto se colocan por columnas.

# Indexacion en matrices-------
   # Seleccionar los elementos de una matriz, podemos hacerlo introduciendo el número
   # de fila y columna entre [ ].

x <- matrix( 1:6, nrow = 3) # Creamos una matriz 2 x 3
x

x[1,2] #Se muestra el elemento de fila 1 columna 2


# Asignar nombres a filas y columnas-------

datos <- matrix(c(20, 65, 174, 22, 70, 180, 19, 68, 170),
                nrow = 3, byrow = T) #Se crea una matrix 3x3
datos
colnames(datos) <- c("edad","peso","altura") # nombres a columna
datos                                        # verifico
rownames(datos) <- c("paco","pepe","kiko")   # nombres a filas
datos          # verifico


######################
### Fin del Script ### 
######################



