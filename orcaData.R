# Gather any data that has relating effets on orca whales

library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")

# Summary of Orca Whales and history
query_params <- list(token = redlistapi)
resource <- "/api/v3/species/narrative/orcinus orca"
base_url <- "http://apiv3.iucnredlist.org"
endpoint <- paste0(base_url, resource)
response <- GET(endpoint, query = query_params)
body <- content(response, "text")
parsed_data <- fromJSON(body)

# Bulleted list of Orca Whale details
query_params_info <- list(token = redlistapi)
resource_info <- "/api/v3/species/orcinus orca"
base_url_info <- "http://apiv3.iucnredlist.org"
endpoint_info <- paste0(base_url_info, resource_info)
response_info <- GET(endpoint_info, query = query_params_info)
body_info <- content(response, "text")
parsed_data_info <- fromJSON(body_info)

# Data frame for Orca Whale details
data_set_info <- as.data.frame(parsed_data_info)





