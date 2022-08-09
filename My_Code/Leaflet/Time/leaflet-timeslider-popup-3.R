

# Read csv file and convert time
pacrim_photos <- read.csv("ExifCameradata-2022-07-19-to-08-01-PacRimVacay.csv")
str(pacrim_photos)
pacrim_photos$time <- lubridate::as_datetime(pacrim_photos$DateTimeOriginal, tz = "PST8PDT")
pacrim_photos$Date <- lubridate::as_date(pacrim_photos$DateTimeOriginal)

# omit na values
pacrim_photos_nona<- na.omit(pacrim_photos)


# geojsonio
pacrim_photos_geo <- geojsonio::geojson_json(pacrim_photos_nona, lat="GPSLatitude", lon="GPSLongitude")
View(pacrim_photos_geo)
# create geojson file
geojsonio::geojson_write(pacrim_photos_geo, file = "pacrim_photos_geo.geojson")

