## ---
## title: "run_analysis.R"
## author: "Matthew Kleinsmith"
##     note: Certain comments used from the Coursera course project requirements
##           list.
## course: Getting and Cleaning Data
## date: "Friday, October 24, 2014"
## input: UCI HAR Dataset, see the section below for the exact files.
## output: Tidy dataset based on the HAR dataset, saved as tidy_data.txt
## ---

## Reads the data into R:

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Prepares the data to be merged:

y_train_prepared <- y_train
names(y_train_prepared) <- "Activity"
X_train_prepared <- cbind(X_train, y_train_prepared)

subject_train_prepared <- subject_train
names(subject_train_prepared) <- "Subject"
X_train_prepared <- cbind(X_train_prepared, subject_train_prepared)


y_test_prepared <- y_test
names(y_test_prepared) <- "Activity"
X_test_prepared <- cbind(X_test, y_test_prepared)

subject_test_prepared <- subject_test
names(subject_test_prepared) <- "Subject"
X_test_prepared <- cbind(X_test_prepared, subject_test_prepared)

#1. Merges the training and the test sets to create one data set:

X <- rbind(X_train_prepared, X_test_prepared)

#4. Appropriately labels the data set with descriptive variable names:

X_named <- X
names(X_named)[1:561] <- as.character(features$V2)

#2. Extracts only the measurements on the mean and standard deviation for each
#   measurement:

mean_locations <- grep("mean\\(\\)", features$V2)
std_locations <- grep("std\\(\\)", features$V2)

mean_columns <- X_named[mean_locations]
std_columns <- X_named[std_locations]

X_mean_std <- cbind(mean_columns, std_columns)

Activity <- X$Activity
Subject <- X$Subject

X_mean_std_activity_subject <- cbind(X_mean_std, Activity, Subject)

#3. Uses descriptive activity names to name the activities in the data set:

data <- X_mean_std_activity_subject # Makes the name of the data frame simpler.

activity_ids <- activity_labels$V1
activity_names <- activity_labels$V2

for (activity_id in activity_ids) {
    
    activity_id_locations <- which(data$Activity == activity_id)
    activity_name <- as.character(activity_names[activity_id])
    
    data$Activity[activity_id_locations] <- activity_name
}

#5. From the data set, creates a second, independent tidy data set with the
#   average of each variable for each activity and each subject.

subjects <- unique(data$Subject)
activities <- activity_labels$V2
variables <- names(data)[1:66]

tidy_data <- data.frame()
    
for (subject in subjects) {
    
    for (activity in activities) {
        
        data_temp <- data.frame()
        data_temp <- rbind(data_temp, data[1, ]) # To give the columns the correct names.
        data_temp <- data_temp[c(68, 67, 1:66)] # To move the Subject and Activity columns to the front.
        
        means <- NULL
        
        for (variable in variables) {
            
            column_of_variable <- data[ , variable]
            subject_condition <- data$Subject == subject
            activity_condition <- data$Activity == activity
            
            values <- column_of_variable[subject_condition & activity_condition]
            
            mean <- mean(values)
            
            means <- c(means, mean)
        
        }
        
        new_row <- c(subject, activity, means)
        data_temp <- rbind(data_temp, new_row)
        
        tidy_data <- rbind(tidy_data, data_temp[2, ]) # Extract only the second row. The first row is junk.
        
    }
    
}

# Concatenates "Avg_" to the beginning of each feature name:
for (index in 3:68) { names(tidy_data)[index] <- paste0("Avg_", names(tidy_data)[index])}

# Removes row names:
rownames(tidy_data) <- NULL

# Outputs the tidy data set:
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

## End of script.
