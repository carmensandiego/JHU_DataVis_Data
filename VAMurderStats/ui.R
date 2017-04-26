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
  titlePanel("Estimated Robberies in Virginia"),
  
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
                  value = 0),
      actionButton("show", "Help")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Robbery Estimate from Model:"), 
      textOutput("pred1"),
      h3("Year:"),
      textOutput("year1"),
      h3("Total Estimated Robbery (from 1960 to selected year):"),
      textOutput("sumyr"),
      plotOutput("plot2")
      # tabsetPanel(
      #   # using iframe along with tags() within tab to display pdf with scroll, height and width could be adjusted
      #   tabPanel("Reference", 
      #            tags$iframe(style="height:400px; width:100%; scrolling=yes", 
      #                        src="https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf")
      # ))
    )
  )
))
