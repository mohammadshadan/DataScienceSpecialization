## ui.R
## This file takes Name of Species as input and send it to server.R for calculation and plotting
library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel('Normal and Exponential Distribution'),
  
  sidebarPanel(
    selectInput("Disbribution", "Please Select Disbribution Type",
                choices = c("Normal", "Exponential")),
    sliderInput("sampleSize", "Please Select Sample Size",
                min = 100, max = 5000, value = 1000, step = 100),
    conditionalPanel(condition="input.Disbribution =='Normal'",
                     textInput("mean", "Please Select the mean", 10),
                     textInput("sd", "Please Select Standard Deviation",3)),
    conditionalPanel(condition="input.Disbribution =='Exponential'",
                     textInput("lambda", "Please Select Exponential lambda", 1))
  ),
  
  mainPanel(
    plotOutput("myPlot")
    
  )
))

#runApp(display.mode='showcase')  
#runApp()  

# install.packages('rsconnect')
# install.packages('devtools')
# library(rsconnect)
# library(devtools)

# rsconnect::setAccountInfo(name='mohammadshadan', token='6931A58B5F9A1883E3DC48BA8DD341BA', secret='LpHyCgI3yOUrDuwSF55SuacRERG78aBvpiSVNS6b')

#deployApp(appName = "normalandexpdist")