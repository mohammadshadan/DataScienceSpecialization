# 
# ngram5 <- read.csv("ngram5.csv", stringsAsFactors=FALSE)
# ngram4 <- read.csv("ngram4.csv", stringsAsFactors=FALSE)
# ngram3 <- read.csv("ngram3.csv", stringsAsFactors=FALSE)
# ngram2 <- read.csv("ngram2.csv", stringsAsFactors=FALSE)
# ls()
# rm(list=ls())
ngram5 <- readRDS("./ngram5.rds")
ngram4 <- readRDS("./ngram4.rds")
ngram3 <- readRDS("./ngram3.rds")
ngram2 <- readRDS("./ngram2.rds")

# Function to clean the Text entered by the User
CleanText <- function(x) {
  x <- tolower(x)                      # convert to lowercase
  x <- gsub("\\S*[0-9]+\\S*", " ", x)  # remove numbers
  x <- gsub("^[(]|[)]$", " ", x)       # remove any end brackets
  x <- gsub("[(].*?[)]", " ", x)       # remove any middle brackets
  x <- gsub("[[:punct:]]", "", x)      # remove punctuations
  x <- gsub("\\s+"," ",x)              # compress and trim whitespace
  x <- gsub("^\\s+|\\s+$", "", x)
  return(x)
}

 x <- c("When you were in Holland you were like 1 inch away from me but you hadn't time to take a")
 x <- c("at the end of")
 x <- c("Good Better Best Never Be")

# Function to fetch the last n words entered by the user
GetLastWords <- function(x, n) {
  x <- CleanText(x)
  words <- unlist(strsplit(x, " "))
  len <- length(words)
  if (n < 1) {
    stop("No Text Entered")
  }
  if (n > len) {
    n <- len
  }
  if (n==1) {
    return(words[len])
  } else {
    l1 <- len-n+1
    text <- words[l1:len]
    }
    text
  }

# GetLastWords(x,3)

## Functions to check n-gram for x. Returns df with cols: [nextword] [MLE]
Check5Gram <- function(x, ngram5, getNrows) {
  words <- GetLastWords(x, 4)
  match <- subset(ngram5, w1 == words[1] & w2 == words[2]
                  & w3 == words[3] & w4 == words[4])
  match <- subset(match, select=c(w5, freq))
  match <- match[order(-match$freq), ]
  sumfreq <- sum(match$freq)
  match$freq <- round(match$freq / sumfreq * 100)
  colnames(match) <- c("nextword","ngram5.MLE")
  if (nrow(match) < getNrows) {
    getNrows <- nrow(match)
  }
  match[1:getNrows, ]
}

# Check5Gram(x, ngram5, 5)

Check4Gram <- function(x, ngram4, getNrows) {
  words <- GetLastWords(x, 3)
  match <- subset(ngram4, w1 == words[1] & w2 == words[2]
                  & w3 == words[3])
  match <- subset(match, select=c(w4, freq))
  match <- match[order(-match$freq), ]
  sumfreq <- sum(match$freq)
  match$freq <- round(match$freq / sumfreq * 100)
  colnames(match) <- c("nextword","ngram4.MLE")
  if (nrow(match) < getNrows) {
    getNrows <- nrow(match)
  }
  match[1:getNrows, ]
}

# Check4Gram(x, ngram4, 5)
# head(match)
Check3Gram <- function(x, ngram3, getNrows) {
  words <- GetLastWords(x, 2)
  paste(words)
  match <- subset(ngram3, w1 == words[1] & w2 == words[2])
  match <- subset(match, select=c(w3, freq))
  match <- match[order(-match$freq), ]
  sumfreq <- sum(match$freq)
  match$freq <- round(match$freq / sumfreq * 100)  # Calaculating Maximum Likelyhood
  colnames(match) <- c("nextword","ngram3.MLE")
  if (nrow(match) < getNrows) {
    getNrows <- nrow(match)
  }
  match[1:getNrows, ]
}

# head(ngram3)
# Check3Gram(x, ngram3, 5)

Check2Gram <- function(x, ngram2, getNrows) {  # ngram4 df should already exist
  words <- GetLastWords(x, 1)
  match <- subset(ngram2, w1 == words[1])
  match <- subset(match, select=c(w2, freq))
  match <- match[order(-match$freq), ]
  sumfreq <- sum(match$freq)
  match$freq <- round(match$freq / sumfreq * 100)
  colnames(match) <- c("nextword","ngram2.MLE")
  if (nrow(match) < getNrows) {
    getNrows <- nrow(match)
  }
  match[1:getNrows, ]
}

# Check2Gram(x, ngram2, 5)

#Understand Below

