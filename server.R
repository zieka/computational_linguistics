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

  phrase <- strsplit(input$text, ' ')
  prediction = NULL
  
  if (length(phrase[[1]]) >= 3 ){
  	gram3 <- phrase[[1]][length(phrase[[1]])-2]
  	gram2 <- phrase[[1]][length(phrase[[1]])-1]
  	gram1 <- phrase[[1]][length(phrase[[1]])]
    prediction = nextword(paste(gram3, gram2, gram1),3)  	
  }
  if (length(phrase[[1]]) == 2 ){
  	gram2 <- phrase[[1]][length(phrase[[1]])-1]
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  	prediction = nextword(paste(gram2, gram1),2) 
  }
  if (length(phrase[[1]]) == 1 ){
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  	prediction = nextword(gram1,1) 
  }
    if (length(phrase[[1]]) == 0 ){
      prediction = "Please type a phrase to begin."
  }
    if (is.null(prediction)){
      prediction = "No Prediction Available. Please type more."
    } 

  
    prediction
  })

})