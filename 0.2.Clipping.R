############################CLIPPING##################################
#
#
#This script subsets an image using a polygon shapefile
#Any questions can be asked to Ximena Tagle: xtagle@iiap.gob.pe
#
#


###SET Working Directory 

#setwd("/home/xtagle/UAV/Results/") #Linux
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Windows


###LOAD LIBRARIES
library(raster)
library(gdalUtils)
library(rgrass7)
library(sp)
library(rgeos)
library(rgdal)
#library(sf)


####LOAD IMAGE
image.path<-"./1_Clip/2_mosaic/IIAP_transparent_mosaic_group1.tif"
image<-stack(image.path)
plotRGB(image) #to visualize the mosaic


####LOAD DSM
D.path<-"./1_Clip/IIAP_dsm.tif" 
DSM<-raster(D.path)

####LOAD DTM
T.path<-"./1_Clip/IIAP_dtm.tif" 
DTM<-raster(T.path)

####LOAD MASK
Mask_path<-"./1_Clip/IIAP_poly.shp"
Mask<-readOGR(dsn="./1_Clip", layer="IIAP_poly")
plot(Mask, border="red", add=T) #to visualize the shapefile, if it does not appear check if the prokection is the same as the raster


###CROP
Clip<-gdalwarp(srcfile= image.path, dstfile = "./1_Clip/JH_1.tif", ot= 'Float32', of='GTiff', cutline= Mask_path, outpt_Raster=T) #Clips the orthomosaic
Clip_DSM<-gdalwarp(srcfile= D.path, dstfile = "./1_Clip/JH_1_DSM.tif", ot= 'Float32', of='GTiff', cutline= Mask_path, outpt_Raster=T) #Clips the DSM
Clip_DTM<-gdalwarp(srcfile= T.path, dstfile = "./1_Clip/JH_1_DTM.tif", ot= 'Float32', of='GTiff', cutline= Mask_path, outpt_Raster=T) #Clips the DTM


###VISUALIZE
plotRGB(Clip)

####LOAD PLOT LIMITS
#plotBorder<-readOGR(dsn="../Plan/JEN", layer="JEN-14")
#plot(plotBorder, pch=1, cex=4, col="white", add=T)
