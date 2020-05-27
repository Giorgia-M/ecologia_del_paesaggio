# R_code_exam.r

# 1. R code first
#copiare con ctrl+a

####################
####################
####################
# 2. R code spatial

###############################
###############################
###############################
# 3. R code spatial 2

################################
################################
# 4. R code point pattern

# codice per analisi dei pattern legati ai punti

install.packages("ggplot2")
install.packages("spatstat")

library(ggplot2) #comando alternativo require(ggplot2)
library(spatstat)

setwd("C:/lab/")

# importare dati
covid <- read.table("covid_agg.csv", head=T)
head(covid)

plot(covid$country,covid$cases)
plot(covid$country,covid$cases,las=0) #parallel labels
plot(covid$country,covid$cases,las=1) #orizontal labels
plot(covid$country,covid$cases,las=2) #perpendicular labels

plot(covid$country,covid$cases,las=3) #vertical labels

plot(covid$country,covid$cases,las=3,cex.lab=0.5, cex.axis=0.5) # vertical labels

#ggplot2
data(mpg)
head(mpg)

#data
#aes
#tipo di geometria
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon()

# ggplot di covid
ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()

#density
#create dataset for spatstat
attach(covid)
covids <- ppp(lon, lat, c(-180,180), c(-90,90))

d <- density(covids)
plot(d)
points(covids)


# save the .RData
setwd("C:/lab/")
load("point_pattern.RData")
ls()
plot(d)
#palette di colori
cl <- colorRampPalette(c('yellow','orange','red')) (100)
plot(d, col=cl)

#esercizio: plot della mappa della densità dal verde al blu
cl1 <- colorRampPalette(c('green','blue')) (100)
plot(d, col=cl1) 

points(covids)

install.packages("rgdal")
library(rgdal)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

# esercizio: plot della mappa di densità con una nuova colorazione e aggiunta dellle coastline
cl <- colorRampPalette(c('blue','light blue','light green','yellow')) (100)
plot(d, col=cl)
plot(coastlines, add=T, col="yellow")



## esercizio: caricare il workspace point_pattern e creare un grafico della mappa..
library(spatstat)
library(rgdal) # for the coastlines
setwd("C:/lab/")
load("point_pattern.RData")
ls()
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(d, col=cl5, main="density")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
 
# interpolazione
head(covid)
view(covid)
marks(covids) <- covid$cases       #oppure attach(covid) senza usare covid$
s <- Smooth(covids)
plot(s)

#esercizio: plot(s) with point and coastline
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(s, col=cl5, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

text(covids)

### mappa finale
par(mfrow=c(2,1)
# densità
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(d, col=cl5, main="density")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)
# interpolazione del numero di casi
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(s, col=cl5, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)


#### San Marino
# setwd("C:/lab/")
# library(spatstat)
load("Tesi.RData")
ls()
head(Tesi)
attach(Tesi)
summary(Tesi)
# x varia da 12.42 a 12.46
# y varia da 43.91 a 43.94
# point pattern: x,y,c(xmin,xmax),c(ymin,ymax)
Tesippp <- ppp(Longitude, Latitude, C(12.41,12.47), c(43.9,43.95))
dT <- density(Tesippp)
plot(dT)
points(Tesippp, col="green") 



setwd("C:/lab/")
load("sanmarino.RData")
library(spatstat)
ls()
# dT= density map, Tesi=dataset originale, Tesi_ppp=point pattern
plot(dT)
points(Tesippp, col="green")
head(Tesi) 
marks(Tesippp) <- Tesi$Species_richness 
interpol <- Smooth(Tesippp)
plot(interpol)
points(Tesippp, col="green")

library(rgdal)
sanmarino <- readOGR("San_Marino.shp")
plot(sanmarino)
plot(interpol, add=T)
point(Tesippp, col="green")
plot(sanmarino, add=T)

# esercizio: plot multiframe di densità e interpolazione
par(mfrow=c(2,1))
plot(dT, main="Density of points")
points(Tesippp, col="green")
plot(interpol, main="Estimate of species richness")
points(Tesippp,col="green")

# esercizio: plot multiframe di densità e interpolazione uno accanto all'altro
par(mfrow=c(1,2))
plot(dT, main="Density of points")
points(Tesippp,col="green")
plot(interpol, main="Estimate of species richness")
points(Tesippp,col="green")


##############################
##############################
##############################

# 5. R code teleril

# codice R per analisi di immagini satellitari
# packages: raster
install.packages("raster")
library(raster)
setwd("C:/lab/")

p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

# save RData
setwd("C:/lab/")
load("teleril.RData")
ls()
# [1] "p224r63" "p224r63_2011"
library(raster)
plot(p224r63_2011)

# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir)
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)
# grey scale low amount of colours
cllow <- colorRampPalette(c('black','grey','light grey'))(5) 
plot(p224r63_2011, col=cllow)
names(p224r63_2011)
# vedi R [1] "........
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)
#attach(dataframe) non funziona con il pacchetto raster
#simbolo che lega la colonna (la banda) al dataset (immagine satellitare): $
   
