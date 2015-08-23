# Computational Linguistics

## Summary
This is a shiny application that uses an n-gram algorithm to predict then next word of a give string.

For more information: 
http://rpubs.com/zieka/text_prediction
http://rpubs.com/zieka/milestone_report

### How to use:
Do one of the following:

* Visit https://zieka.shinyapps.io/computational_linguistics
* Clone and run via R (skip the package installs if you already have them)
    - `git clone https://github.com/zieka/etsy_data`
    - `cd etsy_data` navigate to the directory
    - `R` open an R console
    - `install.packages(c('devtools','data.table'))` 
    - `devtools::install_github(c('rstudio/ggvis', 'rstudio/shiny', 'hadley/dplyr'))`
    - `shiny::runApp()`