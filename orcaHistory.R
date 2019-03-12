# Gather historical assessment data on Orca Whales

library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")

query_params_history <- list(token = redlistapi)
resource_history <- "/api/v3/species/history/name/orcinus orca"
base_url_history <- "http://apiv3.iucnredlist.org"
endpoint_history <- paste0(base_url_history, resource_history)
response_history <- GET(endpoint_history, query = query_params_history)
body_history <- content(response_history, "text")
parsed_data_history <- fromJSON(body_history)

# Data frame for Orca Whale threats
data_set_history <- as.data.frame(parsed_data_history)