README.md
===========

This is the repository for Matthew Kleinsmith's course project submission for the Coursera course titled "Getting and Cleaning Data".

### Requirements:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Script: run_analysis.R

This script completes the requirements in this order: Step 1, Step 4, Step 2, Step 3, Step 5.<br />
Please see the codebook (CodeBook.md) for descriptions of the raw data set and the tidy data set.

####Step 0: Loads the data into RStudio:
`features <- read.table("UCI HAR Dataset/features.txt")`<br />
`activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")`<br /><br />

`X_train <- read.table("UCI HAR Dataset/train/X_train.txt")`<br />
`y_train <- read.table("UCI HAR Dataset/train/y_train.txt")`<br />
`subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")`<br /><br />

`X_test <- read.table("UCI HAR Dataset/test/X_test.txt")`<br />
`y_test <- read.table("UCI HAR Dataset/test/y_test.txt")`<br />
`subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")`<br /><br />

####Step 1: Merges the training and the test sets to create one data set:
First, it prepares the training set to be merged and does the same for the test set. It does this by merging the separate pieces of the training set (the subjects, the activities, and the features) and naming the subject column and the activity column:<br /><br />
`y_train_prepared <- y_train`<br />
`names(y_train_prepared) <- "Activity"`<br />
`X_train_prepared <- cbind(X_train, y_train_prepared)`<br /><br />

`subject_train_prepared <- subject_train`<br />
`names(subject_train_prepared) <- "Subject"`<br />
`X_train_prepared <- cbind(X_train_prepared, subject_train_prepared)`<br /><br />

Then, it merges the two sets row-wise:<br /><br />
`X <- rbind(X_train_prepared, X_test_prepared)`<br /><br />

####Step 4: Appropriately labels the data set with descriptive variable names:
It uses the list of feature names (features$V2) to do this.<br /><br />

`X_named <- X`<br />
`names(X_named)[1:561] <- as.character(features$V2)`<br /><br />

####Step 2. Extracts only the measurements on the mean and standard deviation for each measurement:
First, it finds the locations of the mean() and std() features in the array of feature names:<br /><br />
`mean_locations <- grep("mean\\(\\)", features$V2)`<br />
`std_locations <- grep("std\\(\\)", features$V2)`<br /><br />

Then, it uses those locations to extract the corresponding columns from the data set:<br /><br />
`mean_columns <- X_named[mean_locations]`<br />
`std_columns <- X_named[std_locations]`<br /><br />

It then combines the extracted columns as well as the Subject column and the Activity column:<br /><br />
`X_mean_std <- cbind(mean_columns, std_columns)`<br /><br />

`Activity <- X$Activity`<br />
`Subject <- X$Subject`<br />
`X_mean_std_activity_subject <- cbind(X_mean_std, Activity, Subject)`<br /><br />

####Step 3. Uses descriptive activity names to name the activities in the data set:
First it shortens the name of the data set:<br /><br />
`data <- X_mean_std_activity_subject`<br /><br />

Then it prepares the arrays of activity IDs and names:<br /><br />
`activity_ids <- activity_labels$V1`<br />
`activity_names <- activity_labels$V2`<br /><br />

And finally, it substitutes each activity ID with its corresponding activity name:<br /><br />
`for (activity_id in activity_ids) {`<br />
    
`    activity_id_locations <- which(data$Activity == activity_id)`<br />
`    activity_name <- as.character(activity_names[activity_id])`<br />
    
`    data$Activity[activity_id_locations] <- activity_name`<br />
`}`<br /><br />

####Step 5. From the data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
First, it creates an array for the subjects, an array for the activities, and an array for the variables:<br /><br />
`subjects <- unique(data$Subject)`<br />
`activities <- activity_labels$V2`<br />
`variables <- names(data)[1:66]`<br /><br />

Then, it initializes an empty data frame that will become the tidy data frame:<br /><br />
`tidy_data <- data.frame()`<br /><br />

Then, it goes through each subject-activity-variable configuration and takes the mean of all the values under the variable for that subject-activity pair, and adds a new row to the tidy data set containing that subject, that activity, and that mean:<br /><br />
`for (subject in subjects) {`<br />
    
&nbsp;&nbsp;&nbsp;&nbsp;`    for (activity in activities) {`<br />
        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        data_temp <- data.frame()`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        data_temp <- rbind(data_temp, data[1, ]) # To give the columns the correct names.`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        data_temp <- data_temp[c(68, 67, 1:66)] # To move the Subject and Activity columns to the front.`<br />
        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        means <- NULL`<br />
        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        for (variable in variables) {`<br />
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`            column_of_variable <- data[ , variable]`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`            subject_condition <- data$Subject == subject`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`            activity_condition <- data$Activity == activity`<br />
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`            values <- column_of_variable[subject_condition & activity_condition]`<br />
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`            mean <- mean(values)`<br />
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`            means <- c(means, mean)`<br />
        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        }`
        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        new_row <- c(subject, activity, means)`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        data_temp <- rbind(data_temp, new_row)`<br />
        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`        tidy_data <- rbind(tidy_data, data_temp[2, ]) # Extract only the second row. The first row is junk.`<br />
        
&nbsp;&nbsp;&nbsp;&nbsp;`    }`<br />
    
`}`<br /><br />

Then, it prefixes each variable name with "Avg_" to denote the averaging of the values: <br /><br />
`for (index in 3:68) { names(tidy_data)[index] <- paste0("Avg_", names(tidy_data)[index])}`<br /><br />

Then, it removes the row names from the tidy data set:<br /><br />
`rownames(tidy_data) <- NULL`<br /><br />

And finally, it outputs the tidy data set to "tidy_data.txt":<br /><br />
`write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)`<br /><br />

###End of script.