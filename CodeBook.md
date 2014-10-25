CodeBook.md
===========

### Raw Data

File path                               | Description                                                                         
----------------------------------------|-------------------------------------------------------------------------------------
UCI HAR Dataset/train/subject_train.txt | Train set subjects: 7352 observations and one variable
UCI HAR Dataset/train/y_train.txt       | Train set activities: 7352 observations and one variable.
UCI HAR Dataset/train/X_train.txt       | Train set features: 7352 observations and 561 variables.
UCI HAR Dataset/test/subject_test.txt   | Test set subjects: 2947 observations and one variable.
UCI HAR Dataset/test/y_test.txt         | Test set activities: 2947 observations and one variable.
UCI HAR Dataset/test/X_test.txt         | Test set features: 2947 observations and 561 variables.
UCI HAR Dataset/features.txt            | Feature names: 561 feature names.
UCI HAR Dataset/activity_labels.txt     | Activity names: Six activity names.


        
### Tidy Data

File path     | Description                                                                         
--------------|-------------------------------------------------------------------------------------
tidy_data.txt | Tidy data set: 180 observations and 68 variables. The first variable is the subject, the second is the activity name, and the rest are the averages of the mean() and std() features with respect to the given subject-activity pair.

#### From Raw Data to Tidy Data:

0. Load the data into RStudio.<br /><br />
1. Merge the train set subjects, activities, and features into one data frame.<br /><br />
	a. This is a column-wise merge.<br /><br />
2. Do the same for the test set files.<br /><br />
3. Merge the train set with the test set.<br /><br />
	a. This is a row-wise merge.<br /><br />
4. Use the feature-names file to name the columns of the new data set.<br /><br />
5. Subset this data set into a data set only containing the following columns:<br /><br />
	a. Subject<br /><br />
	b. Activity<br /><br />
	c. mean() or std() features<br /><br />
6. Use the activity-names file to name the activities.<br /><br />
7. Create a new data set from the above data set by averaging the features with respect to a given subject-activity pair.<br /><br />
	a. Prefix the feature names with "Avg_" to denote this change.<br /><br />
8. Output this tidy data set to "tidy_data.txt".

#### Notes:

