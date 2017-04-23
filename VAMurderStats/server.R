#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(boot)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  VA_Murder <- read.csv(url("https://raw.githubusercontent.com/carmensandiego/JHU_DataVis_Data/master/CrimeStatebyState.csv"), skip=8, header=TRUE, nrows=55)   
  model1 <- lm(Murder.and.nonnegligent.Manslaughter~Aggravated.assault, data=VA_Murder)
  model2 <- lm(Murder.and.nonnegligent.Manslaughter~Aggravated.assault + Robbery, data=VA_Murder)
  
  model1pred <- reactive({
    aaInput <- input$slider1
    predict(model1, newdata = data.frame(Aggravated.assault = aaInput))
  })
  yearselect <- reactive({
    yrInput <- input$slider2
    sum(VA_Murder$Murder.and.nonnegligent.Manslaughter[VA_Murder$Year <= yrInput])
  })
  bootstrap_it <- reactive({
    sample_num <- input$slider3
    rsq <- function(formula, data, indices) {
      d <- data[indices,] # allows boot to select sample 
      fit <- lm(formula, data=d)
      return(summary(fit)$r.square)
    } 
    boot(data=VA_Murder, statistic=rsq, 
                    R=sample_num, formula=Murder.and.nonnegligent.Manslaughter~Aggravated.assault)

    })

  
  output$plot1 <- renderPlot({
    aaInput <- input$slider1
  
  plot(VA_Murder$Aggravated.assault, VA_Murder$Murder.and.nonnegligent.Manslaughter,
        xlab = "Aggravated Assault", ylab = "Murder and Nonnegligent Manslaughter", 
        bty = "n", pch = 16)
  if(input$ShowModel1){
    abline(model1, col = "red", lwd  = 2)
  }
  points(aaInput, model1pred(), col="red", pch=16, cex=2)
  points(input$slider2, yearselect(), col="blue", pch=16, cex=2)
  
  })
  output$pred1 = renderText(model1pred())
  output$year1 = renderText(input$slider2)
  output$sumyr = renderText(yearselect())
  
  output$plot2 <- renderPlot({
    plot(bootstrap_it())
  })

  observeEvent(input$show, {
    showModal(modalDialog(
      title = "About Murder/Manslaughter Application",
      tabPanel("Reference", 
               tags$iframe(style="height:400px; width:100%; scrolling=yes", 
                           src="https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf")
      ),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
})
