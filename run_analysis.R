  library(dplyr)
  
  
  variablesNames <- read.table(file = "features.txt",header=F,col.names=c("index","name"))
  activityLabels <- read.table(file = "activity_labels.txt",header=F,col.names=c("index","activityLabels"))
  
  x_Train <- read.table(file = "train/X_train.txt", strip.white=T, header=F,comment.char = "",col.names=variablesNames[,2])
  y_Train <- read.table(file = "train/Y_train.txt",header=F,col.names=c("activity"))
  subjectTrain <- read.table(file = "train/subject_train.txt",header=F,col.names=c("subject"))  
  train <- cbind(subjectTrain,x_Train,y_Train)
  
  x_Test <- read.table(file = "test/X_test.txt", strip.white=T, header=F,comment.char = "",col.names=variablesNames[,2])
  y_Test <- read.table(file = "test/Y_test.txt",header=F,col.names=c("activity"))
  subjectTest <- read.table(file = "test/subject_test.txt",header=F,col.names=c("subject"))  
  test <- cbind(subjectTest,x_Test,y_Test)


  all <- rbind(train,test)
  allSelected <- all[,grepl("^(subject|activity)|mean|std",names(all),ignore.case = TRUE)]
  allSelectedIndex <- mutate(allSelected,index=seq(along.with=all[,1]))
  allSelectedIndexActivity <- arrange(merge(allSelectedIndex,activityLabels,by.x = "activity",by.y = "index"),index)
  allSelectedIndexActivity2 <- select(allSelectedIndexActivity,index,subject,activityLabels,-activity,tBodyAcc.mean...X:angle.Z.gravityMean.)
  
  
  names(allSelectedIndexActivity2) <- gsub("acc", "AccelerometerSignal", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("Gyro", "GyroscopeSignal", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("^t|\\.t", "TimeOf", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("^f", "FastFourierTransformOf", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("Jerk", "WithJerkSignal", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("Mag", "MagnitudeSignal", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("Freq", "Frequency", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("\\.X", ".Xaxis", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("\\.Y", ".Yaxis", names(allSelectedIndexActivity2),ignore.case=TRUE)
  names(allSelectedIndexActivity2) <- gsub("\\.Z", ".Zaxis", names(allSelectedIndexActivity2),ignore.case=TRUE)
  

  dataSetStep4 <- allSelectedIndexActivity2
  
  
  dataSetStep5 <- aggregate(.~activityLabels+subject,dataSetStep4,mean)
  dataSetStep5 <- select(dataSetStep5,-index)
  
  dataSetStep5Names <- names(dataSetStep5) 
  dataSetStep5Names <- paste(dataSetStep5Names,"averageBySubjectActivity", sep = "_")
  dataSetStep5Names[1] <- "ActivityLabels" 
  dataSetStep5Names[2] <- "Subject" 
  
  names(dataSetStep5) <- dataSetStep5Names
  
  write.table(dataSetStep5,file = "outputDataSet.txt",row.names = FALSE) 
