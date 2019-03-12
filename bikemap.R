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

# Shiny 

ui <- fluidPage(
  titlePanel("Stolen Bike Locations in Major Cities"),
  sidebarLayout(
    sidebarPanel(
      
      # Input: Selector for location
      selectInput(
        inputId = "location",
        label = "Choose Location for Map to Display",
        choices = list(
          "Seattle, WA" = "Seattle",
          "Los Angeles, CA" = "LosAngeles", 
          "Houston, TX" = "Houston", 
          "Boston, MA" = "Boston"
        ),
        selected = "Seattle"
      )
    ),
    mainPanel(leafletOutput("mymap"))
  )
)

server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    # Bike incidents 
    
    base_url <- "https://bikewise.org/api/v2/"
    endpoints <- paste0("incidents?page=1&per_page=100&&proximity=",input$location, "&proximity_square=100")
    bike_api_url <- paste0(base_url, endpoints)
    response <- GET(bike_api_url)
    body <- content(response, "text")
    parsed_data <- fromJSON(body)
    bikes_df <- as.data.frame(parsed_data)
    
    # Get Locations
    base_url_locations <- "https://bikewise.org:443/api/v2/"
    endpoints_locations <- paste0("locations?proximity=", input$location, "&proximity_square=100")
    bike_api_url_locations <- paste0(base_url_locations, endpoints_locations)
    response_locations <- GET(bike_api_url_locations)
    body_locations <- content(response_locations, "text")
    parsed_data_locations <- fromJSON(body_locations)
    bikes_df_locations <- parsed_data_locations$features$geometry
    
    
    # Get seperate lat/long coordinates
    
    bikes_df_locations <- separate(bikes_df_locations, col = coordinates, 
                                   into = c("long", "lat"), sep = ",")
    bikes_df_locations$long <- gsub("c\\(", "", bikes_df_locations$long)
    bikes_df_locations$lat <- gsub("\\)", "", bikes_df_locations$lat)
    
    # Make the columns numeric 
    
    bikes_df_locations$lat <- as.numeric(bikes_df_locations$lat)
    bikes_df_locations$long <- as.numeric(bikes_df_locations$long)
    
    # Join the data frames
    
    bikes <- cbind.data.frame(bikes_df, bikes_df_locations)
    
    # Flatten the data
    bikes <- flatten(bikes)
    
    # Specifying popup content for the map
    label <- paste("<h4>", "Incident Title:",bikes$incidents.title, "</h4>",
                   "<h5>", "Incident Type:",bikes$incidents.type, "</h5>",
                   "<p> You can find an image of the bike <a href =", bikes$incidents.media.image_url, ">",
                   "here","</a> <p>")
    
    # Now the actual map 
    incidents_map <-
      leaflet(data = bikes) %>%
      addTiles() %>%
      addCircles(
        lng = ~long,
        lat = ~lat,
        popup = ~lapply(label, HTML),
        labelOptions = labelOptions(noHide = F, style = list(
          "color" = "black",
          "font-family" = "Times New Roman",
          "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
          "font-size" = "15px",
          "border-color" = "rgba(0,0,0,0.5)"
        )),
        stroke = T
      )
  })
}

shinyApp(ui, server)

