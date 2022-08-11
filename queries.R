################################################################################
## RETO 1:


install.packages("DBI")
install.packages("RMySQL")
install.packages("ggplot2")

library(ggplot2)

library(DBI)
library(RMySQL)


MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Si no se arrojaron errores por parte de R, vamos a explorar la BDD

dbListTables(MyDataBase)

# Desplegar los campos o variables que contiene la tabla 
# City

dbListFields(MyDataBase, 'CountryLanguage')



#Una vez hecha la conexión a la BDD, generar una búsqueda con dplyr 
#que devuelva el porcentaje de personas que hablan español 
#en todos los países
DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage where Language='Spanish'")


class(DataDB)
head(DataDB)

View(DataDB)

#Realizar una gráfica con ggplot que represente este porcentaje de tal modo 
#que en el eje de las Y aparezca el país y en X el porcentaje, y que diferencíe 
#entre aquellos que es su lengua oficial y los que no, con diferente color 
#(puedes utilizar geom_bin2d() ó geom_bar() y coord_flip(), si es necesario 
#para visualizar mejor tus gráficas)


ggplot(DataDB, aes(x=CountryCode, y = Percentage)) + 
  geom_bar() +  # Gr?fica de puntos
  ggtitle("Porcentaje de paises que hablan espanol") +
  xlab("Paises") +
  ylab("Porcentaje")

ggplot(DataDB, aes(x=CountryCode, y = Percentage, fill = IsOfficial)) +
  geom_bin2d() +
  ggtitle("Porcentaje de paises que hablan espanol") +
  xlab("Paises") +
  ylab("Porcentaje")


# Nos desconectamos de la base de datos
dbDisconnect(MyDataBase)
