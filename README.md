# Assignment: Getting and Cleaning Data Course Project
## Description
This repo contains all the files of the assignment of the Getting and Cleaning Data Course Project

## Assignment instructions:
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## How to run the analysis
You should take the following steps to run the analysis:

1. Download the data set from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Uncompress the zip to your local computer. It will create a folder named `UCI HAR Dataset`
3. Set R working directory to be the directory where the zip was uncompressed (i.e. the parent of `UCI HAR Dataset`)
4. Run the script `run_analysis.R`, either manually or using source(). It will create a local file called `means.txt`

## Author
Bruno Ascenso, Sep 10, 2018
