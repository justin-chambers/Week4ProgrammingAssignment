## CodeBook for Tidy Data Table

### Variable Descriptions

The following variables are columns in the tidy data table. With the exception of `subjectNumber` and `activityType`, variables are averages of selected feature data by activity and subject. All variables ending in `_average` have been calculated using R's `mean` function.

- subjectNumber : integer representing the test/training subject (ex. 1)
- activityType : string representing the activity during which the other variables were captured (ex. "laying")

The subsequent selected feature averages are numeric values represented in scientific notation (since the original feature data are in scientific notation). For more information on a specific variable name, please consult the codebook given in the source data set.

- tBodyAcc-mean()-X_average 
- tBodyAcc-mean()-Y_average
- tBodyAcc-mean()-Z_average
- tBodyAcc-std()-X_average
- tBodyAcc-std()-Y_average
- tBodyAcc-std()-Z_average
- tGravityAcc-mean()-X_average
- tGravityAcc-mean()-Y_average
- tGravityAcc-mean()-Z_average
- tGravityAcc-std()-X_average
- tGravityAcc-std()-Y_average
- tGravityAcc-std()-Z_average
- tBodyAccJerk-mean()-X_average
- tBodyAccJerk-mean()-Y_average
- tBodyAccJerk-mean()-Z_average
- tBodyAccJerk-std()-X_average
- tBodyAccJerk-std()-Y_average
- tBodyAccJerk-std()-Z_average
- tBodyGyro-mean()-X_average
- tBodyGyro-mean()-Y_average
- tBodyGyro-mean()-Z_average
- tBodyGyro-std()-X_average
- tBodyGyro-std()-Y_average
- tBodyGyro-std()-Z_average 
- tBodyGyroJerk-mean()-X_average
- tBodyGyroJerk-mean()-Y_average
- tBodyGyroJerk-mean()-Z_average
- tBodyGyroJerk-std()-X_average
- tBodyGyroJerk-std()-Y_average
- tBodyGyroJerk-std()-Z_average
- tBodyAccMag-mean()_average
- tBodyAccMag-std()_average
- tGravityAccMag-mean()_average
- tGravityAccMag-std()_average
- tBodyAccJerkMag-mean()_average
- tBodyAccJerkMag-std()_average
- tBodyGyroMag-mean()_average
- tBodyGyroMag-std()_average
- tBodyGyroJerkMag-mean()_average
- tBodyGyroJerkMag-std()_average
- fBodyAcc-mean()-X_average
- fBodyAcc-mean()-Y_average
- fBodyAcc-mean()-Z_average
- fBodyAcc-std()-X_average
- fBodyAcc-std()-Y_average
- fBodyAcc-std()-Z_average
- fBodyAccJerk-mean()-X_average
- fBodyAccJerk-mean()-Y_average
- fBodyAccJerk-mean()-Z_average
- fBodyAccJerk-std()-X_average
- fBodyAccJerk-std()-Y_average
- fBodyAccJerk-std()-Z_average
- fBodyGyro-mean()-X_average
- fBodyGyro-mean()-Y_average
- fBodyGyro-mean()-Z_average
- fBodyGyro-std()-X_average
- fBodyGyro-std()-Y_average
- fBodyGyro-std()-Z_average
- fBodyAccMag-mean()_average
- fBodyAccMag-std()_average
- fBodyBodyAccJerkMag-mean()_average
- fBodyBodyAccJerkMag-std()_average
- fBodyBodyGyroMag-mean()_average
- fBodyBodyGyroMag-std()_average
- fBodyBodyGyroJerkMag-mean()_average
- fBodyBodyGyroJerkMag-std()_average

### Description of the Data

No other data description is provided at this time.

### Transformations to Variables & Data

- activityType : In the raw data directory, the file `activity_labels.txt` contains a mapping of integers and character strings describing the activity. In both `train` and `test` directories of the raw data, `y_train.txt` and `y_test.txt` are single integer vectors whose contents represent the activity type for each observation. In the final output, the activity integer vectors are mapped to their respective descriptions so that the activity types are more easily discerned.

- subjectNumber: Since no string descriptions of the subjects are provided, the `subject_train.txt` and `subject_test.txt` data are left unchanged.

- selected features: The raw data include 561 features per observation. Only those features whose column names contain the key phrases 'mean()' or 'std()' are analyzed. A strict interpretation of the assignment requirements implies that features like <featureName>-meanFreq()-X are excluded from analysis, despite having 'mean' in the column name.
