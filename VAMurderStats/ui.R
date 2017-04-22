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
  titlePanel("Estimated Murder and Non Negligent Manslaughter in Virginia"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("slider1",
                   "Aggravated Assault:",
                   min = 5000,
                   max = 13000,
                   value = 5000),
       checkboxInput("ShowModel1", "Show/Hide Linear Model", value = TRUE),
       
       sliderInput("slider2",
                   "Year:",
                   min = 1960,
                   max = 2014,
                   value = 1960),
      sliderInput("slider3",
                  "Bootstrap Resample:",
                  min = 0,
                  max = 1000,
                  value = 0)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1"),
      plotOutput("plot2"),
      h3("Predicted Murder/Manslaughter Estimate from Model 1:"), 
      textOutput("pred1"),
      h3("Year:"),
      textOutput("year1"),
      h3("Sum of Estimated Murders and Non Negligent Manslaughter (from 1960 to selected year):"),
      textOutput("sumyr")
    )
  )
))
