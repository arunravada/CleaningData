---
title: "Readme.md"
author: "Arun"
date: "Sunday, May 24, 2015"
output: html_document
---
#Run_analysis.R#
The cleanup script (run_analysis.R) does the following:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Files in folder 'UCI HAR Dataset' that will be used are:


1.SUBJECT 

2.test/subject_test.txt

3.train/subject_train.txt

4.ACTIVITY FILES

5.test/X_test.txt
6.train/X_train.txt
7.DATA FILES
8.test/y_test.txt
9.train/y_train.txt
10.features.txt - Names of column variables in the dataTable

activity_labels.txt - Links the class labels with their activity name.

Read the above files and create data tables.

*1. Merges the training and the test sets to create one data set.*


    1.Read all the files from the given location "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles% 
      2FUCI%20HAR%20Dataset.zip"
    2.Merge the Training and Testing data set for subject,x_..,y_..
    3.After merging individual set for suject,x,y make it a single data set
  
*2. Extracts only the measurements on the mean and standard deviation for each measurement.*

    1.Filter data with Mean ans STD names

*3. Uses descriptive activity names to name the activities in the data set*


    1.Assign column names to the dataset 
    2.Do a join on the Activity_names to give approriate description based on id
    

*4. Appropriately labels the data set with descriptive variable names.*
    
    
    1.Rejoin the entire table, keying on subject/acitivity pairs, applying the mean function to each vector of  
      values in each subject/activity pair. This is the clean dataset.

*5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*
    
    
    1.write to text file on disk
    2.A tidy data table is be created

**Conclusion**

The tidy data set a set of variables for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 69 columns - 33 Mean variables + 33 Standard deviation variables + 1 Subject( 1 of of the 30 test subjects) + ActivityName + ActivityNum . The tidy data set's first row is the header containing the names for each column.