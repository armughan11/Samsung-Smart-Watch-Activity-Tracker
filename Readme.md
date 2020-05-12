---
title: "Readme"
author: "Md Armughanuddin"
date: "12/05/2020"
output: html_document
---

## Getting and Cleaning Data Course Project

The objective of this Project is to download and clean the data collected from the accelerometers from the Samsung Galaxy S smartphone.


### Dataset

[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


### Files 

* `Codebook.md` is a code book consisting of variable and data descriptions, and the transformations performed during the cleaning of data
* `run_analysis.R` is the R script which downloads and cleans the data. It does the process in 5 steps:
  + Merges the training and the test sets to create one data set.
  + Extracts only the measurements on the mean and standard deviation for each measurement.
  + Uses descriptive activity names to name the activities in the data set
  + Appropriately labels the data set with descriptive variable names.
  + From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each     activity and each subject.
* `TidyData.txt` consists of the final cleaned data which is outputted from the script. 