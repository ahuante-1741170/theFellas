library(tidyr)
library(dplyr)
library(httr)
library(jsonlite)
library(ggplot2)
library(anytime)

# Bike incidents 

get_city_data <- function(request) {
  response <- GET(request)
  body <- content(response, "text")
  parsed_data <- fromJSON(body)
  as.data.frame(parsed_data)
}

make_dates <- function(df, timezone) {
  to_return <- df %>% mutate(time = anytime(bikes.date_stolen))
  to_return$time <- format(to_return$time, tz = paste0("America/", timezone))
  to_return$time <- strptime(to_return$time, format = "%Y-%m-%d %H:%M")
  to_return$time <- format(round(to_return$time, units = "hours"),
                           format = "%H:%M")
  to_return <- to_return %>%
    group_by(time) %>%
    summarize(count = n())
  to_return
}

# seattle <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=Seattle&stolenness=proximity"),
#                       "Los_Angeles")
# losangeles <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=Los%20Angeles&distance=12&stolenness=proximity"),
#                       "Los_Angeles")
# newyork <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=New%20York&distance=10&stolenness=proximity"),
#                       "New_York")
# chicago <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=Chicago&distance=9&stolenness=proximity"),
#                       "Chicago")
# houston <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=Houston&distance=14&stolenness=proximity"),
#                       "Chicago")
# boston <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=Boston&distance=6&stolenness=proximity"),
#                       "New_York")
# sanfrancisco <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=San%20Francisco&distance=4&stolenness=proximity"),
#                       "Los_Angeles")
# phoenix <- make_dates(get_city_data("https://bikeindex.org:443/api/v3/search?page=1&per_page=100&location=Phoenix&distance=12&stolenness=proximity"),
#                       "Phoenix")

build_plot <- function(df) {
  plot <- ggplot(df) +
    geom_col(aes(x = time, y = count), fill = "#ffb638") +
    scale_x_discrete(name = "Time of Day",
      limits = c(paste0("0", as.character(0:9), ":00"),
                 paste0(as.character(10:23), ":00")),
      labels = c(paste0("0", as.character(0:9), ":00"),
                 paste0(as.character(10:23), ":00"))) +
    labs(
      title = "Number of Bikes Stolen vs. Time of Day",
      y = "Number of Bikes Stolen"
    )
}