
get_data<-function(input){
      
      input <- read.table(input)
      output <- tbl_df(input)
      rm(input)
      return(output)
      
}

create_run_data<-function(){     

# Read in the data X_ and features
      
      data_test <- get_data("./test/X_test.txt")
      data_train <- get_data("./train/X_train.txt")
      features <- get_data("./features.txt")
      
# select std and mean columns from features into vector

      meanStdCols <- grep("mean|std", features$V2, value = FALSE)
      
# list std and mean column names into vector

      meanStdColNames <- grep("mean|std", features$V2, value = TRUE)
      
# select only the cols in "test" and "train" that correspond to meanStd

      data_test <- data_test[,meanStdCols]
      data_train <- data_train[,meanStdCols]
      
# Assign colnames from features

      colnames(data_test) <- meanStdColNames
      colnames(data_train) <- meanStdColNames
      
# Merge test and train
      run_data <- rbind(data_test,data_train)

# Clean up
      rm(data_test,data_train,features)
      
      return(run_data)
}

create_subject_col <- function(){
      
      # read in subject data 
      subject_test <- get_data("./test/subject_test.txt")
      subject_train <- get_data("./train/subject_train.txt")
      
      # Merge test and train  
      subjects <- rbind(subject_test, subject_train)
      colnames(subjects) <- "subject"
      
      # Clean up
      rm(subject_test, subject_train)
      
      return(subjects)
}

get_activity_vector <- function(){
      
      activity_names <- get_data("./activity_labels.txt")    
      
      # create Activiy labels vector
      activities <- as.vector(activity_names$V2)
      
      # Clean up
      rm(activity_names)
      
      return(activities)
      
}

create_activity_col <- function(activities){

# read in data on activities and labels
      activities_test <- get_data("./test/y_test.txt")
      activities_train <- get_data("./train/y_train.txt")
      
# Merge test and train  
      acts <- rbind(activities_test, activities_train)

# convert activity codes into labels in df
      acts<-transmute(acts, activity = activities[acts$V1])

# Clean up
      rm(activities_test, activities_train)
      
      return(acts)
}

tidy_the_data <- function(run_data,activities){
      
# Create an empty df in the format we want it
      
      run_tidy <- data.frame(subject=character, 
                             activity=character(), 
                             measurement=character, 
                             mean=numeric)
# Loop for each subject      
      for(i in 1:30) { 

      # Loop for each activity 
            for (act in activities) { 
                  
            # Subset for this subject/activity
                  run_subset <- run_data[(run_data$subject==i & run_data$activity==act),]
                  run_subset$subject<-NULL
                  run_subset$activity<-NULL
                  
                  
            # Get the colmeans for this subject/activity dataset
                  thisMeans <- colMeans(run_subset)
            
            # Build new df using subject, activity and means
                  tidy <- cbind(i, act, thisMeans)
            
            # Move rownames to df column and remove rownames
                  tidy <- cbind(tidy,rownames(tidy))
                  rownames(tidy)<-NULL
            
            # Re-order the columns
                  colnames(tidy)<-c("subject","activity","mean", "measurement")
                  tidy<-tidy[,c("subject","activity","measurement","mean")]
            
            # Add this subject/activity subset to the run_tidy df
                  run_tidy <- rbind(run_tidy,tidy)
                  
            }
      }
      
      return(run_tidy)
      
}

init <- function(){

# Load libraries
      library(dplyr)   

# create_run_data returns merged test and train with std and mean cols
      run_data <- create_run_data()

# create_subject_col returns a df of subjects merged from test and train
      subjects_col <- create_subject_col()

# get_activity_vector returns the activity labels data as a vector
      activities <- get_activity_vector()

# create_activity_col returns a df of activities merged from test and train
      activity_col <- create_activity_col(activities)

# Add subjects and activity labels to run_data
      run_data <- cbind(subjects_col,activity_col,run_data)

##### We now have our data in one df "run_data"

# tidy_the_data() creates a tidy dataset
      run_tidy <- tidy_the_data(run_data,activities)

      write.table(run_tidy, file = "run_tidy.txt", row.name=FALSE)
}