# R code analisi multitemporale di variazione della land cover
setwd("C:/lab/")
library(raster)
# install.packages("RStoolbox")
library(RStoolbox)
defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

defor1
# names: defor_.1, defor_.2, defor_.3
# defor_.1 = NIR
# defor_.2 = red
# defor_.3 = green

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")

# esercizio: plot della seconda data
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# classificazione non supervisionata
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
cl <- colorRampPalette(c('black','green'))(100)  
plot(d1c$map, col=cl)
# possibilità 2
cl <- colorRampPalette(c('green','black'))(100) 
plot(d1c$map, col=cl)

# esempio sul significato del $
#mappa geologica <- geomap(im_sat, nClasses=..)
#plot(mappageologica$lito)
#plot(mappageologica$lineaments)

# classificazione di defor2
# classificare con 2 classi l'immagine satellitare defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map, col=cl)
dev.off()

# plot delle 2 mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

par(mfrow=c(1,2))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

freq(d1c$map)
# aree aperte = 37039
# foresta = 304253
totd1 <-  37039 + 304253 
totd1
# 341292
percent1 <- freq(d1c$map) * 100 / totd1

# percentuali
# foreste: 89.1
# aree aperte: 10.9

freq(d2c$map)
# aree aperte: 165055
# foreste: 177671
totd2 <- 165055 + 177671
totd2
# 342726
percent2 <- freq(d2c$map) * 100 / totd2

# percentuali
# aree aperte: 48.2
# foresta: 51.8 

cover <- c("Agriculture","Forest")
before <- c(10.9,89.1)
after <- c(48.2,51.8)

output <- data.frame(cover,befor,after)
View(output)

library(ggplot2)
# install.packages("ggplot2")



### lezione 2
library(raster)
setwd("C:/lab/")
load("defor.RData")
ls()
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) 
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

library(ggplot2)
# histograms of the % cover before deforestation
ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")

# esercizio: plot the histograms of the land cover after deforestaton
ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")

install.packages("gridExtra")
library(gridExtra)  # oppure require(Extra)

grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")

# use grid.arrange to plot the two graphs
grid.arrange(grafico1, grafico2, nrow = 1)






