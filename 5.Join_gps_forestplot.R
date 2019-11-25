############################JOIN GPS - FORESTPLOT INFO##################################
#
#
#This script makes a join between the GPS data and the foresplot info, generating a georeferenced database of the palm trees per plot
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#


###SET WD
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/")

#Load libraries
library(dplyr)
library(broom)
library(raster)
library(rgdal)

###LOAD DATA
dir()

#Load GPS data
GPS <- shapefile("../GCPs/VEN/VEN01/SHP/Palmeras_VEN01_2017.shp")
head(GPS@data)
str(GPS)
GPS@data[, c("x", 'y')] <- coordinates(GPS)[,1:2]
GPS@data$name <- as.numeric(as.character(GPS@data$name)) #converts to numeric the factor
str(GPS)

# #In the case that the points were saved with a different code instead of the palm tag
# LinkTable<- read.csv("../GCPs/VEN/VEN01/SHP/Palmeras_GPS_VEN.csv", header=T)
# head(LinkTable)
# str(LinkTable)

#Load forestplots info
VEN01<-read.csv("./VEN01/0_Plot_info/Invent_VEN01.csv", header = T)
head (VEN01)
str(VEN01)


###JOIN DFS
# #In the case that the points were saved with a different code of the palm tag
# PalmsVEN01<-inner_join(GPS@data, LinkTable, by = c("name" = "Waypoint"))
# head(GPS@data)

#Join the GPS data with the forestplot info ... !!!Check that the tags of the recruited trees match the name of the GPS Placa ("XX.1" instead of"XX.A")
PalmsVEN01<-inner_join(PalmsVEN01, VEN01, by = c("Placa" = "Tag_No"))
head(PalmsVEN01)

###CONVERT INTO SP
coordinates(PalmsVEN01) <- ~ x + y
proj4string(PalmsVEN01) <- proj4string(GPS)
mapview::mapview(PalmsVEN01)

###EXPORT SHAPEFILE
writeOGR(PalmsVEN01, dsn="../GCPs/VEN/VEN01/SHP/Palmeras_VEN01_2017_species", layer = 'Palmeras_VEN01_species', driver= "ESRI Shapefile")
