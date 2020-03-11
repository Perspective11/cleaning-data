# Install the required packages if they are not already installed
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")

# Load dplyr and tidyr packages
library(dplyr)
library(tidyr)

# Load features and activity labels into their own look up tables
featuresLookup <- read.csv("./dataset/features.txt", sep = "", header = FALSE)
activitiesLookup <- read.csv("./dataset/activity_labels.txt", sep = "", header = FALSE)

# Load the train set and test set into their own dataframes
trainset <- read.csv("./dataset/train/X_train.txt", sep = "", header = FALSE)
testset <- read.csv("./dataset/test/X_test.txt", sep = "", header = FALSE)

# Load the y_train files that contain the activities into their own vectors and convert them to numbers
trainAcitivitiesVector <- as.integer(readLines("./dataset/train/y_train.txt"))
testAcitivitiesVector <- as.integer(readLines("./dataset/test/y_test.txt"))

# Load the subject_test files that contain the subjects into their own victors and convert them to numbers
trainSubjectVector <- as.integer(readLines("./dataset/train/subject_train.txt"))
testSubjectVector <- as.integer(readLines("./dataset/test/subject_test.txt"))

# Change the column names of the look up tables to be id for the first column and name for the second column
colnames(featuresLookup) <- c("id", "name")
colnames(activitiesLookup) <- c("id", "name")

# Extract the feature names from the data frame into a vector
featureNames <- featuresLookup$name

# Change the column names to the features names in both the test and train set
colnames(testset) <- featureNames
colnames(trainset) <- featureNames

# Remove columns with duplicated names in order to run the select command
trainset <- trainset[, !duplicated(colnames(trainset))]
testset <- testset[, !duplicated(colnames(testset))]

# Select only columns with names that contain the words "mean(" or "std(". 
# Thus excluding all other columns from trainset and test set
trainset <- select(trainset, matches("mean\\(|std\\("))
testset <- select(testset, matches("mean\\(|std\\("))

# Convert activity numbers to their corresponding names
trainAcitivitiesVectorNames <- sapply(trainAcitivitiesVector, function(x){activitiesLookup[x,"name"]})
testAcitivitiesVectorNames <- sapply(testAcitivitiesVector, function(x){activitiesLookup[x,"name"]})

# Append the named activity column to the each of the train set and test set
trainset <- bind_cols(activity = trainAcitivitiesVectorNames, trainset)
testset <- bind_cols(activity = testAcitivitiesVectorNames, testset)

# Create a new column called "type" with the value either "train" or "test" depending on the set, preparing them for merge.
trainset <- mutate(trainset, type = "train")
testset <- mutate(testset, type = "test")

# Append the subject column to the train set and test set
trainset <- bind_cols(subject = trainSubjectVector, trainset)
testset <- bind_cols(subject = testSubjectVector, testset)

# Merge both sets by adding the rows from one set to the other
merged <- bind_rows(trainset, testset)

tidydata <- merged %>% # Create a new data frame "tidydata" that takes the merged set
  group_by(activity, subject) %>% # Group the data by the activity, and subject
  summarise_all(funs(mean)) # Then summarize the grouped data by taking the average of each unique row of the grouped columns

# Write the tidy data into the working directory as a txt file
write.table(tidydata, file = "./tidydata.txt", row.names = FALSE)

