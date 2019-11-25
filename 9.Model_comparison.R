############################MODEL COMPARISON##################################
#
#
#This script compare the accuracy of the different classification techniques used
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WDIR
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #Xime PC


###LOAD ACCURACY FILES
Acc_all<-read.csv("./Acc_all.csv", header=T)
head(Acc_all)
str(Acc_all)


Acc_5<-read.csv("./Acc_5.csv", header=T)
head(Acc_5)
str(Acc_5)

### ANOVA ANALYSIS
#For all
comp.test.K<-aov(Kappa~Classifier,data=Acc_all)
comp.test.OA<-aov(OA~Classifier,data=Acc_all)

summary(comp.test.K)
summary(comp.test.OA)

#For 5
comp.test.K5<-aov(Kappa~Classifier,data=Acc_all)
comp.test.OA5<-aov(OA~Classifier,data=Acc_5)

summary(comp.test.K5)
summary(comp.test.OA5)

## TUKCEY HONEST SIGNIFICANT DIFFERENCES (POST-HOC TEST)
#For all
TukeyHSD(comp.test.K)
TukeyHSD(comp.test.OA)

#For 5
TukeyHSD(comp.test.K5)
TukeyHSD(comp.test.OA5)

###VISUALIZE THE DIFFERENCES
#For all
boxplot(Kappa~Classifier,data=Acc_all)
boxplot(OA~Classifier,data=Acc_all)

#For 5
boxplot(Kappa~Classifier,data=Acc_all)
boxplot(OA~Classifier,data=Acc_all)
