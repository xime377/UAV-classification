############################CANOPY HEIGHT##################################
#
#
#This script extracts the height of the canopy by subtracting the DTM to the DSM in order to provide more information to the classification
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WD
setwd("/home/xtagle/UAV/Results/JEN14") #Linux Manati
#setwd("G:/My Drive/Monan/RPAs/Misiones/Results/JEN14") #Windows Xime Pc


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





############################################If want to compare with SAR DEM#################################################
###LOAD JAXA DSM
JD.path<-"./JEN14/1_Clip/AP_24346_FBD_F7090_RT1.dem.tif" 
JDSM<-raster(JD.path)
#plot(JDSM)



#Reproject coord system and extract only the extent of the DSM
JDS.UTM<-projectRaster(JDSM,Clip)
#plot(JDS.UTM)

writeRaster(JDS.UTM,"./JEN14/1_Clip/Clip_AP_24346_FBD_F7090_RT1_DSM_UTM.tif")


#Compare the Jaxa DSM and DSM
compareRaster(Clip,JDSM.e,extent=T, rowcol=T, crs=T, res=T, orig=T, rotation=T) #Check if they have the same resolution and extent

#Remove the elevation
DSM.We<- Clip-JDSM.e
plot(DSM.We)

#Check the values
ValuesDSM<-DSM.We@data@values
summary(ValuesDSM)

