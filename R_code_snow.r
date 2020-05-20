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
