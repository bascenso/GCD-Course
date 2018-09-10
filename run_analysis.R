## Script: run_analysis.R
##
## This script uses the 'Human Activity Recognition Using Smartphones Data Set' and does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## The original data set may be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## To use the script you should download and unzip the data set in your working directory
## The script assumes that the data set is in the 'UCI HAR Dataset' folder
##


## Check if all required files are present
## 1. Measurements files
fTestSet <- "UCI HAR Dataset/test/X_test.txt"
fTrainSet <- "UCI HAR Dataset/train/X_train.txt"

## 2. Subjects files
fTestSubjects <- "UCI HAR Dataset/test/subject_test.txt"
fTrainSubjects <- "UCI HAR Dataset/train/subject_train.txt"

## 3. Activity files
fTestActivity <- "UCI HAR Dataset/test/y_test.txt"
fTrainActivity <- "UCI HAR Dataset/train/y_train.txt"

## 4. Variable and activity names files
fVariables <- "UCI HAR Dataset/features.txt"
fActivities <- "UCI HAR Dataset/activity_labels.txt"


if (!file.exists(fTestSet) 
    || !file.exists(fTrainSet)
    || !file.exists(fTestSubjects)
    || !file.exists(fTrainSubjects)
    || !file.exists(fTestActivity)
    || !file.exists(fTrainActivity)
    || !file.exists(fVariables)
    || !file.exists(fActivities)
    ) stop ("Data set not found. Make sure to download and unzip to your working directory")


## Load all the test and training data
message("Loading data...")

tTestSet <- read.table(fTestSet) # Measurements - test set
tTrainSet <- read.table(fTrainSet) # Measurements - train set

tTestSubjects <- read.table(fTestSubjects) # Subject ID - test set
tTrainSubjects <- read.table(fTrainSubjects) # Subject ID - train set

tTestActivity <- read.table(fTestActivity) # Activity code - test set
tTrainActivity <- read.table(fTrainActivity) # Activity code - train set

tVariableNames <- read.table(fVariables) # Measurement variable names
tActivityNames <- read.table(fActivities) # Activity names


## 1. Merge the data sets
message("Data loaded. Merging data sets...")
tDataSet <- rbind(tTestSet, tTrainSet)
tSubjectSet <- rbind(tTestSubjects, tTrainSubjects)
tActivitySet <- rbind(tTestActivity, tTrainActivity)


## 2. Select only the measurements (columns) of mean and standard deviation, both to the data set and to the variable names
tDataSetMeanStd <- tDataSet[, grep("mean\\(\\)|std\\(\\)", tVariableNames$V2)]
tVariableNamesMeanStd <- tVariableNames[grep("mean\\(\\)|std\\(\\)", tVariableNames$V2), ]


## 4. Remove the '-' in the variable names to hopefully make them a little more human readable
tVariableNamesMeanStd[, 2] <- gsub("-", " ", tVariableNamesMeanStd[, 2])

## 4. Remove also the '_' in the activity names
tActivityNames[, 2] <- gsub("_", " ", tActivityNames[, 2])

## 3. Convert Activity Ids to Activity Names
tActivitySet$Activity <- sapply(tActivitySet, function(x) tActivityNames[x, 2])
tActivitySet <- tActivitySet[-1] # Get rid of the first column

## 4. Assign the names of the variables to the columns of the data sets
names(tDataSetMeanStd) <- tVariableNamesMeanStd[, 2]
names(tSubjectSet) <- "Subject"

## Now, combine all 3 data sets in the order Subject, Activity, Measurements
tResults <- cbind(tSubjectSet, tActivitySet, tDataSetMeanStd)

## 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject
meltedResults <- melt(tResults, id.vars=c("Subject", "Activity"))
tMeans <- dcast(meltedResults, Subject + Activity ~ variable, mean)

## clarify variable names
names(tMeans)[3:68] <- paste0 ("Average of: ", names(tMeans)[3:68])

## Finally, write both data sets to the working directory
write.table(tResults, "measurements.txt", sep = ",")
write.table(tMeans, "means.txt", sep = ",")

