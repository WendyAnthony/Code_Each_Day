# https://www.rforexcelusers.com/make-pivottable-in-r/

# packages Needed -------------------------
## install.packages("reshape2")
library("reshape2") # ????
library("dplyr") # to make pivot table
library("weathercan") # to import weather_dl station data
library("DT") # to create datatable

dir <- "/Users/wendyanthony/Documents/R"
setwd(dir)
getwd()

# DataPrep -------------------------
vic_UVic <- weather_dl(station_ids = 6812, start = "2019-01-01", end = "2019-12-31")
vic_UVic
names(vic_UVic)
summary(vic_UVic)  # wind_dir NA's 278 length 8760

## ----Remove_na ----------------------------------------
vic_UVic <- vic_UVic[!is.na(vic_UVic$wind_dir),]
summary(vic_UVic) # # wind_dir NA's 0 length 8760 - 278 = 8482 

## change direction by multiplying by 10 to 360 > create new column -----------------
vic_UVic$wind_dir_360 <- vic_UVic$wind_dir * 10
names(vic_UVic)
summary(vic_UVic)

## write imported data to csv file -------------------------
write.csv(vic_UVic, "vic_UVic_2019.csv", row.names = FALSE)

str(vic_UVic) # 8482 observations
names(vic_UVic)

# create variables for columns, used to create a dataframe ----------------------
ID <- vic_UVic[, 2]
Time <- vic_UVic[, 12]
Year <- vic_UVic[, 13]
Month <- vic_UVic[, 14]
Day <- vic_UVic[, 15]
Hour <- vic_UVic[, 16]
Pressure <- vic_UVic[, 20]
Temp <- vic_UVic[, 24]
DewTemp <- vic_UVic[, 25]
wdir <- vic_UVic[, 32]
spd <- vic_UVic[, 34]
dir <- vic_UVic[, 36]
names(vic_UVic)

# create a dataframe using column variables -------------------------
UVic_df <- data.frame(spd, dir, Time, Month, Hour)
names(UVic_df)
str(UVic_df)

## --Change_column_names_to_xnumber_points_and_frequency_of_quadrats  ------------
colnames(UVic_df) <- c("spd", "dir", "time", "month", "hour")
names(UVic_df)

# see data in newly created data.frame -------------------------
datatable(UVic_df)
names(UVic_df)
summary(UVic_df)

# create variables for columns of new dataframe -------------------------
spd <- UVic_df[, 1]
dir <- UVic_df[, 2]

##############################
##############################
##############################

# https://www.statmethods.net/management/sorting.html

## create a column for wind speed bins
UVic_df$spd_bins <- cut(UVic_df$spd, breaks=c(0, 2, 4, 6, 8, 10, 12, 14, 16, 18), labels=c("0-2","2-4","4-6", "6-8", "8-10", "10-12", "12-14", "14-16", "16+"))
UVic_df
head(UVic_df)
class(UVic_df$spd_bins) # factor

# https://stackoverflow.com/questions/7658316/create-new-column-based-on-4-values-in-another-column
# create a new numeric column based on spd_bin values
bin_values <- c("0", "2", "4", "6", "8", "10", "12", "14", "16", "18")
UVic_df$bin_spd <- bin_values[UVic_df$spd_bins]
UVic_df
head(UVic_df)
names(UVic_df)
str(UVic_df)
UVic_df$bin_spd <- as.numeric(as.character(UVic_df$bin_spd))
str(UVic_df)
summary(UVic_df)  # NA's 36


# http://snowfence.umn.edu/Components/winddirectionanddegrees.htm
## create a column for wind dir bins
# alll 0 values were given NA > need to change 0 to 360
# https://stackoverflow.com/questions/5824173/replace-a-value-in-a-data-frame-based-on-a-conditional-if-statement
# https://stackoverflow.com/questions/37707060/converting-data-frame-column-from-character-to-numeric

