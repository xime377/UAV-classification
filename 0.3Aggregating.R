############################REDUCE RESOLUTION##################################
#
#
#This script reduces the mosaic spatial resolution (by default to 5 cms)
#It is recommended to generate the mosaic in the sfm software with the desired spatial resolution, 
#this script is an alternative in case that that task is not possible
#
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#


###SET WD
#setwd("/home/xtagle/UAV/Results/") #Linux Manati
#setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Windows Xime Pc


###LOAD LIBRARIES
library(raster)

###LOAD FUNCTION
source("../lib/ReduceRes.R")

####LOAD IMAGE
image.path="./1_Clip/JEN-14_3.tif"
image=stack(image.path)
plotRGB(image) #Visualize the mosaic

res(image) #Check the image resolution


###REDUCE THE SPATIAL RESOLUTION
image10<-ReduceRes(image, size=0.05) #the size can be changed according to the needs (be aware that the units are in meters!), by default is set to 5cm
res(image10) #Check the image resolution
plotRGB(image10) #Visualize the mosaic

###EXPORT NEW RASTER
writeRaster(image10, "./1_Clip/JEN-14_3_res.tif", datatype="INT2U", options="COMPRESS=NONE")
