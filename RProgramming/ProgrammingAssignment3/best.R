#Finding the best hospital in a state
#best take two arguments: the 2-character abbreviated name of a state and an
#outcome name. The function reads the outcome-of-care-measures.csv and returns 
#a character vector with the name of the hospital that has the best (i.e. lowest) 
#30-day mortality for the specified outcome in that state.

best <- function(state, outcome) {
  ## Read outcome data
  col_index=NULL
  data1 <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available",stringsAsFactors=FALSE)
  #print(state)
  ## Check that state and outcome are valid
  statedata<-unique(data1$State)
  if(!(state %in% statedata)) {
    print("invalid state")
    return()
  }
  if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
    print("invalid outcome")
    return() 
  }
  
  data2<-data1[,c(2,7,11,17,23)]
  names(data2)[2]<-"state"
  names(data2)[3]<-"heart attack"
  names(data2)[4]<-"heart failure"
  names(data2)[5]<-"pneumonia"
  data2<-data2[data2[,2]==state, ]
#  head(data2)
  
#  state.data
#  head(state.data)
#  str(state.data)
  if(outcome=="heart attack") col_index<-3
  else if(outcome=="heart failure") col_index<-4
  else if(outcome=="pneumonia") col_index<- 5
  #  data3<-data.frame()
#  data3<-data2[,c(2,7)]
   data3<-data2[,c(1,2,col_index)]
   #print(names(data3)[col_index])
   #data3sort<-data3[order(names(data3)[col_index], state)]
   data3sort<-data3[order(data3[,3],data3[,1]), ]  #data3[,3]) passes the last column name to  
   
   ## Return hospital name in that state with lowest 30-day death
   #print(data3sort$Hospital.Name[1])
   data3sort[1,1]
  ## rate
}

#> source("best.R")
#> best("TX", "heart attack")
#[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
#> best("TX", "heart failure")
#[1] "FORT DUNCAN MEDICAL CENTER"
#> best("MD", "heart attack")
#[1] "JOHNS HOPKINS HOSPITAL, THE"
#> best("MD", "pneumonia")
#[1] "GREATER BALTIMORE MEDICAL CENTER"
#> best("BB", "heart attack")
#Error in best("BB", "heart attack") : invalid state
#> best("NY", "hert attack")
#Error in best("NY", "hert attack") : invalid outcome
