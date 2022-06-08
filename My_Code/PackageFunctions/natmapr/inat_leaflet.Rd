\name{inat_leaflet}
\alias{inat_leaflet}
\title{
Make a leaflet map using iNaturalist observations
}
\description{
Make a leaflet map, with interactive marker popups
    using a dataframe of iNaturalist observations.
}
\usage{
inat_leaflet(data, long, lat, var1, var2, var3, var4, var5, var6)
}
\arguments{
  \item{data}{
iNaturalist data in dataframe format
}
  \item{long}{
Column containing longitude of observation.
}
  \item{lat}{
Column containing latitude of observation.
}
  \item{var1}{
Column containing Common name of species.
}
  \item{var2}{
Column containing Scientific name of species.
}
  \item{var3}{
Column containing Date of observation.
}
  \item{var4}{
Column containing Place of observation.
}
  \item{var5}{
Column containing URL of original observation.
}
  \item{var6}{
Column containing Image URL of observation.
}
}
\author{
Wendy Anthony <o2b.pickin@gmail.com>
}
\examples{

### Useage
# In order to use inat_leaflet_save, run this function creating object m <-
# m <- inat_leaflet(data, long, lat, var1, var2, var3, var4, var5, var6)
# m
## Read Data
# inat_esqlag <- readRDS("./inst/extdata/esquimalt_lagoon_sub.RDS")
## function
# inat_leaflet(data, long, lat, var1, var2, var3, var4, var5, var6)
# m <- inat_leaflet(
#   inat_esqlag,
#   inat_esqlag$longitude,
#   inat_esqlag$latitude,
#   inat_esqlag$common_name,
#   inat_esqlag$scientific_name,
#   inat_esqlag$observed_on_string,
#   inat_esqlag$place_guess,
#   inat_esqlag$url,
#   inat_esqlag$image_url)
# m

## The function is currently defined as
function (data, long, lat, var1, var2, var3, var4, var5, var6)
{
inat_leaflet <- function(data, long, lat, var1, var2, var3, var4, var5, var6) {

  m <- leaflet::leaflet(data)
  m <- leaflet::addTiles(m)
  m <- leaflet::addCircleMarkers(m,
    fillOpacity = 0.5, radius = 0.8, color = "red",
    ~long,
    ~lat,
    popup = paste0(
      "<strong>Common Name: </strong> ", "<strong>", var1, "</strong>",
      "<br />", "<strong>Scientific Name: </strong>", "<i>", var2, "</i>",
      "<br />", "<strong>Date/Time: </strong>", var3,
      "<br />", "<strong>Place: </strong>", var4,
      "<br />", "<a href='", var5, "'>Observation on iNat</a>",
      "<br /><br />", "<img src='", var6, "' height='150'>"
    ),
    group = "myMarkers")
  m
}
  }
}
