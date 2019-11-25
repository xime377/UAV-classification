#Function to plot boxplots per class

plot.boxes <- function(my_data,y)
{
  #function to plot boxplots with different colors per class
  g <- ggplot(my_data, aes(x = class, y = y , fill=class)) + 
    geom_boxplot()+ theme_bw()+
    theme(axis.title.x = element_blank(),
        axis.title.y = element_text(size=14, face="bold"),
         panel.border = element_blank(),
         axis.line = element_line(colour = "black"))+
    scale_fill_manual(
      values = c(
        "A. butyracea"="#f69898", 
        "A. murumuru"="#d0cece",
        "E. precatoria"="#ffed35",
        "M. armata"="#1f78b4",
        "M. flexuosa"="#db1e2a",
        "Oenocarpus sp."="#7030a0",
        "S. exorrhiza"= "#31f800",
        "tree"="#1c7919"))+
    rotate_x_text(angle=45)+
    guides(fill=FALSE)+
    background_grid(major = "none", minor = "none")
  return(g)
}



#Function to plot RGB mosaics with North Arrow and scale bar (plots coordinate system in lat lon)

# plot.map <- function(my_mosaic,main=NULL)
# {
#   g <- ggplot()+
#     layer_spatial(my_mosaic)+
#     scale_fill_continuous(na.value = NA)+
#     background_grid(major = "none", minor = "none")+
#     annotation_scale(location = "bl", width_hint = 0.25,
#                      pad_x = unit(0.2, "cm"), pad_y = unit(0.1, "cm"),) +   #location is the abbreviation of bottomleft,topright..
#     annotation_north_arrow(location = "bl", which_north = "TRUE", 
#                            pad_x = unit(0.75, "cm"), pad_y = unit(0.5, "cm"),
#                           style = north_arrow_minimal) + #other options: north_arrow_fancy_orienteering,north_arrow_nautical, north_arrow_minimal
#     ggtitle(main)
#   return(g)
# }


#Function to plot RGB mosaics with North Arrow and scale bar (plots coordinate system in UTM)

plot.map <- function(my_mosaic,main=NULL, extend = 0)
{
  g <- ggRGB(my_mosaic, stretch = 'lin')+
    theme_bw(base_size = 11)+
    theme(axis.title.x =element_blank(),
          axis.title.y = element_blank(),
          axis.text.y.left = element_text(angle=90, vjust=0.5, hjust=0.5),
          plot.title = element_text(hjust = 0.5, vjust=-8),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          plot.margin = unit(c(0.1,0.1, 0.1,0.1),"cm"))+
    scale_fill_continuous(na.value = NA)+ #ggspatial
    annotation_scale(location = "bl", width_hint = 0.25,
                     pad_x = unit(0.2, "cm"), pad_y = unit(0.1, "cm")) +   #ADD scale bar. location is the abbreviation of bottomleft,topright..
    #coord_sf()+
    annotation_north_arrow(location = "bl", which_north = "true", 
                           pad_x = unit(0.2, "cm"), pad_y = unit(0.35, "cm"),
                           style = north_arrow_fancy_orienteering) +        #ADD north arrow, options: north_arrow_fancy_orienteering,north_arrow_nautical, north_arrow_minimal
    ggtitle(main) +
    xlim(c(extent(my_mosaic)@xmin - extend, extent(my_mosaic)@xmax + extend
    )) +
    ylim(c(extent(my_mosaic)@ymin - extend, extent(my_mosaic)@ymax + extend
    ))
  return(g)
}


##Function to plot RGB mosaics with North Arrow and scale bar (plots coordinate system in UTM)

plot.RGB <- function(my_mosaic,main=NULL)
{
  plotRGB(my_mosaic, colNA='white', axes=T, yaxt='n',xaxt='n', ann=FALSE)
  axis(side=1,las=1,cex.axis=0.5, mgp=c(0,0,0),mar=(c(10,10,10,10))) 
  axis(side=2,las=0,cex.axis=0.5,mgp=c(0, 0.5,0), mar=(c(10,10,10,10)))
  title(main, line = -2)
  addscalebar(plotepsg=32718, padin = c(0.15, 0.15))
  addnortharrow(pos = "bottomleft", text.col = "black", 
                border = "black", cols = c("white", "black"), scale= 0.5,
                padin = c(0.15, 0.35), lwd = 1)
  box()
    }