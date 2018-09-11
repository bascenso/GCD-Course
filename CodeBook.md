# Code Book

## Description
This code book describes the variables, the data, and the exact steps performed to clean up the data.

## Input Data
The input data is a zip file obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Description of the data set:

Name: `Human Activity Recognition Using Smartphones Dataset`
Version: `Version 1.0`

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

## Transformations performed by the script:
The transformation of the data followed these steps:
1. Combining the data sets train and test
2. Selecting only the appropriate variables
3. Formatting and adding variable names
4. Merging to a single data set
5. Extracting the average of the variables

### 1. Combining the data sets train and test
All the files were loaded using data.table().

The data sets corresponding to the train and test groups are first combined using rbind(), test data first.
This results in 3 data sets - measurements, subjects and observations - each with all the observations of both the test and train groups.

### 2. Selecting only the appropriate variables
To select the measurements on mean and standard deviation, the list of variables was filtered by those that have 'mean()' or 'std()' in the name, using:
grep("mean\\(\\)|std\\(\\)", variableNames)

The data set with the measurements was cut with only the columns that correspond to measures of mean or std.

### 3. Formatting and adding variable names
The variable names were made more readable by removing the '-' and the activity names by removing the '_'.

The activity list was converted to activity names, by matching the ids in the names data set.

The names given to the columns of the data sets were:
* Measurements - names of the variables, after removing the '-'
* Activities - the column was named 'Activity'
* Subjects - the column was named 'Subject'

### 4. Merging to a single data set
The 3 data sets were merged using cbind() in the order Subject, Activity, Measurements.

### 5. Extracting the average of the variables
The average of each variable for each activity and subject was obtained by applying melt() by Subject and Activity, followed by dcast() by Subject and Activity with the function mean.

## Output data
The output data consists of the follwing file:

* means.txt - a tidy data set with the average of each variable for each activity and each subject (CSV file)

## License information
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

