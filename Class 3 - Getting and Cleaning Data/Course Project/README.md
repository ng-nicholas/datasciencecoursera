# README for the Getting and Cleaning Data Course Project
Written by Nicholas Ng on 20 Sep 2014

## Introduction
This README markdown contains details on files in this project, and briefly
discusses the script used to obtain the output data set.

## Files in This Project
* README.md: This README file
* CodeBook.md: A codebook describing the input/output files and data
* Data: Folder containing all of the required original input data
* run_analysis.R: R script that performs all of the required data transformations
* analysis_output.txt: Output data file

## The Script
The R script used to transform the input data is a single standalone R script. 
It takes in the following files which need to be located in the user specified
working directory and creates a analysis_output.txt file containing the output
data, in the same working directory:
* activity_labels.txt
* features.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt

The processes carried out by the script are as follows:
1) The script reads the aforementioned files into R and stores them as data
frames.
2) The variable labels in the features data set are attached as column names in 
the main (X_*) data sets.
3) Using a regular expression to identify the indices of columns that contain
mean and standard deviation estimations, the required columns are subsetted.
4) The subject IDs and activity labels are attached to the main data sets after 
the activity (y_*) data sets have been transformed into factors using the
activity_labels data set.
5) As an additional step, a column identifying the source of the data 
(test/train), was created in the main data sets before merging them into one
data set.
6) The dplyr package is used to chain a few actions together: the merged data
set is grouped by activity and subject, then summarised by applying a mean to 
each variable, except the extra "Source" variable created in the previous step.
7) The resulting data frame is written to file in a way that can be re-read into
R using the following command: read.table("./run_analysis.txt", headers = T)