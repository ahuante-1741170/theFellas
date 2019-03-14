library(tidyr)
library(dplyr)
library(httr)
library(jsonlite)
library(ggmap)
library(ggplot2)
library(leaflet)
library(htmltools)
library(jsonlite)
library(shiny)
library(stringr)
library(anytime)

shinyUI(navbarPage(
  "Bike Incidents Across the US",
  tabPanel(
    "Incident Map",
    titlePanel("Locations of Bike Incidents in Major Cities"),
    sidebarLayout(
      sidebarPanel(
        
        # Input: Selector for location
        selectInput(
          "location",
          label = "Choose Location for Map to Display",
          selected = "Seattle",
          choices = list(
            "Seattle, WA" = "Seattle",
            "Los Angeles, CA" = "LosAngeles", 
            "Houston, TX" = "Houston", 
            "Boston, MA" = "Boston"
          )
        )
      ), #Closes sidebarpanel ()
      mainPanel(
        leafletOutput("incidentsmap")
      ) # Closes mainPanel ()
    ) # Closes sidebarlayout() function 
  ),
  
  tabPanel(
    "Time of Day Plot",
    titlePanel("At What Time Are Most Bikes Stolen?"),
    sidebarLayout(
      sidebarPanel(
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
        )
      ),
      mainPanel(
        plotOutput("time_plot")
      )
    )
  ),
  
  tabPanel(
    "Incident Plot",
    titlePanel("Incident Color Plot"),
    mainPanel(plotOutput("incidents_color"))
  ) # Closes tabpanel ()
))