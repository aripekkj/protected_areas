#
#
# Takes a random sample from raster cells that are not NA
#
#
# Ari-Pekka Jokinen 14/4/2020

library(raster)
library(sf)
library(sp)
library(rgdal)
library(dplyr)

# set work dir
setwd("C:/Users/Ap/Documents/ProtectedAreas/Cambodia/Hansen/")

# read raster 
r <- raster("focal_0010_7x7_utm48.tif")

# take random sample from raster
rrs <- sampleRandom(r, size = 100000, na.rm=T, xy=T, sp=T) # na.rm=T excludes NA cells,  xy=T adds coordinates to dataframe, sp=T returns SpatialPointsDataFrame

# turn to sf
rrs_sf <- st_as_sf(rrs)

# check duplicates
if(any(duplicated(rrs_sf)=='TRUE')){
  print("Duplicates found")
}

# save file
st_write(rrs_sf, "../khm_randomSample_100k_focal_0010.shp", driver = "ESRI Shapefile")



