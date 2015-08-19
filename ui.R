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

  # Copy the line below to make a text input box
  textInput("text", label = h3("Input your phrase here:"), value = "Enter text..."),

  hr(),
  fluidRow(column(7, verbatimTextOutput("value")))

))