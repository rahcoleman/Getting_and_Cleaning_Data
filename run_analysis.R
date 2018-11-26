#load required packages
library(dplyr)
library(reshape2)
# Set working directory to the folder containing the activity labels and features
setwd("~/Coursera/Data Science Specialty/Getting and Cleaning Data/Week 4/Assignment/UCI HAR Dataset")

# read in the activity labels table
activity_labels <- read.table("activity_labels.txt")

# read in the features table
features <- read.table("features.txt")

# set working directory to the folder containing the training set
setwd("~/Coursera/Data Science Specialty/Getting and Cleaning Data/Week 4/Assignment/UCI HAR Dataset/train")

# read in the training table
X_train<- read.table("X_train.txt") 

# read in the training labels
Y_train <- read.table("y_train.txt") 
subject_train <- read.table("subject_train.txt")

# set working directory to the folder containing the trest set
setwd("~/Coursera/Data Science Specialty/Getting and Cleaning Data/Week 4/Assignment/UCI HAR Dataset/test")

# read in the test set
X_test <- read.table("X_test.txt")

# read in the test labels
Y_test <- read.table("y_test.txt") 
subject_test <- read.table("subject_test.txt")

# merge the test and training sets
Combined_X<-rbind(X_test,X_train) 

# add names to the columns in Combined_X
names(Combined_X)<-features$V2 

# find the columns with "mean" or "std" in the column names
mean_std<-grepl("mean|std",features$V2) 

#reduce Combined_X to only the columns from "mean_std" subset
Combined_X<-Combined_X[,mean_std]

# Merge the labels for the test and training sets
Combined_Y <- rbind(Y_test,Y_train)

# Add activity label to Combined Y
Combined_Y[,2] = activity_labels[Combined_Y[,1],2]

# Add descriptive names to the fields in Combined_Y
names(Combined_Y) = c("Activity_ID","Activity_Label")

# Merge the labels for the test and training sets
Combined_Subject <- rbind(subject_test,subject_train)

# Add descriptive name to Combined_Subject
names(Combined_Subject) = "Subject"

# Column Bind Subect, Y and X into a single dataset
Combined_All<- cbind.data.frame(Combined_Subject,Combined_Y,Combined_X)

# Create Indepedent Tidy dataset with the average of each variable for each activity and subject

# Create a vector of variables
Combined_All_Vars <- c("Subject","Activity_ID","Activity_Label")

# Create a vector of all column names
Combined_All_Labels <- names(Combined_All)

# Create a vector of all observation variables
Combined_All_Obs <- setdiff(Combined_All_Labels,Combined_All_Vars)

# melt all observations into a tidy dataset
Combined_Melt <- melt(Combined_All,id=Combined_All_Vars,measure.vars = Combined_All_Obs)

# Produce the final independenty tidy data set with the average for each variable
Combined_Avg <- Combined_Melt %>% group_by (Subject,Activity_ID,Activity_Label,variable) %>% summarize(mean(value))

# Write tidy data set to a table
setwd("~/Coursera/Data Science Specialty/Getting and Cleaning Data/Week 4/Assignment")
write.table(Combined_Avg,file = "Combined_Avg.txt", row.names = FALSE)
