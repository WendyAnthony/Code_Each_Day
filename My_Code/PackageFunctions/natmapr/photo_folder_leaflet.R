photo_folder_leaflet <- function() {
   getwd()

   folder <- getwd()
   folder

   files <- list.files(pattern = "*.JPG")

   dat <- exifr::read_exif(files)

   dat3 <- dplyr::select(dat,
                         SourceFile, DateTimeOriginal,
                         GPSLongitude, GPSLatitude,
                         ExposureTime, FNumber, ISO, FocalLength)
   colnames(dat3)
   colnames(dat3)[3] <- "longitude"
   colnames(dat3)[4] <- "latitude"
   colnames(dat3)
   str(dat3)

   dat3 <- dat3 %>% filter(!is.na(longitude))

   write.csv(dat3, 'ExifCameradata.csv',
             row.names = FALSE)
}

# library(exifr)
# library(dplyr)
#
# # 1. Set directory to folder holding images to map: Session > Set Working Directory > Choose Directory
#       getwd()
#
#       folder <- getwd()
#       folder
#
#       files <- list.files(pattern = "*.JPG")
#
#       dat <- exifr::read_exif(files)
#
#       dat3 <- dplyr::select(dat,
#                      SourceFile, DateTimeOriginal,
#                      GPSLongitude, GPSLatitude,
#                      ExposureTime, FNumber, ISO, FocalLength)
#
#       class(dat3)
#       str(dat3)
#
# #      need to rename GPSLongitude to longitude
#  #     need to rename GPSLatitude to latitude
#       colnames(dat3)
#       colnames(dat3)[3] <- "longitude"
#       colnames(dat3)[4] <- "latitude"
#       colnames(dat3)
#       str(dat3)
#
#       dat3 <- dat3 %>% filter(!is.na(longitude))
#
#       write.csv(dat3, 'ExifCameradata.csv',
#                 row.names = FALSE)


      # dat3 <- select(dat,
      #                var3, var4,
      #                var1, var2,
      #                var7, var5, var6, var8)


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



# 1. Set directory to folder holding images to map: Session > Set Working Directory > Choose Directory
# 2. Get Working Directory: getwd()
# 3. Get folder name of working directory
# 4. List jpg file: files <- list.files(pattern = "*.JPG")
# 5. Read exif: dat <- read_exif(files)
# 6. Select columns to use
# 7. Create leaflet map
# 8. Write csv file of .jpg data
# 9. Save map as webpage.html

