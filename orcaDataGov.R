# Gather data on the conservation for Orca Whales

library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")

#query_params_plants <- list(token = redlistapi)
resource_gov <- "/QVENGdaPbd4LUkLV/arcgis/rest/services/USFWS_Critical_Habitat/FeatureServer"
base_url_gov <- "http://services.arcgis.com"
endpoint_gov <- paste0(base_url_gov, resource_gov)
response_gov <- GET(endpoint_gov)
body_gov <- content(response_gov, "text")
parsed_data_gov <- fromJSON(body_gov)

# Data frame for Orca Whale threats
data_set_gov <- as.data.frame(parsed_data_gov)