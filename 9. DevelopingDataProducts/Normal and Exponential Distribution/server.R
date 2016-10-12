## server.R

shinyServer(
  function(input, output, session) {
    
    data <- reactive({iris[iris$Species == input$Species,]})
    
    output$myPlot <- renderPlot({
      
      distType <- input$Disbribution
      size     <- input$sampleSize
      
      if(distType == "Normal"){
        randomVec <- rnorm(size, mean = as.numeric(input$mean), sd = as.numeric(input$sd))
      }
      else {
        randomVec <- rexp(size, rate = 1/as.numeric(input$lambda))
      }
  
      hist(randomVec, col = "blue" )    
      
      
      
    })
  }
)