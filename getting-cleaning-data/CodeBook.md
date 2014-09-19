This codebook describes additions to the README.txt already available with the data. In general, it describes the variables, 
the data, and transformations done to clean up the data. 

Dictionary of variables and data in summary.txt (which is the output generated from run_analysis.R):
 * activity: A character string that describes the activity that is being measured. Takes on the following values:
 LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
 * subject: This is a number that identifies the person doing the experiment. Takes on values from 1:30. 
 * tBodyAcc-mean()-X etc.: All such variables use the same name as the ones in features.txt in the original dataset. However, 
 these variables in summary.txt represent the mean of all such values in the original dataset grouped by (activity, subject). 
 
Transformations done to the original dataset:
 * Read X_train.txt, X_test.txt, and merge into one data frame. Call this data frame "dft".
 * Read features.txt. Select columns from features that contain "mean()" or "std()". Call these "col"
 * Drop columns from dft that do not correspond to col
 * Read y_train.txt and y_test.txt, and merge them into one data frame. Call this "activity".
 * Read activity_labels.txt, and join with activity table. Call this joined data frame "activity_info".
 * Read subject_train.txt, subject_test.txt, and merge them into a data frame. Call it "subjects".
 * Mutate dft to include activity (from activity_label in activity_info), and subject columns. 
 * Group dft by activity and subject
 * Summarise each of the columns with the "mean" function.
