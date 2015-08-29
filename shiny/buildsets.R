# buildsets.R
#
# Copyright (C) 2015 Kyle Scully
#
# Author(s)/Maintainer(s):
# Kyle Scully
#
# This script does the following:
#
#  * cleans raw data and saved the data

library(tm)
library(SnowballC)
library(RXKCD)
library(RWeka)
library(slam)
library(data.table)

set.seed(123)
options(mc.cores=1)

#Read data

blogs <- readLines("../final/en_US/en_US.blogs.txt")
news <- readLines("../final/en_US/en_US.news.txt")
tweets <- readLines("../final/en_US/en_US.twitter.txt")

#Sample

blogs.index <- sample(1:899288, 90000)
blogs.training <- blogs[blogs.index]; rm(blogs.index); rm(blogs)

news.index <- sample(1:1010242, 100000)
news.training <- news[news.index]; rm(news.index); rm(news)

tweets.index <- sample(1:2360148, 236000)
tweets.training <- tweets[tweets.index]; rm(tweets.index); rm(tweets)


#Combined
set <- blogs.training; rm(blogs.training)
set <- rbind(set,news.training); rm(news.training)
set <- rbind(set,tweets.training); rm(tweets.training)

txt <- VectorSource(set); rm(set)
txt.corpus <- VCorpus(txt); rm(txt)
txt.corpus <- tm_map(txt.corpus, stripWhitespace)
txt.corpus <- tm_map(txt.corpus, content_transformer(tolower))
txt.corpus <- tm_map(txt.corpus, removePunctuation)
txt.corpus <- tm_map(txt.corpus, removeNumbers)

badWords <- scan("./badwords", "")
txt.corpus <- tm_map(txt.corpus, removeWords, badWords)

#bi- with
Tokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))}
tdm <- TermDocumentMatrix(txt.corpus, control = list(tokenize = Tokenizer))

freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
word <- names(freq)
bigram.w <- data.table(word=word, freq=freq)
bigram.w <- bigram.w[bigram.w$freq > 1]

save(bigram.w, file="bigram.w.Rda")

#tri- with
Tokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
tdm <- TermDocumentMatrix(txt.corpus, control = list(tokenize = Tokenizer))

freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
word <- names(freq)
trigram.w <- data.table(word=word, freq=freq)
trigram.w <- trigram.w[trigram.w$freq > 1]

save(trigram.w,file="trigram.w.Rda")

#quad - with
Tokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 4, max = 4))}
tdm <- TermDocumentMatrix(txt.corpus, control = list(tokenize = Tokenizer))

freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
word <- names(freq)
quadgram.w <- data.table(word=word, freq=freq)
quadgram.w <- quadgram.w[quadgram.w$freq > 1]

save(quadgram.w,file="quadgram.w.Rda")

#hectagram
Tokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 5, max = 5))}
tdm <- TermDocumentMatrix(txt.corpus, control = list(tokenize = Tokenizer))

freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
word <- names(freq)
hectagram.w <- data.table(word=word, freq=freq)
hectagram.w <- hectagram.w[hectagram.w$freq > 2]

save(hectagram.w,file="hectagram.w.Rda")

#tri -without
#txt.corpus <- tm_map(txt.corpus, removeWords, stopwords(kind = "en"))
#Tokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
#tdm <- TermDocumentMatrix(txt.corpus, control = list(tokenize = Tokenizer))
#freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
#word <- names(freq)
#trigram.wo <- data.table(word=word, freq=freq)

#save(trigram.wo,file="trigram.wo.Rda")