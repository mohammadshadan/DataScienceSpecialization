#plot3.R
#************************************************************************************
#Objective 3:
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make 
#a plot answer this question.

#Observations based on plots:
#For NON-ROAD : Emissions decreased over the years from 1999 to 2008
#For NONPOINT : Emissions decreased over the years from 1999 to 2008 but much higher compared to other types
#For ON-ROAD  : Emissions decreased over the years from 1999 to 2008
#For POINT    : Emissions increased from 1999 to 2005 then decreased in 2008  

#************************************************************************************

#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Loading ggplot2
library(ggplot2)

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)
scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)
scc <- readRDS("Source_Classification_Code.rds")

#Filtering data for Baltimore City, Maryland (fips == "24510") from 1999 to 2008
scc_data <-subset(scc_data,scc_data$fips == "24510")

#Aggregating sum of Emissions by type and year
emissionbyyear <- aggregate(Emissions ~ type+year, scc_data, FUN=sum)
emissionbyyear$year <- factor(emissionbyyear$year)

#Plotting Non-Road, Non-Point, On-Road and Points seprately over years
g <- qplot(year,Emissions,data=emissionbyyear, facets=.~type, fill=year)
g <- g + geom_bar(stat="identity")
g <- g + geom_text(aes(label=round(Emissions,0), size=.5, hjust=0.5, vjust=-.7))
g <- g + labs(x = "Years", y = "PM2.5 Emissions")
g <- g + labs(title = "Emissions By Source Types NON-ROAD, NONPOINT, ON-ROAD and POINT from 1999-2008")
g


#Saving plot3 as PNG File (680x480)
dev.copy(png, file="plot3.png", width=680, height=480)
dev.off()
cat("Plot3.png has been saved in", getwd())