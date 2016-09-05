This data comes from "Human  Activity Recognition Using Smartphones Data Set". This data can be downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script reads in the data files from the UCI HAR dataset and processes the tables and variable names to produce the final tidy data set.

Raw Data set

The raw data set was created by merging test and training datasets and using the regular expression to filter out the required data which is the mean and Standard deviation for each measurement from the original feature vector set.
 
This created data set was combined with subject identifiers "subject" and activity label "activity labels to produce the the final  raw data set.

Tidy data set

The data set was approriately label with the descriptive variable names as following
prefix "t" was replaced by time
"Acc" was replaced by "Accelerometer
"Gyro" was replaced by Gyrocsope
prefix "f" was replaced  by frequency
"Mag" was replaced by Magnitude
"BodyBody" was replaced by body

The final tidy set was created by taking average of each activity and each subject.
 



