library(tidyr)
library(dplyr)
library(httr)
library(jsonlite)
library(ggmap)
library(ggplot2)

# Bike incidents 

response <- GET("https://bikewise.org:443/api/v2/incidents?page=2&per_page=100&proximity=Seattle&proximity_square=100")
body <- content(response, "text")
parsed_data <- fromJSON(body)
bikes_df <- as.data.frame(parsed_data)


# Locations of bike incidents 

response_locations <- GET("https://bikewise.org:443/api/v2/locations?proximity=Seattle&proximity_square=100")
body_locations <- content(response_locations, "text")
parsed_data_locations <- fromJSON(body_locations)
bikes_df_locations <- as.data.frame(parsed_data_locations)