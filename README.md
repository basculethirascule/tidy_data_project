---------------------------------------------------
Created by Platypus 16 June 2014

----------------------------------------------------

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
    *  'mean_sd.txt': data frame with only the measurements on the mean and standard deviation for each measurement for each subject ('subject', numeric), activity ('activity', numeric), activity label ('activitylabel', descriptive) and group ('group', test or train, descriptive). 
    *  'average_activity_subject.txt': data frame with the average for each variable within ''mean_sd.txt' for each activity for each subject.

 
The class labels and activity name (descriptive) information from 'activity_labels.txt' are assigned to a data frame ('activity.labels').

The feature information is assigned to a data frame ('features').

To a data frame ('test.x' or 'train.x') containing the variable information for the test or training set are added three new columns:

* The activity labels and subject information, under the column headings 'activity.label' and 'subject'.
* a column ('group') that gives set-specific information about which group the data originated from ('test' or 'train'). While not necessary for the current project, future projects may require the data to be split based on whether they came from the training or test set.

rbind is used to combine 'test.x' and 'train.x' to create the data frame 'data'.

* An extra column ('activity') is added to 'data' that provides descriptive names for each activity for each subject.
* The column names, taken from  'features.txt' are edited to remove characters such as -(),. that may cause problems if called as part of calculations.
* Code is included to identify duplicate column names in the data frame 'data'. While not an issue for this assignment, these columns would need to be renamed if used in future analyses.
 * A data frame, 'mean.sd', is created that contains only information for the mean and standard deviation for each measurement for each subject, activity, activity label and group. This data frame is written to the file 'mean_sd.txt'.
     * Note: only columns containing mean and std were included in 'mean.sd' as it is clearly stated in 'features_info.txt':
         * mean(): Mean value
         * std(): Standard deviation
        * meanFreq refers to the weighted average of the frequency components to obtain a mean frequency so columns containing this in the header were not used to create 'mean.sd'.
* 'mean.sd' is written to a tab-separated text file.
* 'mean.sd' ('activity', 'subject', mean and sd columns) is used to create 'wanted.data', which is used to create the aggregated data frame 'agg_data'.
* The column names in 'agg_data' are named appropriately. 'avg' is added as a prefix to column headers to indicate the data transformation that has been performed.
* 'agg_data' is written to a tab-separated text file. It is a tidy data file.

The .txt output files from the script can be imported into R using read.table('filename.txt', header=T, sep='\t').
