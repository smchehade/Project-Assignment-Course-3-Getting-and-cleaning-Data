##Load Libraries
library(ggplot2)
library(lubridate)
library(data.table)
library(rlang)


#I Downloading and Reading Table -------------------------------------------


##I.i#Download File / unzip adn assign to tables

if(!(file.exists("dataset/UCI HAR Dataset"))){
    fileurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    fdest <- file.path(getwd(),"./dataset")
    temp<- tempfile()
    download.file(fileurl,destfile = temp)
    unzip(temp,exdir = fdest)
}


##I.ii#Fetch files to tables
wdpath<-file.path(getwd(),"dataset","UCI HAR Dataset")

    ###I.ii.a#Test File
    filetestpath <- file.path(wdpath,"test")
    fileslist <- list.files(filetestpath)
    
    #construct file path for (subject_test, X_test, Y_test) and read into tables
    subject_test_fileindex <- grep("^subject",fileslist)
    subject_test_filepath <- file.path(filetestpath,fileslist[subject_test_fileindex])
    subject_test <-tbl_df(read.table(subject_test_filepath,col.names = "subject",stringsAsFactors = FALSE))
    
    
    X_test_fileindex <- grep("^[Xx]",fileslist)
    X_test_filepath <- file.path(filetestpath,fileslist[X_test_fileindex])
    X_test <-tbl_df(read.table(X_test_filepath))
    
  
    Y_test_fileindex <- grep("^[Yy]",fileslist)
    Y_test_filepath <- file.path(filetestpath,fileslist[Y_test_fileindex])
    Y_test <-tbl_df(read.table(Y_test_filepath,col.names = "activityindex",stringsAsFactors = FALSE))

  
  ###I.ii.b# Train File
  filetrainpath <- file.path(wdpath,"train")
  fileslist <- list.files(filetrainpath)
  
    #construct file path for (subject_train, X_train, Y_train) and read into tables
    subject_train_fileindex <- grep("^subject",fileslist)
    subject_train_filepath <- file.path(filetrainpath,fileslist[subject_train_fileindex])
    subject_train <-tbl_df(read.table(subject_train_filepath,col.names = "subject",stringsAsFactors = FALSE))
    
    
    X_train_fileindex <- grep("^[Xx]",fileslist)
    X_train_filepath <- file.path(filetrainpath,fileslist[X_train_fileindex])
    X_train <-tbl_df(read.table(X_train_filepath))
    
    
    Y_train_fileindex <- grep("^[Yy]",fileslist)
    Y_train_filepath <- file.path(filetrainpath,fileslist[Y_train_fileindex])
    Y_train <-tbl_df(read.table(Y_train_filepath,col.names = "activityindex",stringsAsFactors = FALSE))
  
  ###I.iii.b# UCI HAR Dataset ( fetch Labels)
    mainfileslist <- list.files(wdpath)
    
    #Activity Labels
    activity_labels_fileindex <- grep("^activity",mainfileslist)
    activity_labels_filepath <- file.path(wdpath,mainfileslist[activity_labels_fileindex])
    activity_labels <-tbl_df(read.table(activity_labels_filepath,col.names = c("activityindex","activityname"),stringsAsFactors = FALSE))
    
    #variables == features  
    features_fileindex <- grep("features.txt",mainfileslist)
    features_filepath <- file.path(wdpath,mainfileslist[features_fileindex])
    features <-tbl_df(read.table(features_filepath,col.names = c("featureindex","feature"),stringsAsFactors = FALSE))
    
   #complete variables rename
    features$feature <-gsub("Acc","Accelerometer",features$feature)
    features$feature <-gsub("Gyro","Gyroscope",features$feature)
    

#II Assigning Labels (variables[feature], activities, and subject) t --------
##Labels--> variables [ features, subject, activity_lables]
  ##II.i:Assigning Feature labels to X
  colnames(X_test) <- features$feature   
  colnames(X_train) <- features$feature
  
  

#III Merge test and train records data -----------------------------------------------
  #* III.i# Merge Records
  X<-rbind(X_test, X_train) # records
  Y<-rbind(Y_test, Y_train) #activity
  subject<-rbind(subject_test,subject_train) # subject
  
  #* III.ii# Uses descriptive activity names to name the activities in the data set
  Y <- merge(Y,activity_labels) # meaningfull activity names instead on index
 
  #* III.iii# Merge Columns (variables)
  humanactivityrecognition <- cbind(subject,Y,X)
  


#IV Independent tidy data set with the average of each variable for  --------
  #* IV.i# Extracts only the measurements on the mean and standard deviation for each measurement
  meansdcol <-grep(("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]"),colnames(humanactivityrecognition))
  definedmeanstdcol<- c(1,2, 3, meansdcol) # Add subjct, ativity index, and activity
  
  #* IV.ii# Group tables by activity and by subject
  HARbyActivitySubject <-   group_by(humanactivityrecognition[,definedmeanstdcol],activityname, subject)
  HARbyActivitySubject2 <-   group_by(humanactivityrecognition[,definedmeanstdcol],activityname, subject)
  
  #* IV.iii# Summarize table by averages on level of activity and Subject
  averageHARbyActivitySubject <- summarize_at(HARbyActivitySubject,colnames(HARbyActivitySubject)[-(1:3)],mean)
  
  
