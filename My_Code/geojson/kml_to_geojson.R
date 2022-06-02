
# https://www.r-bloggers.com/2013/06/r-to-geojson/
# http://ogre.adc4gis.com/

getwd()

library(httr)

togeojson <- function(file, writepath = "~") {
  url <- "http://ogre.adc4gis.com/convert"
  tt <- POST(url, body = list(upload = upload_file(file)))
  out <- content(tt, as = "text")
  fileConn <- file(writepath)
  writeLines(out, fileConn)
  close(fileConn)
}


file <-"!My-Home-Places copy.kml"

togeojson(file, "!My-Home-Places copy.kml.geojson")
