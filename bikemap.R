

library(tidyr)
library(dplyr)
library(httr)
library(jsonlite)
library(ggmap)
library(ggplot2)
library(leaflet)
library(htmltools)
library(jsonlite)

# Bike incidents 

response <- GET("https://bikewise.org:443/api/v2/incidents?page=2&per_page=100&proximity=Seattle&proximity_square=100")
body <- content(response, "text")
parsed_data <- fromJSON(body)
bikes_df <- as.data.frame(parsed_data)


# Locations of bike incidents 

response_locations <- GET("https://bikewise.org:443/api/v2/locations?proximity=Seattle&proximity_square=100")
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

# Flatten the data (there are nested data frames)

bikes <- flatten(bikes)

# Leaflet plot 

# Specifying popup content 
label <- paste("<h4>", bikes$incidents.title, "</h4>",
               "<h5> You can find an image of the bike </h5>", "<a href=", bikes$incidents.media.image_url,">", "Here", "</a>"
)

# Map
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


# Shiny experimentation 

library(shiny)
library(leaflet)


ui <- fluidPage(
  leafletOutput("mymap"),
  p()
)

server <- function(input, output, session) {
  
  
  output$mymap <- renderLeaflet({
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

