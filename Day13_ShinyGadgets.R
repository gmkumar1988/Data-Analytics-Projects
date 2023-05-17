# install.packages("shiny")
# install.packages("miniUI")

library(shiny)
library(miniUI)

myfirstGadget <- function(){
  ui <- miniPage(
    gadgetTitleBar("My First Gadget")
  )
  server <- function(input, output, session) {
    observeEvent(input$done,{
      stopApp()
    })
  }
  runGadget(ui,server)
}