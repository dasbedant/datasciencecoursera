#Getting and Cleaning Data Course Project
#The purpose of this project is to demonstrate your ability to collect, work with, 
#and clean a data set. The goal is to prepare tidy data that can be used for later 
#analysis. You will be graded by your peers on a series of yes/no questions related 
#to the project. You will be required to submit:
#  1) a tidy data set as described below,
#  2) a link to a Github repository with your script for performing the analysis, 
#  3) a code book that describes the variables, the data, and any transformations
#or work that you performed to clean up the data called CodeBook.md. 
#You should also include a README.md in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.

#One of the most exciting areas in all of data science right now is 
#wearable computing - see for example this article . Companies like Fitbit, Nike, 
#and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
  
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Here are the data for the project:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#You should create one R script called run_analysis.R that does the following.

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data
#set with the average of each variable for each activity and each subject.







rm(list=ls())
myhomedirectory <-"C:/Users/user-pc/Documents/Bedant Data Science/datasciencecoursera"
setwd(myhomedirectory)
getwd()
library(jpeg)
library(data.table)
library(dplyr)
library(Hmisc)


#Download Zip file & Unzip
fileurl1 = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dst4 = 'Dataset.zip'
download.file(fileurl1, dst4)
unzip(zipfile="Dataset.zip",exdir="./data")
path_ds <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_ds, recursive=TRUE)

#Read Label files- Activity label and features label

activitylabel <- read.csv("./data/UCI HAR Dataset/activity_labels.txt", sep="",
                          header=FALSE)
colnames(activitylabel)<- c("ActivityId", "ActivityDesc")

featureslabel <- read.csv("./data/UCI HAR Dataset/features.txt", sep="",
                          header=FALSE)
colnames(featureslabel)<- c("FeatureId", "FeatureDesc")

# Read in the X(features) test, y(activity) test & subject test dataset
features.test <- read.csv("./data/UCI HAR Dataset/test/X_test.txt", sep="",
                   header=FALSE)
colnames(features.test) <- featureslabel$FeatureDesc

activity.test <- read.csv("./data/UCI HAR Dataset/test/y_test.txt", sep="",
                   header=FALSE)
colnames(activity.test)<- c("ActivityId")

subject.test <- read.csv("./data/UCI HAR Dataset/test/subject_test.txt",
                         sep="", header=FALSE)
colnames(subject.test)<- c("SubjectId")

TestActivitydf<- merge(activitylabel, activity.test,by = "ActivityId")



# Read in the X(features) train, y(activity) train & subject trainst dataset
features.train <- read.csv("./data/UCI HAR Dataset/train/X_train.txt", sep="",
                    header=FALSE)
colnames(features.train) <- featureslabel$FeatureDesc

activity.train <- read.csv("./data/UCI HAR Dataset/train/y_train.txt", sep="",
                    header=FALSE)
colnames(activity.train)<- c("ActivityId")
TrainActivitydf<- merge(activitylabel, activity.train,by = "ActivityId")


subject.train <- read.csv("./data/UCI HAR Dataset/train/subject_train.txt",
                          sep="", header=FALSE)
colnames(subject.train)<- c("SubjectId")


# Combine the training and test running datasets
cactivitydata <- rbind(TestActivitydf, TrainActivitydf)
cfeaturedata <- rbind(features.test, features.train)
csubjectdata <- rbind(subject.test,subject.train)
# Merge ALL datasets
Mergeddata<- data.frame(csubjectdata, cactivitydata, cfeaturedata)

# Delete the files we don't need anymore 
remove(subject.test, activity.test, features.test)
remove(subject.train, activity.train, features.train)
remove(csubjectdata, cactivitydata, cfeaturedata)
remove(TestActivitydf,TrainActivitydf)



# Select only the columns that contain mean or standard deviations.
# Make sure to bring along the subject and label columns.
# Exclude columns with freq and angle in the name.
Mergeddata2 <- select(Mergeddata, contains("Subject"), contains("Activity"),
                   contains("mean"), contains("std"),-contains("freq"),-contains("angle"))
#str(Mergeddata2)

# Clean up the column names. Remove hyphens, parantheses
# Fix a set of columns that repeat "Body".
setnames(Mergeddata2, colnames(Mergeddata2), gsub("-", "", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2), gsub("\\(\\)", "", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2), gsub("\\.", "", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2), gsub("BodyBody", "Body", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2),gsub("^t", "Time", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2),gsub("^f", "Frequency", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2),gsub("Acc", "Accelerometer", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2),gsub("Gyro", "Gyroscope", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2),gsub("mean", "Mean", colnames(Mergeddata2)))
setnames(Mergeddata2, colnames(Mergeddata2),gsub("std", "Stdev", colnames(Mergeddata2)))



#str(Mergeddata2)
# Group the running data by subject and activity, then
# calculate the mean of every measurement.
Outputdata <- Mergeddata2 %>%
  group_by(SubjectId, ActivityId,ActivityDesc) %>%
     summarise_all(mean)
      
str(Outputdata)

# Write run.data to file
write.table(Outputdata, file="HumanActivityLog_SummaryData.txt")
        