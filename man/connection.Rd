% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/connection.R
\name{connection}
\alias{connection}
\title{HERE Public Transit API: Transit Route}
\usage{
connection(
  origin,
  destination,
  datetime = Sys.time(),
  arrival = FALSE,
  results = 3,
  transfers = -1,
  summary = FALSE,
  url_only = FALSE
)
}
\arguments{
\item{origin}{\code{sf} object, the origin locations of geometry type \code{POINT}.}

\item{destination}{\code{sf} object, the destination locations of geometry type \code{POINT}.}

\item{datetime}{\code{POSIXct} object, datetime for the departure (or arrival if \code{arrival = TRUE}).}

\item{arrival}{boolean, calculate connections for arrival at the defined time (\code{default = FALSE})?}

\item{results}{numeric, maximum number of suggested public transport routes (Valid range: 1 and 6).}

\item{transfers}{numeric, maximum number of transfers allowed per route (Valid range: -1 and 6, \code{default = -1}).}

\item{summary}{boolean, return a summary of the public transport connections instead of the sections of the routes (\code{default = FALSE})?}

\item{url_only}{boolean, only return the generated URLs (\code{default = FALSE})?}
}
\value{
An \code{sf} object containing the requested routes.
}
\description{
Route public transport connections with geometries (\code{LINESTRING}) between pairs of points using the HERE 'Public Transit' API.
Two modes are provided:
\itemize{
  \item\code{summary = FALSE}: The public transport connections are returned as mulitple sections with the same vehicle and transport mode. Each section has a detailed route geometry.
  \item\code{summary = TRUE}: A summary of the connections is retrieved, where each connection is represented as one row with a unified and simplified geometry.
}
}
\note{
As it is not possible to match the "maneuvers" to the "connections-sections" in the API response using the section id (\code{sec_id}),
the returned geometries of walking sections are straight lines between the station (or origin and destination) points instead of routed lines on the pedestrian network.
The walking segments can be routed in hindsight using the \link[hereR]{route} function with mode set to \code{"pedestrian"}.
}
\examples{
# Provide an API Key for a HERE project
set_key("<YOUR API KEY>")

# Connection sections
sections <- connection(
  origin = poi[3:4, ], destination = poi[5:6, ],
  summary = FALSE, url_only = TRUE
)

# Connection summary
summary <- connection(
  origin = poi[3:4, ], destination = poi[5:6, ],
  summary = TRUE, url_only = TRUE
)
}
\references{
\href{https://developer.here.com/documentation/transit/dev_guide/topics/quick-start-routing-1.html}{HERE Public Transit API: Transit Route}
}
