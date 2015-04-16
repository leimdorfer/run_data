# run_data Codebook

## Intro

This codebook refers to the data in "run_data", which is the output from run_analysis.R. This forms part of the Coursera course "Getting and Cleaning Data". The project uses data from sensors in mobile devices recorded while 30 different subjects were involved in 6 distinct activities.

"run_data" is a subset of this data that shows the mean of all the measurements labelled "mean" or "std" in the original dataset.


## Variables in run_tidy

There are 4 variables in run_tidy, which have been extracted from the source data. The table below gives an overview of this dataset.

From the original data a mean per subject/activity has been calculated for each of the measurements in the original data that were labelled with either "mean" or "std". 

### Overview

| Variable      | Type  			| Description  	|
| ------------- |:-----------------:| -----:|
| subject      	| character (1:30) 	| Each number (as.character) refers to one of the 30 people who took part in the trial  |
| activity      | character      	| Describes the 6 different activities that were measured |
| measurement 	| character      	| Describes the aggregate measurements taken from the raw data |
| mean 			| number	   		| The calculated mean of all of the above measurements per subject per activity |


### "subject"

the numbers 1 to 30 as characters, each representing a subject in the trial

### "activity"

the activity being carried out for this measurement, from the following:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

### "measurement"

Each measurement refers to a calculation taken from the raw data. The names given by the researchers have been retained. There are 79 measurements that use either a mean or a std value from the raw data.

* "tBodyAcc-mean()-X"
* "tBodyAcc-mean()-Y" 
* "tBodyAcc-mean()-Z" 
* "tBodyAcc-std()-X" 
* "tBodyAcc-std()-Y" 
* "tBodyAcc-std()-Z" 
* "tGravityAcc-mean()-X" 
* "tGravityAcc-mean()-Y" 
* "tGravityAcc-mean()-Z" 
* "tGravityAcc-std()-X" 
* "tGravityAcc-std()-Y" 
* "tGravityAcc-std()-Z" 
* "tBodyAccJerk-mean()-X" 
* "tBodyAccJerk-mean()-Y"
* "tBodyAccJerk-mean()-Z" 
* "tBodyAccJerk-std()-X" 
* "tBodyAccJerk-std()-Y" 
* "tBodyAccJerk-std()-Z" 
* "tBodyGyro-mean()-X" 
* "tBodyGyro-mean()-Y" 
* "tBodyGyro-mean()-Z" 
* "tBodyGyro-std()-X" 
* "tBodyGyro-std()-Y" 
* "tBodyGyro-std()-Z" 
* "tBodyGyroJerk-mean()-X" 
* "tBodyGyroJerk-mean()-Y" 
* "tBodyGyroJerk-mean()-Z" 
* "tBodyGyroJerk-std()-X" 
* "tBodyGyroJerk-std()-Y" 
* "tBodyGyroJerk-std()-Z" 
* "tBodyAccMag-mean()" 
* "tBodyAccMag-std()" 
* "tGravityAccMag-mean()" 
* "tGravityAccMag-std()" 
* "tBodyAccJerkMag-mean()" 
* "tBodyAccJerkMag-std()" 
* "tBodyGyroMag-mean()" 
* "tBodyGyroMag-std()" 
* "tBodyGyroJerkMag-mean()" 
* "tBodyGyroJerkMag-std()" 
* "fBodyAcc-mean()-X" 
* "fBodyAcc-mean()-Y" 
* "fBodyAcc-mean()-Z" 
* "fBodyAcc-std()-X" 
* "fBodyAcc-std()-Y" 
* "fBodyAcc-std()-Z" 
* "fBodyAcc-meanFreq()-X" 
* "fBodyAcc-meanFreq()-Y" 
* "fBodyAcc-meanFreq()-Z" 
* "fBodyAccJerk-mean()-X" 
* "fBodyAccJerk-mean()-Y" 
* "fBodyAccJerk-mean()-Z" 
* "fBodyAccJerk-std()-X" 
* "fBodyAccJerk-std()-Y" 
* "fBodyAccJerk-std()-Z" 
* "fBodyAccJerk-meanFreq()-X" 
* "fBodyAccJerk-meanFreq()-Y" 
* "fBodyAccJerk-meanFreq()-Z" 
* "fBodyGyro-mean()-X" 
* "fBodyGyro-mean()-Y" 
* "fBodyGyro-mean()-Z" 
* "fBodyGyro-std()-X" 
* "fBodyGyro-std()-Y" 
* "fBodyGyro-std()-Z" 
* "fBodyGyro-meanFreq()-X" 
* "fBodyGyro-meanFreq()-Y" 
* "fBodyGyro-meanFreq()-Z" 
* "fBodyAccMag-mean()" 
* "fBodyAccMag-std()" 
* "fBodyAccMag-meanFreq()" 
* "fBodyBodyAccJerkMag-mean()" 
* "fBodyBodyAccJerkMag-std()" 
* "fBodyBodyAccJerkMag-meanFreq()"
* "fBodyBodyGyroMag-mean()" 
* "fBodyBodyGyroMag-std()" 
* "fBodyBodyGyroMag-meanFreq()" 
* "fBodyBodyGyroJerkMag-mean()" 
* "fBodyBodyGyroJerkMag-std()" 
* "fBodyBodyGyroJerkMag-meanFreq()" 

### "mean"

This is the mean of all the values for a given subject carrying out a given activity. They are all between -1 and 1.


## Methodology for creating run_tidy from source data

run_analysis.R is initialised with the init() function, which retrieves, merges and tidies the data by calling subsequent functions.

### init 

Init does the following:

* Loads library (dplyr)

Retrieves the data from the source

* creates *run_data* with *create_run_data*, which returns merged test and train with std and mean cols
* creates *subject_col* with  *create_subject_col*, which returns a dataframe of subjects merged from test and train
* creates *activities* with  *get_activity_vector*, which returns the activity labels data as a vector
* creates *activity_col* with  *create_activity_col*, which returns a dataframe of activities merged from test and train

* creates a new dataframe *run_data* from the retrieved data above

* passes the new dataframe and the activities vector to *tidy_the_data*, which returns the tidied *run_tidy* dataframe
* *Writes out the tidied data to run_tidy.txt*


### get_data

Takes a string with the path to the file to be opened as an argument and returns a dataframe from the file.

### create_run_data

* Reads in the data X_ and features using *get_data*
* selects std and mean columns from features into vector
* lists std and mean column names into vector
* selects only the cols in "test" and "train" that correspond to meanStd
* Assign column names from features
* Merges the data from the test and train directories
* removes unnecesary files from memory
* returns the merged data 

### create_subject_col 

* Reads in subject data from "test" and "train"
* Merges test and train subject data 
* removes unnecesary files from memory
* returns the merged data 


## get_activity_vector 

* Reads in activity_names data     
* Returns activity labels vector *activities*


## create_activity_col 

* takes *activities* as an argument
* reads in data on activities and labels from "test" and "train"
* Merges test and train activity data 
* Converts activity codes (numeric) into labels from activities* in df
* removes unnecesary files from memory
* returns the merged data with activities labelled


### tidy_the_data
      
* Create an empty df in the format we designed for the tidy data
* Loop for each subject      
* Loop for each activity 
* Creates a subset for this subject/activity
* Gets the colmeans for this subject/activity subset
* Builds a new df using subject, activity and means
* makes acolumn from the rownames and removes rownames
* Re-orders the columns of the tidy data for this subject/activity subset
* Adds this subject/activity subset to the run_tidy df
* Returns the tidied data