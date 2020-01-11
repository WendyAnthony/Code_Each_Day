# https://towardsdatascience.com/pgh-weather-data-plot-and-code-19d8e8b670f

# install.packages("hrbrthemes")

library("weathercan") # downloads weather data
library("viridis")     ## color palette
library("ggridges")       ## ridges # replaces deprecated ggjoy package
library("hrbrthemes")  ## plot theme
library("ggplot2")
library("ggsave") # save ggplots

# working directory
dir <- "/Users/wendyanthony/Documents/R/Weather"
setwd(dir)
getwd()

#### import & clean data ------------------------------------
# UVic data download using weathercan hourly
# VICTORIA UNIVERSITY CS Station ID 6812
# https://climate.weather.gc.ca/historical_data
# date format is yyyy-mm-dd 
vic_UVic_dy_2019 <- weather_dl(station_ids = 6812, start = "2019-01-01", end = "2019-12-31", interval = "day")
vic_UVic_dy_2019
vic_UVic_dy_2018 <- weather_dl(station_ids = 6812, start = "2018-01-01", end = "2018-12-31", interval = "day")
vic_UVic_dy_2018
vic_UVic_dy_2017 <- weather_dl(station_ids = 6812, start = "2017-01-01", end = "2017-12-31", interval = "day")
vic_UVic_dy_2017
vic_UVic_dy_2016 <- weather_dl(station_ids = 6812, start = "2016-01-01", end = "2016-12-31", interval = "day")
vic_UVic_dy_2016
vic_UVic_dy_2015 <- weather_dl(station_ids = 6812, start = "2015-01-01", end = "2015-12-31", interval = "day")
vic_UVic_dy_2015

months <- c("December","November","October","September","August","July","June","May","April","March","February","January") ## need this string vector for sorting later

# 2019 date format is yyyy-mm-dd
vic_UVic_dy_2019$months <- as.Date(vic_UVic_dy_2019$date, format = "%y-%b-%d") %>%
  months() %>%
  as.factor() %>%
  factor(., levels = months)
names(vic_UVic_dy_2019)

# 2018 date format is yyyy-mm-dd
vic_UVic_dy_2018$months <- as.Date(vic_UVic_dy_2018$date, format = "%y-%b-%d") %>%
  months() %>%
  as.factor() %>%
  factor(., levels = months)
names(vic_UVic_dy_2018)

# 2017 date format is yyyy-mm-dd
vic_UVic_dy_2017$months <- as.Date(vic_UVic_dy_2017$date, format = "%y-%b-%d") %>%
  months() %>%
  as.factor() %>%
  factor(., levels = months)
names(vic_UVic_dy_2017)

# 2016 date format is yyyy-mm-dd
vic_UVic_dy_2016$months <- as.Date(vic_UVic_dy_2016$date, format = "%y-%b-%d") %>%
  months() %>%
  as.factor() %>%
  factor(., levels = months)
names(vic_UVic_dy_2016)

# 2015 date format is yyyy-mm-dd
vic_UVic_dy_2015$months <- as.Date(vic_UVic_dy_2015$date, format = "%y-%b-%d") %>%
  months() %>%
  as.factor() %>%
  factor(., levels = months)
names(vic_UVic_dy_2015)

#### plots --------------------------------------
# scale determined overlap of ridges

# for quartiles: stat_density_ridges(quantile_lines = TRUE)

###### 2019
# mean Temp --------------------------------------
UVic_meanTemp_ridges_2019 <- ggplot(vic_UVic_dy_2019, aes(x = `mean_temp`, y = `months`, fill = ..x..)) +
  stat_density_ridges(quantile_lines = TRUE, quantiles = 2) + 
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Mean temperatures (Celsius) by month for 2019\nData: from Environment and Natural Resources Canada', 
       x = "Mean Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_meanTemp_ridges_2019.png", plot = UVic_meanTemp_ridges_2019)

