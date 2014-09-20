# run_analysis R script for "Getting and Cleaning Data" Coursera course project.
# Written by Nicholas Ng on 20 Sep 2014

# This script, when sourced, will read the provided test and train data sets and
# process the data by the given instructions in the course project.

## Checking if the required packages are installed in R. Installs them otherwise
if (!require("dplyr")){
    install.packages("dplyr", dependencies = T)
}
if (!require("tidyr")){
    install.packages("tidyr", dependencies = T)
}
if (!require("Hmisc")){
    install.packages("Hmisc", dependencies = T)
}

## Loads the libraries while suppressing warnings
suppressPackageStartupMessages(library("dplyr"))
library("dplyr")
suppressPackageStartupMessages(library("tidyr"))
library("tidyr")
suppressPackageStartupMessages(library("Hmisc"))
library("Hmisc")

## Reading the data into R. The activity labels and features file should also be
## included in the working directory so that we can use the labels that have
## been included to label our data.
activity_labels <- read.table("./activity_labels.txt", header = F, 
                              stringsAsFactors = F)
features <- read.table("./features.txt", header = F, stringsAsFactors = F)

test_data <- read.table("./X_test.txt", header = F)
test_subjects <- read.table("./subject_test.txt", header = F)
test_activity <- read.table("./y_test.txt", header = F)

train_data <- read.table("./X_train.txt", header = F)
train_subjects <- read.table("./subject_train.txt", header = F)
train_activity <- read.table("./y_train.txt", header = F)

## Attaching the feature labels as found in the features set to the test and
## train data as headers.
names(test_data) <- features[ , 2]
names(train_data) <- features[ , 2]

## Mutate the data sets to add a column specifying the source of the observation
test_data$Source <- "test"
train_data$Source <- "train"

## Combining the data sets
merged_data <- rbind(test_data, train_data)

