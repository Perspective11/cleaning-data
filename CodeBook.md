
# CodeBook.md
This file contains the description of the variables, the data, and any transformations or work that I performed to clean up the data. It also indicates all the variables and summaries calculated, along with units, and other relevant information. 

> Please go through this file after reading the README.md file and following the instructions laid out there. That way you'll have the project folder that contains the files, the data set, and the output tidy data file.

## Description of the columns in the output table `tidydata.txt` :

### - variable
This indicates what is the actual measured variable (feature).
The description of each variable (feature) is found in the file `features_info.txt`.

### - activity
The value of this column is one of 6 values. It describes the activity being performed when the measurement was taken.
 - WALKING
 - WALKING_UPSTAIRS
 - WALKING_DOWNSTAIRS
 - SITTING
 - STANDING
 - LAYING

The labels are described in the file `activity_labels.txt` and the corresponding activity to each record **(before summarization)** is laid out in the files `train/y_train.txt` and `test/y_test.txt`.

### - subject
Is the identifier of the subject who performed the activity. The subject of each record **(before summarization)** is laid out in the files `train/subject_train.txt` and `test/subject_test.txt`.

### - average value

This is the average value of the variable (feature) after grouping by the subject, activity, and variable (feature).
Therefore, each record is a unique combination of those three fields and and an average measure of the remaining rows resulting from the grouping.

## Operations and transformations done to the `UCI HAR Dataset`

- Loaded the files into data frames:
	- Loaded features and activity labels into their own look-up tables from the files `features.txt` and `activity_labels.txt` respectively.
	- Loaded the train set and test set into their own data frames from the files `train/X_train.txt` and `test/X_test.txt` respectively.
	- Loaded the y_train files that contain the activities into their own vectors and convert them to numbers from the files `train/y_train.txt` and `test/y_test.txt`  respectively.
	- Loaded the subject_test files that contain the subjects into their own victors and convert them to numbers from the files `train/subject_train.txt` and `test/subject_test.txt` respectively.

- Changed the column names of the look-up tables (features and activity labels) to be `id` for the first column and `name` for the second column.

- Extracted the feature names from the features look-up table into a vector.

- Changed the column names in both the test set and the train set to the features names. 

- Selected only columns with names that contain the words `"mean("` or `"std("`. Thus excluding all other columns from train set and test set.

- Converted activity numbers that came from the files `train/y_train.txt` and `test/y_test.txt` to their corresponding names.

- Appended the named activity column to the each of the train set and test set.

- Created a new column called `type` with the value either `train` or `test` depending on the set, preparing them for merge.

- Appended the subject column that came from the files `train/subject_train.txt` and `test/subject_test.txt` to the train set and the test set.

- Merged both sets by adding the rows from one set to the other into a new set called `merged`.

- Created a new data frame `tidydata` that takes the merged set and performs grouping and summarization by:
	- Gathering (melting) the feature columns (all columns except `type`, `subject` and `activity`)  into `variable` and `measure` key value columns. 
	- Grouping the resulting data by the `variable`, `activity`, and `subject` columns.
	- Summarizing the grouped data by taking the average of each unique row of the grouped columns.

- Writing the tidy data into the working directory as a `txt` file: `tidydata.txt`.


## Input and output of `run_analysis.R`
### Input
The inputs of the script `run_analysis.R` are 8 files found in the `UCI HAR Dataset`. Namely:
 - `features.txt`
 - `activity_labels.txt`
 - `train/X_train.txt`
 - `test/X_test.txt`
 - `train/y_train.txt`
 - `test/y_test.txt`
 - `train/subject_train.txt`
 - `test/subject_test.txt`

### Output
The output of the script `run_analysis.R` is a text file called `tidydata.txt` that contains 4 columns and 11880 rows.
