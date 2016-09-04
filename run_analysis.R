#!/usr/bin/env Rscript
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl,destfile="./data/Dataset.zip")

###unzipping data
unzip(zipfile="./data/Dataset.zip")

library(dplyr)
library(reshape2)
###unzipped files are in the folderUCI HAR Dataset. Get the list of the files

file_path <- file.path("./" , "UCI HAR Dataset")
filesList <-list.files(file_path, recursive=TRUE)
filesList

##Reading activity files
dataY_Test  <- read.table(file.path(file_path, "test" , "Y_test.txt" ),header = FALSE)
dataY_Train <- read.table(file.path(file_path, "train", "Y_train.txt"),header = FALSE)

##Reading subject files
dataSubject_Train <- read.table(file.path(file_path, "train", "subject_train.txt"),header = FALSE)
dataSubject_Test  <- read.table(file.path(file_path, "test" , "subject_test.txt"),header = FALSE)

##Reading features files
dataX_Test  <- read.table(file.path(file_path, "test" , "X_test.txt" ),header = FALSE)
dataX_Train <- read.table(file.path(file_path, "train", "X_train.txt"),header = FALSE)

##Reading list of all the features
featuresNames_List <-read.table(file.path(file_path, "features.txt"))

##Reading activity names
activity_Names <-read.table(file.path(file_path, "activity_labels.txt"))

##Look at the properties of the above varibles

str(dataY_Test)
str(dataY_Train)
str(dataSubject_Test)
str(dataSubject_Train)
str(dataX_Test)
str(dataX_Train)

##Part1
##Merges the training and the test sets to create one data set
##Concatenate the data tables by rows

dataSubject <- rbind(dataSubject_Train, dataSubject_Test)
dataActivity<- rbind(dataY_Train, dataY_Test)
dataFeatures<- rbind(dataX_Train, dataX_Test)

##set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<-c("activity")


##Part2
###Extracts only the measurements on the mean and standard deviation for each measurement
## Subset Name of Features by measurements on the mean and standard deviation
##taking Names of Features with "mean()" or "std()"

subdataFeaturesNames<-featuresNames_List$V2[grep("mean\\(\\)|std\\(\\)", featuresNames_List$V2), drop = FALSE ]

##Subset the data frame Data by seleted names of Features

dataFeatures <- dataFeatures[, subdataFeaturesNames]
names(dataFeatures) <-featuresNames_List[subdataFeaturesNames, 2]

##Part3
###Using descriptive activity names to name the activities in the data set

dataActivity[,1] <- activity_Names[ dataActivity[,1],2]

## combine the data
AllData <- cbind(dataFeatures, dataActivity, dataSubject)

###Part4
###Appropriately labels the data set with the descriptive variable names

##prefix t is replaced by time
##Acc is replaced by Accelerometer
##Gyro is replaced by Gyroscope
##prefix f is replaced by frequency
##Mag is replaced by Magnitude
###BodyBody is replaced by Body

names(AllData)<-gsub("^t", "time", names(AllData))
names(AllData)<-gsub("^f", "frequency", names(AllData))
names(AllData)<-gsub("Acc", "Accelerometer", names(AllData))
names(AllData)<-gsub("Gyro", "Gyroscope", names(AllData))
names(AllData)<-gsub("Mag", "Magnitude", names(AllData))
names(AllData)<-gsub("BodyBody", "Body", names(AllData))


##Part5
## Second, independent tidy data set created with the average of each variable for each activity and each ##subject based on the data set in step 4.

##library(plyr);
##library(reshape2)
Data2<-aggregate(. ~subject + activity, AllData, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "Cleandata.txt",row.name=FALSE)


