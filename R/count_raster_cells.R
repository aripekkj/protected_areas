## ---------------------------
##
## Purpose of script:
##
## Author: Ari-Pekka Jokinen
##
## Date Created: 2020-05-12
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


library(sp)
library(spdep)
library(rgdal)
library(sf)
library(raster)

# set wd
setwd("C:/Users/Ap/Documents/ProtectedAreas/Cambodia/")

# read PA poly
pa <- st_read("WDPA_Dec2019_KHM-shapefile/khm_protected_areas_utm48.gpkg")

# read raster
r <- raster("Hansen/Hansen_treecover2000_clip_above75_presabs_utm48N.tif")

# select one polygon
test_pa <- pa[1,]
plot(test_pa$geom)

# as sp
ply_sp <- as(test_pa, "Spatial")

# mask raster by polygon
m <- mask(r, ply_sp)
m <- crop(m, extent(ply_sp))

# count frequency of values
fr <- freq(m)



# read table and make a comparing bar plot
t <- read.csv("zonal_stat/khm_2000_forest_in_pa.csv")
t2 <- read.csv("zonal_stat/khm_2010_forest_in_pa.csv")

# assign ID and two sum columns to new dataframe
t3 <- data.frame(t[2],t[6],t2[6])
# rename columns
colnames(t3) <- c("ID", "Sum2000", "Sum2010")

t3_rbind <- rbind(t3$Sum2000, t3$Sum2010)

# namelist
pa_names <- as.vector(pa$NAME)

min2000 <- min(t3$Sum2000)
max2000 <- max(t3$Sum2000)
min2010 <- min(t3$Sum2010)
max2010 <- max(t3$Sum2010)

# increase bottom margin
par(mar=c(15,5,3,3))

# plot
barplot(t3_rbind, beside=T, col=c("red", "blue"),
        names.arg=pa_names, 
        las=2,
        cex.names = 0.5,
        cex.axis = 0.7,
        ylab="count")
legend("topright", legend = c("2000", "2010"), fill=c("red", "blue"), cex = 0.5)
title("Cambodia forest cover pixels in protected areas")