# nrows<-20
# # x
## Function that calculates the backoff score and nextword matches into one dataframe
ScoreNgrams <- function(x, nrows=20) {
  # Find the 2,3,4,5 grams for entered text
  ngram5.match <- Check5Gram(x, ngram5, nrows)
  ngram4.match <- Check4Gram(x, ngram4, nrows)
  ngram3.match <- Check3Gram(x, ngram3, nrows)
  ngram2.match <- Check2Gram(x, ngram2, nrows)
  # merge ngram data frame, by outer join 
  merge5n4 <- merge(ngram5.match, ngram4.match, by="nextword", all=TRUE)
  merge4n3 <- merge(merge5n4, ngram3.match, by="nextword", all=TRUE)
  merge3n2 <- merge(merge4n3, ngram2.match, by="nextword", all=TRUE)
  df <- subset(merge3n2, !is.na(nextword))  # rm any zero-match results
  if (nrow(df) > 0) {
    df[is.na(df)] <- 0  # replace all the NAs with 0
    df <- df[order(-df$ngram5.MLE, -df$ngram4.MLE, -df$ngram3.MLE, -df$ngram2.MLE), ]
    # add in scores
    # df$score <- mapply(SBScore, alpha=0.4, df$ngram5.MLE, df$ngram4.MLE,
    #                    df$ngram3.MLE, df$ngram2.MLE)

    #Calculating and Adding Stupid Back Off score
    alpha <- 0.4
    df$score <- round(ifelse(df$ngram5.MLE > 0, df$ngram5.MLE, 
                       ifelse(df$ngram4.MLE > 0, alpha*df$ngram4.MLE,
                              ifelse(df$ngram3.MLE > 0, alpha*alpha*df$ngram3.MLE, 
                                      ifelse(df$ngram2.MLE > 0, alpha*alpha*alpha*df$ngram2.MLE, 0)))),1)

    df <- df[order(-df$score), ]
  }
  return(df)  # dataframe
}

# ScoreNgrams(x2, nrows=20)


## Implement stupid backoff algo
StupidBackoff <- function(x, getNrows=20) {
  nextword <- ""
  if (x == "") {
    return("the")
  }
  df <- ScoreNgrams(x, getNrows)
  if (nrow(df) == 0) {
    return("and")
  }

    # check if top overall score is shared by multiple candidates
    topwords <- df[df$score == max(df$score), ]$nextword
    # if multiple candidates, randomly select one
    nextword <- sample(topwords, 1)

  return(nextword)
}

# StupidBackoff(x)
# 
# x <- c("cat in the")
# StupidBackoff(x)
# 
# x1 <- c("When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd")
# StupidBackoff(x1)
# 
# 
# x2 <- c("Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his")
# StupidBackoff(x2)
# 
# 
# x3 <- c("I'd give anything to see arctic monkeys this")
# StupidBackoff(x3)
# Check5Gram(x3, ngram5, 5)
# 
# x4 <- c("Talking to your mom has the same effect as a hug and helps reduce your")
# StupidBackoff(x4)
# Check5Gram(x4, ngram5, 5)
# 
# x5 <- c("When you were in Holland you were like 1 inch away from me but you hadn't time to take a")
# StupidBackoff(x5)
# Check5Gram(x5, ngram5, 5)
# 
# x6 <- c("I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the")
# StupidBackoff(x6)
# 
# x7 <- c("I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each")
# StupidBackoff(x7)
# 
# x8 <- c("Every inch of you is perfect from the bottom to the")
# StupidBackoff(x8)
# 
# x9 <- c("I'm thankful my childhood was filled with imagination and bruises from playing")
# StupidBackoff(x9)
# 
# x10 <- c("I like how the same people are in almost all of Adam Sandler's")
# StupidBackoff(x10)
# 
# 
# x11 <- c("united states of")
# StupidBackoff(x11)
# 
# #Quiz 2
# x1 <- c("The guy in front of me just bought a pound of bacon, a bouquet, and a case of")
# StupidBackoff(x1)
# 
# x2 <- c("You're the reason why I smile everyday. Can you follow me please? It would mean the")
# StupidBackoff(x2)
# 
# x3 <- c("Hey sunshine, can you follow me and make me the")
# StupidBackoff(x3)
# 
# x4 <- c("Very early observations on the Bills game: Offense still struggling but the")
# StupidBackoff(x4)
# 
# x5 <- c("Go on a romantic date at the")
# StupidBackoff(x5)
# 
# 
# x6 <- c("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my")
# StupidBackoff(x6)
# 
# x7 <- c("Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some")
# StupidBackoff(x7)
# 
# x8 <- c("After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little")
# StupidBackoff(x8)
# 
# x9 <- c("Be grateful for the good times and keep the faith during the")
# StupidBackoff(x9)
# 
# x10 <- c("If this isn't the cutest thing you've ever seen, then you must be")
# StupidBackoff(x10)
# 
# x11 <- c("android")
# StupidBackoff(x11)
# 
