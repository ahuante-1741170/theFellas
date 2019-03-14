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
library(shinythemes)

shinyUI(
  fluidPage(theme = shinytheme("sandstone"),
    navbarPage(
      "Bike Incidents Across the US",
      tabPanel(
        "Project Overview",
        h1("An In-Depth Analysis of Bike Incidents Across the United States"),
        h3("About the Dataset"),
        p("The dataset used for the purpose of this project is the Bike Index. 
          This dataset provides comprehensive data on a variety of topics regarding bikes, 
          including biking organizations, makes, and bike theft incidences. 
          This particular dataset has a somewhat loose definition for bikes, 
          although they tend to be non-motorized and powered by physical movement. 
          This project specifically examines and answers questions about bike theft in the US.",
          style = "font-weight: 100; line-height: 2; font-size: 15px;"),
        p("There are more than 221,000 registered bikes in this dataset. 
          Evidently, the Bike Index is a product of the participation of its users 
          - it would be impossible to collect this much data without them.",
          style = "font-weight: 100; line-height: 2; font-size: 15px;"),
        h3("Target Audience"),
        p("Our target audience members consist of bike owners and enthusiasts. 
          Since bike theft is a common problem in many cities, 
          especially dense areas where biking is simply faster and more convenient compared to automobiles,
          we hope to encourage audience members to exercise the necessary precautions to avoid having their means of transportation stolen.
          Through education with this dataset,
          we hope that people gain a better understanding of the prevalence of bike theft 
          and learn how they can counteract or avoid such incidences from happening to themselves.",
          style = "font-weight: 100; line-height: 2; font-size: 15px;"),
        h3("3 Questions this project will answer"),
        p("1. How are theft locations distributed in the major US cities?",
          style = "font-weight: 100; line-height: 2; font-size: 15px;"),
        p("2. When do most of these crimes occur during the day?",
          style = "font-weight: 100; line-height: 2; font-size: 15px;"),
        p("3. Is there any correlation between the brand of a bike and theft rate?",
          style = "font-weight: 100; line-height: 2; font-size: 15px;"),
        p("Here is the link", a(href= "https://bikeindex.org/documentation/api_v3#!/bikes/GET_version_bikes_id_format_get_0", "Bike Index"),"!")
      ),
      
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
              style = "font-weight: 100; line-height: 5; font-size: 20px;"
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
              style = "font-weight: 100; line-height: 1; font-size: 20px;"
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
              style = "font-weight: 100; line-height: 1; font-size: 20px;"
            )
          )
        )
      ) # Closes tabpanel ()
    )
  )
)
