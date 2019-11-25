############################POINT TO POLYGON##################################
#
#
#This script generates a polygon shapefile from coordinates points
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WORKING DIRECTORY
setwd("G:/My Drive/Monan/RPAs/Misiones/")

###LOAD LIBRARIES
library("sf")
library("mapview")
library("RColorBrewer")
library(raster)
library(RCurl)


###LOAD POINTS
dir(,"csv")
Plots<-read.csv("./GCPs/Puntos RTK.csv", header=T)
head(Plots)
str(Plots)

###LOAD FUNCTION
#Local dir
source("./Results/lib/Point_to_polygon.R")
##or github
#script <- getURL("https://raw.githubusercontent.com/xime377/UAV-classification/master/Point_to_polygon.R", ssl.verifypeer = F)
#eval(parse(text = script))

###CREATE A SF 
#Convert to Sp <- st_as_sf(pnt, coords = c("x", "y"), crs = 4326)
#RPlots<- st_as_sf(Plots, coords = c("Lon", "Lat"), crs = 4326) #if they are in DD
RPlots<- st_as_sf(Plots, coords = c("X", "Y"), crs = 32718) #if they are in UTM
head(RPlots) 

###PLOTTING POINTS
plot(RPlots[,1])

mapView(RPlots, zcol = "Plot", color= "white",legend=T, 
        map.type=c("Stamen.Terrain", "CartoDB.Positron", "Esri.WorldImagery", "OpenStreetMap", "OpenTopoMap"))


####Export as a shapefile
R.plots<-st_as_sf(RPlots)
st_write(R.plots, "./ALP/ALP06.shp")



###POINTS TO POLYGON
#Load a shp
Rplots<-shapefile("./ALP/ALP-60.shp")
Rplots@coords


#With max and min
# ext <- as(raster::extent(78.46801, 78.83157, 19.53407, 19.74557), "SpatialPolygons")
# proj4string(e) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
# plot(ext)


#Point to poly
ALP60<-Point.to.poly(Rplots)
plot(ALP60)

#Export as shapefile
ALP60<-st_as_sf(ALP60)
st_write(ALP60, "./ALP/ALP60_poly.shp")

