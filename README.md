# Getting_and_Cleaning_Data
Assignment for week 4

The run_analysis requires the dataset to be unzipped and copied to a folder "UCI HAR Dataset"

The script loads the following packages: dplyr, reshape2

The script then reads the following tables from the Dataset
activity_labels.txt
features.txt
X_train.txt
y_train.txt
subject_train.txt
X_test.txt
y_test.txt
subject_test.txt

The script then does the following:
Combines the test and training set (rbind)

Adds field names to the combined test/training set.

Creates a logical vector with a list of fields that include the text "mean" or "std"

Removes fields from the combined test/training set which are not indicated as "True" by the vector above

Combines the row labels from Y_test and Y_train (combined label set)

Adds the "Activity" label to the combined label set

Adds descriptive names to the combined label set

Binds (column bind cbind) the Combined row labels with the combined test/training set. 

Melts the labeled data set using using the variables of "Subject", "Activity_ID" and "Activity_Label"

Creates a new dataset "Combined_Avg" which shows the mean of each variable by Subject, Activity_ID, Activity_Label and Variable
