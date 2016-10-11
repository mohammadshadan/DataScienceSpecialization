---
title: "README"
author: "MOHAMMAD SHADAN"
date: "August 25, 2016"
---

###OBJECTIVE 
Create separate R codes file (plot1.R, plot2.R, plot3.R and plot4.R) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot.

###EXECUTION

Below steps must be performed before the R scripts plot1.R, plot2.R, plot3.R and plot4.R can run : 

**Step 1** : 
Download the zipped file from the [URL](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)

**Step 2** : 
Unzip the zipped file

**Step 3** : 
Transfer the below file into the same working directory as the R script. It's better to create a new directory and move all the files to it including the R scripts.

1. "household_power_consumption.txt"		: Electric power consumption dataset

**Step 3** :
Install the lubricate package if it's not already installed. It can be done using the command install.packages("lubridate") on the R console.

**Step 4** :
After completing the above stpes, you can run the 4 R scripts

**Output** :
Output of the R script will be a 4 PNG Files, namely plot1.png, plot2.png, plot3.png and plot4.png in the same working directory

###How the R Scripts (plot1.R, plot2.R, plot3.R and plot4.R) Work

#### Extracting the Data. This would be same for all the plots

```{r}
#Install package lubridate if it's not already installed
#install.package("lubridate)
library(lubridate)

##***Extracting and Cleaning data begins***

#Extracting data from the .txt file
hpcdata <- read.table("household_power_consumption.txt", skip = 1, sep = ";", header = FALSE, na.strings = "?")

#Copying the Column Names from Row Number 1
cnames <- readLines("household_power_consumption.txt",1)

#Spliting the column names by ";" using strsplit
cnames <- strsplit(cnames, ";", fixed = TRUE)

#Updating the column names
names(hpcdata) <- cnames[[1]]

#Making a copy of clean data set
hpc <-hpcdata

##Convert data in column "Dates" to Date format "YYYY-MM-DD"
hpc$Date <-dmy(hpc$Date)

date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

#Filtering the data between the dates "2007-02-01" and "2007-02-02"
hpc <- subset(hpc, hpc$Date >= date1 & hpc$Date <=date2)

#Combining Data and Time
hpc$datetime<-as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")

##***Extracting and Cleaning data is completed***
```

###  plot1.R 
#### Frequency for Global Active Power (kilowatt)

```{r}
##After Extracting the data

#For plot1

hist(hpc$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red",
     las=1)
```

```{r}
#Saving plot1 as PNG File (480x480)

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
cat("Plot1.png has been saved in", getwd())

```
###  plot2.R 
#### Variation of Global Active Power (kilowatt) over two days

```{r}
#For plot2
##After Extracting the data

plot(hpc$Global_active_power,hpc$DateTime, type="l",ylab="Global Active Power (kilowatts)")
```

```{r}
#Saving plot2 as PNG File (480x480)

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
cat("Plot2.png has been saved in", getwd())

```
###  plot3.R 
#### Variation of Energy sub metering  over two days

```{r}
##After Extracting the data

#For plot3
plot(hpc$datetime,hpc$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
lines(hpc$datetime, hpc$Sub_metering_2,col="red" )
lines(hpc$datetime, hpc$Sub_metering_3,col="blue" )

legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), lwd=c(1,1),cex=0.9)
```

```{r}
#Saving plot3 as PNG File (480x480)
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
cat("Plot3.png has been saved in", getwd())
```

###   plot3.R 
####  Re-create below 4 graphs in a single plot
####  1. Global Active Power vs. datetime, 1st row and 1st column
####  2. Voltage vs. datetime, 1st row and 2nd column
####  3. Energy sub metering vs. datetime, 2nd row and 1st column
####  4. Global Reactive Power vs. datetime, 2nd row and 2nd column

```{r}
##After Extracting the data

#Plotting the graphs
#Arranging rows and columns for plotting 4 graphs

par(mfrow = c(2, 2))

#1. Plot for Global Active Power vs. datetime, 1st row and 1st column

plot(hpc$datetime,hpc$Global_active_power, type="l",
     xlab = "", ylab="Global Active Power (kilowatts)")


#2. Plot for Voltage vs. datetime, 1st row and 2nd column

plot(hpc$datetime,hpc$Voltage, type="l",xlab = "datetime",ylab="Voltage")

#3. Plot for Energy sub metering vs. datetime, 2nd row and 1st column

plot(hpc$datetime,hpc$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
lines(hpc$datetime, hpc$Sub_metering_2,col="red" )
lines(hpc$datetime, hpc$Sub_metering_3,col="blue" )
legend("topright", col=c("black","red","blue"), 
       legend = c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 "),
       lty=c(1,1), lwd=c(1,1), cex=0.4, bty='n')

#4. Plot for Global Reactive Power vs. datetime, 2nd row and 2nd column

plot(hpc$datetime,hpc$Global_reactive_power, type="l",
     xlab = "datetime", ylab="Global_reactive_power")
     
#reset the pars
par(mfrow = c(1, 1))
```

```{r}
#Saving plot4 as PNG File (480x480)

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
cat("Plot4.png has been saved in", getwd())
```

####THANK YOU

