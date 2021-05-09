################################################################################
########  ## this is the file that works!!!!!
################################################################################
# https://www.r-bloggers.com/2016/11/extracting-exif-data-from-photos-using-r/

library(exifr)
library(dplyr)
library(leaflet)

################################################################################
######## Part 1 - extract exif
################################################################################

# set working directory to photo directory
setwd("/Volumes/My Passport for Mac/Pictures/!!Nikon-Camera/Nikon-Coolpix-GPS/2019-08-12-StrathconaPark-ButtleLake")
getwd()

# list files in directory & read exif data
files <- list.files(pattern = "*.JPG")
dat <- read_exif(files)

################################################
################################################

View(dat)
head(dat)
str(dat)
dat$GPSLongitude
dat$GPSLatitude
head(dat)

################################################
# choose columns
# dplyr::select
dat2 <- select(dat,
               SourceFile, DateTimeOriginal,
               GPSLongitude, GPSLatitude,
               GPSTimeStamp)

################################################
# create csv file >>> saves in working directory
write.csv(dat2, 'Exifdata.csv',
          row.names = F)

################################################
# plot map in x,y axis plot
# plot(dat$GPSLongitude, dat$GPSLatitude)

################################################
# interactive map with markers only
leaflet(dat2) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addMarkers(~ GPSLongitude, ~ GPSLatitude)

################################################
### WORKS
# interactive map with markers and popup with images
m <- leaflet(dat2) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addMarkers(~ GPSLongitude, ~ GPSLatitude,
             popup = paste0("<img src = '/Volumes/My Passport for Mac/Pictures/!!Nikon-Camera/Nikon-Coolpix-GPS/2019-08-12-StrathconaPark-ButtleLake/", dat2$SourceFile, "' style='width:314px;height:239px;'", ">"))

saveas(m, "photo-map-pop-1.html")
################################################
# to make map larger
m2 <- dat2 %>%
  leaflet(height=2000, width=2000) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addMarkers(~ GPSLongitude, ~ GPSLatitude,
             popup = paste0("<img src = '/Volumes/My Passport for Mac/Pictures/!!Nikon-Camera/Nikon-Coolpix-GPS/2019-08-12-StrathconaPark-ButtleLake/", dat2$SourceFile, "' style='width:314px;height:239px;'", ">"))

saveas(m2, "photo-map-pop-2.html")
################################################
m3 <- leaflet(dat2) %>%
  # addProviderTiles("Esri.WorldImagery", options = providerTileOptions(minzoom = 1, maxzoom = 10)) %>%
  addProviderTiles("Stamen.TonerLite", group = "Toner", options = providerTileOptions(minzoom = 1, maxzoom = 10)) %>%
  addMarkers(clusterOption = markerClusterOptions(spiderfyOnMaxZoom = TRUE),
             ~ GPSLongitude, ~ GPSLatitude,
             popup = paste0("<b>ImageName:</b> ", dat2$SourceFile, "<br>", "<b>Image Date:</b> ", dat2$DateTimeOriginal, "<br><br>",
               "<img src = '/Volumes/My Passport for Mac/Pictures/!!Nikon-Camera/Nikon-Coolpix-GPS/2019-08-12-StrathconaPark-ButtleLake/",
                            dat2$SourceFile, "' style='width:314px;height:239px;'", ">"))
m3$width <- 1000
m3$height <- 1000

saveas(m3, "photo-map-pop-3.html")
############################
### DIDN'T GET THIS TO WORK
############################
# https://stackoverflow.com/questions/46453598/is-there-a-way-to-make-leaflet-map-popup-responsive-on-r
# Responsive

# load leaflet library
library(leaflet)
library(htmlwidgets)

# create the string for responsiveness that will be injected in the <head> section of the leaflet output html file. Note that the quotes were escaped using the backslash character : `\`.
responsiveness = "\'<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\'"

# build a leaflet map with a stamen background
example.map <- leaflet(dat2) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  setView(-123,48,6) %>%
  # add the javascript for responsivness
  htmlwidgets::onRender(paste0("
    function(el, x) {
      $('head').append(",responsiveness,");
    }"))

# show the map
example.map

# output an save the html file of the leaflet map in the root of your working directory
htmlwidgets::saveWidget(widget=example.map,
           file= "example.html",
           selfcontained = TRUE
)

saveas(example.map, "photo-map-pop-3-ex.html")
