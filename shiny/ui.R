# ui.R
#
# Copyright (C) 2015 Kyle Scully
#
# Author(s)/Maintainer(s):
# Kyle Scully
#
# This script does the following:
#
#  * builds the UI for the shiny webapp
#
library(shiny)
library(ggvis)

shinyUI(fluidPage(
  
  headerPanel("Text Prediction"),
  h4('By Kyle Scully'),
  
  sidebarPanel(
  p('Enter a phrase into the text field, hit submit, and the application will suggest the next word')
  ),
  mainPanel(
  # Copy the line below to make a text input box
  textInput("text", label = h3("Input your phrase here:")),
  #submitButton("Submit"),

  
  
  hr(),
  fluidRow(column(7, verbatimTextOutput("value")))
)
))