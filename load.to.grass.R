load.to.grass=function(raster.list,grass.names){
  #Function to load georeferenced files in grass.
  #   raster.list= list with paths of the files
  #   grass.names= character vector of the resulting grass layers
  
  library(rgrass7)
  
  for (i in 1:length(raster.list)){
    execGRASS("r.in.gdal", flags="o", parameters=list(
      input=raster.list[i], 
      output=grass.names[i]))
  }
 }

