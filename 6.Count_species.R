############################COUNT SPECIES##################################
#
#
#This script determines the number of individuals per palm tree species in the forestplots database per plot
#Any questions or improvements can be emailed to Ximena Tagle: xtagle@iiap.gob.pe
#
#


###SET WD
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/")

###LOAD LIBRARIES
library(dplyr)
library(broom)

###LOAD EXISTING SCRIPTS
source("./lib/count_species.R")

###LOAD DATA
dir()
JEN14<- read.csv("./JEN14/0_Plot_info/Invent_JEN14.csv", header = T)
head (JEN14)

###FILTER ARECACEAE SPECIES
JEN14_arecaceae <- JEN14[JEN14$Family == "Arecaceae", ]

#Determine the Species of that family in the plot
as.character(unique(JEN14_arecaceae$Species))


# #Determines the frequency of individuals per species in Arecaceae Family
# C.JEN14.Are<-count_species(JEN14, "Arecaceae")
# C.JEN14.Are
# n_palms <- sum(C.JEN14.Are$Frequency)
# n_palms

#Determines the frequency of individuals per species in Arecaceae Family in the last census
C.JEN14.Are2017 <- JEN14 %>%
mutate(binomial = as.character(Species)) %>%
  filter(complete.cases(DBH2.2)) %>% 
  filter(Family == "Arecaceae") %>% 
  select(binomial) %>% 
  table() %>% 
  tidy() 

n_palms2017 <- sum(C.JEN14.Are2017$Freq)
n_palms2017
