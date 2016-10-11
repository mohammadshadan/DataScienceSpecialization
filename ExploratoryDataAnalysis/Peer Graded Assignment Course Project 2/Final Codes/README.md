---
title: "README"
author: "MOHAMMAD SHADAN"
date: "August 28, 2016"
---

###OBJECTIVE 
Create separate six R code file (plot1.R, plot2.R,.. plot6.R) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot.

###EXECUTION

Below steps must be performed before the R scripts can run : 

**Step 1** : 
Download the zipped file from the [URL](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

**Step 2** : 
Unzip the zipped file

**Step 3** : 
Transfer the below files into the same working directory as the R script. It's better to create a new directory and move all the files to it including the R scripts.

1. "summarySCC_PM25.rds"		        : PM2.5 Emissions Data
2. "Source_Classification_Code.rds" : Source Classification Code Table

Details about the datasets are give in [CookBook.md]

**Step 3** :
Install the ggplot2 package if it's not already installed. It can be done using the command install.packages("lubridate") on the R console.
ggplot2 package will be required for plot3.R till plot6.R

**Step 4** :
After completing the above stpes, you can run the 6 R scripts

**Output** :
Output of the R script will be a 6 PNG Files, namely plot1.png, plot2.png, plot3.png ,plot4.png, plot5.R and plot6.R in the same working directory

###How the R Scripts  Work

#### Extracting the Data. This would be same for all the plots

```{r}
#Setup the working directory if required e.g. getwd(),setwd("~/R/EDA/P2")

#Extracting data from summarySCC_PM25.rds file (6497651 rows and 6 columns)

scc_data <- readRDS("summarySCC_PM25.rds")

#Extracting data from Source_Classification_Code.rds file (11717 rows 15 columns)

scc <- readRDS("Source_Classification_Code.rds")
```

###  plot1.R 

#### Objective :
#### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

####Observation based on plot :
####Total PM2.5 Emissions decreasd from 1999 to 2008

```{r}
##After Extracting the data

#Aggregating sum of Emissions by year

emissionbyyear <- aggregate(Emissions ~ year, scc_data, FUN=sum)

#Using barplot function from the base plotting system

barplot(height = emissionbyyear$Emissions,
        names.arg = emissionbyyear$year, 
        col = emissionbyyear$Emissions,
        xlab = "Years",
        ylab = "PM2.5 Emissions",
        main = "Total PM2.5 Emissions Each Year")
```

```{r}
#Saving plot1 as PNG File (480x480)

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
cat("Plot1.png has been saved in", getwd())

```
###  plot2.R 

#### Objective :
#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#### Observation based on the plot :
#### Emissions decreased in 2002 but then increased in 2005 and finally decerased in 2008

```{r}
#For plot2
##After Extracting the data

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
        main = "Total PM2.5 Emissions Each Year for Baltimore City, Maryland")

```

```{r}
#Saving plot2 as PNG File (480x480)

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
cat("Plot2.png has been saved in", getwd())
```
###  plot3.R 

#### Objective :
#### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

#### Observations on based on plots:
#### For NON-ROAD : Emissions decreased over the years from 1999 to 2008
#### For NONPOINT : Emissions decreased over the years from 1999 to 2008 but were much higher compared to other types
#### For ON-ROAD  : Emissions decreased over the years from 1999 to 2008
#### For POINT    : Emissions increased from 1999 to 2005 then decreased in 2008  

```{r}
#For plot3
##After Extracting the data

#Filtering data for Baltimore City, Maryland (fips == "24510") from 1999 to 2008

scc_data <-subset(scc_data,scc_data$fips == "24510")

#Aggregating sum of Emissions by type and year

emissionbyyear <- aggregate(Emissions ~ type+year, scc_data, FUN=sum)
emissionbyyear$year <- factor(emissionbyyear$year)

#Plotting Non-Road, Non-Point, On-Road and Points seprately over years

g <- qplot(year,Emissions,data=emissionbyyear, facets=.~type, fill=year)# + geom_line(size=1.5)
g <- g + geom_bar(stat="identity")
g <- g + geom_text(aes(label=round(Emissions,0), size=1, hjust=0.3, vjust=-1))
g <- g + labs(x = "Years", y = "PM2.5 Emissions")
g <- g + labs(title = "Emissions By Source Types NON-ROAD, NONPOINT, ON-ROAD and POINT from 1999-2008")
g

```

```{r}
#Saving plot3 as PNG File (680x480)

dev.copy(png, file="plot3.png", width=680, height=480)
dev.off()
cat("Plot3.png has been saved in", getwd())
```

###   plot4.R 

#### Objective :
####  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
####  Observation based on the plot :
####  For combustion-related sources, emission decreased but were almost same in 2002 and 2005 and finally decreased in 2008

```{r}
##After Extracting the data

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
```

```{r}
#Saving plot4 as PNG File (480x480)

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
cat("Plot4.png has been saved in", getwd())
```

###   plot5.R 

#### Objective :
####  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
####  Observation based on the plot :
####  For motor vehicle sources, emission decreased from 1999 to 2008, though the emission were almost same in 2002 and 2005

```{r}
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
g <- g + labs(title = "Emissions By Motor Sources (ON-ROAD) for Baltimore From 1999-2008")
g

```

```{r}
#Saving plot5 as PNG File (480x480)
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()
cat("Plot5.png has been saved in", getwd())

```

****
###   plot6.R 

#### Objective :
####  Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
####  Observation based on the plot :
####  For Baltimore City, emissions were already less compared to Los Angles County and the emission decreased over the year from 1999 to 2008
####  For Los Angeles County, emission inceased from 1999 to 2005 but decreased in 2008, still the emission in 2008 were more than in 1999

```{r}
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
g <- g + labs(title = "Emissions By Motor Sources for Baltimore City and Los Angles Country from 1999-2008")
g
```

```{r}
#Saving plot6 as PNG File (680x480)
dev.copy(png, file="plot6.png", width=680, height=480)
dev.off()
cat("Plot6.png has been saved in", getwd())

```

####THANK YOU

