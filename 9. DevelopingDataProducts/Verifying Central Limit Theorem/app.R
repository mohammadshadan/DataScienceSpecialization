# Verifying Central Limit Theorem

# palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
#           "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

library(shiny)
library(ggplot2)

ui <- fluidPage(

  headerPanel('Normal and Exponential Distribution'),
  
  sidebarPanel(
    selectInput("Disbribution", "Please Select Disbribution Type",
                choices = c("Normal", "Exponential")),
    sliderInput("num_of_sim", "Please Select Number of Simulations",
                min = 200, max = 2000, value = 300, step = 100),
    sliderInput("sample_size", "Please Select Sample Size",
                min = 40, max = 100, value = 40, step = 10),
    conditionalPanel(condition="input.Disbribution =='Normal'",
                     textInput("mean", "Please Select the mean", 10),
                     textInput("sd", "Please Select Standard Deviation",3)),
    conditionalPanel(condition="input.Disbribution =='Exponential'",
                     textInput("lambda", "Please Select Exponential lambda", 1))
  ),
  
  mainPanel(
    plotOutput("myPlot",width = 800, height = 600)  
  
  )
)

server <- function(input, output) {
  
  #data <- reactive({iris[iris$Species == input$Species,]})
  
  output$myPlot <- renderPlot({
    
    distType        <- input$Disbribution
    num_of_sim            <- input$num_of_sim
    sample_size     <- input$sample_size
    
    if(distType == "Normal"){
      randomVec <- rnorm(num_of_sim*sample_size, mean = as.numeric(input$mean), sd = as.numeric(input$sd))
      test_data <- matrix(randomVec, num_of_sim, sample_size)
      test_data <- as.data.frame(test_data)
      row_mean <- apply(test_data,1,mean)
    }
    else {
      randomVec <- rexp(num_of_sim*sample_size, rate = 1/as.numeric(input$lambda))
      test_data <- matrix(randomVec, num_of_sim, sample_size)
      test_data <- as.data.frame(test_data)
      row_mean <- apply(test_data,1,mean)
    }
    
    par(mfrow = c(2,1))
    hist(randomVec, col = "blue", main="Histogram of Distribution" )
    hist(row_mean, col = "red", main="Histogram of Sample Mean" )
    par(mfrow = c(1,1))
  })
  
}

shinyApp(ui = ui, server = server)

# install.packages('rsconnect')
# install.packages('devtools')
# library(rsconnect)
# library(devtools)

# rsconnect::setAccountInfo(name='mohammadshadan', token='6931A58B5F9A1883E3DC48BA8DD341BA', secret='LpHyCgI3yOUrDuwSF55SuacRERG78aBvpiSVNS6b')

#deployApp(appName = "verifyCLT")


#runApp(display.mode='showcase')  
#runApp()  
#deployApp()
#rsconnect::deployApp('C:/Users/Lenovo/Documents/R/DSC/shinyapp')