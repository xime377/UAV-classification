###SET WD
#setwd("/home/xtagle/UAV/Results/") #Linux
#setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Xime Pc
# setwd("C:/Users/xtagle/Google Drive/Results") #Workstation
setwd("E:/Drones/UAV/Results/JEN14/")

###LOAD LIBRARIES
library(raster)
library(rgeos)
library(sf)


####LOAD ORTHOMOSAIC
o.path<-"./1_Clip/JEN-14_3.tif" 
OM<-raster(o.path)
#plot(OM)


####LOAD DSM
D.path<-"./1_Clip/JEN-14_3_DSM.tif" 
DSM<-raster(D.path)
#plot(DSM)

####LOAD DEM
T.path<-"./1_Clip/JEN-14_3_DEM.tif" 
DTM<-raster(T.path)
#plot(DTM)

#Compare both to see if they have the same extent, resolution..
compareRaster(DSM,DTM,extent=T, rowcol=T, crs=T, res=T, orig=T, rotation=T)

#if the extent or resolution are different
DTM<-projectRaster(DTM,DSM)

#Remove the elevation
CH<- DSM-DTM
#plot(CH)


#Export Canopy height
writeRaster(CH,"./4_Height/JEN14_CH.tif")

