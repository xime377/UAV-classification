############################LIST SCRIPTS##################################
#
#
#This script generates a list of all the scripts per task in case to run them in a batch
#Any questions or suggestions can be send to Ximena Tagle: xtagle@iiap.gob.pe
#
#

###SET WD
#setwd("/home/xtagle/UAV/Results/") #Linux
setwd("G:/My Drive/Monan/RPAs/Misiones/Results/") #X PC
#setwd("C:/Users/xtagle/Google Drive/Results") #Workstation


###List all the scripts

RClip <- list.files(path=("./Scripts"), (pattern="Clipping.*.R$"), full.names=T) #Load all the scripts
RClip


