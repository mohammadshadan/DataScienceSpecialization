---
title: "Vitamin C promotes Tooth Growth in Guinea Pigs"
author: "MOHAMMAD SHADAN"
date: "September 8, 2016"
output: pdf_document
---
##SYNOPSIS
Tests were performed on 60 different guinea pigs and response in the length of odontoblasts (cells responsible for tooth growth) were observed ([URL](http://127.0.0.1:29174/library/datasets/html/ToothGrowth.html))  
- Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day)   
- By one of two delivery methods : orange juice, OJ or ascorbic acid, VC (a form of vitamin C)    

```{r, echo=FALSE}
#Set the Working Directory (e.g. setwd("~/R/SI")) and load required packages
library(ggplot2)
```
##1. Load the ToothGrowth data and perform some basic exploratory data analysis   

```{r}
data(ToothGrowth)                  #Loading dataset ToothGrowth
tg <- as.data.frame(ToothGrowth)   
tg$dose <- as.factor(tg$dose)      #Converting "dose" to factor variable
```
**Exploratory Data Analysis**  

Variation in Length of odontoblasts cells based on Dosage (mg/day) :  
- For Dosage of 0.5 and 1, Mean length is more for Orange Juice compared to Ascorbic Acid  
- For Dosage of 2.0, Mean length is almost same for Orange Juice and Ascorbic Acid

*Refer Code 1 and Figure 1 in APPENDIX for R Script and Plot on which the above observations are based*
 
Variation in Length of odontoblasts cells based on Delivery Method (OJ or VC) :  
- For Orange Juice as well as Ascorbic Acid the Mean length increases as the dosage amount is increased from 0.5 to 2 mg/day

*Refer Code 2 and Figure 2 in APPENDIX for R Script and Plot on which the above observations are based*

Please note, similar results will be reflected by Hypothesis Tests also

##2. Provide a basic summary of the data.

```{r}
summary(tg)   #Summary of ToothGrowth Dataset
str(tg)       #Dimension and Field Type Details
```
##3. Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose   
Assumptions :  
- Variances are unequal  
- Test subjects are not Paired (as tests were done on 60 different Guinea Pigs)  
- Distribution is Normal  

**Null Hpothesis**, H0       : Mean of Length are same i.e. Difference of mean is Zero and thus effects of Delivery Methods(supp) or Dosage are same   
**Alternate Hypothesis**, Ha : Mean of Length are not same i.e. Difference of mean is not Zero and thus effects of Delivery Methods(supp) or Dosage are different   

Considering 95 % Confidence Interval,   
if **pValue > 0.05** : we accept the Null Hypothesis, thus delivery methods or dosage have almost same effect on Tooth Growth  
if **pValue < 0.05** : we reject the Null Hypothesis, thus delivery methods or dosage have different effect on Tooth Growth   

**Firstly, comparing Tooth Growth by Dose (0.5, 1, 2 mg/day)   **
```{r}
#Subsetting the data based on pair of two dose each, (0.5, 1), (0.5,2), (1,2)
dose0.51 <- subset(tg, tg$dose==c(0.5,1))
dose0.52 <- subset(tg, tg$dose==c(0.5,2))
dose12   <- subset(tg, tg$dose==c(1,2))
```
**Compare effect of dose level 0.5 and 1 mg/day on Tooth Growth**  
```{r}
ttest0.51 <- t.test(dose0.51$len~dose0.51$dose, conf = 0.95, paired = FALSE, var.equal = FALSE); 
cat("p.value :", ttest0.51$p.value, " |   Conf. Interval : ", ttest0.51$conf.int)

```
Since pValue < 0.05, we reject the Null Hypothesis, thus both dose levels have different effect on Tooth Growth  

**Compare effect of dose level 0.5 and 2 mg/day on Tooth Growth**  
```{r}
ttest0.52 <- t.test(dose0.52$len~dose0.52$dose, conf = 0.95, paired = FALSE, var.equal = FALSE)
cat("p.value :", ttest0.52$p.value, " |   Conf. Interval : ", ttest0.52$conf.int)
```
Since pValue < 0.05, we reject the Null Hypothesis, thus both dose levels have different effect on Tooth Growth

**Compare effect of dose level 1 and 2 mg/day on Tooth Growth**  
```{r}
ttest12 <- t.test(dose12$len~dose12$dose, conf = 0.95, paired = FALSE, var.equal = FALSE)
cat("p.value :", ttest12$p.value, " |   Conf. Interval : ", ttest12$conf.int)
```
Since pValue < 0.05, we reject the Null Hypothesis, thus both dose levels have different effect on Tooth Growth

**Secondly, comparing Tooth Growth by Supp (Delivery Method, Orange Juice(OJ) and Ascorbic Acid (VC)) **
```{r}
#Subsetting Data based on dosage
supp0.5 <- subset(tg, tg$dose==.5); supp1   <- subset(tg, tg$dose==1); 
supp2   <- subset(tg, tg$dose==2)
```
**Comparing effect of OJ and VC on Tooth Growth at Dosage of .5 mg/day**
```{r}
ttest0.5 <- t.test(supp0.5$len~supp0.5$supp, conf = 0.95, paired = FALSE, var.equal = FALSE); 
cat("p.value :", ttest0.5$p.value, " |   Conf. Interval : ", ttest0.5$conf.int)
```
Since pValue < 0.05, we reject the Null Hypothesis, thus both delivery methods have different effect on Tooth Growth

**Comparing effect of OJ and VC on Tooth Growth at Dosage of 1 mg/day**
```{r}
ttest1 <- t.test(supp1$len~supp1$supp, conf = 0.95, paired = FALSE, var.equal = FALSE);
cat("p.value :", ttest1$p.value, " |   Conf. Interval : ", ttest1$conf.int)
```
Since pValue < 0.05, we reject the Null Hypothesis, thus both delivery methods have different effect on Tooth Growth

**Comparing effect of OJ and VC on Tooth Growth at Dosage of 2 mg/day**
```{r}
ttest2 <- t.test(supp2$len~supp2$supp, conf = 0.95, paired = FALSE, var.equal = FALSE); 
cat("p.value :", ttest2$p.value, " |   Conf. Interval : ", ttest2$conf.int)
```
Since pValue > 0.05, we accept the Null Hypothesis, thus both delivery methods almost same effect on Tooth Growth

##4. State your conclusions and the assumptions needed for your conclusions  
**Assumptions :  **  
- Since tests were done on 60 different Guinea Pigs thus they are considered independent (not Paired)  
- Variances are unequal   
- Normal Distribution is considered  

**Conlcusion based on Exploratory Analysis and Hypothesis Test :  **  
- Mean length of odontoblasts cells is more when delivery method is Orange Juice (OJ) compared to Ascorbic Acid (VC)  when Dosage of 0.5 and 1 mg/day is given   
- Mean length of odontoblasts cells is almost same for Orange Juice and Ascorbic Acid when Dosage of 2.0 mg/day is given   
- Given Orange Juice or Ascorbic Acid the Cell length increases as the dosage amount is increased from 0.5 to 2 mg/day  

\newpage

\begin{center}
APPENDIX
\end{center}


**Report Analysis was based on elaboration of the below points as advised in the assigment :  **  
* Load the ToothGrowth data and perform some basic exploratory data analyses  
* Provide a basic summary of the data  
* Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose  
* State your conclusions and the assumptions needed for your conclusions  

Below are Codes and Plots used to deduce observations for Exploratory Data Analysis on Page 1:  

**Code 1**
```{r}
p <- ggplot(tg, aes(x=supp, y=len, col=dose))
p <- p + geom_point(aes(size=1))
p <- p + facet_grid(.~dose)
p <- p + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red") 
p <- p + labs(title="Figure 1\n Tooth Growth grouped by Dosage \n(+ represents mean)")
```

**Figure 1  **

```{r, echo=FALSE, results='hide',message=FALSE}
p
```
Variation in Cell Length based on of Dosage (mg/day) :  
- For Dosage of 0.5 and 1, Mean length is more for Orange Juice (OJ) compared to Ascorbic Acid (VC) 
- For Dosage of 2.0, Mean length is almost same for Orange Juice and Ascorbic Acid

\newpage

**Code 2**  
```{r}
q <- ggplot(tg, aes(x=dose, y=len, col=supp))
q <- q + geom_point(aes(size=1))
q <- q + facet_grid(.~supp)
q <- q + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red") 
q <- q + labs(title="Figure 2\n Tooth Growth grouped by Delivery Method \n(+ represents mean)")
```
**Figure 2  **  
```{r, echo=FALSE, results='hide',message=FALSE}
q
```

Variation of Cell Length based on Delivery Method (OJ or VC) :  
- For Orange Juice as well as Ascorbic Acid the Mean length increases as the dosage amount is increased from 0.5 to 2 mg/day

