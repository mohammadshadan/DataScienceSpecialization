plot5.R
#************************************************************************************
#Objective 5:
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore 
#City?

#Observation based on the plot :
#For motor vehicle sources, emission decreased from 1999 to 2008, though the emission
#were almost same in 2002 and 2005
#************************************************************************************

#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Load ggplot2 package
library(ggplot2)

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)
scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)

scc <- readRDS("Source_Classification_Code.rds")

#Filtering data for Baltimore City, Maryland (fips == "24510") from 1999 to 2008
scc_data <-subset(scc_data,scc_data$fips == "24510" & scc_data$type == "ON-ROAD")

#Aggregating sum of Emissions by year
emissionbyyear <- aggregate(Emissions ~ year, scc_data, FUN=sum)
emissionbyyear$year <- factor(emissionbyyear$year)

#Using qplot from ggplot2 package
g <- qplot(year,Emissions,data=emissionbyyear, fill=year) 
g <- g + geom_bar(stat="identity")
g <- g + geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-0.6))
g <- g + labs(x = "Years", y = "PM2.5 Emissions")
g <- g + labs(title = "Emissions By Motor Sources (ON-ROAD) in Baltimore From 1999-2008")
g

#Saving plot5 as PNG File (480x480)
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()
cat("Plot5.png has been saved in", getwd())