---
title: "CodeBook"
author: "MOHAMMAD SHADAN"
date: "August 25, 2016"

---

**Dataset**    : "household_power_consumption.txt" (Electric power consumption) 

The dataset has 2,075,259 rows and 9 columns and can be download from the [URL](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)

**Description**: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.             
            
**Time Period** : For our analysis the data has been filtered for Dates "2007-02-01" and "2007-02-02"

The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

#####1. Date 
Date in format dd/mm/yyyy (This need to be converted into proper date format for proper execution)

#####2. Time
Time in format hh:mm:ss

#####3. Global_active_power
Household global minute-averaged active power (in kilowatt)

#####4. Global_reactive_power
Household global minute-averaged reactive power (in kilowatt)

#####5. Voltage              
Minute-averaged voltage (in volt)

#####6. Global_intensity     
Household global minute-averaged current intensity (in ampere)

#####7.Sub_metering_1       
Energy sub-metering No. 1 (in watt-hour of active energy). 
It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered)

#####8. Sub_metering_2       
Energy sub-metering No. 2 (in watt-hour of active energy). 
It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.

#####9. Sub_metering_3       
Energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.