# cleaning and getting data assignment

## this is the pipeline was done for the data:

1. Mergeing the training and the test sets to creating one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement.
3. Useing descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 ## files descriptions:
+ run_analysis.R : to preforme the data analysis.
+ CodeBook.md : the descriptions of the output data.

 
## notes:
#### the script assumes that the "UCI HAR Dataset" exists in your home directory
#### else you have to assigne the directory that contains the "UCI HAR Dataset" to the "WD" variable in the biggining of the script
#### with replacing "/" instead of "\".
