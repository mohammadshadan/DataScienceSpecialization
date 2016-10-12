---
title: "Effect of Transmission Type on Car's Mileage"
author: "MOHAMMAD SHADAN"
date: "September 17, 2016"
output: pdf_document
---
##EXECUTIVE SUMMARY  
Analyzing the data from the 1974 Motor Trend US magazine, which comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models).   

--------  -----------------------  -------- --------------------  -------- ----------------------------------------
**mpg**   Miles/(US) gallon        **cyl**  Number of cylinders   **disp** Displacement (cu.in.)   
**hp**    Gross horsepower         **drat** Rear axle ratio       **wt**   Weight (1000 lbs)     
**qsec**  1/4 mile time            **vs**   V/S                   **carb** Number of carburetors           
**am**    Transmission Type        **gear** Num of forward gears  
--------  -----------------------  -------- --------------------  -------- ----------------------------------------

Analysis will elaborate on the below two points :  
- Is an automatic (0) or manual (1) transmission better for MPG   
- Quantify the MPG difference between automatic and manual transmissions   

```{r,  echo=FALSE, results='hide',message=FALSE}
#Set the Working Directory setwd("~/R/RM"), Load Required Libraries and mtcars dataset
library(ggplot2); library(gridExtra); data(mtcars); attach(mtcars);
```
```{r, echo=FALSE, results='hide',message=FALSE}
head(mtcars)
str(mtcars)
summary(mtcars)
agg_am <- aggregate(mpg~am, mtcars, mean)
agg_am
```  
##EXPLORATORY DATA ANALYSIS
```{r, echo=FALSE, results='hide',message=FALSE}
#plot(mpg~am, data=mtcars)

#Figure 1 - Scatter Plot
g1 <- ggplot(mtcars, aes(x=factor(am), y=mpg)) + geom_point(aes(color=factor(am)), size=3)
g1 <- g1 + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red")
g1 <- g1 + theme(legend.position="none")
g1 <- g1 + labs(x = "Transmission (0 = automatic, 1 = manual)", y = "Miles per Gallon(mpg)")
g1 <- g1 + labs(title="Figure 1 - Scatter Plot")

#Figure 2 - Boxplot
g2 <- ggplot(mtcars, aes(x=am, y=mpg, group=am,fill=factor(am))) + geom_boxplot()
g2 <- g2 + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red")
g2 <- g2 + theme(legend.position="none")
g2 <- g2 + labs(x = "Transmission (0 = automatic, 1 = manual)",y = "Miles per Gallon(mpg)")
g2 <- g2 + labs(title="Figure 2 - Box Plot")   
```
Scatterplot and Boxplot for Miles Per Gallon (mpg) vs. Transmission Type (am). "+" sign represents mean   

```{r, echo=FALSE, results='hide',message=FALSE, fig.width=7, fig.height=4}
#g2
grid.arrange(g1, g2, ncol=2)
#As can be seen from the plot, Average Miles per gallon for Manual Transmission compared to Automatic Transmission 
```

- Average mpg for automatic and manual transmission are **17.14737** and **24.39231** respectively
- Considering other variables constant, Manual cars travel more on per gallon fuel compared to Automatic cars
- We need to analyize and select other varibles including Transmission Type which affect "mpg" to get optimized result

```{r, echo=FALSE, results='hide',message=FALSE}
#mpg~wt
g <- ggplot(mtcars, aes(x=factor(am), y=mpg))
g <- g + geom_point(aes(color=factor(am)), size=3)
g <- g + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red")
g <- g + geom_smooth(method="lm")

#mpg~wt
g <- ggplot(mtcars, aes(x=qsec, y=mpg))
g <- g + geom_point(aes(color=factor(am)))
g <- g + geom_smooth(method="lm")

#mpg~wt
g <- ggplot(mtcars, aes(x=wt, y=mpg))
g <- g + geom_point()
g <- g + geom_smooth(method = "lm")

fit <- lm(mpg~.-wt, data=mtcars)
summary(fit)
anova(fit)

independent <- c("disp","hp","drat","wt","qsec","vs","gear","carb")
independent[5]

for (i in 1:8){
  print(independent[i])
}

#summary(lm(mpg ~ am + cyl + disp + hp + drat + wt + qsec + vs + gear + carb, data=mtcars))
```

##SELECTING BEST FIT MODEL

I have used **Backwards Elimination (p-value) Method** to find the best fit model. Steps involved are :   
- Start with the full model  
- Drop the variable with the highest p-value and refit a smaller model   
- Repeat until all variables left in the model are significant  

