#
#
# Reproject rasters
#
#
# Ap Jokinen, 29.11.2019


# packages
library(raster)
library(rgdal)

# work dir
getwd()
setwd("C:/Users/Ap/Documents/_HY/Greenland/satimg/")

# read filelist
f_list <- read.table("files.txt", header = FALSE, stringsAsFactors = FALSE)

# check
head(f_list)

# proj4 details for utm
utm <- "+proj=utm +zone=22 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
#utm <- "+proj=utm +zone=45 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
#utm <- "+proj=utm +zone=48 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"

# suffix
suf <- "_utm22N"

# set counter
counter = 1

# reproject
for (i in f_list$V1){
  # read file from list as a raster stack
  f <- raster::stack(i)
  # reproject file
  reprojected <- projectRaster(f, res = 1, crs = utm)
  #output filename
  out_name <- paste(substr(i, 1, nchar(i)-4), suf, sep = "")
  # write file to folder
  writeRaster(reprojected, filename = out_name, datatype='INT1U', format = "GTiff")
  
  # print counter
  print(paste(counter, '/', nrow(f_list)))
  counter <- counter + 1
  #break
}
