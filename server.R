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

shinyServer(function(input, output) {

  output$value <- renderPrint({

	phrase <- input$text
  phrase <- strsplit(input$text, ' ')

  if (length(phrase[[1]]) >= 3 ){
  	gram3 <- phrase[[1]][length(phrase[[1]])-2]
  	gram2 <- phrase[[1]][length(phrase[[1]])-1]
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  }
  if (length(phrase[[1]]) == 2 ){
  	gram3 <- ""
  	gram2 <- phrase[[1]][length(phrase[[1]])-1]
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  }
  if (length(phrase[[1]]) == 1 ){
  	gram3 <- ""
  	gram2 <- ""
  	gram1 <- phrase[[1]][length(phrase[[1]])]
  }
    if (length(phrase[[1]]) == 0 ){
  	gram3 <- ""
  	gram2 <- ""
  	gram1 <- ""
  }

  prediction = "prediction"

    paste(gram3, gram2, gram1, prediction)
  })

})