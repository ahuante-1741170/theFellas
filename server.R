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

source("time_analysis.R")

server <- function(input, output) {
  output$incidentsmap <- renderLeaflet({
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
                   "<p> You can find an image of the incident <a href =", bikes$incidents.media.image_url, ">",
                   "here!","</a> <p>")
    
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
  
  # Generates plot for correlation between time of day and number of bikes stolen
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
  
  # Generates a plot for corelation between color of bike and how often it gets stolen
  output$incidents_color <- renderLeaflet({
    # Bike theft based on color
    
    base_url_color <- "https://bikeindex.org:443/api/v3/"
    endpoints_color <- paste0("search?page=1&per_page=100&location=IP&distance=10&stolenness=stolen")
    bike_api_url_color <- paste0(base_url_color, endpoints_color)
    response_color <- GET(bike_api_url_color)
    body_color <- content(response_color, "text")
    parsed_data_color <- fromJSON(body_color)
    bikes_df_color <- as.data.frame(parsed_data_color)
    
    # Wrangles data of bikes stolen by manufacture
    manufacture_raw <- bikes_df_color %>% select(bikes.manufacturer_name)
    manufacture_filter <- manufacture_raw %>% distinct(bikes.manufacturer_name) %>% 
      mutate(str_count(bikes.manufacturer_name))
    manufacture_final <- manufacture_filter %>% rename(
      Manufactures = bikes.manufacturer_name,
      Stolen = `str_count(bikes.manufacturer_name)`
    )
    
    # Creates bar chart
    stolen_map <- ggplot(data = manufacture_final) +
      geom_col(mapping = aes(x = Manufactures, y = Stolen)
      )
    
  })
}