library(dplyr)
# Downloading te data and saving it to a file data.zip. Once downloaded, we extract the data.
if(!file.exists("./data")){dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/data.zip",method="curl")
unzip(zipfile="./data/data.zip",exdir="./data")}


#reading the files from UCI HAR Dataset
path <- file.path("./data" , "UCI HAR Dataset")

#Reading Activity Files
activitytest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
activitytrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

#Reading Subject Files
subjecttest <- read.table(file.path(path, "test" , "subject_test.txt" ),header = FALSE)
subjecttrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)

#Reading Measurement Files
measurementtest <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
measurementtrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

#Reading Features Files
featurenames <- read.table(file.path(path, "features.txt"),header=FALSE)

#Reading Activity LaBELS
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)


#Merging the measurement data sets and setting the colmn name
measurement <- rbind(measurementtrain, measurementtest)
names(measurement) <- featurenames$V2

#Merging the activity data sets and setting the column name
activity <- rbind(activitytrain, activitytest)
names(activity) <- c("Activity")

#Merging the Subject data sets and setting the column name
subject <- rbind(subjecttrain, subjecttest)
names(subject)<- c("Subject")

#Merging the Data
MergedData1 <- cbind(subject, activity, measurement)

#Choosing the fetures with only mean and std, selecting the final column names, and then 
#subsetting the dataset with the required names
subdataFeatures<-featurenames$V2[grep("mean\\(\\)|std\\(\\)", featurenames$V2)]
namesfinal<-c("Subject", "Activity", as.character(subdataFeatures))
TidyData<-subset(MergedData1,select=namesfinal)

#Replacing the activities with descriptive activity names
TidyData$Activity = activityLabels[TidyData$Activity, 2]

#Labelling the Variables with descriptive names
names(TidyData)<-gsub("^t", "time", names(TidyData))
names(TidyData)<-gsub("^f", "frequency", names(TidyData))
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))

#Grouping the the Tidy Data by subject and activity and finding the mean
TidyData_Final <- TidyData %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

#Writing the Output using write.table
write.table(TidyData_Final, "TidyData.txt", row.name=FALSE)