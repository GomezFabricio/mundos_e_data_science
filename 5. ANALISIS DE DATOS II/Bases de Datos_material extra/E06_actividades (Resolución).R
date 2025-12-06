#####Actividades#####

# compañia ferroviaria

datos=c(10.1, 9.5, 6.5, 8.0, 8.8, 12, 7.2, 10.5, 8.2, 9.3)
mu0=8
t.test(datos,mu=mu0,alternative="greater",conf.level = 0.95)

#p-valor 0,04101


# ciclista

ciclista_1<-c(130,129,130,124,124,122,130,125,126,123,130,126,125,128,125,125,125,125,125,125,130,123,120,122,125,123,122,127,120,121)

ciclista_2 <- c(128,130,125,125,127,123,130,125,124,123,130,125,125,129,125,125,125,124,125,125,130,122,121,121,125,125,122,128,121,125)

boxplot(ciclista_1,ciclista_2,main="Comparacion de recorrido",ylab="Kilometros",col="Orange")

# varianzas son conocidas y que podemos asumir que son normales sus poblaciones 
# realizaremos la prueba de hipotesis

t.test(ciclista_1,ciclista_2,alternative="greater",mu=0,var.equal=TRUE,conf.level=0.95)

#p-valor 0,5536