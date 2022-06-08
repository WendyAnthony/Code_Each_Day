inat_leaflet_save <- function(m, filename) {
  htmlwidgets::saveWidget(m, file = filename)
}


# save in specific folder
# inat_leaflet_save(m "./inst/extdata/filename.html")

# save in working directory folder
# inat_leaflet_save(m "filename.html")
