#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Virginia Murder and Non Negligent Manslaughter"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("slider1",
                   "Year:",
                   min = 1960,
                   max = 2014,
                   value = 1960)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Year:"),
       textOutput("text1")
    )
  )
))
