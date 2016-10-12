---
title: "Peer Graded Assignment: Course Project 1 (Reproducible Research)"
author: "MOHAMMAD SHADAN"
date: "September 4, 2016"
output: html_document
---
### Introduction

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a [Fitbit](http://www.fitbit.com), [Nike 
Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or
[Jawbone Up](https://jawbone.com/up).

This assignment makes use of data from a personal activity monitoring device

* This device collects data at 5 minute intervals through out the day. 

* The dataset consists of two months (October and November, 2012) of data from an anonymous individual 

* Included are the number of steps taken in 5 minute intervals each day.

### Brief Overview of Data

The data for this assignment can be downloaded from the course web
site:

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) 

The variables included in this dataset are:

* **steps**: Number of steps taking in a 5-minute interval (missing
    values are coded as `NA`)

* **date**: The date on which the measurement was taken in YYYY-MM-DD
    format

* **interval**: Identifier for the 5-minute interval in which
    measurement was taken

### Loading and preprocessing the data

```{r, echo=TRUE}
#Set the Working Directory e.g.
#setwd("~/GitHub/RepData_PeerAssessment1")

#Install and load below packages

#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("chron") #Used for is.weekend() function

library(ggplot2)
library(dplyr)
library(chron)   #Used for is.weekend() function
```

####1. Load the data (i.e. `read.csv()`)
```{r, echo=TRUE}
a <- read.csv("activity.csv", header = TRUE)

```
####2. Process/transform the data (if necessary) into a format suitable for your analysis
```{r, echo=TRUE}
head(a)
```
### What is mean total number of steps taken per day?

For this part of the assignment, you can ignore the missing values in
the dataset.

####1. Make a histogram of the total number of steps taken each day
```{r, echo=TRUE}
#Aggregating(summation) of steps over date
aggsteps<- aggregate(steps ~ date, a, FUN=sum)

#Aggregated Data (all steps added for a particular date)
head(aggsteps)

#Ploting histogram using hist() from Base Plotting
hist(aggsteps$steps, 
     col="red", 
     xlab = "Frequency", 
     ylab = "Steps",
     main = "Total Number Of Steps Taken Each day")
    
```

####2. Calculate and report the **mean** and **median** total number of steps taken per day

```{r, echo=TRUE}
amean <- mean(aggsteps$steps)
amedian <- median(aggsteps$steps)

#Mean total number of steps taken per day
amean

#Median total number of steps taken per day
amedian

```

####**Mean** and **Median** total number of steps taken per day are **10766.19** and **10765** respectively. 


### What is the average daily activity pattern?

####1. Make a time series plot (i.e. `type = "l"`) of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```{r, echo=TRUE}
#Aggregating(summation) of steps over time interval (of 5 min)
agginterval <- aggregate(steps ~ interval, a, FUN=sum)

#Plotting line graph using plot() from Base Plotting for Total Steps vs 5-Minute Interval
plot(agginterval$interval, agginterval$steps, 
     type = "l", lwd = 2,
     xlab = "Interval", 
     ylab = "Total Steps",
     main = "Total Steps vs. 5-Minute Interval")

```

####2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
```{r, echo=TRUE}
#Fetching the 5 min interval which has maximum number of steps
filter(agginterval, steps==max(steps))

```
####Maximum number of steps (10927 steps) happened in 835th 5-min interval

### Imputing missing values

Note that there are a number of days/intervals where there are missing
values (coded as `NA`). The presence of missing days may introduce
bias into some calculations or summaries of the data.

####1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with `NA`s)
```{r, echo=TRUE}
#In the Output of the below query TRUE represents the total number of NA values
table(is.na(a))

```
####The total number of rows with `NA`s are 2304

####2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
```{r, echo=TRUE}
#In the original data set aggregating (mean) steps over 5-minute interval
meaninterval<- aggregate(steps ~ interval, a, FUN=mean)

#Merging the mean of total steps for a date with the original data set
anew <- merge(x=a, y=meaninterval, by="interval")

#Replacing the NA values with the mean for that 5-minute interval
anew$steps <- ifelse(is.na(anew$steps.x), anew$steps.y, anew$steps.x)

#Merged dataset which will be subsetted in the next step by removing not required columns
head(anew)

```
####3. Create a new dataset that is equal to the original dataset but with the missing data filled in.

```{r, echo=TRUE}
#Fetching only the required columns (steps, date, interval) and storing in the new data set.
anew <- select(anew, steps, date, interval)

#New dataset with NA imputed by mean for that 5-minute interval
head(anew)
```

####4. Make a histogram of the total number of steps taken each day and Calculate and report the **mean** and **median** total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
```{r, echo=TRUE}

#Aggregating(summation) of steps over date
aggsteps_new<- aggregate(steps ~ date, anew, FUN=sum)

#Plotting
#Setting up the pannel for one row and two columns
par(mfrow=c(1,2))

#Histogram after imputing NA values with mean of 5-min interval
hist(aggsteps_new$steps, 
     col="green",
     xlab = "Steps", 
     ylab = "Frequency",
     ylim = c(0,35),
     main = "Total Number Of Steps Taken Each day \n(After imputing NA values with \n mean of 5-min interval)",
     cex.main = 0.7)

#Histogram with the orginal dataset
hist(aggsteps$steps, 
     col="red", 
     xlab = "Steps", 
     ylab = "Frequency",
     ylim = c(0,35),
     main = "Total Number Of Steps Taken Each day \n(Orginal Dataset)",
     cex.main = 0.7)

par(mfrow=c(1,1)) #Resetting the panel

amean_new <- mean(aggsteps_new$steps)
amedian_new <- median(aggsteps_new$steps)

#Comparing Means
paste("New Mean      :", round(amean_new,2), "," ,  
      " Original Mean :", round(amean,2),"," , 
      " Difference :",round(amean_new,2) -  round(amean,2))

#Comparing Medians
paste("New Median    :", amedian_new, ",", 
      " Original Median :", amedian,"," , 
      " Difference :",round(amedian_new-amedian,2))

```
####The Mean are same but New Median differs from Original Median by **1.19**


### Are there differences in activity patterns between weekdays and weekends?

For this part the `weekdays()` function may be of some help here. Use
the dataset with the filled-in missing values for this part.

####1. Create a new factor variable in the dataset with two levels -- "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.
```{r, echo=TRUE}
#Below code will use "chron" package, please install if not alrady installed
#install.packages("chron")
#library(chron)

#is.weekend() function considers Saturday and Sunday as weekends
#In the output of below query FALSE means weekday, TRUE means weekend
table(is.weekend(anew$date))

#Adding new factor variable "dayofweek" indicating whether a given date is a weekday or weekend day
anew$dayofweek <- ifelse(is.weekend(anew$date), "weekend", "weekday")

#Number of Weekdays and Weekends
table(anew$dayofweek)

#New Data after adding factor variable for weekday or weekend
head(anew)
```

####2. Make a panel plot containing a time series plot (i.e. `type = "l"`) of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). The plot should look something like the following, which was created using **simulated data**:


```{r, echo=TRUE}

#Aggregating(mean) steps over interval and day of week
meaninterval_new<- aggregate(steps ~ interval + dayofweek, anew, FUN=mean)

#Aggregated Data
head(meaninterval_new)

#Time Series plot using ggplot
ggplot(meaninterval_new, aes(x=interval, y=steps)) + 
  geom_line(color="blue", size=1) + 
  facet_wrap(~dayofweek, nrow=2) +
  labs(x="\nInterval", y="\nNumber of steps")
```

```{r}
#library(knitr)
#knit("PA1_template.Rmd")
```

##THANK YOU


