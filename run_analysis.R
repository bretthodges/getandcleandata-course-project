################################################################################
#
# Data pulled from:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# This script does the following:
#
#       1. Merges the training and the test sets to create one data set.
#
#       2. Extracts only the measurements on the mean and standard deviation
#          for each measurement.
#
#       3. Uses descriptive activity names to name the activities in the
#          data set
#
#       4. Appropriately labels the data set with descriptive variable names
#
#       5. From the data set in step 4, creates a second, independent tidy data
#          set with the average of each variable for each activity and each
#          subject
#
################################################################################

library(dplyr)


## This is a helper function used by the main script body below.
## This function is used to load all of the various data files for
## a specific data group---either Training data or Test data--and
## combine those data files into a single table that represents that
## data group.
loadData <- function(type = 'TRAIN', df.lookup.feature, df.lookup.activity){

        ## the path to the directory containing this data group's
        ## data files
        path <- paste0('UCI HAR Dataset\\', tolower(type), '\\')

        ### Load the subject details to determine which rows in the
        ### data set correspond to which subjects.
        subject.file <- paste0(path, '\\subject_', tolower(type), '.txt')

        df.index.subject <-
                tbl_df(read.table(file = subject.file,
                                  col.names = "SubjectID",
                                  check.names = FALSE,
                                  stringsAsFactors = FALSE))

        ### Load the activity identifiers to determine which rows in the
        ### data set correspond to which activity type.
        activity.file <- paste0(path, '\\Y_', tolower(type), '.txt')

        df.index.activity <-
                tbl_df(read.table(file = activity.file,
                                  col.names = "ActivityID",
                                  check.names = FALSE,
                                  stringsAsFactors = FALSE)) %>%
                inner_join(df.lookup.activity)

        df.index.activity$ActivityID <- NULL

        ### Load the features data used in the training data set
        data.file <- paste0(path, '\\X_', tolower(type), '.txt')

        df.data <-
                tbl_df(read.table(file = data.file,
                                  col.names = df.lookup.feature$Feature.R,
                                  colClasses = "numeric",
                                  check.names = FALSE,
                                  stringsAsFactors = FALSE))

        ### Combine the Subject, Activity, and Variables into a single
        ### table representing this data group.
        df.data <-
                bind_cols(df.index.subject,
                          df.index.activity,
                          df.data) %>%
                arrange(SubjectID, Activity)

        return(df.data)

}

##################################
# This is the main script body...
##################################


#
# Step 1: Merge the training and the test sets to create one data set.
#

## Load the feature details from the features.txt file.
df.lookup.feature <-
        tbl_df(read.table(file = "UCI HAR Dataset\\features.txt",
                          col.names = c("FeatureID", "Feature"),
                          check.names = FALSE,
                          stringsAsFactors = FALSE))

## The Feature column in df.lookup.feature contains the original feature names,
## most of which contain characters that aren't allowed in column names
## of R objects; consequently, we need to create "R-friendly" versions of
## them.
df.lookup.feature$Feature.R <-
        make.names(names=df.lookup.feature$Feature,
                   unique=TRUE, allow_ = TRUE)

## Load the activity details from the activity_labels.txt file.
df.lookup.activity <-
        tbl_df(
                read.table(file = "UCI HAR Dataset\\activity_labels.txt",
                           col.names = c("ActivityID", "Activity"),
                           check.names = FALSE,
                           stringsAsFactors = FALSE))

## Load the Training data set
df.train <- loadData(type='TRAIN', df.lookup.feature, df.lookup.activity)

## Load the Test data set
df.test <- loadData(type='TEST', df.lookup.feature, df.lookup.activity)

## Combine the Train and Test data into a single data set
df.data <- bind_rows(df.train, df.test)


#
# Step 2: Extract only the measurements on the mean and standard deviation
#         for each measurement.

## Besides the SubjectID and Activity columns (which act as Key columns),
## keep only those measurements with column names containing either of
## the substrings, 'mean' or 'std', explicitly in lower case. Note that
## the 'angle(...)' columns are excluded, since they don't fit with the
## naming scheme that is consistent across all of the other variables.
col.names <- names(df.data)
key.cols <- c('SubjectID', 'Activity')

## Get all of the column names that we should keep based on the requirement
## described above.
keep.cols <- c(key.cols,
               grep(pattern = '\\.(std|mean)',
                    x = col.names,
                    value = TRUE))

## Now pull only the columns identified above into the data table
## and sort the rows by values in the Key columns.
df.data <-
        df.data %>%
        select(one_of(keep.cols)) %>%
        arrange(SubjectID, Activity)


# Step 3: Use descriptive activity names to name the activities in the data set

## As part of Step 1, the full activity names have been inserted for each row
## of data.  The activity names are all meaningful, with values such as
## 'STANDING', 'WALKING', etc.


# Step 4: Appropriately label the data set with descriptive variable names

## The variable names are descriptive as they are, but they don't
## quite meet the guidelines for tidy variable names since they
## contain periods.
##
## To fix this:
##              replace all occurances of 'mean' with 'Mean'
##              replace all occurances of 'std' with 'StdDev'
##              replace all '.' with '' (i.e. remove them)

col.names <- names(df.data)
col.names <- gsub(pattern = 'mean',
                  replacement = 'Mean',
                  x = col.names)
col.names <- gsub(pattern = 'std',
                  replacement = 'StdDev',
                  x = col.names)
col.names <- gsub(pattern = '\\.',
                  replacement = '',
                  x = col.names)

## Now simply replace the variable names with the "R-friendly"
## versions we just created
names(df.data) <- col.names


# Step 5: From the data set in step 4, create a second, independent tidy data
#         set with the average of each variable for each activity and each
#         subject

## Define data grouping based on unique SubjectID and Activity combinations.
by.subj.and.act <- df.data %>% group_by(SubjectID, Activity)

## Calculate and capture the mean of all mean and std variables by
## each group. (That is to say, calculate the average value of the relevant
## variables across all of the sampled window observations--a.k.a, the
## 'sample set'--associated with each unique subject and activity combination.
## The end result is a single observation/row containig the mean values
## for each subject by activity.
df.new.data <- by.subj.and.act %>% summarize_each(funs(mean))

## Then save the new tidy data set to disk.
## Note: Since each row now contains individual mean values calculated
## from multiple rows in the source data that comprised the 'sample set'
## of observations for a subject and activity, it is probably wise to
## indicate as much in the file name we assign to this new data set.

write.table(x = df.new.data,
            file = 'HAR_mean_and_std_variables_averaged_by_subject_and_activity.txt',
            row.names = FALSE)

## Verify it was saved correctly by re-loading it
df.tidy.data <- read.table(file = 'HAR_mean_and_std_variables_averaged_by_subject_and_activity.txt',
                           header = TRUE,
                           check.names = FALSE,
                           stringsAsFactors = FALSE)


