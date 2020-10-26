#
#
# Reproject shapefile 
#
#
# A-P Jokinen 20.3.2020

library(sf)

# set work dir
setwd("C:/Users/Ap/Documents/ProtectedAreas/Madagascar/OSM/")

# read file
shape <- st_read("osm_cities_population.shp")
# outputname
outname <- "mdg_cities_utm.gpkg"
# set target utm epsg code
utm <- 32738 # UTM38S

# reproject if not in the desired utm zone
if (!st_crs(shape)[1] == utm){
  # reproject
  shape_reproj <- st_transform(shape, crs = utm)
}

# write reprojected to file
st_write(shape_reproj, dsn = outname, driver = "GPKG")














