========================================================================

###CodeBook - run_analysis.R script
####01-23-2015
####Developed by Paulo Marcon (paulofbmarcon@gmail)
####For the Course Project of the Getting and Cleaning Data Course

========================================================================

####Variables description - Code Book

Below is a short description about the variables. Detailed information can be found in the original dataset located here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
 The 88 variables represent the average grouped by ActivityLabels and Subject. In some measuments there will be the mean of the means or the mean of the standard deviation of the original data. The description of each variable is given by the following text retrieved from the original description:
 
 [...]
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
[...]
Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
[...]"
 

========================================================================
#### Experimental Study

## Important Information
>To run the script you will need the dplyr package;
>The script doesn`t need any kind of parametrization;
>You need leave the data files in the same folder of the script, except the train and test files that shoul be in your original folders.

##Steps to obtain the tidy data set

1. All the files were readen by read.table method. Other methods like read.fwf showed very slow. Where it was possible the collumns names were informed. With cbind and rbind all the files were grouped;
2. Only the mean and standard deviation were left in the data set, this was achieved with the use of lgrep;
3.The ActivityLabels column receveid meaningfull names for their observations;
4. Using smart replacements all the columns names reaceived meaningfull names, avoiding abreaviated names;
5. Finally with the use of agreggate function was obtained the mean of the variables grouped by ActivityLabels and Subject. Subsequently there is a call to write.table function to save the obtained data set.

