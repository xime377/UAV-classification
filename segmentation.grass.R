segmentation.grass=function(group,ext,min.size,threshold){
  #   Function to segment in grass.
  #     group: name of the group created with make.group.grass
  #     ext: extent of the segmentation. This can be 4 types
  #                 - numeric vector c(minX,maxX,minY,maxY)
  #                 - extent object (of raster for instance)
  #                 - NA: do not change extent
  #     min.size: segmentation parameter
  #     threshold: segmentation parameter
  
  
  library(rgrass7)
  library(raster)
  
  #SET EXTENT
  if (is(ext,"numeric")){
    e=extent(ext)
    execGRASS("g.region",parameters=list(n=as.character(e@ymax),
                                         s=as.character(e@ymin),
                                         e=as.character(e@xmax),
                                         w=as.character(e@xmin))) 
  }
  if (is(ext,"Extent")){
    e=ext
    execGRASS("g.region",parameters=list(n=as.character(e@ymax),
                                         s=as.character(e@ymin),
                                         e=as.character(e@xmax),
                                         w=as.character(e@xmin))) 
  }
  
  
  #SEGMENT
  execGRASS("i.segment",flags=c("overwrite"),
            parameters=list(group=group,output="segments_r",
                            minsize=min.size,threshold=threshold))
  
  
  #EXPORT
  meta=gmeta()
  path=paste(meta$GISDBASE,meta$LOCATION_NAME,meta$MAPSET,
             ".tmp","unknown",sep="\\")
  unlink(paste0(path,"\\","segments*"))
  
  #Convert to vector
  execGRASS("r.to.vect",flags=c("overwrite"), 
            parameters=list(input="segments_r",
                            output="segments_v",
                            type="area"))
  #Remove files
  meta = gmeta() 
  tmpDir = file.path(meta$GISDBASE, meta$LOCATION_NAME, meta$MAPSET, ".tmp", "unknown",sep="\\") 
  file.remove( list.files(path = tmpDir, full.names = T)) 
  
  #segments_v = readOGR("segments_v") 
  use_sp()
  segments_v=  readVECT("segments_v")
  
  segments_r=raster(readRAST("segments_r"))
  return(segments=list(segments_v=segments_v,segments_r=segments_r))
}

