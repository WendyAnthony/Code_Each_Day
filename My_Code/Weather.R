# https://ropensci.org/blog/2018/03/06/weathercan/


#install.packages("weathercan")
#install.packages("lutz")
#install.packages("naniar")
# package ‘feedr’ is not available (for R version 3.6.1)
# install.packages("feedr")
# library(feedr) # Access to data containing feeder visits by birds


library("weathercan")
library("sf") # needed for station timezones; # Spatial analyses
library("lutz")
library("tidyverse") # needed for filter
library("ggplot2") # Data manipulation and plotting
library("DT") # to create datatable
library("RColorBrewer")
library("dplyr") # Data manipulation and plotting
library("naniar") # Checking data completeness
library("mapview") # Spatial analyses

# set working directory ------------------------
# dir <- "/Users/wendyanthony/Documents/R/Weather"
# setwd(dir)
# getwd()

head(stations)
glimpse(stations)
stations_search("Victoria", interval = "hour")

stations <- stations_dl()
Victoria_stn <- stations_search("Victoria")
bc_stn <- filter(stations, prov == "BC") %>% 
  select(-prov, -climate_id, -WMO_id, -TC_id)
View(bc_stn)

Victoria_intl_a_stn <- stations_search("VICTORIA INT'L A")

# Manitoba weather station data
mb <- filter(stations, 
             prov == "MB",
             interval == "day",
             end >= 2018) %>%
  select(-prov, -climate_id, -WMO_id, -TC_id)
mb

mb_weather_all <- weather_dl(station_ids = mb$station_id, 
                             start = "2018-01-01", 
                             interval = "day", quiet = TRUE)

# BC weather station data 
bc <- filter(stations, 
             prov == "BC",
             interval == "day",
             end >= 2019) %>%
  select(-prov, -climate_id, -WMO_id, -TC_id)
bc

# BC weather station weather data 
bc_weather_all <- weather_dl(station_ids = bc$station_id, 
                             start = "2019-01-01", 
                             interval = "day", quiet = TRUE)
bc_weather_all

# which victoria stations have climate norms?
Vic_stn_norm <- stations_search("VICTORIA", normals_only = TRUE)
Vic_stn_norm

# https://docs.ropensci.org/weathercan/

# Victoria Int'l A data download
vic_IA <- weather_dl(station_ids = 51337, start = "2019-01-01", end = "2019-12-31")
vic_IA
# Victoria Int'l A ggplot temp
vic_IA_gg <- ggplot(data = vic_IA, aes(x = time, y = temp, group = station_name, colour = station_name)) +
  theme_minimal() + 
  geom_line()
vic_IA_gg

# Victoria Int'l A & UVic data download
vic_IA_UVic <- weather_dl(station_ids = c(6812, 51337), start = "2019-01-01", end = "2019-12-31")
vic_IA_UVic
# Victoria Int'l A & UVic ggplot
vic_IA_UVic_gg <- ggplot(data = vic_IA_UVic, aes(x = time, y = temp, group = station_name, colour = station_name)) +
  theme_minimal() + 
  geom_line()
vic_IA_UVic_gg
# Split in horizontal direction
# margins = TRUE shows all together
vic_IA_UVic_gg_ft <- vic_IA_UVic_gg + facet_grid(. ~ station_id, margins = TRUE)
vic_IA_UVic_gg_ft

# UVic data download
vic_UVic <- weather_dl(station_ids = 6812, start = "2019-01-01", end = "2019-12-31")
vic_UVic
#UVic ggplot
vic_UVic_gg <- ggplot(data = vic_UVic, aes(x = time, y = wind_dir, colour = station_name)) +
  theme_minimal() + 
  geom_line()
vic_UVic_gg

##########################
# try a windrose        # 
##########################

names(vic_UVic)

# change direction by multiplying by 10 to 360
vic_UVic$wind_dir_360 <- vic_UVic$wind_dir * 10
class(vic_UVic$wind_dir_360)

# https://rpubs.com/mariner610/windrose
# windrose
head(vic_UVic)
class(vic_UVic)
str(vic_UVic)
vic_UVic

dim(vic_UVic) # # rows and columns
nrow(vic_UVic)
ncol(vic_UVic)

names(vic_UVic)

# create variables for columns, used to create a dataframe
ID <- vic_UVic[, 2]
Year <- vic_UVic[, 13]
Month <- vic_UVic[, 14]
Day <- vic_UVic[, 15]
Hour <- vic_UVic[, 16]
Pressure <- vic_UVic[, 20]
Temp <- vic_UVic[, 24]
DewTemp <- vic_UVic[, 25]
spd <- vic_UVic[, 34]
dir <- vic_UVic[, 36]

# create a dataframe using column variables
UVic_df <- data.frame(ID, Month, Hour, spd, dir)
names(UVic_df)
str(UVic_df)

# see data in newly created data.frame
datatable(UVic_df)
names(UVic_df)
spd <- UVic_df[, 4]
dir <- UVic_df[, 5]