#Esercizio: plottare la banda dell'infrarosso vicino con colorRampPalette che varia dal rosso all'arancione al giallo  
clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

# multiframe
par(mfrow=c(2,2))
# blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)
# green
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)
# red
clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)
# nir
clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

dev.off()

# natural colours
# 3 componenti R: R G B
# 3 bande: R = banda del rosso, G = banda del verde, B = banda del blu 
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # RGB in maiuscolo

# nir
# false colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
  
# salvataggio
pdf("primografico.pdf")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()

# multiframe
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

dev.off()

# nir nella componente R (red)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# nir nella componente G (green)
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
# nir nella componente B (blue)
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


# day 2
library(raster)
setwd("C:/lab/")
load("teleril.RData")

# list
ls()
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

# multiframe
par(mfrow=c(2,2))
# blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)  
plot(p224r63_1988$B1_sre, col=clb)
# green
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_1988$B2_sre, col=clg)
# red
clr <- colorRampPalette(c('dark red','red','pink'))(100)  
plot(p224r63_1988$B3_sre, col=clr)
# nir
clnir <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_1988$B4_sre, col=clnir)

dev.off()

# B1: blue - 1
# B2: green - 2
# B3: red - 3
# B4: near infrared (nir) - 4
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

# Esercizio: plot the image using the nir on the "r" component in the RGB space
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# plot delle 2 immagini 1988 e 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin", main="1988")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin", main="2011")
dev.off()

# spectral indices
# dvi1988 = nir1988 - red1988
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
plot(dvi1988)

# esercizio: calculate dvi for 2011
dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
plot(dvi2011)

cldvi <- colorRampPalette(c('light blue','light green','green'))(100)  
plot(dvi2011, col=cldvi)

# multitemporal analysis
difdvi <- dvi2011 - dvi1988
plot(difdvi)
cldifdvi <- colorRampPalette(c('red','white','blue'))(100) 
plot(difdvi, col=cldifdvi)

# visualize the output
#multiframe 1988rgb, 2011rgb, difdiv
par(mfrow=c(3,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plot(difdvi, col=cldifdvi)

dev.off()

# changing the grain (resolution)
p224r63_2011lr <- aggregate(p224r63_2011, fact=10)
p224r63_2011
p224r63_2011lr

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")

# lower resolution
p224r63_2011lr50 <- aggregate(p224r63_2011, fact=50)
p224r63_2011lr50
# original 30 m <- resampled 1500 m

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr50, r=4, g=3, b=2, stretch="Lin")

dev.off()

# dvi2011 low resolution
dvi2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
plot(dvi2011lr50)

# dvi1988 low resolution
p224r63_1988lr50 <- aggregate(p224r63_1988, fact=50)
dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre

# difdvi low resolution
difdvilr50 <- dvi2011lr50 - dvi1988lr50
cldifdvi <- colorRampPalette(c('red','white','blue'))(100) 
plot(difdvilr50,col=cldifdvi)

# multiframe 
par(mfrow=c=(2,1))
plot(difdvi, col=cldifdvi)
plot(difdvilr50, col=cldifdvi)

###################################
###################################
####################################
6. R code land cover
# R code land cover
# install.packages(c("RStoolbox","raster"))
library(raster)
install.packages("RStoolbox")
library(RStoolbox)
setwd("C:/lab/") 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# landsat bands: 1b, 2g, 3r, 4nir
# rgb
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=4)
p224r63_2011c
plot(p224r63_2011c$map)
clclass <- colorRampPalette(c('red', 'green', 'blue', 'black'))(100) 
plot(p224r63_2011c$map, col=clclass)
p224r63_2011c <- unsuperClass(p224r63_2011, nClasses=2)
plot(p224r63_2011c$map)
# in funzione del numero di classi aumenta l'intercezza dell'algoritmo automatico di classificazione
# riportando potenzialmente classi leggermente differenti