Based on backwards elimination (p-value) method the best model fit is :  

**lm(mpg ~ am + wt + qsec, data=mtcars)**   

*Step by Step analysis for finalizing above model using Backwards Elimination (p-value) Method and R outputs are shown in APPENDIX*  

```{r, someVar, echo=FALSE}
pfit8 <- lm(mpg ~ am + wt + qsec, data=mtcars)
summary(pfit8)
```

##CONCLUSION

$$ mpg = 9.6178 + 2.9358 am -3.9165 wt + 1.2259 qsec $$

Is an automatic or manual transmission better for MPG   

- Manual Transmission is better than Automatic Transmission for Miles Per Gallon, but assuming all other predictors (cyl, disp, hp, drat, wt, qsec, vs, gear, carb) constant   

Quantify the MPG difference between automatic and manual transmissions  

- Considering weight (wt) and accelaration (qsec) speed also, Manual Cars run **2.9358** Miles Per Gallon more than the cars with Automatic Transmisson   

\newpage

\begin{center}
APPENDIX
\end{center}

```{r,  echo=TRUE, results='hide',message=FALSE}
#Set the Working Directory setwd("~/R/RM"), Load Required Libraries and mtcars dataset
library(ggplot2); library(gridExtra); data(mtcars); attach(mtcars);
#Figure 1 - Scatter Plot
g1 <- ggplot(mtcars, aes(x=factor(am), y=mpg)) + geom_point(aes(color=factor(am)), size=3)
g1 <- g1 + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red")
g1 <- g1 + theme(legend.position="none") + labs(title="Figure 1 - Scatter Plot")
g1 <- g1 + labs(x = "Transmission (0 = automatic, 1 = manual)", y = "Miles per Gallon(mpg)")
#Figure 2 - Boxplot
g2 <- ggplot(mtcars, aes(x=am, y=mpg, group=am,fill=factor(am))) + geom_boxplot()
g2 <- g2 + stat_summary(fun.y=mean, geom="point", shape="+", size=9, col = "red")
g2 <- g2 + theme(legend.position="none") + labs(title="Figure 2 - Box Plot")
g2 <- g2 + labs(x = "Transmission (0 = automatic, 1 = manual)",y = "Miles per Gallon(mpg)")
```

**Step by step analysis using Backwards Elimination (p-value) to find the best fit model :  **

```{r}
#Step 1 : Start with the full model
pfit1 <- lm(mpg ~ ., data=mtcars); coef(summary(pfit1))
```

```{r}
#Step 2 : cyl has the largest pvalue(0.91608738), so drop cyl and refit the model
pfit2 <- lm(mpg ~ am + disp + hp + drat + wt + qsec + vs + gear + carb, data=mtcars) 
coef(summary(pfit2))
```

```{r}
#Step 3 : vs has the largest pvalue (0.84325850), so drop vs and refit the model
pfit3 <- lm(mpg ~ am + disp + hp + drat + wt + qsec + gear + carb, data=mtcars); coef(summary(pfit3))
```

```{r}
#Step 4 : carb has the largest pvalue (0.74695821), so drop carb and refit the model
pfit4 <- lm(mpg ~ am + disp + hp + drat + wt + qsec + gear, data=mtcars); coef(summary(pfit4))
```

```{r}
#Step 5 : gear has the largest pvalue (0.619640616), so drop gear and refit the model
pfit5 <- lm(mpg ~ am + disp + hp + drat + wt + qsec, data=mtcars); coef(summary(pfit5))
```

```{r}
#Step 6 : drat has the largest pvalue (0.462401185), so drop drat and refit the model
pfit6 <- lm(mpg ~ am + disp + hp + wt + qsec, data=mtcars); coef(summary(pfit6))
```

```{r}
#Step 7 : disp  has the largest pvalue (0.298972150), so drop disp and refit the model
pfit7 <- lm(mpg ~ am + hp + wt + qsec, data=mtcars); coef(summary(pfit7))
```

```{r}
#Step 8: hp  has the largest pvalue (0.223087932), so drop hp and refit the model
pfit8 <- lm(mpg ~ am + wt + qsec, data=mtcars); coef(summary(pfit8))
```
Since all the p values are significantly low, below is our best fit model and should not remove more predictors   

**lm(mpg ~ am + wt + qsec, data=mtcars)**

###RESIDUAL PLOT   
```{r, fig.width=7, fig.height=5}
par(mfrow=c(2,2)); plot(pfit8); par(mfrow=c(1,1))
```



