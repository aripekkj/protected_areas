## ---------------------------
##
## Purpose of script:
##
## Author: Ari-Pekka Jokinen
##
## Date Created: 2020-04-22
##
## Copyright (c) Ari-Pekka Jokinen, 2020
## Email: ari-pekka.jokinen@helsinki.fi
##
## ---------------------------
##
## Notes:
##   
##
## ---------------------------
#
# Calculate focal statistics
#
#
#
#

library(raster)
library(sf)
library(viridis)

# set work dir
setwd("C:/Users/Ap/Documents/ProtectedAreas/")

# read file
r <- raster("Cambodia/Hansen/loss_0010_above75_utm48.tif")

# focal sum of 3x3 window
f <- focal(r, w=matrix(1,7,7), fun=sum, na.rm=T, pad=TRUE)

# read country border for plotting
b <- st_read("Cambodia/border/cmd_border.gpkg")

# plot
plot(b$geom, col='grey')
plot(f, col=viridis(50,direction=1), add=T)
title(main="Focal sum of forest loss 2000-2010 on 7x7 window")

# save raster
writeRaster(f, "Cambodia/Hansen/focal_0010_7x7_utm48.tif")


