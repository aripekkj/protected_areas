# select rows from file by matching string
# 
# Script contains workflow for csv and shapefile
# 1st CSV
# 2nd Shapefile
#
#
#
# @ A-P Jokinen, 26.11.2019



# packages
library(sf)
library(plyr)
library(rgdal)


# workdir
getwd()
#setwd('E:/LocalData/aripekkj/TA/Cambodia/OSM/')
setwd('E:/LocalData/aripekkj/TA/Bhutan/Bhutan_OSM')
#setwd('E:/LocalData/aripekkj/R/')

####################################################
################ WITH CSV FILE #####################
####################################################


# read csv
d <- read.csv('osm_roads.csv', sep=';')

# check data
head(d)
cnames <- colnames(d)

# select by string
strings <- c("primary","primary_link","secondary","secondary_link","tertiary","tertiary_link","track","unclassified")

result <- data.frame()

# make a selection by string in strings and finally rbind all selections to dataframe "result"
for (string in strings) {
  # make selection acccording to "string" from dataframe d
  s1 <- d[d$fclass== string,]
  # bind the results to dataframe
  result <- rbind(result, s1)
}  

# check results
head(result)
unique(result$fclass)

# save as csv
write.csv(result, file = "selected_roads.csv", sep = ";")




####################################################
#############  SAME WITH SHAPEFILE #################
####################################################



# read shapefile using sf package
d_sf <- st_read('gis_osm_waterways_free_1.shp')

# print unique values of road classes in OSM data
print(unique(d_sf$fclass))

# select by string (exact match). Define here all the strings to be matched. 
#strings <- c("primary","primary_link", "trunk", "secondary","secondary_link","tertiary","tertiary_link","track","unclassified", 
#             "track_grade1", "track_grade2", "track_grade3", "track_grade4", "track_grade5")

strings <- c("river", "riverbank", "tidal_channel", "canal")

# empty data frame for selections
result <- data.frame()

# make a selection by string in strings and finally rbind all selections to dataframe "result"
for (string in strings) {
  # make selection acccording to "string" from dataframe d
  s1 <- d_sf[d_sf$fclass== string,]
  # bind the results to dataframe
  result <- rbind.data.frame(result, s1)
}  

# check results
head(result)
unique(result$fclass)

# write to file
st_write(result, dsn = 'osm_rivers_selected.shp', driver = 'ESRI Shapefile')




