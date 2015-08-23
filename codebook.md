# Getting and Cleaning Data Course Project - Codebook

## Data Source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### Data Record Contents
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Files
- `README.txt
- `features_info.txt` -- Shows information about the variables used on the feature vector.
- `features.txt `-- List of all features.
- `activity_labels.txt` -- Links the class labels with their activity name.
- `train/X_train.txt` -- Training set.
- `train/y_train.txt` -- Training labels.
- `test/X_test.txt` -- Test set.
- `test/y_test.txt` -- Test labels.
- `test/subject_train.txt` -- Identifies the subject who performed the activity for each window sample (a numeric in the range of 1:30)
- `train/subject_train.txt` -- Same as "test/subject_train.txt" but for training 


### Notes
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

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
