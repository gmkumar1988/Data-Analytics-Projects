install.packages("shiny")
install.packages("tidyverse")
install.packages("shinydashboard")
install.packages("MASS")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("shinythemes")

library(shiny)
library(tidyverse)
library(shinydashboard)
library(MASS)
library(ggplot2)
library(dplyr)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("lumen"),
  titlePanel("Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload CSV file", multiple = FALSE, accept = ".csv"),
      br(),
      actionButton("analyzeBtn", "Statistical Analysis Results"),
      tabsetPanel(
        tabPanel("Data", DT::dataTableOutput('tbl')), # Data dalam tabel
        tabPanel("Summary Data", verbatimTextOutput("summaryText")),
        tabPanel("Box Plot",
                 fluidRow(
                   column(width = 4,
                          h5("Select variables for the boxplot:"),
                          selectInput("var_box", "Variabel:", "")
                   ),
                   column(width = 8,
                          plotOutput("boxPlot")
                   )
                 )
        ),
        tabPanel("Bar Plot",
                 fluidRow(
                   column(width = 4,
                          h5("Select variables for the barplot:"),
                          selectInput("var_bar", "Variabel:", "")
                   ),
                   column(width = 8,
                          plotOutput("barPlot")
                   )
                 )
        ),
        tabPanel("Data and ANOVA Test Results",
                 fluidPage(
                   titlePanel("Analysis of Variance"),
                   sidebarPanel(
                     selectInput("vardipen", label = h3("Dependen"),
                                 list("y" = "y"), selected = 1),
                     selectInput("varindepen", label = h3("Independen"),
                                 list("group" = "group"), selected = 1)
                   ),
                   mainPanel(
                     titlePanel("Data"),
                     DT::dataTableOutput('tbl1'),
                     titlePanel("Result"),
                     verbatimTextOutput("anovaText")
                   )
                 )
        )
      )
    ),
    mainPanel()
  )
)
