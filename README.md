
The data set is provided using the "Human Activity Recognition Using Smartphones Dataset". 

This data set provides the following records and has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

run_analysis.R script was created to get the tidy data set as cleandata.txt by using the below given steps.

Following files were merged to create one data set:
 -'train/X_train.txt': Training set.
 -'train/y_train.txt': Training labels.
 -'test/X_test.txt': Test set.
 -'test/y_test.txt': Test labels.
 
Features were named using the list in feature.txt file.
Activities performed by the subjects were labelled using the data provided in the activity_labels.txt file.
Data was merged only for the mean and standard deviation measurements.
Tidy data set was created by taking the average of each activity and for each subject in cleandata.txt file.
