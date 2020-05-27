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
Activity Labels
activity_labels_fileindex <- grep("^activity",mainfileslist)
activity_labels_filepath <- file.path(wdpath,mainfileslist[activity_labels_fileindex])
activity_labels <-tbl_df(read.table(activity_labels_filepath,col.names = c("activityindex","activityname"),stringsAsFactors = FALSE))
features  which is the variables names that are recorded in X_test and X_train

Note: Somefeature names were change to give more complete meaning ( ACC replaced with Accelerometer,...)

For more details on the variables definition and names refere to "features_info.txt" and "features.txt"

###Section:II Assigning Labels in run_analysis.R
This section assigns labels to column names in X_test and X_train, which is the feature/variable name in "features.txt"

###Section:III Merge test and train records data  in run_analysis.R
This section merges in two dimentions. 
Rows Merging Dimension (test and train):it combines the records of test and train together to get the following:
X has records of X_test table and X_train
Y has records of Y_test table and Y_train
Subject has records of Subject_test table and Subject_train

Columns Merging Dimension (Subject, X, and Y, Activity Name)
humanactivityrecognition  is the Final Merged table


 
###Section:IV Independent tidy data set with the average of each variable grouped by activity name then subject
In this section, is constructed in 3 steps.
step 1: Select columns related to mean and standard deviation of the variables
step 2: Group the table by activity name then subject and store in **HARbyActivitySubject**
step 3: Apply the mean on each column and store in **averageHARbyActivitySubject**