# min Temp --------------------------------------
UVic_minTemp_ridges_2019 <- ggplot(vic_UVic_dy_2019, aes(x = `min_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Min temperatures (Celsius) by month for 2019\nData: from Environment and Natural Resources Canada', 
       x = "Min Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_minTemp_ridges_2019.png", plot = UVic_minTemp_ridges_2019)

# max Temp --------------------------------------
UVic_maxTemp_ridges_2019 <- ggplot(vic_UVic_dy_2019, aes(x = `max_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Max temperatures (Celsius) by month for 2019\nData: from Environment and Natural Resources Canada', 
       x = "Max Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_maxTemp_ridges_2019.png", plot = UVic_maxTemp_ridges_2019)

## --------------------------------------------
## finish 2019
## start 2018
## --------------------------------------------

###### 2018
# mean Temp --------------------------------------
UVic_meanTemp_ridges_2018 <- ggplot(vic_UVic_dy_2018, aes(x = `mean_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Mean temperatures (Celsius) by month for 2018\nData: from Environment and Natural Resources Canada', 
       x = "Mean Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_meanTemp_ridges_2018.png", plot = UVic_meanTemp_ridges_2018)

# min Temp --------------------------------------
UVic_minTemp_ridges_2018 <- ggplot(vic_UVic_dy_2018, aes(x = `min_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Min temperatures (Celsius) by month for 2018\nData: from Environment and Natural Resources Canada', 
       x = "Min Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_minTemp_ridges_2018.png", plot = UVic_minTemp_ridges_2018)

# max Temp --------------------------------------
UVic_maxTemp_ridges_2018 <- ggplot(vic_UVic_dy_2018, aes(x = `max_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Max temperatures (Celsius) by month for 2018\nData: from Environment and Natural Resources Canada', 
       x = "Max Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_maxTemp_ridges_2018.png", plot = UVic_maxTemp_ridges_2018)

## --------------------------------------------
## finish 2018
## start 2017
## --------------------------------------------

###### 2017
# mean Temp --------------------------------------
UVic_meanTemp_ridges_2017 <- ggplot(vic_UVic_dy_2017, aes(x = `mean_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Mean temperatures (Celsius) by month for 2017\nData: from Environment and Natural Resources Canada', 
       x = "Mean Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_meanTemp_ridges_2017.png", plot = UVic_meanTemp_ridges_2017)

# min Temp --------------------------------------
UVic_minTemp_ridges_2017 <- ggplot(vic_UVic_dy_2017, aes(x = `min_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Min temperatures (Celsius) by month for 2017\nData: from Environment and Natural Resources Canada', 
       x = "Min Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_minTemp_ridges_2017.png", plot = UVic_minTemp_ridges_2017)

# max Temp --------------------------------------
UVic_maxTemp_ridges_2017 <- ggplot(vic_UVic_dy_2017, aes(x = `max_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Max temperatures (Celsius) by month for 2017\nData: from Environment and Natural Resources Canada', 
       x = "Max Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_maxTemp_ridges_2017.png", plot = UVic_maxTemp_ridges_2017)

## --------------------------------------------
## finish 2017
## start 2016
## --------------------------------------------

###### 2016
# mean Temp --------------------------------------
UVic_meanTemp_ridges_2016 <- ggplot(vic_UVic_dy_2016, aes(x = `mean_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Mean temperatures (Celsius) by month for 2016\nData: from Environment and Natural Resources Canada', 
       x = "Mean Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_meanTemp_ridges_2016.png", plot = UVic_meanTemp_ridges_2016)

# min Temp --------------------------------------
UVic_minTemp_ridges_2016 <- ggplot(vic_UVic_dy_2016, aes(x = `min_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Min temperatures (Celsius) by month for 2016\nData: from Environment and Natural Resources Canada', 
       x = "Min Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_minTemp_ridges_2016.png", plot = UVic_minTemp_ridges_2016)

# max Temp --------------------------------------
UVic_maxTemp_ridges_2016 <- ggplot(vic_UVic_dy_2016, aes(x = `max_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Max temperatures (Celsius) by month for 2016\nData: from Environment and Natural Resources Canada', 
       x = "Max Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_maxTemp_ridges_2016.png", plot = UVic_maxTemp_ridges_2016)

## --------------------------------------------
## finish 2016
## start 2015
## --------------------------------------------

###### 2015
# mean Temp --------------------------------------
UVic_meanTemp_ridges_2015 <- ggplot(vic_UVic_dy_2015, aes(x = `mean_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Mean temperatures (Celsius) by month for 2015\nData: from Environment and Natural Resources Canada', 
       x = "Mean Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_meanTemp_ridges_2015.png", plot = UVic_meanTemp_ridges_2015)

# min Temp --------------------------------------
UVic_minTemp_ridges_2015 <- ggplot(vic_UVic_dy_2015, aes(x = `min_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Min temperatures (Celsius) by month for 2015\nData: from Environment and Natural Resources Canada', 
       x = "Min Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_minTemp_ridges_2015.png", plot = UVic_minTemp_ridges_2015)

# max Temp --------------------------------------
UVic_maxTemp_ridges_2015 <- ggplot(vic_UVic_dy_2015, aes(x = `max_temp`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures at VICTORIA UNIVERSITY CS station 6812',
       subtitle = 'Max temperatures (Celsius) by month for 2015\nData: from Environment and Natural Resources Canada', 
       x = "Max Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())
# save plot
ggsave("UVic_maxTemp_ridges_2015.png", plot = UVic_maxTemp_ridges_2015)

## --------------------------------------------
## finish 2015
## start 2014
## --------------------------------------------

####################################################################
# ggplot
####################################################################
# https://cedricscherer.netlify.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/
# https://www.statmethods.net/management/merging.html
# append data by adding rows rbind()
library("gtools")

vic_UVic_dy_2015_2019 = rbind(vic_UVic_dy_2015, vic_UVic_dy_2016, vic_UVic_dy_2017, vic_UVic_dy_2018, vic_UVic_dy_2019)

class(vic_UVic_dy_2019)
str(vic_UVic_dy_2019)
table(vic_UVic_dy_2019)
tibble::glimpse(vic_UVic_dy_2015_2019)

# min temp
# Warning message: Removed 19 rows containing missing values (geom_point). 
UVic_mintemp_plot_2015_2019 <- ggplot(vic_UVic_dy_2015_2019, aes(x = date, y = min_temp)) +
  theme_set(theme_bw()) +
  geom_point(color = "firebrick") +
  labs(x = "Year", y = "Min Temperature (°C)",
       title = "Min Temperatures at UVic 2015-2019") +
  theme(plot.title = element_text(size = 15, face = "bold",
                                  margin = margin(10, 0, 10, 0)))
UVic_mintemp_plot_2015_2019
# mean temp
UVic_meantemp_plot_2015_2019 <- ggplot(vic_UVic_dy_2015_2019, aes(x = date, y = mean_temp)) +
  theme_set(theme_bw()) +
  geom_point(color = "green") +
  labs(x = "Year", y = "Mean Temperature (°C)",
       title = "Mean Temperatures at UVic 2015-2019") +
  theme(plot.title = element_text(size = 15, face = "bold",
                                  margin = margin(10, 0, 10, 0)))
UVic_meantemp_plot_2015_2019
# max temp
UVic_maxtemp_plot_2015_2019 <- ggplot(vic_UVic_dy_2015_2019, aes(x = date, y = max_temp)) +
  theme_set(theme_bw()) +
  geom_point(color = "blue") +
  labs(x = "Year", y = "Max Temperature (°C)",
       title = "Max Temperatures at UVic 2015-2019") +
  theme(plot.title = element_text(size = 15, face = "bold",
                                  margin = margin(10, 0, 10, 0)))
UVic_maxtemp_plot_2015_2019

## facet
UVic_maxtemp_plot_2015_2019 + facet_wrap(~year, nrow = 2, scales = "free") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))


###################
# Plot Seasons
# Create a new column for Meteorological Seasons
# Meteorological season Winter: Dec, Jan, Feb; Spring: Mar, Apr, May; Summer: June, Jul, Aug; Fall: Sep, Oct, Nov

str(vic_UVic_dy_2015_2019)
names(vic_UVic_dy_2015_2019)

# https://stackoverflow.com/questions/7658316/create-new-column-based-on-4-values-in-another-column
# Create new values in new column season based on meteorological seasons
vic_UVic_dy_2015_2019$Season <- rep(NA, nrow(vic_UVic_dy_2015_2019))
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "December", ][, "Season"] <- "Winter"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "January", ][, "Season"] <- "Winter"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "February", ][, "Season"] <- "Winter"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "March", ][, "Season"] <- "Spring"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "April", ][, "Season"] <- "Spring"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "May", ][, "Season"] <- "Spring"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "June", ][, "Season"] <- "Summer"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "July", ][, "Season"] <- "Summer"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "August", ][, "Season"] <- "Summer"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "September", ][, "Season"] <- "Autumn"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "October", ][, "Season"] <- "Autumn"
vic_UVic_dy_2015_2019[vic_UVic_dy_2015_2019$months == "November", ][, "Season"] <- "Autumn"
vic_UVic_dy_2015_2019

# https://stackoverflow.com/questions/9202413/how-do-you-delete-a-column-by-name-in-data-table
# drop mispelled column "seson"
vic_UVic_dy_2015_2019$Seson = NULL
names(vic_UVic_dy_2015_2019)
class(vic_UVic_dy_2015_2019$Season) # character
# change character to factor
vic_UVic_dy_2015_2019$Season <- as.factor(vic_UVic_dy_2015_2019$Season)

# https://www.datanovia.com/en/blog/how-to-change-ggplot-legend-order/
# Or specify the factor levels in the order you want to change legend label order
vic_UVic_dy_2015_2019$Season <- factor(vic_UVic_dy_2015_2019$Season, levels = c("Winter", "Spring", "Summer", "Autumn"))

#### -----------------------------------------
# Plot Seasons
####
# https://cedricscherer.netlify.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/
vic_UVic_dy_2015_2019_p1 <- ggplot(vic_UVic_dy_2015_2019, aes(x = date, y = mean_temp,
  color = Season)) +
  geom_point(size = 0.5) +
  geom_rug() +
  scale_fill_discrete(breaks=c("Spring", "Summer", "Autumn", "Winter")) + # change legend order from A, Sp, Su, W
  labs(x = "Year", y = "Temperature (°C)")
vic_UVic_dy_2015_2019_p1

# save plot
ggsave("vic_UVic_dy_2015_2019_p1.png", plot = vic_UVic_dy_2015_2019_p1)


