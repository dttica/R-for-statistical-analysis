# install.packages("tidyverse")

library(tidyverse)
install.packages("dplyr")
install.packages("devtools")
install.packages("DBI")


library(EDAWR)
?tb

cases
class(cases)
dim(cases)

gather(cases, "Año", "Conteo", c(2,3,4))

cases %>%
  gather("Año","Conteo", 2:4)

notas <- data.frame(
  nombre = c("Jasmin","Fabrizzio","Frank",
             "Luis", "Angel"),
  control1 = c(12,10,14,16,15),
  control2 = c(13,12,10,18,15),
  control3 = c(8,12,6,5,NA),
  final = c(16,15,18,20,10))

notas

notas2 <- gather(notas, "Examen", "Nota", 2:5)

gather(notas, "Examen", "Nota", 3:5)


pollution
spread(pollution, size, amount)


View(notas2)

notas3 <- spread(notas2, Examen, Nota)
class(notas3)

storms
separate(storms, date, c("Año", "Mes", "Dia"), sep = "-")

storms2 <- as.data.frame(storms)
storms2

storms3 <- storms2 %>%
  separate(date, c("Año", "Mes", "Dia"), sep = "-")

unite(storms3, "Fecha", Año:Dia, sep = "-")

notas

notas$Apellido <- c("Catalan","Vasquez","Castillo",
                    "Chacon","Pajita")

notas

unite(notas, "NombreCompleto", nombre, Apellido, sep = " ")

install.packages("nycflights13")
library(nycflights13)

notas
select(notas, control1:control3)

notas %>%
  select(control1:control3)

notas %>%
  unite("NombreCompleto", nombre, Apellido, sep = " ") %>%
  select(NombreCompleto, final)

notas %>%
  select(-control2)

notas %>%
  select(everything())

notas %>%
  select(starts_with("con"))

notas %>%
  select(contains("tr"))

notas %>%
  select(matches(".tr."))

filter(notas, final >= 14)

notas %>%
  filter(final>=16) %>%
  unite("NombreCompleto",nombre,Apellido,sep=" ") %>%
  select(NombreCompleto, final)
  
notas %>%
  filter(final>=16, nombre %in% c("Jasmin","Fabrizzio","Angel"))

notas %>%
  filter(final >=16, control1 >=14)

notas %>%
  filter(control1 %in% c(14:20)) %>%
  unite("NombreCompleto", nombre, Apellido, sep = " ") %>%
  select(NombreCompleto,control1) 
  
notas %>%
  mutate(PromControl = (control1 + control2 + control3)/3)

notas %>%
  summarise(promedio = mean(control3, na.rm = TRUE), 
            asistentes = sum(!is.na(control3)))

notas %>%
  summarise(max_nota = max(final))

notas %>%
  arrange(desc(final), desc(control3)) %>%
  select(nombre, final, control3)

notas
notas[3,5] <- 20

notas %>%
  arrange(desc(final), desc(control3)) %>%
  select(nombre, final, control3)

library(dplyr)
library(magrittr)

notas %>%
  filter(control2 >= 13)
  
notas %>%
  filter(control2 >= 13 & control2 <=15)

notas  %>% 
  filter(between(control2, 13, 15))

notas %>%
  summarise(rango = max(final) - min(final))
  
max(notas$final)  
min(notas$final)  

rango  <- function(x){
  aux = x[!is.na(x)]
  max(aux) - min(aux)
}

summarise(notas , rango = rango(control2))
  
pollution <- data.frame(city = c("NY","NY",
                                 "London","London",
                                 "Beijing", "Beijing"),
                        size = rep(c("Large","Small"),3),
                        amount = c(23,14,22,16,121,56))
pollution

levels(pollution$city)

pollution %>%
  group_by(city) %>%
  summarise(conteo = n(), promedio = mean(amount), 
            rango = rango(amount), desv = sd(amount))

library(tidyr)
notas %>%
  select(-final) %>%
  gather("control", "nota", 2:4) %>%
  group_by(control) %>%
  summarise(promedio = mean(nota, na.rm = TRUE),
            rango = rango(nota))
  
notas %>%
  select(-final) %>%
  gather("control", "nota", 2:4) %>%
  group_by(nombre) %>%
  summarise(promedio = sum(nota, na.rm = T)/3)
  
notas %>%
  ungroup()

tb %>%
  group_by(country) %>%
  summarise(casos = sum(cases))
