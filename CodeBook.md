#Project Title: Dataset tidyness { focusing on test and train data collections, for X and Y axis for 561 variables}
##Introduction
The analysis data is collection based on 5 activities ( their index and label can be found in "activity_labels.txt" file), and run on 30 subjects ( participants. participants are indicated by uniuqe numbers, whether in the test or the train. corresponding files can be found in "subject_test.txt" and "subject_train.txt"
Variables records are captured in X_test.txt and X_train.txt. there are 561 variables.
the corresponding subject and activity names related to the captured 561 variable records are captured in Subject and Y files correspondingly ("Subject_test.txt" and "Y_test.txt" for the test collections, and "Subject_train.txt" and "Y_train.txt" for the train collections)

##Run ANalysis Code Sections

###Section:I Downloading and Reading Table in run_analysis.R
download the files and fetch all above .txt into tables:

subject_test <-tbl_df(read.table(subject_test_filepath,col.names = "subject",stringsAsFactors = FALSE))
    
    
 
    X_test tables includes "X_test.txt"
    Y_test tables includes "y_test.txt"
    subject_test tables includes "Subject_test.txt"
  
  
    X_train tables includes "X_train.txt"
    Y_train tables includes "y_train.txt"
    subject_train tables includes "Subject_train.txt"
 
  
  
    #Activity Labels
    activity_labels_fileindex <- grep("^activity",mainfileslist)
    activity_labels_filepath <- file.path(wdpath,mainfileslist[activity_labels_fileindex])
    activity_labels <-tbl_df(read.table(activity_labels_filepath,col.names = c("activityindex","activityname"),stringsAsFactors = FALSE))
    
    #variables == features  
    features_fileindex <- grep("features.txt",mainfileslist)
    features_filepath <- file.path(wdpath,mainfileslist[features_fileindex])
    features <-tbl_df(read.table(features_filepath,col.names = c("featureindex","feature"),stringsAsFactors = FALSE))


Defining Variables, and their names

defining activity a
