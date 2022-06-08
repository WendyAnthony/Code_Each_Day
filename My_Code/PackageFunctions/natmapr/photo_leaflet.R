photo_leaflet <- function(data, var1, var2, var3, var4, var5, var6, var7, var8, folder, tiles) {

  map3 <- leaflet::leaflet(data)
  # map3 <- leaflet::addTiles(map3)
  map3 <- leaflet::addProviderTiles(map3, tiles)
  map3 <- leaflet::addMarkers(map3,
                              clusterOption = leaflet::markerClusterOptions(spiderfyOnMaxZoom = TRUE),
                              ~ var1, ~ var2,
                              popup = paste0("<b>Image Name:</b> ", var3, "<br>",
                                             "<b>Image Date:</b> ", var4, "<br><br>",
                                             "<b>FN Number:</b> ", var5, "<br>",
                                             "<b>ISO:</b> ", var6, "<br>",
                                             "<b>Exposure Time:</b> ", var7, "<br><br>",
                                             "<b>Focal Length:</b> ", var8, "<br><br>",
                                             "<b>Folder:</b> ", folder, "<br><br>",
                                             "<img src = '",
                                             var3, "' style='width:314px;height:239px;'", ">"))
  map3







#  saveWidget(map3, "photo-map3.html")


}


# map3 <- photo_folder_leaflet(dat3, dat3$longitude, dat3$latitude, dat3$SourceFile,
# dat3$DateTimeOriginal, dat3$FNumber, dat3$ISO, dat3$ExposureTime, dat3$FocalLength)

# var1  dat3$longitude
# var2  dat3$latitude
# var3  dat3$SourceFile
# var4  dat3$DateTimeOriginal
# var5  dat3$FNumber
# var6  dat3$ISO
# var7  dat3$ExposureTime
# var8  dat3$FocalLength
# tiles "Esri.WorldImagery"



# 1. Set directory to folder holding images to map: Session > Set Working Directory > Choose Directory
# 2. Get Working Directory: getwd()
# 3. Get folder name of working directory
# 4. List jpg file: files <- list.files(pattern = "*.JPG")
# 5. Read exif: dat <- read_exif(files)
# 6. Select columns to use
# 7. Create leaflet map
# 8. Write csv file of .jpg data
# 9. Save map as webpage.html

