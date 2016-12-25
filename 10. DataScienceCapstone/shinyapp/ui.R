# ui.R
library(shiny)

shinyUI(fluidPage(
  
  titlePanel(h1("Word Predictor", align="center"),
             windowTitle = "Data Science Capstone"),
  h4("(using Stupid Backoff)", align="center"),
  h4("Mohammad Shadan - Data Science Capstone Project", align="center"),
  hr(),
  
  fluidRow(
    
    column(6, offset=3,
           
                                h4("Please Enter The Text in the Below Box", align="center"),
                                h5("e.g. Entering", "' United States Of '", "would predict", "' america '", align="center"),
                                # h5("e.g. Entering", "' Android '", "would predict", "' phone '", align="center"),
                                textInput("phrase", label = "", value = ""),
                                tags$head(tags$style(type="text/css", "#phrase {width: 630px;}", align="center")),
                                
                                fluidRow(
                                  
                                  column(6, offset = 3,
                                         br(),
                                         textOutput("stats"), align="center"
                                  ),
                                  
                                  column(6, offset = 3,
                                         br(),br(),
                                         h4("Predicted Word Is ...", align="center")
                                         # "(Please wait for 2-3 sec)", align="center"
                                  ),
                                  column(6, offset = 3,
                                         # p(textOutput("stats2")),
                                         h1(textOutput("nextword"), align="center")
                                  )
                                )
    )
  )))

# install.packages('rsconnect')
# install.packages('devtools')
# library(rsconnect)
# library(devtools)
# devtools::install_github("rstudio/shinyapps")
# rsconnect::setAccountInfo(name='mohammadshadan', token='6931A58B5F9A1883E3DC48BA8DD341BA', secret='LpHyCgI3yOUrDuwSF55SuacRERG78aBvpiSVNS6b')
#runApp(display.mode='showcase')  
#runApp()  
#deployApp()
#rsconnect::deployApp('C:/Users/Lenovo/Documents/R/DSC/shinyapp')
#deployApp(appName = "wordpredictor")
 