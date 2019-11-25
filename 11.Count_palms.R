############################PALM QUANTIFICATION##################################
#
#
#This script counts the palm trees from a vector file (output from an object-based clasification)
#It clips the crowns based on the canopy height model
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WDIR
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/JEN14/") #Windows Xime PC
#.libPaths("C:/Users/tagle002/R")
#setwd("/home/xtagle/UAV/Results/") #Linux Manati


###LOAD LIBRARIES
library(raster)
library(RStoolbox)
library(rgdal)
library(rgeos)
library(sf)
library(rgrass7)
#library(RCurl)

###LOAD FUNCTIONS
#Local dir
source("../lib/polygonizeR.R")
##or github
#script <- getURL("https://raw.githubusercontent.com/xime377/UAV-classification/master/polygonizeR.R", ssl.verifypeer = F)
#eval(parse(text = script))

###LOAD CH
CH.path="./4_Height/JEN14_CH.tif"
CH=raster(CH.path)

plot(CH)


###CLUSTER K-MEANS
clas.CH<-unsuperClass(CH, nClasses = 5)
plot(clas.CH$map)


###EXPORT CLASSIFICATION OF CH
#as raster
writeRaster(clas.CH$map, filename = "./4_Height/JEN14_CH_class5.tif")

#as polygon
###INITIATE GRASS-R CONNECTION
initGRASS("C:/Program Files/GRASS GIS 7.6", tempdir(), override=T) #path to GRASS win
#initGRASS("/usr/lib64/grass76", tempdir(), override=TRUE) #linux
CH_class_poly<-gdal_polygonizeR(clas.CH$map, "./4_Height/JEN14_CH_class5", readpoly = T, fillholes = T, aggregate = F)
head(CH_class_poly)


#clean the polygon
use_sp()
writeVECT(CH_class_poly, "CH_class_poly", v.in.ogr_flags=c("o", "overwrite"), snap=1e-008) #Load to GRASS as "sf"
CH_class_cleaned1<-readVECT("CH_class_poly") #import to R

execGRASS("v.clean", flags = c("overwrite"), tool=c('snap','rmdangle','rmdupl', 'rmdac', 'rmarea'), 
          threshold= c(1e-008,-0.5,0,0,3) , input= "CH_class_poly", output= "CH_class_clean") #removes dangles, snaps, removes small polygons
CH_class_cleaned2<-readVECT("CH_class_clean")
CH_class_cleaned2@proj4string<-CH_class_poly@proj4string #add projection
CH_class_poly<-st_as_sf(CH_class_cleaned2)
#st_crs(CH_class_cleaned2) <- crs(CH_class_poly) #Add CRS SF

#Export cleaned polygon
st_write(CH_class_poly,"./4_Height", layer="JEN14_CH_class5_cleaned", update=T, driver="ESRI Shapefile")




###COUNT PALM TREES 
#Load class results
rf_poly<-st_read("./6_Classification/predicted_output_rf_JEN14_50005_200_f5cleaned.shp") 
head(rf_poly)
st_crs(rf_poly) <- crs(CH_class_poly) #Add CRS

#Remove water, trees and soil
rf_poly_p<-rf_poly[!rf_poly$DN %in% c(1,2,5),]
unique(rf_poly_p$DN)

#Assign name species
rf_poly_p$sp<-ifelse(rf_poly_p$DN==3,"E. precatoria", 
                     ifelse(rf_poly_p$DN==4,"M. flexuosa",0))
#check if the assigment worked fine
head(rf_poly_p)
unique(rf_poly_p$sp) 
st_crs(rf_poly_p) <- crs(CH_class_poly) #Add CRS

#st_write(rf_poly_p,"./7_Quantification", layer="predicted_output_rf_JEN14_P", driver="ESRI Shapefile", update=T)


#Plot to Check if the geometry is fine
plot(rf_poly_p[3]) 

#INTERSECT CANOPY MASK WITH CH
rf_crown<-st_intersection(rf_poly_p, CH_class_poly) #sf
rf_crown_P<-st_cast(rf_crown, "POLYGON")
plot(rf_crown[1])

#Remove small polygons
#rf_crown<-st_read("./7_Quantification", layer="predicted_output_rf_JEN14_IntersectQ") #import in case that the intersection was done in another software
use_sf()
writeVECT(rf_crown, "rf_crown", v.in.ogr_flags=c("o", "overwrite"), snap=1e-008) #Load to GRASS as "sf"
rf_Ccleaned1<-readVECT("rf_crown") #import to R

execGRASS("v.clean", flags = c("overwrite"), tool=c('snap','rmdangle','rmdupl', 'rmdac', 'rmarea'), 
          threshold= c(1e-008,-0.5,0,0,3) , input= "rf_crown", output= "rf_Cclean") #removes dangles, snaps, removes small polygons
use_sf()
rf_Ccleaned2<-readVECT("rf_Cclean")

#COUNT POLYGONS
table(rf_crown$sp)

#EXPORT SHAPEFILE
st_write(rf_Ccleaned2,"./7_Quantification", layer="predicted_output_rf_JEN14_Q", driver="ESRI Shapefile")


###########################################################################################