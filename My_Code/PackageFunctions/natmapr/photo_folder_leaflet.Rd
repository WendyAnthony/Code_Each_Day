\name{photo_folder_leaflet}
\alias{photo_folder_leaflet}
\title{
1. Data prep and cleaning for photo_leaflet(). Copy the code from example section and run in console
}
\description{
Function for data prep and cleaning for photo_leaflet(). FIRST, copy paste the code in the example section to the console and run. Getting working directory, list all .jpg files in folder, select columns to include, change lat long column names, remove rows with na no data in lat/long columns, and write a csv file.
}
\usage{
photo_folder_leaflet()
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{}{
Simply run the function, after first changing the working directory to the .jpg image folder, using Session > Set Working Directory > Choose Directory.
}
}
\author{
Wendy Anhtony <o2b.pickin@gmail.com>
}
\examples{
# 1. Set directory to folder holding images to map: Session > Set Working Directory > Choose Directory
# 2. Get Working Directory: getwd()
# 3. Get folder name of working directory
# 4. List jpg file: files <- list.files(pattern = "*.JPG")
# 5. Read exif: dat <- read_exif(files)
# 6. Select columns to use
# 7. Create leaflet map
# 8. Write csv file of .jpg data
# 9. Save map as webpage.html


## The function is currently defined as
function ()
{

# copy the following code into console and run,
# after setting working directory via Session > Set Working Directory > Choose Directory

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
}

