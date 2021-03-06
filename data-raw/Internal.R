## Create internal `mock` and `example` dataset
library(sf)

## URLs
url_geocode <-
  geocode(addresses = poi$city, url_only = TRUE)
url_autocomplete <-
  autocomplete(addresses = poi$city, results = 3, url_only = TRUE)
url_reverse_geocode_addresses <-
  reverse_geocode(poi = poi, landmarks = FALSE, results = 3, url_only = TRUE)
url_reverse_geocode_landmarks <-
  reverse_geocode(poi = poi, landmarks = TRUE, results = 3, url_only = TRUE)
url_route <-
  route(origin = poi[1:2, ], destination = poi[3:4, ], url_only = TRUE)
url_route_matrix <-
  route_matrix(origin = poi, url_only = TRUE)
url_isoline <-
  isoline(poi = poi, url_only = TRUE)
url_weather_observation <-
  weather(poi = poi, product = "observation", url_only = TRUE)
url_weather_forecast_hourly <-
  weather(poi = poi, product = "forecast_hourly", url_only = TRUE)
url_weather_forecast_astronomy <-
  weather(poi = poi, product = "forecast_astronomy", url_only = TRUE)
url_weather_alerts <-
  weather(poi = poi, product = "alerts", url_only = TRUE)
url_flow <-
  flow(aoi = aoi[aoi$code == "LI", ], url_only = TRUE)
url_incident <-
  incident(aoi = aoi, from = Sys.time() - 60*60*0.1, url_only = TRUE)
url_connection <-
  connection(origin = poi[3:4, ], destination = poi[5:6, ], results = 2, url_only = TRUE)
url_station <-
  station(poi = poi, url_only = TRUE)

## Get response mocks
mock <- list(
  geocode_response = hereR:::.get_content(url_geocode),
  autocomplete_response = hereR:::.get_content(url_autocomplete),
  reverse_geocode_addresses = hereR:::.get_content(url_reverse_geocode_addresses),
  reverse_geocode_landmarks = hereR:::.get_content(url_reverse_geocode_landmarks),
  route_response = hereR:::.get_content(url_route),
  route_matrix_response = hereR:::.get_content(url_route_matrix),
  isoline_response = hereR:::.get_content(url_isoline),
  weather_observation_response = hereR:::.get_content(url_weather_observation),
  weather_forecast_hourly_response = hereR:::.get_content(url_weather_forecast_hourly),
  weather_forecast_astronomy_response = hereR:::.get_content(url_weather_forecast_astronomy),
  weather_alerts_response = hereR:::.get_content(url_weather_alerts),
  flow_response = hereR:::.get_content(url_flow),
  incident_response = hereR:::.get_content(url_incident),
  connection_response = hereR:::.get_content(url_connection),
  station_response = hereR:::.get_content(url_station)
)

## Get examples
example <- list(
  geocode = geocode(addresses = poi$city),
  autocomplete = autocomplete(addresses = poi$city, results = 3),
  reverse_geocode_addresses = reverse_geocode(poi = poi, results = 3, landmarks = FALSE),
  reverse_geocode_landmarks = reverse_geocode(poi = poi, results = 3, landmarks = TRUE),
  route = route(origin = poi[1:2, ], destination = poi[3:4, ]),
  route_matrix = route_matrix(origin = poi),
  isoline = isoline(poi = poi),
  weather_observation = weather(poi = poi, product = "observation"),
  weather_forecast_hourly = weather(poi = poi, product = "forecast_hourly"),
  weather_forecast_astronomy = weather(poi = poi, product = "forecast_astronomy"),
  weather_alerts = weather(poi = poi, product = "alerts"),
  flow = flow(aoi = aoi[aoi$code == "LI", ]),
  incident = incident(aoi = aoi, from = Sys.time() - 60*60*0.1),
  connection_section = connection(origin = poi[3:4, ], destination = poi[5:6, ], results = 2, summary = FALSE),
  connection_summary = connection(origin = poi[3:4, ], destination = poi[5:6, ], results = 2, summary = TRUE),
  station = station(poi)
)

## Save as internal package data
usethis::use_data(mock, example, overwrite = TRUE, internal = TRUE)
