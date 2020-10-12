## ---------------------------
##
## Purpose of script:
##            Download data via ftp
## Author: Ari-Pekka Jokinen
##
## Date Created: 2020-09-28
##
## Copyright (c) Ari-Pekka Jokinen, 2020
## Email: ari-pekka.jokinen@helsinki.fi
##
## ---------------------------
##
## Notes:
##   Created for Downloading NASA GPM Precipitation data from their PPS. ftp text file obtained from NASA STORM
##
## ---------------------------

library(RCurl)

# set workdir
getwd()
setwd("E:/LocalData/aripekkj/ProtectedAreas/Precipitation/")

# ftp file
ftp <- read.table("ftp_url_008_202009280544.txt", sep=",")
ftp

# destination path
destpath = "E:/LocalData/aripekkj/ProtectedAreas/Precipitation/20122020/"

# download each file
for (fp in ftp){
  # get filename from ftp url
  fn = 
  # create full filepath for destination file
  destfile = 
  curl::curl_download(fp, )
}






