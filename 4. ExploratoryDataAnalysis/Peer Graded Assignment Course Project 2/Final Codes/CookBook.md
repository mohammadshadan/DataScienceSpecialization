---
title: "CookBook"
author: "MOHAMMAD SHADAN"
date: "August 28, 2016"
---
### OVERVIEW

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.


### DATASETS
The data can downloaded from the [URL](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip).


  The 2 data files that will be used to load data are listed as follows :
  
1. `summarySCC_PM25.rds`		        : PM2.5 Emissions Data

PM2.5 Emissions Data (summarySCC_PM25.rds): 

This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 

For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
Columns name in the file summarySCC_PM25.rds are as below :

1. fips: A five-digit number (represented as a string) indicating the U.S. county
2. SCC: The name of the source as indicated by a digit string (see source code classification table)
3. Pollutant: A string indicating the pollutant
4. Emissions: Amount of PM2.5 emitted, in tons
5. type: The type of source (point, non-point, on-road, or non-road)
6. year: The year of emissions recorded

2. `Source_Classification_Code.rds` : Source Classification Code Table
  
Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".

Columns name in file Source_Classification_Code.rds are as below :

1. SCC                 
2. Data.Category       
3. Short.Name          
4. EI.Sector           
5. Option.Group       
6. Option.Set          
7. SCC.Level.One       
8. SCC.Level.Two       
9. SCC.Level.Three     
10. SCC.Level.Four     
11. Map.To              
13. Last.Inventory.Year 
14. Created_Date        
15. Revised_Date        
16. Usage.Notes 