plot.windrose <- function(data,
                          spd,
                          dir,
                          spdres = 2,
                          dirres = 30,
                          spdmin = 2,
                          spdmax = 20,
                          spdseq = NULL,
                          palette = "YlGnBu",
                          countmax = NA,
                          debug = 0){
  
  # Look to see what data was passed in to the function
  if (is.numeric(spd) & is.numeric(dir)){
    # assume that we've been given vectors of the speed and direction vectors
    data <- data.frame(spd = spd,
                       dir = dir)
    spd = "spd"
    dir = "dir"
  } else if (exists("data")){
    # Assume that we've been given a data frame, and the name of the speed 
    # and direction columns. This is the format we want for later use.    
  }  
  
  # Tidy up input data ----
  n.in <- NROW(data)
  dnu <- (is.na(data[[spd]]) | is.na(data[[dir]]))
  data[[spd]][dnu] <- NA
  data[[dir]][dnu] <- NA
  
  # figure out the wind speed bins ----
  if (missing(spdseq)){
    spdseq <- seq(spdmin,spdmax,spdres)
  } else {
    if (debug >0){
      cat("Using custom speed bins \n")
    }
  }
  # get some information about the number of bins, etc.
  n.spd.seq <- length(spdseq)
  n.colors.in.range <- n.spd.seq - 1
  
  # create the color map
  spd.colors <- colorRampPalette(brewer.pal(min(max(3,
                                                    n.colors.in.range),
                                                min(9,
                                                    n.colors.in.range)),              
                                            palette))(n.colors.in.range)
  
  if (max(data[[spd]],na.rm = TRUE) > spdmax){    
    spd.breaks <- c(spdseq,
                    max(data[[spd]],na.rm = TRUE))
    spd.labels <- c(paste(c(spdseq[1:n.spd.seq-1]),
                          '-',
                          c(spdseq[2:n.spd.seq])),
                    paste(spdmax,
                          "-",
                          max(data[[spd]],na.rm = TRUE)))
    spd.colors <- c(spd.colors, "red")
  } else{
    spd.breaks <- spdseq
    spd.labels <- paste(c(spdseq[1:n.spd.seq-1]),
                        '-',
                        c(spdseq[2:n.spd.seq]))    
  }
  data$spd.binned <- cut(x = data[[spd]],
                         breaks = spd.breaks,
                         labels = spd.labels,
                         ordered_result = TRUE)
  # clean up the data
  data. <- na.omit(data)
  
  # figure out the wind direction bins
  dir.breaks <- c(-dirres/2,
                  seq(dirres/2, 360-dirres/2, by = dirres),
                  360+dirres/2)  
  dir.labels <- c(paste(360-dirres/2,"-",dirres/2),
                  paste(seq(dirres/2, 360-3*dirres/2, by = dirres),
                        "-",
                        seq(3*dirres/2, 360-dirres/2, by = dirres)),
                  paste(360-dirres/2,"-",dirres/2))
  # assign each wind direction to a bin
  dir.binned <- cut(data[[dir]],
                    breaks = dir.breaks,
                    ordered_result = TRUE)
  levels(dir.binned) <- dir.labels
  data$dir.binned <- dir.binned
  
  # Run debug if required ----
  if (debug>0){    
    cat(dir.breaks,"\n")
    cat(dir.labels,"\n")
    cat(levels(dir.binned),"\n")       
  }  
  
  # deal with change in ordering introduced somewhere around version 2.2
  if(packageVersion("ggplot2") > "2.2"){    
    #cat("Hadley broke my code\n")
    data$spd.binned = with(data, factor(spd.binned, levels = rev(levels(spd.binned))))
    spd.colors = rev(spd.colors)
  }
  
  # create the plot ----
  p.windrose <- ggplot(data = data,
                       aes(x = dir.binned,
                           fill = spd.binned)) +
    geom_bar() + 
    scale_x_discrete(drop = FALSE,
                     labels = waiver()) +
    coord_polar(start = -((dirres/2)/360) * 2*pi) +
    scale_fill_manual(name = "Wind Speed (m/s)", 
                      values = spd.colors,
                      drop = FALSE) +
    #theme_bw() +
    theme(axis.title.x = element_blank(),
          #panel.border = element_rect(colour = "blank"),
          panel.grid.major = element_line(colour="grey65"))
  
  # adjust axes if required
  if (!is.na(countmax)){
    p.windrose <- p.windrose +
      ylim(c(0,countmax))
  }
  
  # print the plot
  print(p.windrose)  
  
  # return the handle to the wind rose
  return(p.windrose)
}

p1 <- plot.windrose(data = UVic_df, 
                    spd = spd,
                    dir = dir)

p2 <- plot.windrose(data=UVic_df, spd = spd,
                    dir = dir,
                    spdseq = c(0,3,6,12,20))

# save plots as png files to 
p1 <- plot.windrose(data = UVic_df, 
                    spd = spd,
                    dir = dir)
ggsave("UVic-2019-windrose-1.png")

p2 <- plot.windrose(data=UVic_df, spd = spd,
                    dir = dir,
                    spdseq = c(0,3,6,12,20))
ggsave("UVic-2019-windrose-2.png")
