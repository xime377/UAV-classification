############################POINT TO POLYGON##################################
#
#
#This script generates a polygon shapefile from coordinates points
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.org.pe
#
#


###SET Working Directory 

#setwd("/home/xtagle/UAV/Results/") #Linux
setwd("G:/My Drive/Monan/Taller_Oct/") #Windows


#Load libraries
library("sf")
library("mapview")
library("RColorBrewer")
library(raster)
library(RCurl)

#load points
dir(,"csv")
Plots<-read.csv("./1_Clip/IIAP_v.csv", header=T)
head(Plots)
str(Plots)

#Load function
source("./lib/Point_to_polygon.R")
#or 
#script <- getURL("https://raw.githubusercontent.com/xime377/UAV-classification/master/Point_to_polygon.R", ssl.verifypeer = F)
#eval(parse(text = script))


#Convert to Sp <- st_as_sf(pnt, coords = c("x", "y"), crs = 4326)
#RPlots<- st_as_sf(Plots, coords = c("Lon", "Lat"), crs = 4326) #if they are in DD
RPlots<- st_as_sf(Plots, coords = c("X", "Y"), crs = 32718) #if they are in UTM
head(RPlots) 

#Plotting points
plot(RPlots[,1])

mapView(RPlots, zcol = "Plot", color= "white",legend=T, 
        map.type=c("Stamen.Terrain", "CartoDB.Positron", "Esri.WorldImagery", "OpenStreetMap", "OpenTopoMap"))


#Export as shapefile
R.plots<-st_as_sf(RPlots)
st_write(R.plots, "./1_Clip/IIAP_v.shp")



###Points to polygon

#Load a shp (if it is not loaded yet)
Rplots<-shapefile("./1_Clip/IIAP_v.shp")
Rplots@coords


#With max and min (when only a rectangle is needed)
# ext <- as(raster::extent(78.46801, 78.83157, 19.53407, 19.74557), "SpatialPolygons")
# proj4string(e) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
# plot(ext)


#Point to poly
IIAP<-Point.to.poly(Rplots)
plot(IIAP)

#Export as shapefile
IIAP<-st_as_sf(IIAP)
st_write(IIAP, "./1_Clip/IIAP_poly.shp")

