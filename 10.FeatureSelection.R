############################FEATURE SELECTION##################################
#
#
#This script helps to select the features that will be used into the object-based classification
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WDIR
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Windows Xime PC

###LOAD LIBRARIES
library(rgdal)
library(dplyr)
library(sf)
library(gdata)
library(ggplot2)
library(cowplot)
library(ggpubr)
library(reshape2)
library(raster)
#library(RCurl)

###LOAD FUNCTIONS
#Local dir
source("./lib/Plot.box.R")
##or github
#script <- getURL("https://raw.githubusercontent.com/xime377/UAV-classification/master/Plot.box.R", ssl.verifypeer = F)
#eval(parse(text = script))

###LOAD TRAINING DATA
JEN14<-st_read("./JEN14/5_Training/training50005.shp") #Raster and training sets must have the same variables names
PIU02<-st_read("./PIU02/5_Training/training50005.shp") #Raster and training sets must have the same variables names
PRN01<-st_read("./PRN01/5_Training/training50005.shp") #Raster and training sets must have the same variables names
QUI01<-st_read("./QUI01/5_Training/training50005.shp") #Raster and training sets must have the same variables names
SAM01<-st_read("./SAM01/5_Training/training50005.shp") #Raster and training sets must have the same variables names
VEN01<-st_read("./VEN01/5_Training/training50005.shp") #Raster and training sets must have the same variables names
VEN02<-st_read("./VEN02/5_Training/training50005.shp") #Raster and training sets must have the same variables names
VEN03<-st_read("./VEN03/5_Training/training50005.shp") #Raster and training sets must have the same variables names
VEN04<-st_read("./VEN04/5_Training/training50005.shp") #Raster and training sets must have the same variables names
VEN05<-st_read("./VEN05/5_Training/training50005.shp") #Raster and training sets must have the same variables names

head(JEN14)


###COMBINE ALL THE DATA INTO ONE DATAFRAME
Training_all<-combine(JEN14,PIU02,PRN01,SAM01, VEN01, VEN02, VEN04, VEN05)

head(Training_all)
summary(Training_all)

names(Training_all)
names(Training_all) <- c("area",  "compactness",  "fd", 
                         "length", "max_RGB.blue", "max_RGB.green",      
                         "max_RGB.red", "mean_entr_RGB.blue",  "mean_entr_RGB.green",
                         "mean_entr_RGB.red", "mean_RGB.blue",  "mean_RGB.green",
                         "mean_RGB.red", "mean_sv_RGB.blue",  "mean_sv_RGB.green",  
                         "mean_sv_RGB.red", "median_RGB.blue",  "median_RGB.green", 
                         "median_RGB.red", "min_RGB.blue", "min_RGB.green", 
                         "min_RGB.red",  "sd_entr_RGB.blue", "sd_entr_RGB.green",  
                         "sd_entr_RGB.red",  "sd_RGB.blue", "sd_RGB.green",
                         "sd_RGB.red", "sd_sv_RGB.blue", "sd_sv_RGB.green",    
                         "sd_sv_RGB.red","CH", "class", "geometry", "plot")   #add "geometry" when working with sf

class(Training_all) #Check is it's a dataframe
str(Training_all)
Training_all<-Training_all[,-which(names(Training_all)=="geometry")] #remove the geometry column
head(Training_all)

#Change Latin names for abbreviations
N.T<-as.character(unique(Training_all$class))

Training_all$class<-ifelse(Training_all$class=="Euterpe precatoria","E. precatoria", 
                           ifelse(Training_all$class=="agua","water", ifelse(Training_all$class=="arbol", "tree",
                            ifelse(Training_all$class=="Mauritia flexuosa", "M. flexuosa",                           
                            ifelse(Training_all$class=="suelo", "soil",
                            ifelse(Training_all$class=="Mauritiella armata", "M. armata",
                            ifelse(Training_all$class=="Oenocarpus balickii", "Oenocarpus sp.",
                            ifelse(Training_all$class=="Socratea exorrhiza", "S. exorrhiza",
                            ifelse(Training_all$class=="Astrocaryum murumuru","A. murumuru",
                            ifelse(Training_all$class=="Attalea butyracea", "A. butyracea", 
                            ifelse(Training_all$class=="Oenocarpus mapora", "Oenocarpus sp.",0)))))))))))

Training_all$class<-as.factor(Training_all$class)

#Select only vegetation
Training_trees<-filter(Training_all, !(class=="water"| class=="soil"))


#Melt data into 3 columns
TData<-melt(Training_all, id=c("plot","class"), 
            variable.name= "Feature",
            value.name = "Value")

head(TData)



### GENERATE PLOTS

##Plot boxplots general
# ggplot(TData, aes(x= Feature, y= Value, fill= class))+
#   geom_boxplot()+
#   facet_wrap(~Feature, nrow=6)+
#   background_grid(major = "none", minor = "none")

p1<-plot.boxes(Training_trees, Training_trees$CH)+ylab("Canopy Height Model (m)")
p2<-plot.boxes(Training_trees, Training_trees$compactness)+ylab("Compactness")
p3<-plot.boxes(Training_trees, Training_trees$median_RGB.green)+ylab("Median values green band")
p4<-plot.boxes(Training_trees, Training_trees$mean_sv_RGB.green)+ylab("Mean sum of variance green band")
p5<-plot.boxes(Training_trees, Training_trees$mean_entr_RGB.red)+ylab("Mean entropy values red band")
p6<-plot.boxes(Training_trees, Training_trees$sd_sv_RGB.blue)+ylab("SD Sum of variance blue band")

plot_grid(p1,p2,p3,p4,p5,p6, align="h")#, #all plots together
          #labels = c("Canopy Height model", "Compactness","Median values green band", "Mean sum of variance green band", "Mean entropy values red band", "SD Sum of variance blue band"),
          #label_size = 10)


###Plot boxplots per plot (PRN01)
PRN01w<-Training_trees[Training_trees$plot %in% "PRN01",]

PRN01p1<-plot.boxes(PRN01w, PRN01w$compactness)


###Plot boxplots per plot (VEN02)
VEN02w<-Training_trees[Training_trees$plot %in% "VEN02",]

VEN02p1<-plot.boxes(VEN02w, VEN02w$compactness)+ylab("Compactness of VEN-02")

plot_grid(p1,p2,p3,p4,p5,VEN02p1, align="h") #all plots together
          

###CHECK CORRELATION
#Remove the "geometry" column
st_geometry(JEN14) <- NULL 
names(JEN14)

st_geometry(QUI01) <- NULL 
names(QUI01)

#Calculate pearson correlation
cor(JEN14[,1:31])
cor(QUI01[,1:31])

#Plot
pairs(JEN14)
