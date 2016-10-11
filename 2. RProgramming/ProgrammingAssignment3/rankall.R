#Ranking hospitals in all states
#rankall that takes two arguments: 
#an outcome name (outcome) and 
#a hospital rank-ing (num).

rankall <- function(outcome, num= "best") {
  ## Read outcome data
  col_index=NULL
  data1 <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available",stringsAsFactors=FALSE)
  #print(state)
  ## Check that state and outcome are valid
  statedata<-unique(data1$State)
  statedata<-statedata[order(statedata)]
  rows_state<-length(statedata)
  #print(statedata)

  if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))){
    print("invalid outcome")
    return() 
  }
  
  data2<-data1[,c(2,7,11,17,23)]
  names(data2)[1]<-"hospital"
  names(data2)[2]<-"state"
  names(data2)[3]<-"heart attack"
  names(data2)[4]<-"heart failure"
  names(data2)[5]<-"pneumonia"
  #data2<-data2[data2[,2]==state, ]
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
  data3sort<-data3[order(data3[,2],data3[,3],data3[,1]), ]  #data3[,3]) passes the last column name to  
  #data3sort<-data3sort[complete.cases(data3sort), ]
  #print(head(data3sort))
  #print(head(data3sort))
  #print(tail(data3sort))
  
  ## Return hospital name in that state with the given rank 30-day death rate
  #print(data3sort$Hospital.Name[1])
  #if(num=="best") num<-1
  #else if(num=="worst") num<-nrow(data3sort)
  #print(nrow(data3sort))
  #data3sort[num,1] 
  
  output_data<-data.frame()
  #names(output_data)<-c("hospital","state")
#/remove this
    for(i in 1:rows_state) {
    temp_state<-statedata[i]
    temp_data<-data3sort[data3sort[,2]==temp_state, ]
    temp_data2<-temp_data[complete.cases(temp_data), ]
    
    if(num=="best") temp_num<-1
    else if(num=="worst") temp_num<-nrow(temp_data2)
    else temp_num<-num
    
    temp_data2<-cbind(temp_data2[temp_num,1],temp_state)
    output_data<-rbind(output_data,temp_data2)
    #output_data<-rbind(output_data,temp_data[num,c(1,2)])
 }   
  
#      temp_state<-'WY'
#      temp_data<-data3sort[data3sort[,2]==temp_state, ]
#      temp_data2<-temp_data[complete.cases(temp_data), ]
#      #print(temp_data2)
#      if(num=="best") num<-1
#      else if(num=="worst") num<-nrow(temp_data2)
#      
#      
#      temp_data2<-cbind(temp_data2[num,1],temp_state)
#      output_data<-rbind(output_data,temp_data2)
#      #output_data<-rbind(output_data,temp_data[num,c(1,2)])
  
  names(output_data)[1]<-"hospital"
  names(output_data)[2]<-"state"
  
  output_data
#  print(num)
  #print(head(output_data))
  ## rate
}

#Here is some sample output from the function.
#> source("rankall.R")
#> head(rankall("heart attack", 20), 10)
#hospital state
#AK <NA> AK
#AL D W MCMILLAN MEMORIAL HOSPITAL AL
#AR ARKANSAS METHODIST MEDICAL CENTER AR
#AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
#CA SHERMAN OAKS HOSPITAL CA
#CO SKY RIDGE MEDICAL CENTER CO
#CT MIDSTATE MEDICAL CENTER CT
#DC <NA> DC
#DE <NA> DE
#FL SOUTH FLORIDA BAPTIST HOSPITAL FL
#
#> tail(rankall("pneumonia", "worst"), 3)
#hospital state
#WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
#WV PLATEAU MEDICAL CENTER WV
#WY NORTH BIG HORN HOSPITAL DISTRICT WY
#
#> tail(rankall("heart failure"), 10)
#hospital state
#TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
#TX FORT DUNCAN MEDICAL CENTER TX
#UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
#VA SENTARA POTOMAC HOSPITAL VA
#VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
#VT SPRINGFIELD HOSPITAL VT
#WA HARBORVIEW MEDICAL CENTER WA
#WI AURORA ST LUKES MEDICAL CENTER WI
#WV FAIRMONT GENERAL HOSPITAL WV
#WY CHEYENNE VA MEDICAL CENTER WY