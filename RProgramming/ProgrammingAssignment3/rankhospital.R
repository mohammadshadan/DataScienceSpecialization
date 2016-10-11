#Ranking hospitals by outcome in a state
#rankhospital  takes three arguments: the 2-character abbreviated name of a
#state (state), 
#an outcome (outcome), 
#and the ranking of a hospital in that state for that outcome (num).

rankhospital <- function(state, outcome, num) {
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
  data3sort<-data3sort[complete.cases(data3sort), ]
  #print(head(data3sort))
  #print(tail(data3sort))
  
  ## Return hospital name in that state with the given rank 30-day death rate
  #print(data3sort$Hospital.Name[1])
  if(num=="best") num<-1
  else if(num=="worst") num<-nrow(data3sort)
  #print(nrow(data3sort))
  data3sort[num,1] 
  ## rate
}

#Here is some sample output from the function.
#> source("rankhospital.R")
#> rankhospital("TX", "heart failure", 4)
#[1] "DETAR HOSPITAL NAVARRO"
#> rankhospital("MD", "heart attack", "worst")
#[1] "HARFORD MEMORIAL HOSPITAL"
#> rankhospital("MN", "heart attack", 5000)
#[1] NA