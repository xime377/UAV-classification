make.group.grass=function(input.layers,group.name){
  #Function to group rasters in grass.
  #   input.layers= character vector with the names of the layers
  #   group.name= name of the resulting group
  
  library(rgrass7)
    
  #######CREATE GROUP
  for (i in 1:length(input.layers)){
    execGRASS("i.group",parameters=list(group=group.name,
                                        input=input.layers[i]))
  }
  
}
