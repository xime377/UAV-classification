#######REDUCE_RES: FUNCTION TO REDUCE THE RESOLUTION OF THE MOSAIC#########################
#'
#' @param image raster (High resolution UAV mosaic)
#'
#' @param size cell size in meters, by default it will be 0.05 m(5 cm)
#' 
#' 
#' @return 5 cm resolution raster

library(raster)


ReduceRes<-function(image, size=0.05){
  
  resolution=res(image) #Extracts the image resolution
  
  scale=size/resolution
  scale=scale[1]
  
  ResImg<-aggregate(image, fact=scale)
  
  ResImg
  
}
