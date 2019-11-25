############################ACC COMPARISON##################################
#
#
#This script plots the comparison of the results of the classification per plot
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WDIR
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Xime PC

###LOAD LIBRARIES
library(ggplot2)

###LOAD ACCURACY FILE
Acc_plot<-read.csv("./Acc_plots.csv", header=T)
head(Acc_plot)
str(Acc_plot)
names(Acc_plot)
unique(Acc_plot$Species)

### PLOT
ggplot(Acc_plot, aes(x=Visibility, y=Kappa, colour=Species)) + 
  geom_line(linetype = "dashed")+
  geom_point(size=3)+
  xlab("Palm visibility (%)")+ ylab("Kappa coefficient (k)")+
  scale_colour_manual(
    values = c(
      "M. flexuosa, M. armata"="#F9AC37",
      "M. flexuosa, E. precatoria"="#17B6EB",
      "M. flexuosa, E. precatoria, M. armata"="#8c510a",
      "M. flexuosa, S. exorrhiza, A. butyracea"="#4d9221",
      "M. flexuosa, E. precatoria, S. exorrhiza, O. mapora"="#EB17E4",
      "M. flexuosa, M. armata, E. precatoria, S. exorrhiza, O. mapora"="#999999",
      "M. flexuosa, M. armata, E. precatoria, S. exorrhiza, O. balickii,  A. murumuru"="#000000"))+
  theme_bw()+                                                     #Saca el fondo plomo
  theme(panel.grid.major = element_blank(),,
        panel.grid.minor = element_blank())+ # Saca la grilla
  theme(legend.key = element_blank())+
  labs(col= "Species composition")
