#
# Aggregate raster and turn to polygon grid
#
# Copyright: Ari-Pekka Jokinen

library(raster)
library(sf)

# set work dir
setwd("C:/Users/Ap/Documents/ProtectedAreas/")

########

# Aggregate single file

########

# read file
#r <- raster("Cambodia/Hansen/Hansen_forestcover2010_above75_utm48N.tif")

# aggregate by a factor 
#aggre <- raster::aggregate(r, fact=30, fun=mean, na.rm=T)

# write result
#writeRaster(aggre, "Cambodia/Hansen/Hansen_forestcover2010_above75_utm48N_agg.tif")


################

# Aggregate list of files

################

# set filepath for the text file containing filepaths of files to be processed
table <- "C:/Users/Ap/Documents/ProtectedAreas/aggregate_files.txt"

# set suffix for output filenames
suf <- "agg_mean_res_900"

# read text filelist
f_list <- read.table(table, header = FALSE, stringsAsFactors = FALSE)

# iterate through the list and perform the task to each file
for (i in f_list$V1){
  # read file from list as a raster layer
  f <- raster(i)
  # aggregate file
  aggregated <- raster::aggregate(f, fact = 30, fun=mean, na.rm=T)
  # generate output filename
  out_name <- paste(substr(i, 1, nchar(i)-4), suf, sep = "")
  # write file
  writeRaster(aggregated, filename = out_name, format = "GTiff")
  #break
}




# raster to polygon
#r.poly <- rasterToPolygons(agre)
#sf_poly <- st_as_sf(r.poly)

#st_write(sf_poly, "", driver = "GPKG")


