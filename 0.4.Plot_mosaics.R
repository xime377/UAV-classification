############################PLOT MAPS##################################
#
#
#This script helps plots different mosaics in one layout
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WDIR
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Windows Xime PC
#setwd("~/UAV/Results/") #Linux

###LOAD LIBRARIES
library(raster)
library(maptools)
library(prettymapr)
library(RStoolbox)
library(ggplot2)
library(ggspatial)
library(cowplot)
#devtools::install_github("thomasp85/patchwork")
library(patchwork)


###LOAD FUNCTIONS
source("./lib/Plot.box.R")


###LOAD ORTHOMOSAIC
JEN14<-stack("./JEN14/1_Clip/JEN-14_3.tif") 
PIU02<-stack("./PIU02/1_Clip/PIU-02_12.tif") 
PRN01<-stack("./PRN01/1_Clip/PRN-01_1.tif") 
QUI01<-stack("./QUI01/1_Clip/QUI-01_1.tif") 
SAM01<-stack("./SAM01/1_Clip/SAM-01_all.tif") 
VEN01<-stack("./VEN01/1_Clip/VEN-01_90_65.tif") 
VEN02<-stack("./VEN02/1_Clip/VEN-02_12.tif") 
VEN03<-stack("./VEN03/1_Clip/VEN-03_2.tif") 
VEN04<-stack("./VEN04/1_Clip/VEN-04_2.tif") 
VEN05<-stack("./VEN05/1_Clip/VEN-05_1.tif") 



###VISUALIZE ALL TOGETHER (ggplot plus patchwork)
a<-plot.map(JEN14, main="JEN-14", 10)
b<-plot.map(PIU02, main="PIU-02", -28)
c<-plot.map(PRN01, main="PRN-01", -28)
d<-plot.map(QUI01, main="QUI-01", -23)
e<-plot.map(SAM01, main="SAM-01", -10)
f<-plot.map(VEN01, main="VEN-01", 2)
g<-plot.map(VEN02, main="VEN-02", -16)
h<-plot.map(VEN03, main="VEN-03",7)
i<-plot.map(VEN04, main="VEN-04", -13)
j<-plot.map(VEN05, main="VEN-05", -10)

p_left <- a+e+i+plot_layout(ncol = 1, heights = c(3,3,6))

p_center <- b+f+j+plot_layout(ncol = 1, heights = c(1,1,2))

p_middle <- c+g+plot_layout(ncol = 1, heights = c(2, 4))

p_right <- d+h+plot_layout(ncol = 1, heights = c(2, 4))

#combine different arrangements
all_p <- p_left | p_center| p_middle |p_right
all_p


# ###VISUALIZE ALL TOGETHER (basic)
# par(mfrow=c(2,2),
#     oma = c(2,2,1,1),
#     mar = c(0,1,1,2),
#     mgp=c(0,1,0))
# 
# 
# plot.RGB(JEN14, main="JEN-14")
# plot.RGB(PIU02, main="PIU-02")
# plot.RGB(PRN01, main="PRN-01")
# plot.RGB(QUI01, main="QUI-01")
# plot.RGB(SAM01, main="SAM-01")
# plot.RGB(VEN01, main="VEN-01")
# plot.RGB(VEN02, main="VEN-02")
# plot.RGB(VEN03, main="VEN-03")
# plot.RGB(VEN04, main="VEN-04")
# plot.RGB(VEN05, main="VEN-05")
# 

#EXPORT IMAGE
ggsave("./Maps/JEN-14.tiff",plot=a,dpi=300,limitsize = F)
ggsave("./Maps/PIU-02.tiff",plot=b,dpi=800,limitsize = F)
ggsave("./Maps/PRN-01.tiff",plot=c,dpi=600,limitsize = F)
ggsave("./Maps/QUI-01.tiff",plot=d,dpi=800,limitsize = F)
ggsave("./Maps/SAM-01.tiff",plot=e,dpi=600,limitsize = F)
ggsave("./Maps/VEN-01.tiff",plot=f,dpi=300,limitsize = F)
ggsave("./Maps/VEN-02.tiff",plot=g,dpi=600,limitsize = F)
ggsave("./Maps/VEN-03.tiff",plot=h,dpi=800,limitsize = F)
ggsave("./Maps/VEN-04.tiff",plot=i,dpi=600,limitsize = F)
ggsave("./Maps/VEN-05.tiff",plot=j,dpi=600,limitsize = F)

###OVERLAY
#Ground data
plot(points, bg="transparent",col="red", add=T)

#Plot boundaries