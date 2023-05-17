library(shiny)
library(miniUI)

multiplynumbers = function(number1, number2) {
  ui <- miniPage(
    gadgetTitleBar("Multiply Two numbers"),
    miniContentPanel(
      selectInput("num1","First Number",choices = number1),
      selectInput("num2","Second Number",choices = number2)
    )
    
  )
  server <- function(input,output, session) {
    observeEvent(input$done,{
      num1 <- as.numeric(input$num1)
      num2 <- as.numeric(input$num2)
      stopApp(num1 * num2)
    })
  }
  runGadget(ui,server)
}