No units were given in the tidy data because no units were given in the raw data.<br /><br />
The data is tidy because each row is an observation, each column is a variable, and each table corresponds to one type of observation. (For the definition of "tidy data" used in this project see page 4 of Dr. Wickham's paper on tidy data: http://vita.had.co.nz/papers/tidy-data.pdf)

#### Variables and Their Descriptions

Variable                           | Description                                                                   
-----------------------------------|-------------------------------------------------------------------------------------
Subject                            | Subject ID of the subject who performed the activity. There were 30 subjects.
Activity                           | Activity name
Avg_tBodyAcc-mean()-X                  | Average of the means of the body acceleration in the X-axis in the time domain.
Avg_tBodyAcc-mean()-Y                  | Average of the ... in the Y-axis
Avg_tBodyAcc-mean()-Z                  | Average of the ... in the Z-axis
Avg_tGravityAcc-mean()-X               | Average of the means of the gravity acceleration in the X-axis in the time domain.
Avg_tGravityAcc-mean()-Y               | Average of the ... in the Y-axis
Avg_tGravityAcc-mean()-Z               | Average of the ... in the Z-axis
Avg_tBodyAccJerk-mean()-X              | Average of the means of the derivative of the body acceleration in the X-axis in the time domain.
Avg_tBodyAccJerk-mean()-Y              | Average of the ... in the Y-axis
Avg_tBodyAccJerk-mean()-Z              | Average of the ... in the Z-axis
Avg_tBodyGyro-mean()-X                 | Average of the means of the body angular velocity in the X-axis in the time domain.
Avg_tBodyGyro-mean()-Y                 | Average of the ... in the Y-axis
Avg_tBodyGyro-mean()-Z                 | Average of the ... in the Z-axis
Avg_tBodyGyroJerk-mean()-X             | Average of the means of the derivative of the body angular velocity in the X-axis in the time domain.
Avg_tBodyGyroJerk-mean()-Y             | Average of the ... in the Y-axis
Avg_tBodyGyroJerk-mean()-Z             | Average of the ... in the Z-axis
Avg_tBodyAccMag-mean()                 | Average of the means of the magnitude of the three-dimensional body acceleration signal in the time domain calculated using the Euclidean norm.
Avg_tGravityAccMag-mean()              | Average of the means of the magnitude of the three-dimensional gravity acceleration signal ... .
Avg_tBodyAccJerkMag-mean()             | Average of the means of the magnitude of the derivative of the three-dimensional body acceleration signal ... .
Avg_tBodyGyroMag-mean()                | Average of the means of the magnitude of the three-dimensional the angular velocity signal ... .
Avg_tBodyGyroJerkMag-mean()            | Average of the means of the magnitude of the derivative the three-dimensional angular velocity signal ... .
Avg_fBodyAcc-mean()-X                  | Average of the means of the body acceleration in the X-axis in the frequency domain.
Avg_fBodyAcc-mean()-Y                  | Average of the ... in the Y-axis
Avg_fBodyAcc-mean()-Z                  | Average of the ... in the Z-axis
Avg_fBodyAccJerk-mean()-X              | Average of the means of the derivative of the body acceleration in the X-axis in the frequency domain.
Avg_fBodyAccJerk-mean()-Y              | Average of the ... in the Y-axis
Avg_fBodyAccJerk-mean()-Z              | Average of the ... in the Z-axis
Avg_fBodyGyro-mean()-X                 | Average of the means of the angular velocity in the X-axis in the frequency domain.
Avg_fBodyGyro-mean()-Y                 | Average of the ... in the Y-axis
Avg_fBodyGyro-mean()-Z                 | Average of the ... in the Z-axis
Avg_fBodyAccMag-mean()                 | Average of the means of the magnitude of the three-dimensional body acceleration signal in the frequency domain calculated using the Euclidean norm.
Avg_fBodyBodyAccJerkMag-mean()         | Average of the means of the magnitude of the derivative of the three-dimensional body acceleration signal ... .
Avg_fBodyBodyGyroMag-mean()            | Average of the means of the magnitude of the three-dimensional the angular velocity signal ... .
Avg_fBodyBodyGyroJerkMag-mean()        | Average of the means of the magnitude of the derivative of the three-dimensional angular velocity signal ... .
Avg_tBodyAcc-std()-X                   | Average of the standard deviations of the body acceleration in the X-axis in the time domain.
Avg_tBodyAcc-std()-Y                   | Average of the ... in the Y-axis
Avg_tBodyAcc-std()-Z                   | Average of the ... in the Z-axis
Avg_tGravityAcc-std()-X                | Average of the standard deviations of the gravity acceleration in the X-axis in the time domain.
Avg_tGravityAcc-std()-Y                | Average of the ... in the Y-axis
Avg_tGravityAcc-std()-Z                | Average of the ... in the Z-axis
Avg_tBodyAccJerk-std()-X               | Average of the standard deviations of the derivative of the body acceleration in the X-axis in the time domain.
Avg_tBodyAccJerk-std()-Y               | Average of the ... in the Y-axis
Avg_tBodyAccJerk-std()-Z               | Average of the ... in the Z-axis
Avg_tBodyGyro-std()-X                  | Average of the standard deviations of the angular velocity in the X-axis in the time domain.
Avg_tBodyGyro-std()-Y                  | Average of the ... in the Y-axis
Avg_tBodyGyro-std()-Z                  | Average of the ... in the Z-axis
Avg_tBodyGyroJerk-std()-X              | Average of the standard deviations of the derivative of the angular velocity in the X-axis in the time domain.
Avg_tBodyGyroJerk-std()-Y              | Average of the ... in the Y-axis
Avg_tBodyGyroJerk-std()-Z              | Average of the ... in the Z-axis
Avg_tBodyAccMag-std()                  | Average of the standard deviations of the magnitude of the three-dimensional body acceleration signal in the time domain calculated using the Euclidean norm.
Avg_tGravityAccMag-std()               | Average of the standard deviations of the magnitude of the three-dimensional gravity acceleration signal ... .
Avg_tBodyAccJerkMag-std()              | Average of the standard deviations of the magnitude of the derivative of the three-dimensional body acceleration signal ... .
Avg_tBodyGyroMag-std()                 | Average of the standard deviations of the magnitude of the three-dimensional angular velocity signal ... .
Avg_tBodyGyroJerkMag-std()             | Average of the standard deviations of the magnitude of the derivative of the three-dimensional angular velocity signal ... .
Avg_fBodyAcc-std()-X                   | Average of the standard deviations of the body acceleration in the X-axis in the frequency domain.
Avg_fBodyAcc-std()-Y                   | Average of the ... in the Y-axis
Avg_fBodyAcc-std()-Z                   | Average of the ... in the Z-axis
Avg_fBodyAccJerk-std()-X               | Average of the standard deviations of the derivative of the body acceleration in the X-axis in the frequency domain.
Avg_fBodyAccJerk-std()-Y               | Average of the ... in the Y-axis
Avg_fBodyAccJerk-std()-Z               | Average of the ... in the Z-axis
Avg_fBodyGyro-std()-X                  | Average of the standard deviations of the angular velocity in the X-axis in the frequency domain.
Avg_fBodyGyro-std()-Y                  | Average of the ... in the Y-axis
Avg_fBodyGyro-std()-Z                  | Average of the ... in the Z-axis
Avg_fBodyAccMag-std()                  | Average of the standard deviations of the magnitude of the three-dimensional body acceleration signal in the frequency domain calculated using the Euclidean norm.
Avg_fBodyBodyAccJerkMag-std()          | Average of the standard deviations of the magnitude of the derivative of the three-dimensional body acceleration signal ... .
Avg_fBodyBodyGyroMag-std()             | Average of the standard deviations of the magnitude of the three-dimensional angular velocity signal ... .
Avg_fBodyBodyGyroJerkMag-std()         | Average of the standard deviations of the magnitude of the derivative of the three-dimensional angular velocity signal ... .