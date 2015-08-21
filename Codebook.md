
# CodeBook

To reproduce the steps I used to analyze the data, see the README.md file. This outlines the process I used. 

The original dataset is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The descriptions below refer to dataset2.txt and refer to the data frame produced through the run_analysis.R process, the final tidy data set.

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
The column names are direct descendents of these variables, only I have removed distracting hyphens and parentheses.


### Transformations performed on original dataset
1.Merges the training and the test sets to create one combined data set.

2.Extracts only the measurements on the mean and standard deviation feild for each measurement.

3.Uses descriptive activity names to name the activities in the data set. There are 6 distinct activites  :- 

    -WALKING
    -WALKING_UPSTAIRS
    -WALKING_DOWNSTAIRS
    -SITTING
    -STANDING
    -LAYING


4.Appropriately labels the data set (column names) with descriptive variable names.

5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Column Names

The table below describes the variables used in dataset2.txt, the dataset produced by the run_analysis.R script.

| Name             | Description               |
|:--------------------|:-------------|
|**Subject**	   |A subject number, from 1 to 30|
|**Activity**	   |One 0f the six activity labels| 
|**Mean and  Std** | For these type of column names, it is best to refer to the features_info.txt file from the original dataset. |

In short, all the column names that contain std are standard deviation measures, and all that contain mean are mean measures. Time domain variables begin with t, time frequency domain variables begin with f. Variables containing acc refer to acceleration values.