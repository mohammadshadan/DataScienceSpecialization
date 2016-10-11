##FINAL PROJECT SUBMISSION FOR GETTING AND CLEANING DATA COURSE
##WRITTEN BY : MOHAMMAD SHADAN
##DATE       : 23-APR-2016

#run_analysis.R does the following
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.

#Details of the Datasets used and which should be present in the working dirctory :
#- 'features.txt'       : List of all features.
#- 'activity_labels.txt': Links the class labels with their activity name.
#- 'train/X_train.txt'  : Training set.
#- 'train/y_train.txt'  : Training labels.
#- 'test/X_test.txt'    : Test set.
#- 'test/y_test.txt'    : Test labels.
#-  subject_train.txt  	: Each row identifies the subject who performed the activity (train)
#-  subject_test.txt	  : Each row identifies the subject who performed the activity (test)

#install package reshape2 if it's already not installed
#install.packages("reshape2")

library(reshape2)

##EXTRACTING THE DATA SETS

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


#Update the names of headers (columns) in the measurement files from featuers
names(xtest)<- features[,2]
names(xtrain) <- features[,2]

#Update the names of headers (columns) in the label files
names(ytest)<- "activity"
names(ytrain) <- "activity"

#Update the names of headers (columns) in the subject files
names(subject_train) <- "subjectid"
names(subject_test) <- "subjectid"

#****************************************************************************
##OBJECTIVE 1 : Merges the training and the test sets to create one data set
#****************************************************************************

#Merging the measurement Data Sets for test and train

test_data <- cbind(subject_test,ytest, xtest)
train_data <- cbind(subject_train,ytrain, xtrain)
merge_data <- rbind(test_data, train_data)

#Merging the subjets Data Sets to create a single data frame 
subjects <- rbind(subject_train,subject_test)

#*****************************************************************************************************
##Objective 2 : Extracts only the measurements on the mean and standard deviation for each measurement
#*****************************************************************************************************

#Determining which columns contains mean() and std()
#Since subjectid and activity are also part of data, they are also included
tomatch <- c("mean","std","subjectid", "activity")
tomatch_columns <- grep(paste(tomatch,collapse="|"), names(merge_data))

#Fetching data only from the required columns ( %mean%, %std%, studentid, activity)
meanstd_data <- subset(merge_data,select=tomatch_columns)

#*************************************************************************************
##Objective 3 : Uses descriptive activity names to name the activities in the data set
#*************************************************************************************

##As given in the file "activity_label.txt" the activity names are :
# 1     WALKING
# 2     WALKING_UPSTAIRS
# 3     WALKING_DOWNSTAIRS
# 4     SITTING
# 5     STANDING
# 6     LAYING

#thus updating 1 to WALKING, 2 to WALKING_UPSTARIS till 6 to LAYING

meanstd_data$activity <- factor(meanstd_data$activity, 
                                 labels=c("WALKING", "WALKING UPSTAIRS", 
                                          "WALKING DOWNSTAIRS", "SITTING", 
                                           "STANDING", "LAYING"))

#*******************************************************************************
#Objective 4. Appropriately labels the data set with descriptive variable names
#*******************************************************************************

#Updating t to Time, f to Frequency, mean() to Mean, std to StdDev, - to space, 
#BodyBody to Body, meanFreq() to MeanFreq

names(meanstd_data) <- gsub("^t", "Time", names(meanstd_data))
names(meanstd_data) <- gsub("^f", "Frequency", names(meanstd_data))
names(meanstd_data) <- gsub("mean\\(\\)", "Mean", names(meanstd_data))
names(meanstd_data) <- gsub("std\\(\\)", "StdDev", names(meanstd_data))
names(meanstd_data) <- gsub("-", "", names(meanstd_data))
names(meanstd_data) <- gsub("meanFreq()\\(\\)", "MeanFreq", names(meanstd_data))
names(meanstd_data) <- gsub("BodyBody", "Body", names(meanstd_data))

#***********************************************************************************************
#Objective 5 : From the data set in step 4, creates a second, independent tidy data set with the 
#              average of each variable for each activity and each subject.
#***********************************************************************************************

meltdata <- melt(meanstd_data, id=c("subjectid","activity"))
tidydata <- dcast(meltdata, subjectid+activity ~ variable, mean)

#Writing the data into csv files separated by comma
#write.table(tidydata, "tidydata.txt", row.names = FALSE, sep = ",")
write.table(tidydata, "tidydata.csv", row.names = FALSE, sep = ",")

#************************************END OF SCRIPT*********************************************

