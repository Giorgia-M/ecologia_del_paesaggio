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

