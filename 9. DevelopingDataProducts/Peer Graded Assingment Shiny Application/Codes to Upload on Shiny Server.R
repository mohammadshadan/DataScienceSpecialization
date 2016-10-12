install.packages('rsconnect')
install.packages('devtools')
library(rsconnect)
library(devtools)
devtools::install_github("rstudio/shinyapps")

rsconnect::setAccountInfo(name='mohammadshadan', token='XXXX', secret='XXXXX')

deployApp(appName = "myapp")