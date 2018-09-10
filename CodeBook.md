# Code Book

## Description
This code book describes the variables, the data, and the exact steps performed to clean up the data.

## Input Data
The input data is a zip file obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It contains the following files that are used in the analysis:
* X_test.txt - contains the measurements of the 'test' group of data
* X_train.txt - contains the measurements of the 'train' group of data

* subject_test.txt - contains the id of the subject for each observation of the 'test' group
* subject_train.txt - contains the id of the subject for each observation of the 'train' group

* y_test.txt - contains the id of the activity performed in each observation of the 'test' group
* y_train.txt - contains the id of the activity performed in each observation of the 'train' group

* features.txt - contains the list of the variables measured
* activity_labels.txt - contains the descriptive names of the activities


## Transformations
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
The output data consists of the follwing two files:

* measurements.txt - a tidy data set with the measurements on the mean and standard deviation (CSV file)
* means.txt - a tidy data set with the average of each variable for each activity and each subject (CSV file)
