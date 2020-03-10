# ReadMe.md
This is my solution to the Coursera peer-graded assignment for the Data Cleaning course.


## This Github repo includes the following files:

### - run_analysis.R
This file contains the code that performs cleaning, merging and tidying operations on the [Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip) found in [this website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### - CodeBook.md

This is the file that contains the description of the variables, the data, and any transformations or work that I performed to clean up the data.

## Steps to run the run_analysis.R file on the data

 1. Create a folder and set the working directory to that new folder. We'll call that the project folder.
 2. Put `run_analysis.R` in the project folder.
 3. Download [Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip) and extract it.
 4. Open the extracted directory and copy the folder `UCI HAR Dataset` to the project folder, then rename the folder to `dataset`.
 5. Now run the file `run_analysis.R`.

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
