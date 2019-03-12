# Gather data on threats about Orca Whales

library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")

query_params_threats <- list(token = redlistapi)
resource_threats <- "/api/v3/threats/species/name/orcinus orca"
base_url_threats <- "http://apiv3.iucnredlist.org"
endpoint_threats <- paste0(base_url_threats, resource_threats)
response_threats <- GET(endpoint_threats, query = query_params_threats)
body_threats <- content(response_threats, "text")
parsed_data_threats <- fromJSON(body_threats)

# Data frame for Orca Whale threats
data_set_threats <- as.data.frame(parsed_data_threats)