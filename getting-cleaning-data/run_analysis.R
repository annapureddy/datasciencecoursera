library(data.table)
library(dplyr)


# Setup the workspace in a temporary directory
setupWorkspace <- function() {
  # Create a temp dir to store all the working data, and cd into it
  dir <- tempdir()  
  setwd(dir)

  # Create a temp file, and unzip into the "data" directory
  file <- tempfile("data", fileext = ".gz")
  dir <- tempfile("data")
  download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file)
  unzip(file, exdir = dir)
  
  c(file, paste(dir, "UCI\ HAR\ Dataset", sep = '/'))
}

# Merges the training and the test sets to create one data set
step1 <- function(dir) {  
  # Read the training set
  file <- paste(dir, 'train', 'X_train.txt', sep = '/')
  df1 <- read.table(file)
  
  # Read the test set
  file <- paste(dir, 'test', 'X_test.txt', sep = '/')
  df2 <- read.table(file)
  
  # Merge the two sets
  df <- rbind_list(df1, df2)
  dft <- tbl_df(df)
  dft
}

# Extracts only the measurements on the mean and standard deviation for each measurement
# Appropriately labels the data set with descriptive variable names
step2 <- function(dft) {
  # Read the features
  file <- paste(dir, "features.txt", sep = '/')
  features <- read.table(file)
  
  # Identify the columns which are 'mean' and 'std'
  col <- grep('mean()|std()', features[, 2])
  
  # Label the variables appropriately
  dft <- dft[, col]
  colnames(dft) <- features[col, 2]
  dft
}

# Uses descriptive activity names to name the activities in the data set
step3 <- function(dir) {
  # Read the training set
  file <- paste(dir, 'train', 'y_train.txt', sep = '/')
  df1 <- read.table(file)
  
  # Read the test set
  file <- paste(dir, 'test', 'y_test.txt', sep = '/')
  df2 <- read.table(file)
  
  # Merge the two sets
  df <- rbind_list(df1, df2)
  
  # Read the actual activity labels
  file <- paste(dir, 'activity_labels.txt', sep = '/')
  activities <- read.table(file)
  
  # Join the tables together
  df <- inner_join(df, activities)
  colnames(df) <- c('activity_number', 'activity_label')
  df
}

# Appropriately labels the data set with descriptive variable names
step4 <- function() {
  # Nothing to do here; step 2 takes care of this
}

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
step5 <- function(dft, activities) {
  # Read the training set
  file <- paste(dir, 'train', 'subject_train.txt', sep = '/')
  df1 <- read.table(file)
  
  # Read the test set
  file <- paste(dir, 'test', 'subject_test.txt', sep = '/')
  df2 <- read.table(file)
  
  # Merge the two sets
  subjects <- rbind_list(df1, df2)
  colnames(subjects) <- c('subject')
  
  # Add the activities and subjects columns to dft
  mutate(dft, activities, subjects)
  
  # Summarize the data
}

# Cleanup the temp files created
cleanupWorkspace <- function(file, dir) {
  unlink(file)
  unlink("data", recursive = TRUE)
}

# paths <- setupWorkspace()
# dir <- paths[2]
# dft <- step1(dir)
# dft <- step2(dft)
# activities <- step3(dir)
# Nothing to do in step4; step2 takes care of it
# step5(dft, activities)
# cleanupWorkspace(paths[1], paths[2])