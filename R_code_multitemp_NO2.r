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






