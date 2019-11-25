############################PLOT STATISTICS##################################
#
#
#This script calculates the statistics of the RAINFOR plots using as input the database from Foresplots.net
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

#Set working directory
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/")


#Load libraries
library(rgdal)
library(ggplot2)
library(plyr)


#Info alturas JEN14
dir(,"csv")
dataJEN14<-read.csv("JEN14/0_Plot_info/Invent_JEN14.csv",header=TRUE)
head(dataJEN14)
str(dataJEN14)
summary(dataJEN14)

#Info alturas PIU02
dataPIU02<-read.csv("PIU02/0_Plot_info/Invent_PIU02.csv",header=TRUE)
head(dataPIU02)
str(dataPIU02)
summary(dataPIU02)
hist(dataPIU02$Height)


#Info alturas PRN01
dataPRN01<-read.csv("PRN01/0_Plot_info/Invent_PRN01.csv",header=TRUE)
head(dataPRN01)
str(dataPRN01)
summary(dataPRN01)
hist(dataPRN01$Height)


#Info alturas QUI01
dataQUI01<-read.csv("QUI01/0_Plot_info/Invent_QUI01.csv",header=TRUE)
head(dataQUI01)
str(dataQUI01)
summary(dataQUI01)
hist(dataQUI01$Height)


#Info alturas SAM01
dataSAM01<-read.csv("SAM01/0_Plot_info/Invent_SAM01.csv",header=TRUE)
head(dataSAM01)
str(dataSAM01)
summary(dataSAM01)
summary(dataSAM01$Species)
hist(dataSAM01$Height)

#Info alturas VEN01
dir(,"csv")
dataVEN01<-read.csv("VEN01/0_Plot_info/Invent_VEN01.csv",header=TRUE)
head(dataVEN01)
str(dataVEN01)
summary(dataVEN01$Species)
summary(dataVEN01)
hist(dataVEN01$Height.2)

##Info alturas VEN02
dataVEN02<-read.csv("VEN02/0_Plot_info/Invent_VEN02.csv",header=TRUE)
head(dataVEN02)
str(dataVEN02)
summary(dataVEN02)
hist(dataVEN02$Height.2)

##Info alturas VEN03
dataVEN03<-read.csv("VEN03/0_Plot_info/Invent_VEN03.csv",header=TRUE)
head(dataVEN03)
str(dataVEN03)
summary(dataVEN03)
hist(dataVEN03$Height.2)

##Info alturas VEN04
dataVEN04<-read.csv("VEN04/0_Plot_info/Invent_VEN04.csv",header=TRUE)
head(dataVEN04)
str(dataVEN04)
summary(dataVEN04)
hist(dataVEN04$Height.2)

##Info alturas VEN05
dataVEN05<-read.csv("VEN05/0_Plot_info/Invent_VEN05.csv",header=TRUE)
head(dataVEN05)
str(dataVEN05)
summary(dataVEN05)
hist(dataVEN05$Height.2)
