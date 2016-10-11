plot4.R
#************************************************************************************
#Objective 4:
#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999-2008?

#Observation based on the plot :
#For combustion-related sources, emission decreased but were almost same in 2002 
#and 2005 and finally decreased in 2008
#************************************************************************************

#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Load ggplot2 package
library(ggplot2)

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)
scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)
scc <- readRDS("Source_Classification_Code.rds")

#Fetching the required columns from Source Classification Code Table
scc <- scc[,c('SCC','Short.Name')]
#Filtering data where "Coal" comes in the Short.Name column
scc <- subset(scc, grepl("Coal",Short.Name))

#Merging the data
coal_data <- merge(scc_data, scc, by='SCC')

#Aggregating sum of Emissions by year
emissionbyyear <- aggregate(Emissions ~ year, coal_data, FUN=sum)
emissionbyyear$year <- factor(emissionbyyear$year)

#Using qplot from ggplot2 package
g <- qplot(year,Emissions,data=emissionbyyear, fill=year) 
g <- g + geom_bar(stat="identity")
g <- g + geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-0.6))
g <- g + labs(x = "Years", y = "PM2.5 Emissions")
g <- g + labs(title = "Total PM2.5 Emissions By Coal Sources From 1999-2008")
g

#Saving plot4 as PNG File (480x480)
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
cat("Plot4.png has been saved in", getwd())