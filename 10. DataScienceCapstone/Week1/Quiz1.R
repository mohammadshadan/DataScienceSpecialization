getwd()
dir.create("~/R/DSC")
setwd("~/R/DSC")
getwd()

install.packages("tm")
library(tm)
library(data.table)

#blogs   <- readLines("en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE)
data_blogs   <- readLines("en_US.blogs.txt")
data_news    <- readLines("en_US.news.txt")
data_twitter <- readLines("en_US.twitter.txt")

head(data_blogs)
head(data_twitter)
data_twitter[2]
max(nchar(data_blogs))
max(nchar(data_news))
max(nchar(data_twitter))



file.size("en_US.blogs.txt")
file.size("en_US.news.txt")
file.size("en_US.twitter.txt")

summary(blogs)
summary(news)
summary(twitter)
dim(news)
blogs <- as.data.frame(blogs)
news <- as.data.frame(news)
twitter <- as.data.frame(twitter)

head(blogs)
head(news)
head(twitter)

dim(blogs)
dim(news)
dim(twitter)


lblogs <- apply(blogs, 1, nchar)
lnews <- apply(news, 1, nchar)
ltwitter <- apply(twitter, 1, nchar)


#1. The en_US.blogs.txt  file is how many megabytes?
file.size("en_US.blogs.txt")
#[1] 210160014

#2. The en_US.twitter.txt has how many lines of text?
summary(twitter)
nrow(twitter)
dim(twitter)

length(data_twitter)

#Answer : [1] 2360148

#3. What is the length of the longest line seen in any of the three en_US data sets?
max(nchar(data_blogs))
max(nchar(data_news))
max(nchar(data_twitter))

max(lblogs)
max(lnews)
max(ltwitter)

max(max(lblogs), max(lnews), max(ltwitter))

#Answer : [1] 40835

# 4. In the en_US twitter data set, if you divide the number of lines where the word "love" 
# (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, 
# about what do you get?


ntwitter <- t100[grep('love',t100, fixed = TRUE)]
love <- data_twitter[grep('love',data_twitter, fixed = TRUE)]
nlove <- length(love)

hate <- data_twitter[grep('hate',data_twitter, fixed = TRUE)]
nhate <- length(hate)

loveorhate <- nlove/nhate
loveorhate

#Answer : [1] 4.108592

#5.  The one tweet in the en_US twitter data set that matches the word "biostats" says what?

biostats <- data_twitter[grep('biostats',data_twitter, fixed = TRUE)]
biostats

#Answer : [1] "i know how you feel.. i have biostats on tuesday and i have yet to study =/"

#6. How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)

longtext <- data_twitter[grep('A computer once beat me at chess, but it was no match for me at kickboxing',data_twitter, fixed = TRUE)]

length(longtext)

#Answer : [1] 3

# In the en_US twitter data set, if you divide the number of lines where the word "love" 
# (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, 
# about what do you get?

ntwitter <- twitter[grep("love",twitter, fixed = TRUE)]
head(ntwitter)

blogs
head(news)
length(news)
summary(news)
list.files()
