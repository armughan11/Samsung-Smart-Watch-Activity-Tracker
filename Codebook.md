---
title: "Codebook"
author: "Md Armughanuddin"
date: "12/05/2020"
output: html_document
---

## Getting and Cleaning Data from Acceloremetersm the Samsung Galaxy S smartphone

The objective of the ` run_analysis.R ` script is to obtain the data and cleaning it up for further analysis. We follow the five steps which are given in the Course Project Description and finally save the output as `TidyData.txt`

### Downloading the Data

The first step towards this project is downloading the Data. The script checks if the data folder already exists or not, and if it does not, it goes on to proceed with the download of the Dataset.We use `file.download` and `unzip` to download and unzip the dataset, respectively. 

* `fileUrl` saves the URL of the Dataset

### Assigning the Data to Variables

We assign the respective datasets to the Variables for cleaning and merging the data.

* `path` saves the URL to the UCI HAR Dataset folder, which contains the data

* `activitytest` stores all the data from `Y_test.txt` and consists of the activity codes for the test data
* `activitytrain` stores all the data from `Y_train.txt` and consists of the activity codes for the train data

* `subjecttest` stores all the data from `subject_test.txt` and consists of the subject codes for the test data
* `subjecttrain` stores all the data from `subect_train.txt` and consists of the subject codes for the train data

* `measurementtest` stores all the data from `X_test.txt` and consists of the measurements for the test data
* `measurementtrain` stores all the data from `X_train.txt` and consists of the measurements for the train data

* `featurenames` stores all the data from `features.txt` and consists of the feature names. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ

* `activityLabels` stores all the data from `activity_labels.txt` and consists of all the activity labels

### Merging the Data and Naming Columns 

Once the test and train data is assigned, we merge it and label the columns.

* `measurement` contains the test and train data of measurements. The column names are named with the help of `featurenames`
* `subject` contains the test and train data of subject. The column name is set as `Subject`
* `activity` contains the test and train data of activity. The column name is set as `Activity`

* `MergedData1` contains the merged data from measurement, subject, and activity

### Extract only the measurements on the mean and standard deviation for each measurement

We subset `MergedData1` to only include the measurements with mean and standard deviation.

*`subdataFeatures` consists of all the column names with mean and std
* `namesfinal` consists of the final list of columns we want in the Tidy Dataset
* `TidyData` consists of the final tidied data which is a subset of MergedData1 by selecting `namesfinal`

### Replace Activities with Descriptive Activity Names
We replace `TidyData$Activity` with the descriptive activity names from `activityLabels`

### Labelling the Variables with descriptive names
We replace the incomplete column names with complete names
* All names starting with `t` replaced with `time`
* All names starting with `f` replaced with `frequency`
* All names with `Acc` replaced with `Accelorometer`
* All names with `Gyro` replaced with `Gyroscope`
* All names with `Mag` replaced with `Magnitude`
* All names with `BodyBody` replaced with `Body`

###From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

We group the data by subject and activity, and then find the mean.

* `TidyData_Final` contains the Tidy Data grouped by subject and activity, with the average of each variable being taken using the `mean` function

###Writing the Output using write.table
We save the ouput of `TidyData_Final` to `TidyData.txt` using the `write.table` command 