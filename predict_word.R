#-------------------------------------------------------------------------------
# predict_word.R
#
# Copyright (C) 2015 Kyle Scully
#
# Author(s)/Maintainer(s):
# Kyle Scully
#
# Predicts next word in phrase based on n-gram
#-------------------------------------------------------------------------------
library(qdap)

nextword <- function(string, size){
  # clean
  phrase <- VectorSource(string)
  phrase <- VCorpus(phrase)
  phrase <- tm_map(phrase, stripWhitespace)
  phrase <- tm_map(phrase, content_transformer(tolower))
  phrase <- tm_map(phrase, removePunctuation)
  phrase <- tm_map(phrase, removeNumbers)
  phrase <- tm_map(phrase, removeWords, badWords)
  phrase <- inspect_text(phrase)
  phrase <- toString(phrase)
  
  regex <- paste("^",phrase,sep="")
  
  if(size == 3){
    prediction <- strsplit(quadgram.w[grep(regex,quadgram.w$word),][1]$word, " ")[[1]][4]
  }
  if(size == 2 ){
    prediction <- strsplit(trigram.w[grep(regex,trigram.w$word),][1]$word, " ")[[1]][3]
  }
  if(size == 1 ) {
    prediction <- strsplit(bigram.w[grep(regex,bigram.w$word),][1]$word, " ")[[1]][2]
  }  

  prediction
  
}