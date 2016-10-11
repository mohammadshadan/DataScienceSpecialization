#plot1.R
#**********************************************************************************
#Objective 1:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

#Observation based on plot :
#Total PM2.5 Emissions decreasd from 1999 to 2008
#**********************************************************************************

#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)

scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)

scc <- readRDS("Source_Classification_Code.rds")

#Aggregating sum of Emissions by year
emissionbyyear <- aggregate(Emissions ~ year, scc_data, FUN=sum)

#Using barplot function from the base plotting system
barplot(height = emissionbyyear$Emissions,
        names.arg = emissionbyyear$year, 
        col = emissionbyyear$Emissions,
        xlab = "Years",
        ylab = "PM2.5 Emissions",
        main = "Total PM2.5 Emissions Each Year from 1999 to 2008")

#Saving plot1 as PNG File (480x480)
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
cat("Plot1.png has been saved in", getwd())