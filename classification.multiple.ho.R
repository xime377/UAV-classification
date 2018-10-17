######## Function to perform multiple classification algorithms using caret ######

classification.multiple.ho <- function(data,       #dataset
                              train.ind,
                              fmla,       #formula
                              k,          #number of folds
                              times,      #number of resamples
                              methods,    #chaclassifier,
                              tuneLength, #number of parameters to test for training the model
                              print.report, #True or False
                              output.name)
  {
  library(caret)
  library(knitr)
  library(ProjectTemplate)
  data=get_all_vars(fmla,data)
  
  ####### CREATE SETS
  train=data[train.ind,] 
  test=data[-train.ind,] 
  
  ####### CREATE FOLDS FOR TRAINING THE CLASSIFIER
  MyFolds.ho <- createMultiFolds(train[,1],k=k,times=times) 
  
  ########### TRAIN MODELS 
  MyControl.ho <- trainControl(method = "repeatedCV", index = MyFolds.ho)
  
  models.ho=list()
  for (i in 1:length(methods)){
    models.ho[[i]] <- train(fmla,train,method=methods[i],
                         trControl=MyControl.ho,tuneLength=tuneLength) #with cross-validation
  }
  
  names(models.ho)=methods

  
  ########## OVERVIEW OF RESULTS
  #######hold out
  newdata=predict(models.ho,test)
  conf.mat.ho=vector("list", length(models.ho))
  for (i in 1:length(models.ho)){
    var=eval(parse(text=paste0("test$",as.character(fmla[[2]]))))
    conf.mat.ho[[i]]=confusionMatrix(data = newdata[[i]],var)
  }
  names(conf.mat.ho)=names(newdata)
  
  #######aggregate results in a matrix
  results=matrix(NA,nrow=2+(2*length(levels(data[,1]))),ncol=length(models.ho))
  colnames(results)=names(models.ho)  
  rownames(results)=c("Overall_Acc","Kappa",paste("Prod_Acc",gsub("Class: ","",names(conf.mat.ho[[1]]$byClass[,1])),sep="."),
                      paste("User_Acc",gsub("Class: ","",names(conf.mat.ho[[1]]$byClass[,1])),sep="."))
  
  for (z in 1:length(models.ho)){
    results[1,z]=conf.mat.ho[[z]]$overall[1]#OA
    results[2,z]=conf.mat.ho[[z]]$overall[2]#Kappa
    results[3:(2+length(levels(data[,1]))),z]=conf.mat.ho[[z]]$byClass[,1]#PA
    results[(3+length(levels(data[,1]))):dim(results)[1],z]=conf.mat.ho[[z]]$byClass[,3]#PA
  }
  
  if (print.report==TRUE){
    mainDir <- "./6_Classification/reports"
    subDir <- output.name
    
    dir.create(file.path(mainDir, subDir))
   
    knit("./lib/report_classification_ho_multiple.rmd",output=paste0(file.path(
      mainDir, subDir),"/report_ho"),envir=new.env())
    knit2html(paste0(file.path(mainDir, subDir),"/report_ho"))
    file.rename("report_ho.html", paste0(file.path(mainDir, subDir),"/report_ho.html"))
    file.rename("report_ho.txt", paste0(file.path(mainDir, subDir),"/report_ho.txt"))
    write.table(results,paste0(file.path(mainDir, subDir),"/results_ho.csv"),sep=",")
  }
  
  results.ho=list(conf.mat=conf.mat.ho,models=models.ho,fmla=fmla,times=times,k=k,
              data=data,results=results)
  save(results.ho,file=paste0(file.path(mainDir, subDir),"/results_ho.Rdata"))
  
  return(results.ho)
       
}
