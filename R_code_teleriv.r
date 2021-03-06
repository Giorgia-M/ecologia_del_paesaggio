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


 
