############################CANOPY HEIGHT##################################
#
#
#This script extracts the height of the canopy by subtracting the DTM to the DSM in order to provide more information to the classification
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.org.pe
#
#

###SET WD
#setwd("/home/xtagle/UAV/Results/") #Linux
setwd("G:/My Drive/Monan/Taller_Oct/") #Windows



###LOAD LIBRARIES
library(raster)
library(rgeos)
library(sf)


####LOAD DSM
D.path<-"E:/Orthomosaics/Monan/2017/VEN-01/VEN-01_all/3_dsm_ortho/1_dsm/VEN-01_all_dsm.tif" 
DSM<-raster(D.path)
#plot(DSM)


####LOAD ORTHOMOSAIC
o.path<-"./1_Clip/JH_1.tif" 
OM<-raster(o.path)
plot(OM)

####LOAD DSM
D.path<-"./1_Clip/JH_1_DSM.tif" 
DSM<-raster(D.path)
#plot(DSM)

####LOAD DTM
T.path<-"./1_Clip/JH_1_DTM.tif" 
DTM<-raster(T.path)
#plot(DTM)


#Remove the elevation
CH<- DSM-DTM
plot(CH)

#Check the values
ValuesDSM<-DSM.We@data@values
summary(ValuesDSM)

#Export Canopy height
writeRaster(CH,"./4_Height/JH_1_canopyH.tif")
