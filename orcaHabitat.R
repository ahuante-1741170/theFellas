# Gather data on the habitat for Orca Whales

library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")

query_params_habitat <- list(token = redlistapi)
resource_habitat <- "/api/v3/habitats/species/name/orcinus orca"
base_url_habitat <- "http://apiv3.iucnredlist.org"
endpoint_habitat <- paste0(base_url_habitat, resource_habitat)
response_habitat <- GET(endpoint_habitat, query = query_params_habitat)
body_habitat <- content(response_habitat, "text")
parsed_data_habitat <- fromJSON(body_habitat)

# Data frame for Orca Whale threats
data_set_habitat <- as.data.frame(parsed_data_habitat)