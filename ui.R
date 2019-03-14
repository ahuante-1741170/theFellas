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

shinyUI(
  navbarPage(
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
        ), # Closes sidebarpanel ()
        mainPanel(
          leafletOutput("incidentsmap"),
          p("Try clicking on the points for a description of each incident!",
            style = "font-weight: 500; line-height: 5; font-size: 20px;"
          )
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
          plotOutput("time_plot"),
          p("This plot shows the percentage of bikes stolen at each hour of the
            day. It gives the user an idea of what time of day to be most
            cautious during when leaving their bike unattended. Please not that
            the times are in military time.",
            style = "font-weight: 500; line-height: 1; font-size: 20px;"
          )
        )
      )
    ),

    tabPanel(
      "Manufacturer Plot",
      titlePanel("Incident Manufacturer Plot"),
      sidebarLayout(
        sidebarPanel(
          radioButtons(
            "city",
            label = "Choose a city to plot:",
            choices = list(
              "Seattle" = "Seattle",
              "Los Angeles" = "Los%20Angeles",
              "San Francisco" = "San%20Francisco",
              "Phoenix" = "Phoenix",
              "Houston" = "Houston",
              "Chicago" = "Chicago",
              "New York" = "New%20York",
              "Boston" = "Boston"
            )
          )
        ),
        mainPanel(
          plotOutput("incidents_manufacturer"),
          p("This plot shows the top brand(s) of bikes that are stolen.
            Interestingly, in different locations, brand of bike stolen varies
            widely.",
            style = "font-weight: 500; line-height: 1; font-size: 20px;"
          )
        )
      )
    ) # Closes tabpanel ()
  )
)
