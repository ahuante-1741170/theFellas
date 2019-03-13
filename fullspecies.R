library(ggplot2)
library(dplyr)
library(httr)
library(jsonlite)
source("api-keys.R")


# GET REQUEST 
query_params_all <- list(token = redlistapi)
resource_all <- "/api/v3/country/getspecies/US"
base_url_all <- "http://apiv3.iucnredlist.org"
endpoint_all <- paste0(base_url_all, resource_all)
response_all <- GET(endpoint_all, query = query_params_all)
body_all <- content(response_all, "text")
parsed_data_all <- fromJSON(body_all)

# Data frame 
all_species <- as.data.frame(parsed_data_all)

# Data Wrangling



