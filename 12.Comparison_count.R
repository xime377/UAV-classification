############################COMPARISON COUNT##################################
#
#
#This script compares the results of the quantification step (classification + clipping the CH) with the ground data
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#
###SET WD
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/")
# setwd("C:/Users/xtagle/Google Drive/Results/")

###LOAD LIBRARIES
library(dplyr)

###LOAD RESULTS
Data_P <- read.csv("./Palm_counting.csv", header=T)
head (Data_P)
names(Data_P)

###COMPARISON OF RESULTS PER SPECIES
#Select Mauritia
MFlex<-Data_P[,1:3]
head(MFlex)
Vis<-filter(MFlex, type=="Visible UAV")
Clas<-filter(MFlex, type=="Classification")
Groun<-filter(MFlex, type=="Ground data")
  
#Selec Mauritiella
MArm<-Data_P[,c(1:2,4)]
head(MArm)
VisMA<-filter(MArm, type=="Visible UAV")
VisMA<-VisMA %>% filter(!is.na(Mauritiella.armata))

ClasMA<-filter(MArm, type=="Classification")
ClasMA<-ClasMA %>% filter(!is.na(Mauritiella.armata))

GrounMA<-filter(MArm, type=="Ground data")
GrounMA<-GrounMA %>% filter(!is.na(Mauritiella.armata))

###Plot
#Vis vs Class
plot(Vis$Mauritia.flexuosa,Clas$Mauritia.flexuosa, pch=19, col="red", xlab="No. M. flexuosa palms visible in the UAV mosaic",
     ylab="No. M. flexuosa palms in the classification", xlim = c(0,180), ylim = c(0,140))
lm(Clas$Mauritia.flexuosa~Vis$Mauritia.flexuosa)
summary(lm(Clas$Mauritia.flexuosa~Vis$Mauritia.flexuosa))
abline(0, 1) #1:1
abline(26.3173,0.6877, lty=2, col="#969696")

plot(VisMA$Mauritiella.armata,ClasMA$Mauritiella.armata, pch=19, col="blue", xlab="No. M. armata palms visible in the UAV mosaic",
     ylab="No. M. armata palms in the classification", xlim = c(0,120), ylim = c(0,140))
lm(ClasMA$Mauritiella.armata~VisMA$Mauritiella.armata)
summary(lm(ClasMA$Mauritiella.armata~VisMA$Mauritiella.armata))
abline(0, 1) #1:1
abline(4.4458,0.8819, lty=2, col="#969696")

#Ground vs Class
plot(Groun$Mauritia.flexuosa,Clas$Mauritia.flexuosa, pch=19, col="red", xlab="No. M. flexuosa palms in RAINFOR plot",
     ylab="No. M. flexuosa palms in the classification", xlim = c(0,180), ylim = c(0,140))
lm(Clas$Mauritia.flexuosa~Groun$Mauritia.flexuosa)
summary(lm(Clas$Mauritia.flexuosa~Groun$Mauritia.flexuosa))
abline(0, 1)
abline(34.5485,0.4575, lty=2, col="#969696")

plot(GrounMA$Mauritiella.armata,ClasMA$Mauritiella.armata, pch=19, col="blue", xlab="No. M. armata palms in RAINFOR plot",
     ylab="No. M. armata palms in the classification", xlim = c(0,120), ylim = c(0,140))
lm(ClasMA$Mauritiella.armata~GrounMA$Mauritiella.armata)
summary(lm(ClasMA$Mauritiella.armata~GrounMA$Mauritiella.armata))
abline(0, 1)
abline(0.1323,0.6482, lty=2, col="#969696")
