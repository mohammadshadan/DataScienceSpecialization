#MOHAMMAD SHADAN
#Objevtive : Re-create below 4 graphs in a single plot and save as PNG File (480x480)
#             1. Global Active Power vs. datetime, 1st row and 1st column
#             2. Voltage vs. datetime, 1st row and 2nd column
#             3. Energy sub metering vs. datetime, 2nd row and 1st column
#             4. Global Reactive Power vs. datetime, 2nd row and 2nd column

#Dataset    : "household_power_consumption.txt" (Electric power consumption)
#Description: Measurements of electric power consumption in one household with a 
#             one-minute sampling rate over a period of almost 4 years. Different electrical quantities 
#             and some sub-metering values are available.
#             The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power  : household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage              : minute-averaged voltage (in volt)
#Global_intensity     : household global minute-averaged current intensity (in ampere)
#Sub_metering_1       : energy sub-metering No. 1 (in watt-hour of active energy). 
#                       It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave 
#                       (hot plates are not electric but gas powered).
#Sub_metering_2       : energy sub-metering No. 2 (in watt-hour of active energy). 
#                       It corresponds to the laundry room, containing a washing-machine, a tumble-drier, 
#                       a refrigerator and a light.
#Sub_metering_3       : energy sub-metering No. 3 (in watt-hour of active energy). 
#                       It corresponds to an electric water-heater and an air-conditioner.

#Install package lubridate if it's not already installed
#install.package("lubridate)
library(lubridate)

##***Extracting and Cleaning data begins***
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

#Plotting the graphs
#Arranging row and columns for plotting 4 graphs
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


#Saving plot4 as PNG File (480x480)
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
cat("Plot4.png has been saved in", getwd())
