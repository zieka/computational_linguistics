# server.R
#
# Copyright (C) 2015 Kyle Scully
#
# Author(s)/Maintainer(s):
# Kyle Scully
#
# This script does the following:
#
#  * builds the controller for the shiny webapp

library(shiny)
source("predict_word.R")

shinyServer(function(input, output) {

  output$value <- renderPrint({
  phrase <- gsub("^[ \t]+",'',input$text)
  phrase <- gsub(" [ \t]+$",'',phrase)
  phrase <- strsplit(phrase, '[ \t]+')
  prediction = "NA"
  
  if (length(phrase[[1]]) >= 4 ){
    gram4 <- phrase[[1]][length(phrase[[1]])-3]
    gram3 <- phrase[[1]][length(phrase[[1]])-2]
    gram2 <- phrase[[1]][length(phrase[[1]])-1]
    gram1 <- phrase[[1]][length(phrase[[1]])]
    prediction <- nextword(paste(gram4, gram3, gram2, gram1),4)  	
  } 
  if (length(phrase[[1]]) >= 3 ){
  	gram3 <- phrase[[1]][length(phrase[[1]])-2]
  	gram2 <- phrase[[1]][length(phrase[[1]])-1]
  	gram1 <- phrase[[1]][length(phrase[[1]])]
    prediction <- nextword(paste(gram3, gram2, gram1),3)  	
  }
  if (length(phrase[[1]]) == 2 ){
  	gram2 <- phrase[[1]][length(phrase[[1]])-1]
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  	prediction <- nextword(paste(gram2, gram1),2) 
  }
  if (length(phrase[[1]]) == 1 ){
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  	prediction <- nextword(gram1,1) 
  }
  if (is.na(prediction)){
    prediction <- "No Prediction Available"
  } 
  if (length(phrase[[1]]) == 0 ){
    prediction <- "Please type a phrase to begin."
  }
  
    prediction
  })

})