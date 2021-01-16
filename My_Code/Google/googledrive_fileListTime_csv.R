###############################################################
# -------- Create csv file listing google drive files, folders
# -------- and time created and modified
###############################################################

## https://googledrive.tidyverse.org/ 

# setup
## Install / load packages: {googledrive} and {tidyverse}

# install.packages("googledrive")
library("googledrive")
library(tidyverse) # needed for mutate to get dates

## log into Google account
## Google drive will ask to authorize access credentials
## test to get first 3 records and accept cache OAuth access
drive_find(n_max = 3)
# Is it OK to cache OAuth access credentials in the folder '/workingin directory' between R sessions?


# # Create Save dataframe table as csv file
# create 2  new columns for Time
gd_find_Time_10 <- drive_find(n_max = 10) %>%
  drive_reveal("path") %>% 
  mutate(created = map_chr(drive_resource, "createdTime"), 
         modified = map_chr(drive_resource, "modifiedTime")) %>%
  select(name, path, id, created, modified) %>% # oldest first 
  arrange(created)
# arrange(desc(created)) # newest first

print(gd_find_Time_10)

# write csv file with currentDate appended
# https://stat.ethz.ch/pipermail/r-help/2011-June/280068.html
currentDate <- Sys.Date()
csvFileName <- paste("googleDrive_files_10_",currentDate,".csv",sep="")
write.csv(gd_find_Time_10, file=csvFileName) 

### or without the date
# write_csv(gd_find_Time_10, "googleDrive_files_10.csv")
