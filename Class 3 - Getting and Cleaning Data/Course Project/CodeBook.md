# Supplementary Code Book for the Getting and Cleaning Data Course Project
Written by Nicholas Ng on 20 Sep 2014

## Introduction
This markdown lists the files which contain data (both inputs and outputs), and
discusses the variables in greater detail. For a discussion on the
transformations and methods used in handling the data, please refer to the
README markdown included in the same directory as this markdown.

## Data Files
The data files used in this project can be found in the data folder of this
directory and are as follows:
* activity_labels.txt
* features.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt

The final tidy data set as required in step 5 of the course project is
analysis_output.txt, and can be found in the main directory.

## The Input Data
The raw data as provided in the course project comes from the "Human Activity 
Recognition Using Smartphones" research conducted by the Smartlab - Non Linear 
Complex Systems Laboratory at the Università degli Studi di Genova.

The following sections describe in greater detail the data contained within each
file and the variables used to describe the data. The numbers in parentheses
indicate the column index which is being referred to.

### activity_labels.txt File
This file contains a reference table for descriptors of activities for which 
measurements were taken for. It contains 2 columns of data which are given the
following variable names in the process of the script:
* (1) Activity_ID: Integers as an reference index for activities measured.
* (2) Activity: Strings describing the activity being measured.

### features.txt File
This file contains the short descriptors of variables which every column of data
represents in the X_*.txt files. It has 2 columns of data:
* (1) ID: Integers as a reference index for each variable
* (2) Feature: Strings with the descriptor of each variable

Because each string is used as a variable name for the data in the X_*.txt 
files, a more detailed discussion of each variable and its names can be found in
the relevant section.

### subject_*.txt Files
These files contain a vector which every element identifies a research subject/
individual involved in the research. All elements are integers and elements may
repeat due to separate measurements taken for different activities. It should be
noted that there are 30 unique individuals when the data in both test and train 
variants of the files are combined and data is stored in the same fashion in
both files.

### X_*txt Files
These files contain the all of the measurement data collected in the research,
and contain no descriptive/categorical variables on their own. The data files
also do not contain variable names, hence the variable names need to be pulled
from the features.txt file and attached to the data frames when these files are
read into R.

Because there are a total of 561 different variables based on different
measurements and transformations made by the researchers, the following 
discussion of the variables follows the provided supplementary codebook in the
original dataset, features_info.txt.

Raw signals were captured from accelerometers and gyroscopes in 4 dimensions
(the X, Y and Z planes and across time) and stored as tAcc-XYZ and tGyro-XYZ
(although it is described here and in other measurements as "-XYZ", it is only for
easier discussion and is actually separately denoted as"-X", "-Y", and "-Z"). 
The tAcc-XYZ measurements were sorted into 2 sets, tBodyAcc-XYZ representing the
acceleration of the body, and tGravityAcc-XYZ representing the acceleration of
gravity.

The Jerk signals, measuring impulse recorded by the accelerometer and gyroscope
were derived in time and are represented as tBodyAccJerk-XYZ and 
tBodyGyroJerk-XYZ. The researchers calculated the magnitude of the all 3-
dimensional signals using the euclidean norm to obtain the tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag and tBodyGyroJerkMag measurements.

The last transformation of the raw signals done by the researchers was to apply
a Fast Fourier transformation to the signals, obtaining fBodyAcc-XYZ, 
fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag and 
fBodyGyroJerkMag.

The dataset does not include the raw data as discussed above, but instead
contain estimations of the above measurements. The list of estimations performed
are as follows:
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between 2 vectors.

Lastly, the researchers used estimated vectors for the angle() estimation. They 
are gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean.

As one is not familiar with the research and the topic as a whole, I would not be
able to comment on the units of the above variables.

### y_*.txt Files
These files contain a vector which every element identifies the activity the 
measurements are taken for. All elements are integers and should be used in
conjunction with the activity_labels.txt file to attach descriptive labels to
the data sets.

## The Output Data
The final tidy data set, as aforementioned, is named as analysis_output.txt, and
contains the objective data as required in step 5 of the course project. This
data set has been subsetted to only include the mean and standard deviation
variables of the main measurements:
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The data has been grouped by activity (Activity) and subject (Subject_ID), and
summarised by applying a mean function over the variables. Although the values
now represent the mean of the original data, it was difficult to find meaningful
new names for the variables, hence there have been no changes made.

The variables representing the angle between the two mean vectors have been
excluded from the output data set as one is of the opinion that these variables
do not present the mean and standard deviation of the raw measurements made by
the researchers, and hence is not required in the final output.

The Fast Fourier transformed variables have been included, since the raw signal
measurements have not been included and without verbatim on the parameters used
in the transformation method, it is not possible to recalculate these variables
from the other transformed variables.