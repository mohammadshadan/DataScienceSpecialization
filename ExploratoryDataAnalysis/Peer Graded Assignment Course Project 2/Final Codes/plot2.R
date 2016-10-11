#plot2.R
#************************************************************************************
#Objective 2:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

#Observation based on the plot :
#Emissions decreased in 2002 but then increased in 2005 and finally decerased in 2008
#************************************************************************************

#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)

scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)

scc <- readRDS("Source_Classification_Code.rds")

#Filtering data for Baltimore City, Maryland (fips == "24510") from 1999 to 2008

scc_data <-subset(scc_data,scc_data$fips == "24510")

#Aggregating sum of Emissions by year
emissionbyyear <- aggregate(Emissions ~ year, scc_data, FUN=sum)

#Using barplot function from the base plotting system
barplot(height = emissionbyyear$Emissions,
        names.arg = emissionbyyear$year, 
        col = emissionbyyear$Emissions,
        xlab = "Years",
        ylab = "PM2.5 Emissions",
        main = "PM2.5 Emissions Each Year in Baltimore City, Maryland")


#Saving plot2 as PNG File (480x480)
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
cat("Plot2.png has been saved in", getwd())