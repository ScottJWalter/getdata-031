# Getting and Cleaning Data Course Project

This repository holds the script and codebook for the Coursera course "Getting and Cleaning Data"

## Code Flow
The script `run_analysis.R` performs the following:

- If a 'data' subdirectory doesn't exists below the working directory:
	- The 'data' subdirectory is created
	- The data set is downloaded 
- Loads the traning and test sets for the Activity, Subject, and Features variables.
- Merges the test and training data for each variable into single data frames.
- Performs some name clean up on the Activity and Features variables
- Merges all three variables into a single data frame
- Extracts a subset out of the data frame of only the mean and standard deviation
  for each Feature
- Generates a new, tidy, data set with the average of each measurement (mean or std)
  for each activity and subject.
- Exports the tidy data set via write.table() to a .txt file
  
## Execution

To run the script, simply load it:  `souce("run_analysis.R")`
