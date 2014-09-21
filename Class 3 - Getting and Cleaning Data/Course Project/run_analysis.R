## run_analysis R script for "Getting and Cleaning Data" Coursera course project
## Written by Nicholas Ng on 20 Sep 2014

## This script, when sourced, will read the provided test and train data sets and
## process the data by the given instructions in the course project.
## Packages required: base, utils, dplyr

## Start of script ##

# Checking if the dplyr package is installed in R. Installs it otherwise and
# loads it.
if (!require("dplyr")) {
    install.packages("dplyr", dependencies = T)
}
suppressPackageStartupMessages(library("dplyr"))
library("dplyr")

# Reading the data into R. The activity and feature labels are read in first,
# as they are used to transform the activity id data and name columns in the
# data sets. Appropiate column names are given to the data sets for easier
# manipulation later.
activity_labels <- read.table("./activity_labels.txt", header = F, 
                              stringsAsFactors = F, 
                              col.names = c("Activity_ID", "Activity"))
features <- read.table("./features.txt", header = F, stringsAsFactors = F, 
                       col.names = c("ID", "Feature"))
features$Feature <- gsub("-", "_", features$Feature) # Makes labels more R-friendly

test_data <- read.table("./X_test.txt", header = F, 
                        col.names = features$Feature)
test_subjects <- read.table("./subject_test.txt", header = F,
                            col.names = "Subject_ID")
test_activity <- read.table("./y_test.txt", header = F,
                            col.names = "Activity_ID")

train_data <- read.table("./X_train.txt", header = F,
                         col.names = features$Feature)
train_subjects <- read.table("./subject_train.txt", header = F,
                             col.names = "Subject_ID")
train_activity <- read.table("./y_train.txt", header = F,
                             col.names = "Activity_ID")

# Using regexes to determine the indices of columns that hold the mean and std
# estimations of measurements, based on the features data set.
pattern <- paste(c("mean\\()", "std\\()"), collapse = "|")
indices <- which(grepl(pattern, features$Feature))

# Removing unnecessary columns through subsetting, and keeping only mean and
# standard deviation columns.
test_data <- test_data[ , indices]
train_data <- train_data[ , indices]
rm(features, pattern, indices)

# Attaching subject labels to the data sets.
test_data$Subject_ID <- test_subjects[ , 1]
train_data$Subject_ID <- train_subjects[ , 1]
rm(test_subjects, train_subjects)

# Creating a new column that attaches the activity labels as a factor variable,
# using the values in the activity labels data frame as factor labels.
test_data$Activity <- factor(test_activity[ , 1], 
                             labels = activity_labels$Activity)
train_data$Activity <- factor(train_activity[ , 1], 
                              labels = activity_labels$Activity)
rm(test_activity, train_activity, activity_labels)

# Mutate the data sets to add a column specifying the source of the observation
# (Not required in the project requirements, but just in case users wish to
# perform different operations based on the source of the data.)
test_data$Source <- "test"
train_data$Source <- "train"

# Combining the data sets
merged_data <- tbl_df(rbind(test_data, train_data))
rm(test_data, train_data)

# Creating a summary data frame that presents the averages of all variables by 
# activity and subject, using chaining.
summary <- merged_data %>%
    group_by(Activity, Subject_ID) %>%
    summarise_each(funs(mean), -Source)

# Writing the summary to file
write.table(summary, file = "./analysis_output.txt", row.names = F)

# Clearing memory of all remaining objects (you may comment out this step to 
# observe the final transformed data frames.)
rm(merged_data, summary)

## End of script ##
