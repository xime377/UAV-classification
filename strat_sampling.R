#######STRAT_SAMPLING: FUNCTION TO EXTRACT POINTS PER CLASS#########################
#'
#' @param pointsP Spatial Polygon Data frame with a column with classes named "Species"
#'
#' @param n number of samples required, by default 50
#' 
#' @param type type of sampling. See spsample options"random", "stratified"..
#' 
#' @return Spatial points



strat_samp<-function(pointsP, n=50, type="random"){
  
  name.class=unique(pointsP@data$Species) #Extracts the names of each class
  
  points<-NULL #Generate an empty object
  
  for (item in name.class){
    if(is.null(points)){
      points<-spsample(pointsP[pointsP@data$Species == item,], n= n, type= type)
    }else{
      temp<-spsample(pointsP[pointsP@data$Species == item,], n= n, type= type)
      points<-c(temp,points)
    }
  }
  points <- do.call(rbind,points) #merge all the points per class
  
  points
  
}
