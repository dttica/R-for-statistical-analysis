# IMPUTACION
# install.packages(c("missForest", "mice", "Hmisc", "VIM"))

notas

library(Hmisc)
notas$control3_imp <- with(notas,impute(control3, mean))
notas$control3_imp <- with(notas,impute(control3, min))
notas$control3_imp <- with(notas,impute(control3, 1))

# Casos completos (sin NA)
notas[complete.cases(notas),]

library(mice)
library(VIM)

View(sleep)
summary(sleep)

md.pattern(sleep)

sum(complete.cases(sleep))
42/62










