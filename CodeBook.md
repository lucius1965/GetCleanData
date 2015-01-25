Code Book
========

Source of data
-------------------

### Origin

The data are from UCI Machine Learning repository, in particular from the
the *Human Activity Recognition Using Smartphones Data Set* [[1](#uci-har)],
originally used to experiment Activity Recognition [[2](#activity-recognition)] on Support Vector Machine (SVM) [[3](#har-smart)].

The data were collected using smartphones as sensing tools, given that they have embedded build in sensor as gyroscopes, aceelerometers etc.

The data set was built from experiments carried out with a group of 30 volunteers
each performing six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone on the waist. The signal of its embedded accelerometer, gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured and recorded.

The obtained data set has been randomly partitioned into two sets, where 70% of
the volunteers was selected for generating the training data and 30% the test data.

### Signals

The signal in time domain  from accelerometer and gyroscope were captured and filtered to avoid noise.
Other filtered signal were captured for body and gravity acceleration.
With mathematical derivate were calculated jerk signals.
With concept of Euclidean norm were obtained the magnitude of the 3-dimensional data and finally an FFT (Fast Fourier Tranform) were applied to some of the signal to obtain the frequency spectrum of them

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autoregression coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded
within [-1,1].

Data transformation
-------------------
See file readme.md
The raw data sets are processed with run_analisys.R script to create a tidy data
set [[5](#tidy-dataset)].

### Creating working space 

Were created a clean working space, creating required directory and loading the library if not already present in the environment. Then dataset required for the analisys are downloaded and exploded.

### Merge training and test sets

Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt,
subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain to obtain three data sets for measurement, activities and subjects. An additional data set for the labels were extracted from features.txt.

### Extract mean and standard deviation variables

From the merged data set of measurement (x_data) is extracted a data set with the variables having mean or standard deviation. The procedure is to build a logical vector checking the presence of mean (variables with labels that contain "mean") and standard
deviation (variables with labels that contain "std") on the data set of features, and then using this logical vector (named )

### Use descriptive activity names

A new column is added to intermediate data set with the activity description.
Activity id column is used to look up descriptions in activity_labels.txt.

### Label variables appropriately

Labels given from the original collectors were changed:
* to obtain valid R names without parentheses, dashes and commas
* to obtain more descriptive labels

### Create a tidy data set

From the intermediate data set is created a final tidy data set where numeric
variables are averaged for each activity and each subject.

The tidy data set contains 10299 observations with 81 variables divided in:

*  an activity label (__Activity__): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
*  an identifier of the subject who carried out the experiment (__Subject__):
   1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
*  a 79-feature vector with time and frequency domain signal variables (numeric)

The following table relates the 17 signals to the names used as prefix for the
variables names present in the data set. ".XYZ" denotes three variables, one for each axis.

Name                                  | Time domain                                 | Frequency domain
------------------------------------- | ------------------------------------------- | ------------------------------------------------
Body Acceleration                     | TimeDomain.BodyAcceleration.XYZ             | FrequencyDomain.BodyAcceleration.XYZ
Gravity Acceleration                  | TimeDomain.GravityAcceleration.XYZ          |
Body Acceleration Jerk                | TimeDomain.BodyAccelerationJerk.XYZ         | FrequencyDomain.BodyAccelerationJerk.XYZ
Body Angular Speed                    | TimeDomain.BodyAngularSpeed.XYZ             | FrequencyDomain.BodyAngularSpeed.XYZ
Body Angular Acceleration             | TimeDomain.BodyAngularAcceleration.XYZ      |
Body Acceleration Magnitude           | TimeDomain.BodyAccelerationMagnitude        | FrequencyDomain.BodyAccelerationMagnitude
Gravity Acceleration Magnitude        | TimeDomain.GravityAccelerationMagnitude     |
Body Acceleration Jerk Magnitude      | TimeDomain.BodyAccelerationJerkMagnitude    | FrequencyDomain.BodyAccelerationJerkMagnitude
Body Angular Speed Magnitude          | TimeDomain.BodyAngularSpeedMagnitude        | FrequencyDomain.BodyAngularSpeedMagnitude
Body Angular Acceleration Magnitude   | TimeDomain.BodyAngularAccelerationMagnitude | FrequencyDomain.BodyAngularAccelerationMagnitude

For variables derived from mean and standard deviation estimation, the previous labels
are augmented with the terms "Mean" or "StandardDeviation".

The data set is written to the file sensor_avg_by_act_sub.txt.

References
----------

1.  <a name="uci-har"/>Human Activity Recognition Using Smartphones Data Set.
    URL: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. 
    
2.  <a name="activity-recognition"/>Activity recognition. URL: <http://en.wikipedia.org/wiki/Activity_recognition>.
   
3. <a name="har-smart"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*.
   International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

4. <a name="har-smart2"/>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *A Public Domain Dataset for Human Activity Recognition Using Smartphones*.
   ESANN 2013 proceedings, European Symposium on Artificial Neural Networks, Computational Intelligence and
   Machine Learning. Bruges (Belgium), 24-26 April 2013
5.  <a name="tidy-dataset"/>Tidy data set. URL: <https://github.com/jtleek/datasharing#the-tidy-data-set>.
     Accessed 05/21/2014
