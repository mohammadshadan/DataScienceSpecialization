#MOHAMMAD SHADAN
#Objevtive : Re-create Plot for Energy sub metering variation over two days and save as PNG File (480x480)

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


#For plot3
plot(hpc$datetime,hpc$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
lines(hpc$datetime, hpc$Sub_metering_2,col="red" )
lines(hpc$datetime, hpc$Sub_metering_3,col="blue" )

legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), lwd=c(1,1),cex=0.9)

       
#Saving plot3 as PNG File (480x480)
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
cat("Plot3.png has been saved in", getwd())
