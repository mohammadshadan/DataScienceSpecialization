plot6.R
#******************************************************************************************
#Objective 6:
#Compare emissions from motor vehicle sources in Baltimore City ("24510") with emissions  
#from  motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
##How have emissions from motor vehicle sources changed from 1999-2008 in 
#Baltimore City?

#Observation based on the plot :
#For Baltimore City, emissions were already less compared to Los Angles County and 
#the emission decreased over the year from 1999 to 2008
#For Los Angeles County, emission inceased from 1999 to 2005 but decreased in 2008,
#still the emission in 2008 were more than in 1999
#******************************************************************************************

#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Load ggplot2 package

library(ggplot2)

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)
scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)
scc <- readRDS("Source_Classification_Code.rds")


#Filtering data for Baltimore City, Maryland (fips == "24510") and
#Los Angeles County, California (fips == "06037") from 1999 to 2008
#for motor vehicle sources
scc_data <-subset(scc_data,(scc_data$fips == "24510" | scc_data$fips == "06037") & scc_data$type == "ON-ROAD")

#Aggregating sum of Emissions by year
emissionbyyear <- aggregate(Emissions ~ year+fips, scc_data, FUN=sum)
emissionbyyear$year <- factor(emissionbyyear$year)

#Changing the fips from number code to names
emissionbyyear$fips[emissionbyyear$fips=="24510"] <- "Baltimore, MD"
emissionbyyear$fips[emissionbyyear$fips=="06037"] <- "Los Angeles County, CA"

#Using qplot from ggplot2 package
g <- qplot(year,Emissions,data=emissionbyyear, facets=.~fips, fill=year) 
g <- g + geom_bar(stat="identity")
g <- g + geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-0.7))
g <- g + labs(x = "Years", y = "PM2.5 Emissions")
g <- g + labs(title = "Emissions By Motor Sources in Baltimore City and Los Angles Country from 1999-2008")
g

#Saving plot6 as PNG File (680x480)
dev.copy(png, file="plot6.png", width=680, height=480)
dev.off()
cat("Plot6.png has been saved in", getwd())