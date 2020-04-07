# codice R per analisi di immagini satellitari
# packages: raster
install.packages("raster")
library(raster)
setwd("C:/lab/")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