################################
################################
################################
7. R code multi temp
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



### lezione 3
cover <- c("Agriculture","Forest")
before <- c(10.9,89.1)
after <- c(48.2,51.8)
output <- data.frame(cover,before,after)
output

grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")

grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")

grid.arrange(grafico1, grafico2, nrow = 1)
 
library(gridExtra) 
grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100)

grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100)

grid.arrange(grafico1, grafico2, nrow = 1)
 
##############################
##############################
##############################
#8. R code mutitemp NO2
# R code for analysing NO2 data from ESA - January to March 2020
library(raster)
setwd("C:/lab/")

EN01 <- raster("EN_0001.png")
plot(EN01)

# esercizio: import all the images
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN01, col=cl)
plot(EN013, col=cl)

par(mfrow=c(1,2))
plot(EN01, col=cl)
plot(EN13, col=cl)

# difference
difno2 <- EN13 - EN01
cldif <- colorRampPalette(c('blue','black','yellow'))(100) 
plot(difno2, col=cldif)

# plot images
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)
 

## lezione 2-3
setwd("C:/lab/")
load("EN.RData")
ls()

setwd("C:/lab/esa_no2")
rlist <- list.files(pattern=".png")
rlist

listafinale <- lapply(rlist, raster)
EN <- stack(listafinale)

difEN <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difEN, col=cld)

cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN, col=cl)

boxplot(EN, horizontal=T, outline=F)

#################################
#################################
#################################
# 9. R code snow
# R_code_snow.r
setwd("C:/lab/") 
install.packages("ncdf4")
library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")  # il warning message è normale
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)

# esercizio: plot snow cover with the cl palette
plot(snowmay, col=cl)

### import snow data
setwd("C:/lab/snow") 
rlist <- list.files(pattern=".tif")
rlist 

# save raster into list
# con lapply
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)

# prediction
# go to IOL and download prediction.r into the folder snow
source("prediction.r")

plot(predicted.snow.2025.norm, col=cl)
predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
#########################à
##########################
##########################
# 10. R code patches
# R_code_patches.r
library(raster)

# install.packages("igraph")
library(igraph) # for patches
setwd("C:/lab/")

d1c <- raster("d1c.tif")
d2c <- raster("d2c.tif")

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) 
plot(d1c,col=cl)
plot(d2c,col=cl)

# forest: class 2; agriculture: class 1
d1c.for <- reclassify(d1c, cbind(1,NA))
d2c.for <- reclassify(d2c, cbind(1,NA))

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) 
plot(d1c,col=cl)
plot(d1c.for, col=cl))

par(mfrow=c(1,2))
plot(d1c)
plot(d2c)

# creating patches
d1c.for.patches <- clump(d1c.for)
d2c.for.patches <- clump(d2c.for)

# writeRaster(d1c.for.patches, "d1c.for.patches.tif")
# writeRaster(d2c.for.patches, "d2c.for.patches.tif")
# d1c.for.patches <- raster("d1c.for.patches.tif")
# d2c.for.patches <- raster("d2c.for.patches.tif")

# esercizio: plottare entrambe le mappe una accanto all'altra
clp <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) 
par(mfrow=c(1,2))
plot(d1c.for.pacthes, col=clp)
plot(d2c.for.pacthes, col=clp)

# max patches d1 = 301
# max patches d2 = 1212

# plot results:
time <- c("Before deforestation","After deforestation")
npatches <- c(301,1212)
output <- data.frame(time,npatches)
attach(output)
library(ggplot2)
ggplot(output, aes(x=time, y=npatches, color="red")) + geom_bar(stat="identity", fill="white")


