## ---------------------------
##
## Purpose of script:
##
## Author: Ari-Pekka Jokinen
##
## Date Created: 2020-10-26
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
#
#
#
#

library(raster)
library(rgdal)

# set work dir
setwd("C:/Users/Ap/Documents/ProtectedAreas/Bhutan/")

# read raster file
r <- raster("Hansen_forestcover2018_above30.tif")

# set time limit
setTimeLimit(1200)
# calculate distance grid
distgrid <- gridDistance(r, origin=1)

# write output
writeRaster(distgrid, filename="dist_to_forest_above30_2018.tif", format="GTiff", datatype="FLT4S")












