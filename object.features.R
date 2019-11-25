#######OBJECT FEATURES: FUNCTION TO CREATE OBJECT FEATURES BASED ON SEGMENTS

object.features=function(segments_r,    #Segments in raster format
                         segments_v,    #Segments in vector format
                         statistics,    #Logical: If ==TRUE the statistics listed in stat.methods are calculated
                         stat.rasters,  #Character vector of the grass-names of the rasters for which the
                         #statistics listed in stat.methods are calculated. 
                         stat.methods,  #Options: mean,sd,max,min,median ...
                         texture,       #Logical: If ==TRUE the texture parameters listed in text.methods are calculated
                         text.rasters,  #Character vector of the grass-names of the rasters for which the 
                         #texture parameters listed in text.methods are calculated
                         text.methods,  #Options: asm, contrast, corr, var, idm, sa, se, sv, entr, dv, de, moc1, moc2
                         #See  http://grass.osgeo.org/grass70/manuals/r.texture.html for more info
                         text.window,   #The size of moving window (odd and >= 3)
                         text.stats,    #How should the texture (which is pixel-based) Options: mean,sd,max,min,median ...
                         shape,         #Logical: If ==TRUE shape parameters are calculated
                         rasters.output, #Logical: If ==TRUE raster outputs are created in the return
                         texture.output #Logical: If ==TRUE raster outputs are created for the original
                         #texture (pixel-based) images
){
  
  
  library(Hmisc)
  library(rgeos)
  
  variables=as.data.frame(segments_v)["value"]
  variables=variables[order(variables$value),]
  variables=as.data.frame(variables)
  names(variables)="zone"
  
  
  meta=gmeta()
  path=paste(meta$GISDBASE,meta$LOCATION_NAME,meta$MAPSET,".tmp","unknown",sep="\\")
  
  ############STATISTICS
  if (statistics==T){
    for (i in 1:length(stat.rasters)){
      unlink(paste0(path,"\\",stat.rasters[i],"*"))
      image=raster(readRAST(stat.rasters[i]))
      
      for (t in 1:length(stat.methods)){
        stat=zonal(image,segments_r, fun=stat.methods[t])
        if((nrow(stat)!=nrow(variables))==T){
          stat= stat[-nrow(stat),]  #Se elimina la última fila que contiene NaN
        }
        variables=cbind(variables,stat[,2])
        names(variables)[dim(variables)[2]]=paste0(stat.methods[t],"_",stat.rasters[i])
      }
    }
  }
  print("#############TEXTURE")
  #############TEXTURE
  texture.images=list()
  if (texture==T){
    for (i in 1:length(text.rasters)){
      unlink(paste0(path,"\\","text*"))
      print("===r.texture")
      execGRASS("r.texture", parameters=list(input=text.rasters[i],output="text",method=text.methods,size=text.window))
      print("===r.texture FIN")
      for (t in 1:length(text.methods)){
        print("Segundo for t: ",t)
        if(text.methods[t]=="sv"){
          image=raster(readRAST(paste0("text_",toupper(text.methods[t]))))
        }else{
          image=raster(readRAST(paste0("text_",capitalize(text.methods[t]))))
        }
        texture.images[[i]]=image
        names(texture.images[[i]])=paste0(text.methods[t],"_",text.rasters[i])  
        for (q in 1:length(text.stats)){
          print("Tercer for q: ",q)
          stat=zonal(image,segments_r,fun=text.stats[q])        
          if((nrow(stat)!=nrow(variables))==T){
            print("Dentro de if: ")
            stat= stat[-nrow(stat),]  #Se elimina la ultima fila que contiene NaN
          }
          variables=cbind(variables,stat[,2])
          names(variables)[dim(variables)[2]]=paste0(text.stats[q],"_",text.methods[t],"_",text.rasters[i])
        }
      }
    }
  }
  print("##########SHAPE")
  ###############SHAPE
  if (shape==T){
    ##SHAPE
    #add fields to shape
    area=cbind(as.data.frame(segments_v),area=gArea(segments_v, byid=TRUE))
    area=area[order(area$value),]
    variables=cbind(variables,area=area$area)
    
    length=cbind(as.data.frame(segments_v),length=gLength(segments_v, byid=TRUE))
    length=length[order(length$value),]
    variables=cbind(variables,length=length$length)
    
    variables["compactness"]=variables["length"]/(2*sqrt(pi*variables["area"]))
    variables["fd"]=2*(log(variables["length"])/log(variables["area"]))
  }
  print("##########GENERATE OUTPUT")
  ################GENERATE OUTPUT
  size=dim(variables)[2]
  if (rasters.output==TRUE) {
    feature.images=list()
    for (i in 2:size){
      feature.images[[i-1]]=subs(segments_r,variables,by="zone",
                                 which=names(variables[i]))
    }
    names(feature.images)=names(variables)[2:dim(variables)[2]]
  } 
  
  if (rasters.output==T){
    return(list(features=variables,feature.images=feature.images,texture.images=texture.images))
  } else{
    return(list(features=variables))
  }
} 




