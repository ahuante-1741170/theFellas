library(tidyr)
library(dplyr)
library(httr)
library(jsonlite)
library(ggplot2)
library(anytime)

source("time_analysis.R")

ui <- fluidPage(
  titlePanel("At What Time Are Most Bikes Stolen?"),
  radioButtons(
    "city_choice",
    label = "Choose a city to plot:",
    choices = list(
      "Seattle" = "Seattle Los_Angeles",
      "Los Angeles" = "Los%20Angeles Los_Angeles",
      "San Francisco" = "San%20Francisco Los_Angeles",
      "Phoenix" = "Phoenix Pheoenix",
      "Houston" = "Houston Chicago",
      "Chicago" = "Chicago Chicago",
      "New York" = "New%20York New_York",
      "Boston" = "Boston New_York"
    )
  ),
  plotOutput("time_plot")
)

server <- function(input, output) {
  data <- reactive({
    split <- strsplit(input$city_choice, " ")
    request <- paste0(
      "https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=",
      split[[1]][1], "&distance=10&stolenness=proximity"
    )
    make_dates(get_city_data(request), split[[1]][2])
  })

  output$time_plot <- renderPlot({
    plot <- build_plot(data())
    plot
  })
}

shinyApp(ui, server)
