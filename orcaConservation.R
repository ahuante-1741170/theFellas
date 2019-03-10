# Gather data on the conservation for Orca Whales

library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")

query_params_conservation <- list(token = redlistapi)
resource_conservation <- "/api/v3/measures/species/name/orcinus orca"
base_url_conservation <- "http://apiv3.iucnredlist.org"
endpoint_conservation <- paste0(base_url_conservation, resource_conservation)
response_conservation <- GET(endpoint_conservation, query = query_params_conservation)
body_conservation <- content(response_conservation, "text")
parsed_data_conservation <- fromJSON(body_conservation)

# Data frame for Orca Whale threats
data_set_conservation <- as.data.frame(parsed_data_conservation)

