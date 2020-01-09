# https://towardsdatascience.com/pgh-weather-data-plot-and-code-19d8e8b670f

# install.packages("ggjoy")
# install.packages("hrbrthemes")
# install.packages("weathermetrics")
# https://www.rdocumentation.org/packages/weathermetrics
# to convert from F to C temperature
library("viridis")     ## color palette
library("ggjoy")       ## ridges
# The ggjoy package has been deprecated. Please switch over to the ggridges package, which provides the same functionality. Porting guidelines can be found here: https://github.com/clauswilke/ggjoy/blob/master/README.md
library("hrbrthemes")  ## plot theme
library("weathermetrics")

dir <- "/Users/wendyanthony/Documents/R/Weather"
setwd(dir)
getwd()



# https://www.wunderground.com/weather/ca/victoria
# VICTORIA INNER HARBOUR AIRPORT STATION
# copy paste data & add column for date dd-mo-yyy; rename columns by adding summary column title to end e.g. avg > mean TemperatureF

# import & clean data ------------------------------------
vihas_weather <- read.csv("weather-data-vic-2019.csv") ## setwd() to your own
months <- c("December","November","October","September","August","July","June","May","April","March","February","January") ## need this string vector for sorting later
vihas_weather$months <- as.Date(vihas_weather$CST, format = "%d-%b-%y") %>%
  months() %>%
  as.factor() %>%
  factor(., levels = months)

# convert from Temp F to C ------------------
names(vihas_weather)
vihas_weather$Max.TemperatureC <- fahrenheit.to.celsius(vihas_weather$Max.TemperatureF)
vihas_weather$Mean.TemperatureC <- fahrenheit.to.celsius(vihas_weather$Mean.TemperatureF)
vihas_weather$Min.TemperatureC <- fahrenheit.to.celsius(vihas_weather$Min.TemperatureF)

names(vihas_weather)

mins <- min(vihas_weather$Min.TemperatureC)
maxs <- max(vihas_weather$Max.TemperatureC)

# plots
# mean Temp
## black and white
ggplot(vihas_weather,aes(x = Mean.TemperatureC,y=months,height=..density..))+
  geom_joy(scale=3) +
  scale_x_continuous(limits = c(mins,maxs))+
  theme_ipsum(grid=F)+
  theme(axis.title.y=element_blank(),
        axis.ticks.y=element_blank(),
        strip.text.y = element_text(angle = 180, hjust = 1))+
  labs(title='Temperatures in Victoria Inner Harbour Airport Station',
       subtitle='Median temperatures (Celsius) by month for 2019\nData: Original CSV from the Weather Underground', x = "Mean Temperature [ºC]")
## in color
ggplot(vihas_weather, aes(x = `Mean.TemperatureC`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures in Victoria Inner Harbour Airport Station',
       subtitle = 'Mean temperatures (Celsius) by month for 2019\nData: Original CSV from the Weather Underground', 
       x = "Mean Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())

# download yearly data 

# min Temp
ggplot(vihas_weather,aes(x = Min.TemperatureC,y=months,height=..density..))+
  geom_joy(scale=3) +
  scale_x_continuous(limits = c(mins,maxs))+
  theme_ipsum(grid=F)+
  theme(axis.title.y=element_blank(),
        axis.ticks.y=element_blank(),
        strip.text.y = element_text(angle = 180, hjust = 1))+
  labs(title='Temperatures in Victoria Inner Harbour Airport Station',
       subtitle='Min temperatures (Celsius) by month for 2019\nData: Original CSV from the Weather Underground', x = "Min Temperature [ºC]")
## in color
ggplot(vihas_weather, aes(x = `Min.TemperatureC`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures in Victoria Inner Harbour Airport Station',
       subtitle = 'Min temperatures (Celsius) by month for 2019\nData: Original CSV from the Weather Underground', 
       x = "Min Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())


# max Temp
ggplot(vihas_weather,aes(x = Max.TemperatureC,y=months,height=..density..))+
  geom_joy(scale=3) +
  scale_x_continuous(limits = c(mins,maxs))+
  theme_ipsum(grid=F)+
  theme(axis.title.y=element_blank(),
        axis.ticks.y=element_blank(),
        strip.text.y = element_text(angle = 180, hjust = 1))+
  labs(title='Temperatures in Victoria Inner Harbour Airport Station',
       subtitle='Max temperatures (Celsius) by month for 2019\nData: Original CSV from the Weather Underground', x = "Min Temperature [ºC]")
## in color
ggplot(vihas_weather, aes(x = `Max.TemperatureC`, y = `months`, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01, gradient_lwd = 1.) +
  scale_x_continuous(expand = c(0.01, 0)) +
  scale_y_discrete(expand = c(0.01, 0)) +
  scale_fill_viridis(name = "Temp. [ºC]", option = "C") +
  labs(title = 'Temperatures in Victoria Inner Harbour Airport Station',
       subtitle = 'Max temperatures (Celsius) by month for 2019\nData: Original CSV from the Weather Underground', 
       x = "Max Temperature") +
  theme_ridges(font_size = 13, grid = TRUE) + theme(axis.title.y = element_blank())