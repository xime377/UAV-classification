##Point to polygon function
#'
#' @param pointsP Data frame with Vertex, Latitude, Longitude and Altitude (From ForestPlots)
#'
#' @return sf Polygon 

Point.to.poly<-function(pointsP){
  
  P.matrix <- as.matrix(pointsP@coords[,1:2]) #convert it to a matrix and subsets only the coordinates
  C.Poly <- rbind(P.matrix, P.matrix[1,]) # Add the initial coordinate to close the polygon
  O.Poly <- Polygon(C.Poly) # creates a polygon object
  P.Polys<-Polygons(list(O.Poly), ID = "Plot")
  Polys<-SpatialPolygons(list(P.Polys), 
          proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")) # wrap it in a spatial polygons object
  Polys
  }



