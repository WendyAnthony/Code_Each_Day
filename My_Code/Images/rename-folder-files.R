# place this R file in folder with files to be renamed

# rename files
# https://www.flickr.com/photos/60047451@N00/albums/72157718341684272
setwd("/Volumes/MyPassportForMac/Pictures/!Nikon-Camera/Nikon-Coolpix-GPS/2022-02-06-BeaconHillPark-HarlandPoint-CattlePoint/test/")
getwd()

# rename a single file
# https://r-lang.com/how-to-rename-a-file-in-r/

file <- "DSCN9533.JPG"
if (file.exists(file)) {
  file.rename("DSCN9533.JPG", "HarlingPoint-DSCN9533.JPG")
} else {
  cat("The file does not exist")
}


# https://stackoverflow.com/questions/46256412/r-renaming-files-in-directory
# Rename multiple files in directory
# put this .R file in directory with files to be renames
# list files in directory with patttern of jpg
files <- list.files(pattern = "*.JPG")
files

# new_names sub > pattern replacement
new_names <- sub("DSCN", "HP_2022_02_06_DSCN", files)
new_names

# rename files
file.rename(from = files, to = new_names)

##################################
##################################
##############
# rename files using exif data
##############

files <- list.files(pattern = "*.JPG")

## Extract exif

dat <- read_exif(files)

class(dat) # df
class(dat$FileModifyDate) # character
dat$SourceFile
str(dat)


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

# pastes date in front of original file name, seaparated by -
fn <- apply(dat, 1, function(row) paste0(row, collapse = "-"))
file.rename(files, file.path(dirname(files), fn))

######################################

# rename file based on folder name

# get working directory >> folder this r script is in
getwd()
# "/Volumes/MyPassportForMac/Pictures/!!Nikon-Camera/Nikon-Coolpix-GPS/2022-02-06-BeaconHillPark-HarlandPoint-CattlePoint/test"

folder <- "/Volumes/MyPassportForMac/Pictures/!!Nikon-Camera/Nikon-Coolpix-GPS/2022-02-06-BeaconHillPark-HarlandPoint-CattlePoint/test/"

# extract file list
# files <-list.files(folder)
files <-list.files(folder, pattern = "*.JPG")


# extract folder name
folder_name <-unlist(strsplit(folder, "/"))[length(unlist(strsplit(folder, "/")))]

# rename files
#file.rename(from = paste0(folder,files),to = paste0(folder,folder_name,"_",files))
file.rename(from = files, to = paste0(folder, folder_name, "_", files))
