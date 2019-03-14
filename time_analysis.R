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