--------------------------------------------------
Created by Platypus 16 June 2014

----------------------------------------------------

#CodeBook.md file for course project

##Data transformations
Note: this information is replicated in 'README.md'.
#README.md file for course project
##Background to data
>_The experiments were  carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, investigators captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data._

The data were provided in a mixed format, in which test and training data were separated. Below is provided information about which files were used to tidy the data and create a merged data set that had information for all test and training subjects.

Refer to 'CodeBook.md' for details of the variables, the data, and transformations done on the data to clean them up.

NB: The following information is replicated in 'CodeBook.md'.
#The data were processed from the following files:
- 'features.txt': List of all 561 variables for which data were available (numeric and descriptive name).
- 'activity_labels.txt': class labels for the different activities along with their respective activity names.
- 'train/subject_test.txt': information relating to which subject was associated with each row of data.
- 'train/X_train.txt': variable data (561 columns) for all 21 patients within the training set.
- 'train/y_train.txt': activities for the training set, given by class label.
- 'test/subject_test.txt': information relating to which subject was associated with each row of data.
- 'test/X_test.txt': variable data (561 columns) for all 9 patients within the test set.
- 'test/y_test.txt': activities for the test set, given by class label.

'features_info.txt': gave information about the variables used on the feature vector and was used to discern which variables related to mean and standard deviations for the data.

#The script used to process the data is 'course_project.R'.
* Output files from 'course_project.R':
    * 'tidy_data.txt': all test and training data in a single data frame. Contains data for 561 variables, plus 
'activity' (descriptive), 'activity.label' (numeric) and subject (numeric).
    *  'mean_sd.txt': data frame with only the measurements on the mean and standard deviation for each measurement.
    *  'average_activity_subject.txt': data frame with the average for each variable within ''mean_sd.txt' for each activity for each subject.
* The class labels and activity name (descriptive) information from 'activity_labels.txt' are assigned to a data frame ('activity.labels').
* The feature information is assigned to a data frame ('features').
* To a data frame ('test.x' or 'train.x') containing the variable information for the test or training set are added three new columns:
    * the activity labels and subject information, under the column headings 'activity.label' and 'subject'.
    * a column ('group') that gives set-specific information about which group the data originated from ('test' or 'train'). While not necessary for the current project, future projects may require the data to be split based on whether they came from the training or test set.
 * rbind is used to combine 'test.x' and 'train.x' to create the data frame 'data'.
 * An extra column ('activity') is added to 'data' that provides descriptive names for each activity for each subject.
 * The column names, taken from  'features.txt' are edited to remove characters such us -(), (replaced with _) that may cause problems if called as part of calculations.
 * 'data' is written to the file 'tidy_data.txt'.
 * A data frame, 'mean.sd', is created that contains only information for the mean and standard deviation for each measurement. This data frame is written to the file 'mean_sd.txt'.
     * Note: only columns containing _mean and _std were included in 'mean.sd' as it is clearly stated in 'features_info.txt':
         * mean(): Mean value
         * std(): Standard deviation
        * meanFreq refers to the weighted average of the frequency components to obtain a mean frequency so columns containing this in the header were not used to create 'mean.sd'.
* 'mean.sd' is combined with 'activity' and 'subject' information from 'data' to produce the data frame 'wanted.data'. This is collapsed to produce averages for variables for each subject and each activity using aggregate() with 'subject' and 'activity' as the IDs and the rest of 'wanted.data' as the variables. The aggregated data frame is assigned to 'agg_data'.
* The column names in 'agg_data' are named appropriately,  'Avg_' is added as a prefix to column headers to indicate the data transformation that has been performed.


The .txt output files from the script can be imported into R using write.table('filename.txt', header=T, sep='\t').       

#Features information
##Feature Selection

The features contained within the output files 'mean_sd.txt', 'average_activity_subject.txt' and 'tidy_data.txt' relate to the variables detailed below, which were from 'features_info.txt'. In addition to the existing variables, new variables were created and incorporated into the data set:

* activity.label: numeric labels for activities.
* activity: descriptive labels for activities.
* subject: subject number (number between 1 and 30).
* group: whether the data came from the 'test' or the 'train' data set.

activity.label/activity

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc_XYZ and tGyro_XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc_XYZ and tGravityAcc_XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk_XYZ and tBodyGyroJerk_XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc_XYZ, fBodyAccJerk_XYZ, fBodyGyro_XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc_XYZ
- tGravityAcc_XYZ
- tBodyAccJerk_XYZ
- tBodyGyro_XYZ
- tBodyGyroJerk_XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc_XYZ
- fBodyAccJerk_XYZ
- fBodyGyro_XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean: Mean value
- std: Standard deviation
- mad: Median absolute deviation
- max: Largest value in array
- min: Smallest value in array
- sma: Signal magnitude area
- energy: Energy measure. Sum of the squares divided by the number of values. 
- iqr: Interquartile range 
- entropy: Signal entropy
- arCoeff: Autorregresion coefficients with Burg order equal to 4
- correlation: correlation coefficient between two signals
- maxInds: index of the frequency component with largest magnitude
- meanFreq: Weighted average of the frequency components to obtain a mean frequency
- skewness: skewness of the frequency domain signal 
- kurtosis: kurtosis of the frequency domain signal 
- bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

Prefix of the variable names shown above with 'Avg_' in the table 'average_activity_subject.txt' indicates that the data represent the average of all data available for a subject and their chosen activity.