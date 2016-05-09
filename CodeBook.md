---
title: "CodeBook for the HAR Mean and Standard Deviation Variables Averaged over Subject and Activity"
output:
  html_document:
    keep_md: yes
---

#Data Collection Description

This project uses the pre-existing [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) available for [download here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The data was extracted from the provided zip file into the *UCI HAR Dataset* sub-folder of this project. Please refer to the *README.txt* and *features_info.txt* files in that sub-folder for descriptions of the structure and contents of the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


#Data Description

This project generates a new tidy data set that contains the calculated mean for each of the mean and standard deviation variables over each unique combination of Subject and Activity in the source data set referenced above.  The project then saves the new tidy data set to the *HAR_mean_and_std_variables_averaged_by_subject_and_activity.txt* file, which is a **' '(i.e. blank space) delimitted text file**.


###Requirements for Tidy Data

In ['tidy data'](http://vita.had.co.nz/papers/tidy-data.pdf):

1. Each variable forms a column.

2. Each observation forms a row.

3. Each type of observational unit forms a table.

The data set created by this project and saved in the *HAR_mean_and_std_variables_averaged_by_subject_and_activity.txt* file meets the tidy data requirments, in that:

1. All of the variables are represented as columns, with each column containing mean values of a specific mean or standard deviation variable from the source data set.

2. Each row contains a single observation that reflects the average of the Mean and Standard Deviation measurements across all time windows in the source data set for each unique combination of subject and activity.

3. The observational unit defined by the unique combination of subject and activity values forms a single table.


###Data Structure

Observation Identifier Columns

Col. # | Name | Explanation
------ | ---- | -----------
1 | SubjectID | A unique identifier of the subject who carried out the experiment in the source data
2 | Activity | The label describing the activity performed by the subject

This data set contains a single row for every unique combination of SubjectID and Activity.
It makes sense then that the the first two columns in the data set represent those unique SubjectID and Activity pairs.

The remaining columns are all variables for this new data set, with each one describing the mean value of a Mean or Standard Deviation measurement calculated across all rows in the source data set belonging to each subject and activity combination.  The new variable names and the source data variables from which they are calculated are all listed below. 

Col. # | Name for New Mean Variable | Source Data Set's Variable Name
------ | ---- | -----------
3 | tBodyAccMeanX | tBodyAcc-mean()-X
4 | tBodyAccMeanY | tBodyAcc-mean()-Y
5 | tBodyAccMeanZ | tBodyAcc-mean()-Z
6 | tBodyAccStdDevX | tBodyAcc-std()-X
7 | tBodyAccStdDevY | tBodyAcc-std()-Y
8 | tBodyAccStdDevZ | tBodyAcc-std()-Z
9 | tGravityAccMeanX | tGravityAcc-mean()-X
10 | tGravityAccMeanY | tGravityAcc-mean()-Y
11 | tGravityAccMeanZ | tGravityAcc-mean()-Z
12 | tGravityAccStdDevX | tGravityAcc-std()-X
13 | tGravityAccStdDevY | tGravityAcc-std()-Y
14 | tGravityAccStdDevZ | tGravityAcc-std()-Z
15 | tBodyAccJerkMeanX | tBodyAccJerk-mean()-X
16 | tBodyAccJerkMeanY | tBodyAccJerk-mean()-Y
17 | tBodyAccJerkMeanZ | tBodyAccJerk-mean()-Z
18 | tBodyAccJerkStdDevX | tBodyAccJerk-std()-X
19 | tBodyAccJerkStdDevY | tBodyAccJerk-std()-Y
20 | tBodyAccJerkStdDevZ | tBodyAccJerk-std()-Z
21 | tBodyGyroMeanX | tBodyGyro-mean()-X
22 | tBodyGyroMeanY | tBodyGyro-mean()-Y
23 | tBodyGyroMeanZ | tBodyGyro-mean()-Z
24 | tBodyGyroStdDevX | tBodyGyro-std()-X
25 | tBodyGyroStdDevY | tBodyGyro-std()-Y
26 | tBodyGyroStdDevZ | tBodyGyro-std()-Z
27 | tBodyGyroJerkMeanX | tBodyGyroJerk-mean()-X
28 | tBodyGyroJerkMeanY | tBodyGyroJerk-mean()-Y
29 | tBodyGyroJerkMeanZ | tBodyGyroJerk-mean()-Z
30 | tBodyGyroJerkStdDevX | tBodyGyroJerk-std()-X
31 | tBodyGyroJerkStdDevY | tBodyGyroJerk-std()-Y
32 | tBodyGyroJerkStdDevZ | tBodyGyroJerk-std()-Z
33 | tBodyAccMagMean | tBodyAccMag-mean()
34 | tBodyAccMagStdDev | tBodyAccMag-std()
35 | tGravityAccMagMean | tGravityAccMag-mean()
36 | tGravityAccMagStdDev | tGravityAccMag-std()
37 | tBodyAccJerkMagMean | tBodyAccJerkMag-mean()
38 | tBodyAccJerkMagStdDev | tBodyAccJerkMag-std()
39 | tBodyGyroMagMean | tBodyGyroMag-mean()
40 | tBodyGyroMagStdDev | tBodyGyroMag-std()
41 | tBodyGyroJerkMagMean | tBodyGyroJerkMag-mean()
42 | tBodyGyroJerkMagStdDev | tBodyGyroJerkMag-std()
43 | fBodyAccMeanX | fBodyAcc-mean()-X
44 | fBodyAccMeanY | fBodyAcc-mean()-Y
45 | fBodyAccMeanZ | fBodyAcc-mean()-Z
46 | fBodyAccStdDevX | fBodyAcc-std()-X
47 | fBodyAccStdDevY | fBodyAcc-std()-Y
48 | fBodyAccStdDevZ | fBodyAcc-std()-Z
49 | fBodyAccMeanFreqX | fBodyAcc-meanFreq()-X
50 | fBodyAccMeanFreqY | fBodyAcc-meanFreq()-Y
51 | fBodyAccMeanFreqZ | fBodyAcc-meanFreq()-Z
52 | fBodyAccJerkMeanX | fBodyAccJerk-mean()-X
53 | fBodyAccJerkMeanY | fBodyAccJerk-mean()-Y
54 | fBodyAccJerkMeanZ | fBodyAccJerk-mean()-Z
55 | fBodyAccJerkStdDevX | fBodyAccJerk-std()-X
56 | fBodyAccJerkStdDevY | fBodyAccJerk-std()-Y
57 | fBodyAccJerkStdDevZ | fBodyAccJerk-std()-Z
58 | fBodyAccJerkMeanFreqX | fBodyAccJerk-meanFreq()-X
59 | fBodyAccJerkMeanFreqY | fBodyAccJerk-meanFreq()-Y
60 | fBodyAccJerkMeanFreqZ | fBodyAccJerk-meanFreq()-Z
61 | fBodyGyroMeanX | fBodyGyro-mean()-X
62 | fBodyGyroMeanY | fBodyGyro-mean()-Y
63 | fBodyGyroMeanZ | fBodyGyro-mean()-Z
64 | fBodyGyroStdDevX | fBodyGyro-std()-X
65 | fBodyGyroStdDevY | fBodyGyro-std()-Y
66 | fBodyGyroStdDevZ | fBodyGyro-std()-Z
67 | fBodyGyroMeanFreqX | fBodyGyro-meanFreq()-X
68 | fBodyGyroMeanFreqY | fBodyGyro-meanFreq()-Y
69 | fBodyGyroMeanFreqZ | fBodyGyro-meanFreq()-Z
70 | fBodyAccMagMean | fBodyAccMag-mean()
71 | fBodyAccMagStdDev | fBodyAccMag-std()
72 | fBodyAccMagMeanFreq | fBodyAccMag-meanFreq()
73 | fBodyBodyAccJerkMagMean | fBodyBodyAccJerkMag-mean()
74 | fBodyBodyAccJerkMagStdDev | fBodyBodyAccJerkMag-std()
75 | fBodyBodyAccJerkMagMeanFreq | fBodyBodyAccJerkMag-meanFreq()
76 | fBodyBodyGyroMagMean | fBodyBodyGyroMag-mean()
77 | fBodyBodyGyroMagStdDev | fBodyBodyGyroMag-std()
78 | fBodyBodyGyroMagMeanFreq | fBodyBodyGyroMag-meanFreq()
79 | fBodyBodyGyroJerkMagMean | fBodyBodyGyroJerkMag-mean()
80 | fBodyBodyGyroJerkMagStdDev | fBodyBodyGyroJerkMag-std()
81 | fBodyBodyGyroJerkMagMeanFreq | fBodyBodyGyroJerkMag-meanFreq()


Notes: 
======
- The variable values in this data set are normalized and bounded within [-1,1] since the source data for this data set's mean calculation is also normalized and bounded within [-1,1].

