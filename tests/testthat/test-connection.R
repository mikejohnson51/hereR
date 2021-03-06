test_that("connection works", {
  # Set dummy key
  set_key("dummy_api_key")

  # Load package example data
  data(poi)

  # Input checks
  expect_error(connection(origin = c(1, 2, 3), destination = poi), "'points' must be an sf object.")
  expect_error(connection(origin = c("character", NA), destination = poi), "'points' must be an sf object.")
  expect_error(connection(origin = aoi, destination = poi), "'points' must be an sf object with geometry type 'POINT'.")
  expect_error(connection(origin = poi, destination = poi, datetime = "not_POSIXct"))
  expect_error(connection(origin = poi, destination = poi, results = "not_numeric"))
  expect_error(connection(origin = poi, destination = poi, results = -1))
  expect_error(connection(origin = poi, destination = poi, changes = "not_numeric"))
  expect_error(connection(origin = poi, destination = poi, changes = -10))
  expect_error(connection(origin = poi, destination = poi, arrival = "not_a_bool"))
  expect_error(connection(origin = poi, destination = poi, summary = "not_a_bool"))
  expect_error(connection(origin = poi, destination = poi, url_only = "not_a_bool"), "'url_only' must be a 'boolean' value.")

  ## Test with API response mock
  # Route segments: "summary = FALSE"
  with_mock(
    "hereR:::.get_content" = function(url) {hereR:::mock$connection_response},
    connections <- connection(origin = poi[3:4, ], destination = poi[5:6, ], summary = FALSE),

    # Tests
    expect_equal(any(sf::st_geometry_type(connections) != "LINESTRING"), FALSE),
    expect_equal(length(unique(connections$id)), 2)
  )

  # Route summary: "summary = FALSE"
  with_mock(
    "hereR:::.get_content" = function(url) {hereR:::mock$connection_response},
    connections <- connection(origin = poi[3:4, ], destination = poi[5:6, ], summary = TRUE),

    # Tests
    expect_equal(any(sf::st_geometry_type(connections) != "LINESTRING"), FALSE),
    expect_equal(length(unique(connections$id)), 2)
  )
})
