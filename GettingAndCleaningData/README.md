---
title: "README"
author: "MOHAMMAD SHADAN"
date: "August 23, 2016"
---
###INTRODUCTION

run_analysis.R script is created to perform below 5 tasks :

1. Merge the training and the test sets to create one data set

2. Extract only the measurements on the mean and standard deviation for each measurement

3. Use descriptive activity names to name the activities (Walking, Sitting etc.) in the data set

4. Appropriately labels the Column of data set with understandable names

5. Creates a tidy data set with the average of each variable for each activity and each subject


###EXECUTION

Below steps must be performed before the run_analysis.R script is run : 

**Step 1** : 
Download the zipped file from the [URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

**Step 2** : 
Unzip the zipped file

**Step 3** : 
Transfer the below files into the same working directory as the run_analysis.R script. It's better to create a new directory and move all the files to it including the R script.

1. X_train.txt		: Training data set.

2. X_test.txt		: Test data set.					

3. y_train.txt		: Training labels.

4. y_test.txt		: Test labels.

5. subject_train.txt	: Each row identifies the subject who performed the activity (train)

6. subject_test.txt	: Each row identifies the subject who performed the activity (test)

7. features.txt		: List of all features.

8. activity_labels.txt	: Links the class labels with their activity name.


**Step 3** :
Install the reshape2 package if it's not already installed. It can be done using the command install.packages("reshape2") on the R console.

**Step 4** :
After completing the above stpes, you can run the run_analysis.R script

**Output** :
Output of the R script will be a tidy data set named [tidydata.csv](https://github.com/mohammadshadan/Getting-And-Cleaning-Data/blob/master/tidydata.csv) in the same working directory

###HOW THE SCRIPT(run_analysis.R) WORKS


#### Starting step is to extract the test, train, features, activity and subjects data sets

```{r}
#testing data sets
xtest <- read.table("X_test.txt")  # read text file
ytest <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

#training data sets
xtrain <- read.table("X_train.txt")  # read text file
ytrain <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

#features data set
features <- read.table("features.txt")

#activity data set
activity <- read.table("activity_labels.txt")
```

#### Updating Column names

```{r}
#Update the names of headers (columns) in the measurement files from featuers
names(xtest)<- features[,2]
names(xtrain) <- features[,2]

#Update the names of headers (columns) in the label files
names(ytest)<- "activity"
names(ytrain) <- "activity"

#Update the names of headers (columns) in the subject files
names(subject_train) <- "subjectid"
names(subject_test) <- "subjectid"

```
#### Now the data is ready for the below operations to be performed

####1. Merging the training and the test sets to create one data set

```{r}
#Merging the measurement Data Sets for test and train
test_data <- cbind(subject_test,ytest, xtest)
train_data <- cbind(subject_train,ytrain, xtrain)
merge_data <- rbind(test_data, train_data)
```

####2. Extracting only the measurements on the mean and standard deviation for each measurement

```{r}
#Determining which columns contains mean() and std()
#Since subjectid and activity are also part of data, they are also included
tomatch <- c("mean","std","subjectid", "activity")
tomatch_columns <- grep(paste(tomatch,collapse="|"), names(merge_data))

#Fetching data only from the required columns ( %mean%, %std%, studentid, activity)
meanstd_data <- subset(merge_data,select=tomatch_columns)
```

####3. Useing descriptive activity names to name the activities in the data set

```{r}
#Updating 1 to WALKING, 2 to WALKING_UPSTARIS till 6 to LAYING
meanstd_data$activity <- factor(meanstd_data$activity, 
                                 labels=c("WALKING", "WALKING UPSTAIRS", 
                                          "WALKING DOWNSTAIRS", "SITTING", 
                                           "STANDING", "LAYING"))
```

####4. Appropriately labels the data set with descriptive variable names

```{r}
#Updating t to Time, f to Frequency, mean() to Mean, std to StdDev, - to space, 
#BodyBody to Body, meanFreq() to MeanFreq

names(meanstd_data) <- gsub("^t", "Time", names(meanstd_data))
names(meanstd_data) <- gsub("^f", "Frequency", names(meanstd_data))
names(meanstd_data) <- gsub("mean\\(\\)", "Mean", names(meanstd_data))
names(meanstd_data) <- gsub("std\\(\\)", "StdDev", names(meanstd_data))
names(meanstd_data) <- gsub("-", "", names(meanstd_data))
names(meanstd_data) <- gsub("meanFreq()\\(\\)", "MeanFreq", names(meanstd_data))
names(meanstd_data) <- gsub("BodyBody", "Body", names(meanstd_data))
```

####5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

```{r}
meltdata <- melt(meanstd_data, id=c("subjectid","activity"))
tidydata <- dcast(meltdata, subjectid+activity ~ variable, mean)

#Writing the data into csv files separated by comma
write.table(tidydata, "tidydata.csv", row.names = FALSE, sep = ",")
```