---
title: "Practical Machine Learning Course Project"
author: "MOHAMMAD SHADAN"
date: "September 21, 2016"
output: 
  html_document: 
    keep_md: yes
---

###TABLE OF CONTENT    
- Executive Summary     
- Loading Trainig and Test Data     
- Exploratory Data Analysis     
- Data Processing and Cleaning Data       
    - Removing Zero Covariates      
    - Removing Columns with 90 % missing Values      
- Cross Validation        
- Traning the Models (Boosting with Trees, Random Forest)      
- Check the prediction models on Validation Dataset    
- Model Comparison (Accuracy and Out of Sample Error)  
- Prediction on Testing Dataset (20 different test cases)   
- Result       

###EXECUTIVE SUMMARY   
Six young health participants aged between 20-28 years, with little weight lifting experience were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions and was measured using fitness device which the subject wore :        
- Class A : exactly according to the specification   
- Class B : throwing the elbows to the front   
- Class C : lifting the dumbbell only halfway   
- Class D : lowering the dumbbell only halfway   
- Class E : throwing the hips to the front   

The goal of the project is to choose and train the prediction models on training data and predict the manner in which the subjects did the exercise for 20 different test cases.    

The data for this project come from the [source](http://groupware.les.inf.puc-rio.br/har) and is licensed under the Creative Commons License (CC BY-SA).    


###LOADING DATA

- Training Dataset can be downloaded from the [URL](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv)    
- Testing Dataset can be downloaded from the [URL](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv)     
- Move the Training and Testing dataset to the Working Directory     

```{r,  echo=TRUE, results='hide',message=FALSE}
#Setup the working directory and copy the required training and test datasets
#setwd("~/GitHub/practicalmachinelearning/")

#Load the requied libraries
library(caret); library(ggplot2); library(gridExtra); library(plyr);
library(randomForest); library(splines); library(rpart); library(plyr);
library(parallel); library(doParallel)
```

```{r, cache = TRUE}
set.seed(825)
#Loading the data assuming Missing Values and Uncomputable values as NA
data_training <- read.csv("pml-training.csv", na.strings = c("#DIV/0!", "NA",""))
data_testing <- read.csv("pml-testing.csv", na.strings = c("#DIV/0!", "NA",""))

# If you don't want to download the datasets manually use the below queries
# training_url  <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
# testing_url   <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
# data_training <- read.csv(training_url, na.strings = c("#DIV/0!", "NA",""))
# data_testing  <- read.csv(testing_url, na.strings = c("#DIV/0!", "NA",""))
```
###Exploratory Data Analysis

Dimensions of Training Data Set     
```{r, echo=FALSE}
dim(data_training)
```

Dimensions of Testing Data Set    
```{r, echo=FALSE}
dim(data_testing)
```

Checking for mismatch in column names in both the original training and testing datasets
```{r}
mismatch_all <- which(names(data_training)!=names(data_testing))
```
```{r, echo=FALSE}
cat("Mismatch of Column Names is in Column Number   :", mismatch_all, 
  "\nMismatched Training Data Set Column Name       :", names(data_training)[mismatch_all], 
  "\nMismatched Testing Data Set Column Name        :", names(data_testing)[mismatch_all])
```

`classe` is the variable on which we will build our prediction model  
```{r}
exer_count <- data.frame(table(data_training$classe))
names(exer_count) <- c("Exercise", "Frequency")
table(data_training$classe)
```

```{r, echo=FALSE}
#Frequency Plot
g <- ggplot(exer_count, aes(x=Exercise,y=Frequency, fill=Exercise)) 
g <- g + geom_bar(stat = "identity")
g <- g + labs(title="Variation of classe variable in Training Dataset")
g <- g + geom_text(aes(label=Frequency,  hjust=0.5, vjust=-0.7),size=3.5)
g <- g + theme(legend.position="none")
g <- g + coord_cartesian(ylim=c(0,6000))
g
```

###DATA PROCESSING AND CLEANING DATA

####Removing Zero Covariates   
Some variables have no variability at all. These variables are not useful when we want to construct a prediction model. When nzv = TRUE, those variables can be removed from the model
```{r}
#Creating new datasets training_all and testing after removing Near Zero Variables

#Removing the nearZeroVar (TRUE) variables from the train dataset
training_all <- data_training[, -nearZeroVar(data_training)]

#Removing the same variable which were removed from the train dataset from the test dataset also
testing <- data_testing[, -nearZeroVar(data_training)]
```

####Removing Columns with more than 90 % missing values    
Removing variables (Columns) which have 90 percent NA or missing values and keeping the required columns for better prediction     

```{r}
#Finding column numbers which have more than 90 percent missing values
col_90NA <- which(colSums(is.na(training_all))/nrow(training_all) > .9,arr.ind=TRUE)

# Removing the above columns from the training and testing data sets
training_all <- training_all[, -col_90NA]
testing      <- testing[, -col_90NA]
```

####Removing other non useful columns which won't affect the prediction    
```{r}
# Removing columns X, user_name, raw_timestamp_part_1, raw_timestamp_part_2, cvtd_timestamp, num_window
# Initially I didn't remove these columns but model gave wiered results for "gbm" so removing these
# unwanted columns

training_all <- training_all[, -c(1:6)]
testing      <- testing[, -c(1:6)]
```

Dimensions of the **cleaned** Training Dataset      
```{r, echo = FALSE}
dim(training_all); 
```

Dimensions of the **cleaned** Testing Dataset    
```{r, echo = FALSE}
dim(testing)
```

Veryfying the Column Name Mismatch. There should be one column mismatch    
```{r, echo=FALSE}
mismatch <- which(names(training_all)!=names(testing))

cat("Mismatch of Column Names is in Column Number   :", mismatch, 
  "\nMismatched Training Data Set Column Name       :", names(training_all)[mismatch], 
  "\nMismatched Testing Data Set Column Name        :", names(testing)[mismatch])
```

###CROSS VALIDATION
Since the training data set has 19,622 observations so this data set will be divided into two datsets "training" and "validation". Firstly we will train the model on training data set and do the testing on validation dataset to check the accuracy.    

Splitting the cleaned training dataset (`training_all`) into two datasets, `training` (75 %) and`validation` (remaining 25 %).   

Thus we will have 3 datasets to work on, namely :   
1. `training`   : it has 75 % of the cleaned training data     
2. `validation` : it has 25 % of the cleaned training data    
3. `testing`    : cleaned testing dataset on which final prediction will be done as per the assignment    

```{r}
## Create training set indexes with 75% of cleaned training data
inTrain <- createDataPartition(y=training_all$classe,p=0.75, list=FALSE)
# Subset training_all data to training (75%)
training <- training_all[inTrain,]
# Subset training_all data (the rest) to validation (25%)
validation <- training_all[-inTrain,]
```

###TRAINING THE MODELS (Boosting with Trees, Random Forest)    

I will be using `Boosting With Trees` ("gbm") and `Random Forest` ("rf") as prediction models and will do the testing on the validation data set for accuracy.   

The model which give better results will be used to do the prediction on the final `testing` data set

Step 1: Configure parallel processing
```{r}
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)
```
Step 2: Configure trainControl object
```{r}
fitControl <- trainControl(method = "cv", number = 10, allowParallel = TRUE)
```

Step 3: Develop training model    

Boosting with Trees (gbm)     
```{r,  echo=TRUE, results='hide',message=FALSE}
#Training model using Boosting with Trees and monitoring time taken for execution
start_time_gbm <- Sys.time()
fit_gbm <- caret::train(classe ~ ., method="gbm",data=training ,trControl = fitControl)
end_time_gbm <- Sys.time()
```

Random Forest (rf)    
```{r,  echo=TRUE, results='hide',message=FALSE}
#Training model using Random Forest and monitoring time taken for execution
start_time_rf <- Sys.time()
fit_rf <- caret::train(classe ~ ., method="rf",data=training ,trControl = fitControl)
end_time_rf <- Sys.time()
```

Step 4: De-register parallel processing cluster
```{r}
stopCluster(cluster)
```

###CHECK THE PREDICTION MODELS ON VALIDATION DATASET

####Validation using Boosting with Trees (gbm)
```{r}
#Most important variables as predicted by gbm
varImp(fit_gbm)

#Plotting Accuracy vs. Randomly Selected Predictors
plot(fit_gbm, main="Boosting with Trees, gbm")

#Testing the Boosting with Trees Prediction Model on validation dataset
prediction_gbm <- predict(fit_gbm,newdata=validation[,-53])

#Confusion Matrix for Boosting with Trees
confusionMatrix(prediction_gbm, validation$classe)

#Accuracy and Kappa for Boosting with Trees
ak_gbm <- postResample(prediction_gbm, validation$classe)
```

####Validation using Random Forest (rf)

```{r}
##Most important variables as predicted by Random Forest
varImp(fit_rf)

#Plotting Accuracy vs. Randomly Selected Predictors
plot(fit_rf, main="Random Forest, rf")

#Testing the Random Forest Prediction Model on validation dataset
prediction_rf <- predict(fit_rf,newdata=validation[,-53])

#Confusion Matrix  for Random Forest
confusionMatrix(prediction_rf, validation$classe)

#Accuracy and Kappa for Random Forest
ak_rf <- postResample(prediction_rf, validation$classe)   
```

###Plot comparing the two prediction models with validation data for classe variable

```{r, echo=FALSE}
#Plot for classe variable in Validation Dataset
exer_count_v <- data.frame(table(validation$classe))
names(exer_count_v) <- c("Exercise", "Frequency")
gv <- ggplot(exer_count_v, aes(x=Exercise,y=Frequency, fill=Exercise)) 
gv <- gv + geom_bar(stat = "identity")
gv <- gv + geom_text(aes(label=Frequency,  hjust=0.5, vjust=-0.7),size=3.5)
gv <- gv + theme(legend.position="none")
gv <- gv + coord_cartesian(ylim=c(0,1500))
gv <- gv + labs(title="Validation Data, classe \n (25% of training data)")

#Plot for Prediction using Boosting with Trees (gbm)
exer_count_gbm <- data.frame(table(prediction_gbm))
names(exer_count_gbm) <- c("Exercise", "Frequency")
ggbm <- ggplot(exer_count_gbm, aes(x=Exercise,y=Frequency, fill=Exercise)) 
ggbm <- ggbm + geom_bar(stat = "identity")
ggbm <- ggbm + geom_text(aes(label=Frequency,  hjust=0.5, vjust=-0.7),size=3.5)
ggbm <- ggbm + theme(legend.position="none")
ggbm <- ggbm + coord_cartesian(ylim=c(0,1500))
ggbm <- ggbm + labs(title="Prediction using \n Boosting with Trees")

#Plot for Prediction using Random Forest (rf)
exer_count_rf <- data.frame(table(prediction_rf))
names(exer_count_rf) <- c("Exercise", "Frequency")
grf <- ggplot(exer_count_rf, aes(x=Exercise,y=Frequency, fill=Exercise)) 
grf <- grf + geom_bar(stat = "identity")
grf <- grf + geom_text(aes(label=Frequency,  hjust=0.5, vjust=-0.7),size=3.5)
grf <- grf + theme(legend.position="none")
grf <- grf + coord_cartesian(ylim=c(0,1500))
grf <- grf + labs(title="Prediction using \n Random Forest")

#Panel Plot for Events affecting Population Health
grid.arrange(gv, ggbm, grf, ncol=3)
```

####Time taken for Execution of Prediction Training Models
```{r, echo=FALSE}
cat("Boosting with Trees       :", end_time_gbm - start_time_gbm, 
  "\nRandom Forest             :", end_time_rf - start_time_rf)
```

####Accuracy of Models
```{r, echo=FALSE}
cat("Boosting with Trees       :", ak_gbm[1], 
  "\nRandom Forest             :", ak_rf[1])
```

####Out of Sample Errors (1 - Accuracy)
```{r, echo=FALSE}
cat("Boosting with Trees       :", (1-ak_gbm[1]), 
  "\nRandom Forest             :", (1-ak_rf[1]))
```
As can be confirmed by the Accuracy and Out of Sample Error, Random Forest (rf) does better prediction as compared to Boosting with Trees (gbm) but takes more time for execution.   

###PREDICTION ON TESTING DATASET    
Prediction on the provided `testing` dataset as per the Assignment.    
Using Random Forest as it is more accurate     
```{r}
prediction <- predict(fit_rf,newdata=testing[,-53])
```

###RESULT
Using Random Forest, corresponding values (Class) of `problem_id` in the testing dataset are as below :
```{r}
cbind(testing$problem_id, data.frame(prediction))
```
     
###THANK YOU   