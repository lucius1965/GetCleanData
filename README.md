
### Creating working space 

Build a clean working space, creating required directory and loading the library if not already present in the environment. Then dataset required for the analisys are downloaded and exploded.

### Merge training and test sets

Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt,
subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain three data sets for measurement, activities and subjects. An additional data set for the labels were extracted from features.txt.

### Extract mean and standard deviation variables

From the merged data set of measurement **(x_data)** is extracted a data set with the variables having mean or standard deviation. The procedure is to build a logical vector checking the presence of mean (variables with labels that contain "mean") and standard deviation (variables with labels that contain "std") on the data set of **Features**, and then using this logical vector (named **mean_and_std_features**) to subset the required columns.

### Use descriptive activity names

Correction of names of variable in data sets giving names from features. 
A correction on names data frame for activity (y_data) and some tweaking on data frame for subject (basically a list with number of subject for every row of data) and then you can build a binding of those 3 structure named **all_data**

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
