##################################
# place this R file in folder with files to be renamed
##################################
# rename files
# https://www.flickr.com/photos/60047451@N00/albums/72157718341684272

##################################
# load libraries
library(exifr)

##################################
getwd()

##################################
# https://stackoverflow.com/questions/46256412/r-renaming-files-in-directory
# Rename multiple files in directory
# put this .R file in directory with files to be renames


##################################
# extract kust if files
files <- list.files(pattern = "*.JPG")
files

files_mp4 <- list.files(pattern = "*.MP4")
files_mp4

files <- c(files, files_mp4)
files

##################################
# rename files using exif data
##################################

## Extract exif

dat <- read_exif(files)

class(dat) # df
class(dat$FileModifyDate) # character
dat$SourceFile
str(dat)

##################################
# change FileModifyDate to date format from character
# create new column
# https://community.rstudio.com/t/convert-character-to-date/107594/4
dat$FileModifyDateFormat = format(as.Date(dat$FileModifyDate, "%Y:%m:%d"), "%Y-%m-%d")
class(dat$FileModifyDateFormat) # character
dat$dates <- as.Date(dat$FileModifyDateFormat)
class(dat$dates)

files <- files[order(match(basename(files), dat$SourceFile))] # reorder if necessary

# this specifies order that info is pasted
dat <-dat[, c("dates", "SourceFile")]

# pastes date in front of original file name, separated by -
fn <- apply(dat, 1, function(row) paste0(row, collapse = "-"))
file.rename(files, file.path(dirname(files), fn))

######################################
##################################
# rename file adding  on folder name

##################################
# get working directory >> copy the path for  folder this r script is in
getwd()

folder <- getwd()

##################################
# extract file list

files <- list.files(pattern = "*.JPG")
files

files_mp4 <- list.files(pattern = "*.MP4")
files_mp4

files <- c(files, files_mp4)
files

##################################
# extract folder name
folder_name <-unlist(strsplit(folder, "/"))[length(unlist(strsplit(folder, "/")))]

##################################
# rename files
#file.rename(from = paste0(folder,files),to = paste0(folder,folder_name,"_",files))
file.rename(from = files, to = paste0(folder_name, "-", files))

##################################
##################################
