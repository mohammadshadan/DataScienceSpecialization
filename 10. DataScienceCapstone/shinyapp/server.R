# server.R

source("predictword.R")

nextw <- function(phrase) {
    return(StupidBackoff(phrase))
}

shinyServer(function(input, output) {
  
  output$stats <- renderText({
    numword <- length(strsplit(input$phrase," ")[[1]])
    numchar <- nchar(input$phrase)
    paste("You Entered ", numword, " Words ( ", numchar, "Characters )")
  })
  output$nextword <- renderText({
    result <- nextw(input$phrase)
    paste0(result)
  })
  
})
