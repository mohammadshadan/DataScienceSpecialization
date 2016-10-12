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