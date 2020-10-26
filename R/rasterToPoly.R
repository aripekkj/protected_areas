## ---------------------------
##
## Purpose of script:
##
## Author: Ari-Pekka Jokinen
##
## Date Created: 2020-04-07
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

# raster to polygon

library(raster)
library(rgeos)
library(rgdal)

# read raster
r <- raster("/scratch/project_2000912/Cambodia/Hansen_treecover2000_clip_above75_presabs.tif")

# raster to poly
p <- rasterToPolygons(r, na.rm = TRUE, dissolve = TRUE)

# write
writeOGR(p, "/scratch/project_2000912/Cambodia/f_poly.gpkg", driver = "GPKG")