UVic_df$dir[UVic_df$dir %in% "0"] <- "360"
class(UVic_df$dir)
UVic_df$dir <- as.numeric(as.character(UVic_df$dir))
head(UVic_df)
class(UVic_df$dir)
UVic_df$dir_bins <- cut(UVic_df$dir, breaks=c(348.75, 11.25, 33.75, 56.25, 78.75, 101.25, 123.75, 146.25, 168.75, 191.25, 213.75, 236.25, 358.75, 281.25, 303.76, 326.25, 458.75), labels=c("N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "N"))
UVic_df
head(UVic_df)
class(UVic_df$dir_bins) # factor

# create a new numeric column based on dir_bin values
bin_dir_values <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16")
UVic_df$bin_dir <- bin_dir_values[UVic_df$dir_bins]
UVic_df$bin_dir <- as.numeric(as.character(UVic_df$bin_dir))
UVic_df
head(UVic_df)
names(UVic_df)
str(UVic_df)
summary(UVic_df) 

# NA values because $dir_bins value of 10 isn't registering as N
# NA values because $bin_dir value
UVic_df$dir_bins[UVic_df$dir_bins %in% NA] <- "N"
UVic_df$bin_dir[UVic_df$bin_dir %in% NA] <- "1"
summary(UVic_df) 
# NA values because $spd_bins values of 19-24 isn't registering as 16+
# NA values because $bin_spd value
UVic_df$spd_bins[UVic_df$spd_bins %in% NA] <- "16+"
UVic_df$bin_spd[UVic_df$bin_spd %in% NA] <- "16"
summary(UVic_df) 

names(UVic_df)
# create variables for columns of new dataframe -------------------------
binSpd <- UVic_df[, 7]
binDir <- UVic_df[, 9]

names(sort_spd_dir_bins)
str(sort_spd_dir_bins)

# change bin_dir from character to numeric for sort
# to avoid creating NA when trying to sort a character or factor class
sort_spd_dir_bins$bin_dir <- as.numeric(as.character(sort_spd_dir_bins$bin_dir))
class(sort_spd_dir_bins$bin_dir)

sort_spd_dir_bins$bin_spd <- as.numeric(as.character(sort_spd_dir_bins$bin_spd))
class(sort_spd_dir_bins$bin_spd)
str(sort_spd_dir_bins)
#################
## sort
sort_spd_bins <- UVic_df[order(binSpd, dir, spd),]
sort_spd_bins

sort_spd_dir_bins <- UVic_df[order(binSpd, binDir, dir, spd),]
sort_spd_dir_bins

class(sort_spd_dir_bins)
head(sort_spd_dir_bins)
names(sort_spd_dir_bins)
str(sort_spd_dir_bins)
summary(sort_spd_dir_bins)

## again
# change bin_dir from character to numeric for sort
# to avoid creating NA when trying to sort a character or factor class
sort_spd_dir_bins$bin_dir <- as.numeric(as.character(sort_spd_dir_bins$bin_dir))
class(sort_spd_dir_bins$bin_dir)

sort_spd_dir_bins$bin_spd <- as.numeric(as.character(sort_spd_dir_bins$bin_spd))
class(sort_spd_dir_bins$bin_spd)
str(sort_spd_dir_bins)
summary(sort_spd_dir_bins)

##############################
##############################
# group by
##############################

by_dir <- sort_spd_dir_bins %>% group_by(bin_dir)
by_dir
summary(by_dir)

by_spd <- sort_spd_dir_bins %>% group_by(bin_spd)
by_spd
summary(by_spd)
class(by_spd)

##############################
##############################
##############################

#### NOT SURE THIS IS WORKING OK >>>>


# create pivot table -------------------------
## 1. filter to keep three months -------------------------
# basic_summ = filter(by_spd, month %in% c("10", "11", "12"))


summary(by_spd)
basic_summ <- by_spd
summary(basic_summ) 
class(basic_summ) 
str(basic_summ)

## 2. set up dataframe for group processing
basic_summ_gr = group_by(basic_summ, dir, add = FALSE)
basic_summ_gr
summary(basic_summ_gr) 

## 3. transpose the summary using dcast from reshape 2 library
##### introducing time introduces lots of NA values ????
basic_summ_t = dcast(basic_summ_gr, spd ~ dir, value.var = "spd", count)

basic_summ_t$spd <- as.integer(as.numeric(basic_summ_t$spd))
class(basic_summ_t$spd)
str(basic_summ)
# https://stackoverflow.com/questions/33051386/dcast-error-aggregation-function-missing-defaulting-to-length
# Aggregation function missing: defaulting to length
basic_summ_t
class(basic_summ_t) # data.frame
summary(basic_summ_t$spd)
count(basic_summ_t$spd)
class(basic_summ_t$spd) # data.frame

### WORKS
# https://stackoverflow.com/questions/34417973/easy-way-to-convert-long-to-wide-format-with-counts/34418124
basic_summ_newdf <- dcast(basic_summ_gr, spd ~ dir,
               value.var = "dir", fun.aggregate = length)
basic_summ_newdf
summary(basic_summ_newdf)
class(basic_summ_newdf)
str(basic_summ_newdf)
