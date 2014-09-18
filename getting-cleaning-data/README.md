This directory contains the following files:
 * README.md (you are reading this now :))
 * CodeBook.md: Describes the variables, the data, and transformations done to clean up the data
 * run_analysis.R: An R script that implements the entire process
 * summary.txt: Contains the output of run_analysis.R (attached on the assignment submission page)

The script, run_analysis.R, in this directory does the following:
 * Fetch a dataset from the web 
 * Unzip the downloaded file 
 * Merges train/X_train.txt and test/X_test.txt into one dataset (let's call it 'dft' for convenience)
 * Reads features.txt, and extracts all the features that contain mean() or std()
 * Select only these features from dft
 * Obtain activity labels for all the rows in dft
 * Obtain subject numbers for all the rows in dft
 * Mutate dft by adding two columns: activity labels and subject numbers
 * Group this new dft by activity and subject
 * Summarize the data by computing the mean for all the featues (after grouping by activity and subject)
 
There were several choices made:
 * I do not consider data in 'Inertial Signals' folder. This is because we remove all features that are not
 a mean or standard deviation in step 2 anyway (which reads "Extracts only the measurements on the mean and standard 
 deviation for each measurement")
 * The script takes care of setting up the workspace. This involves downloading the data directly from the URL, 
 storing and extracting the data into a temporary directory, and working in that temporary directory. This was 
 recommended in the classes, as well as by community TAs. In particular, the script here will not work when the 
 dataset is available in the current directory.
 * I interpret "Extracts only the measurements on the mean and standard deviation for each measurement" to mean
 all the variables which have a "mean()" or "std()" in their name. This criteria matches the data pretty well. 
 
 
