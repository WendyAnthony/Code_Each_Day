inat_leaflet <- function(data, long, lat, var1, var2, var3, var4, var5) {

  m <- leaflet::leaflet(data)
  m <- leaflet::addTiles(m)
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
      "<br /><br />", "<img src='", var5, "' height='150'>"
    ),
    group = "myMarkers")
  m

}


### Useage
## Read Data
# inat_esqlag <- readRDS('./inst/extdata/esquimalt_lagoon_sub.RDS')
## function
# inat_leaflet(data, long, lat, var1, var2, var3, var4, var5, filename)
# inat_leaflet(
#   inat_esqlag,
# 'esq_lag.html',
#   inat_esqlag$longitude,
#   inat_esqlag$latitude,
#   inat_esqlag$common_name,
#   inat_esqlag$scientific_name,
#   inat_esqlag$observed_on_string,
#   inat_esqlag$place_guess,
#   inat_esqlag$image_url)


