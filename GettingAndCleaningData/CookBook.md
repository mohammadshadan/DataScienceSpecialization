---
title: "CookBook"
author: "MOHAMMAD SHADAN"
date: "August 23, 2016"
---
### OVERVIEW

The data for the this project represent data collected from the accelerometers from the Samsung Galaxy S II smartphone.

The experiments have been carried out with a group of **30 volunteers** within an age bracket of 19-48 years

Each person performed **six activities** (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone

For each record in the dataset it is provided : 

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 

* Triaxial Angular velocity from the gyroscope. 

* A **561-feature** vector with time and frequency domain variables. 

* Its activity label. 

* An identifier of the subject who carried out the experiment.


### DATASETS
The data was downloaded from the [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

For the purposes of this project, the files in the Inertial Signals folders are not used. 

  The 8 data files that will be used to load data are listed as follows.
  
`activity_labels.txt` : IDs and Names for each of the 6 activities 

* WALKING 
* WALKING UPSTAIRS 
* WALKING DOWNSTAIRS 
* SITTING 
* STANDING 
* LAYING

`features.txt` : Names of the 561 features.

`X_train.txt`	: Measurements for 21 of the 30 volunteers, 7352 observations for 561 features.

`X_test.txt`	: Measurements for 9 of the 30 volunteers, 2947 observations for 561 features.

`y_train.txt`	: Vector of 7352 integers, containing activity ID for each observations in X_train.txt.
  			                   
`y_test.txt`	: Vector of 2947 integers, containing activity ID for each observations in X_test.txt.
			                   
`subject_train.txt`	: Vector of 7352 integers, containing subject ID of Volunteers related to each of the observations in X_train.txt.
  			                   
`subject_test.txt` : Vector of 2947 integers, containing subject ID of Volunteers related to each of the observations in X_test.txt.


### TIDY DATA SET ([tidydata.csv](https://github.com/mohammadshadan/Getting-And-Cleaning-Data/blob/master/tidydata.csv))
####The tidy data set has 81 columns (features) and 180 rows. Features are as below.

```{r}
1. subjectid
2. activity
3. TimeBodyAccMeanX
4. TimeBodyAccMeanY
5. TimeBodyAccMeanZ
6. TimeBodyAccStdDevX
7. TimeBodyAccStdDevY
8. TimeBodyAccStdDevZ
9. TimeGravityAccMeanX
10. TimeGravityAccMeanY
11. TimeGravityAccMeanZ
12. TimeGravityAccStdDevX
13. TimeGravityAccStdDevY
14. TimeGravityAccStdDevZ
15. TimeBodyAccJerkMeanX
16. TimeBodyAccJerkMeanY
17. TimeBodyAccJerkMeanZ
18. TimeBodyAccJerkStdDevX
19. TimeBodyAccJerkStdDevY
20. TimeBodyAccJerkStdDevZ
21. TimeBodyGyroMeanX
22. TimeBodyGyroMeanY
23. TimeBodyGyroMeanZ
24. TimeBodyGyroStdDevX
25. TimeBodyGyroStdDevY
26. TimeBodyGyroStdDevZ
27. TimeBodyGyroJerkMeanX
28. TimeBodyGyroJerkMeanY
29. TimeBodyGyroJerkMeanZ
30. TimeBodyGyroJerkStdDevX
31. TimeBodyGyroJerkStdDevY
32. TimeBodyGyroJerkStdDevZ
33. TimeBodyAccMagMean
34. TimeBodyAccMagStdDev
35. TimeGravityAccMagMean
36. TimeGravityAccMagStdDev
37. TimeBodyAccJerkMagMean
38. TimeBodyAccJerkMagStdDev
39. TimeBodyGyroMagMean
40. TimeBodyGyroMagStdDev
41. TimeBodyGyroJerkMagMean
42. TimeBodyGyroJerkMagStdDev
43. FrequencyBodyAccMeanX
44. FrequencyBodyAccMeanY
45. FrequencyBodyAccMeanZ
46. FrequencyBodyAccStdDevX
47. FrequencyBodyAccStdDevY
48. FrequencyBodyAccStdDevZ
49. FrequencyBodyAccMeanFreqX
50. FrequencyBodyAccMeanFreqY
51. FrequencyBodyAccMeanFreqZ
52. FrequencyBodyAccJerkMeanX
53. FrequencyBodyAccJerkMeanY
54. FrequencyBodyAccJerkMeanZ
55. FrequencyBodyAccJerkStdDevX
56. FrequencyBodyAccJerkStdDevY
57. FrequencyBodyAccJerkStdDevZ
58. FrequencyBodyAccJerkMeanFreqX
59. FrequencyBodyAccJerkMeanFreqY
60. FrequencyBodyAccJerkMeanFreqZ
61. FrequencyBodyGyroMeanX
62. FrequencyBodyGyroMeanY
63. FrequencyBodyGyroMeanZ
64. FrequencyBodyGyroStdDevX
65. FrequencyBodyGyroStdDevY
66. FrequencyBodyGyroStdDevZ
67. FrequencyBodyGyroMeanFreqX
68. FrequencyBodyGyroMeanFreqY
69. FrequencyBodyGyroMeanFreqZ
70. FrequencyBodyAccMagMean
71. FrequencyBodyAccMagStdDev
72. FrequencyBodyAccMagMeanFreq
73. FrequencyBodyAccJerkMagMean
74. FrequencyBodyAccJerkMagStdDev
75. FrequencyBodyAccJerkMagMeanFreq
76. FrequencyBodyGyroMagMean
77. FrequencyBodyGyroMagStdDev
78. FrequencyBodyGyroMagMeanFreq
79. FrequencyBodyGyroJerkMagMean
80. FrequencyBodyGyroJerkMagStdDev
81. FrequencyBodyGyroJerkMagMeanFreq
```



