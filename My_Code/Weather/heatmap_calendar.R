# https://dominicroye.github.io/en/2020/a-heatmap-as-calendar/
# https://xeo81.shinyapps.io/MeteoExtremosGalicia/

## Packages
# instalamos los paquetes si hace falta
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("ragg")) install.packages("ragg")
if(!require("lubridate")) install.packages("lubridate")

# paquetes
library(tidyverse)
library(lubridate)
library(ragg)

## Data
# import the data
# https://climate.weather.gc.ca/climate_data/daily_data_e.html?hlyRange=2013-07-09%7C2020-12-29&dlyRange=2013-05-16%7C2020-12-29&mlyRange=%7C&StationID=51337&Prov=BC&urlExtension=_e.html&searchType=stnName&optLimit=yearRange&StartYear=1840&EndYear=2020&selRowPerPage=25&Line=22&searchMethod=contains&Month=12&Day=29&txtStationName=victoria&timeframe=2&Year=2020
dat_pr <- read_csv("Victoria_en_climate_daily_BC_1018621_2020_P1D.csv")
dat_pr
head(dat_pr)
str(dat_pr)
dat_pr$'Total Precip (mm)'

# Rename column names
colnames(dat_pr)
cname <- colnames(dat_pr)

cname[5] <- "Date"
cname[24] <- "Precip"
colnames(dat_pr) <- cname
colnames(dat_pr)

mod_dat_pr = dat_pr[,c('Date', 'Precip')]
dat_pr <- mod_dat_pr

############
## Prep
# 1) complement the time series from December 21 to December 31 with NA, 2) add the day of the week, the month, the week number and the day.
# Depending on whether we want each week to start on Sunday or Monday, we indicate it in the wday() function.
# week_start = 1  starts Monday
# week_start = 7  starts Sunday
# wday(ymd(080101) + days(-2:4))
# [1] 1 2 3 4 5 6 7

### if I use week_start = 1 , calendar days work fine
## if I use week_start - 7, calendar days start Sunday, 
### but anomaly about extra day added at top left corner
### last Sunday empty, all other values move up one week?
# Reply from Dominic
##### isoweek() starts Mond to epiweek() starts Sunday re: Lubridate

dat_pr <- dat_pr %>% 
  complete(Date = seq(ymd("2020-01-01"), 
                      ymd("2020-12-31"), 
                      "day")) %>%
  mutate(weekday = wday(Date, label = T, week_start = 7), 
         month = month(Date, label = T, abbr = F),
         week = epiweek(Date),
         day = day(Date))

# In the next step we need to make a change in the week of the year, 
# which is because in certain years there may be, for example, 
# a few days at the end of the year as the first week of the following year. 
# We also create two new columns. On the one hand, 
# we categorize precipitation into 14 classes and on the other, 
# we define a white text color for darker tones in the heatmap.

dat_pr <- mutate(dat_pr, 
                 week = case_when(month == "December" & week == 1 ~ 53,
                                  month == "January" & week %in% 52:53 ~ 0,
                                  TRUE ~ week),
                 pcat = cut(Precip, c(-1, 0, .5, 1:5, 7, 9, 15, 20, 25, 30, 300)),
                 text_col = ifelse(pcat %in% c("(15,20]", "(20,25]", "(25,30]", "(30,300]"), 
                                   "white", "black")) 

dat_pr  

######
## Vizualization
# color ramp
# create a color ramp from Brewer colors.
pubu <- RColorBrewer::brewer.pal(9, "PuBu")
col_p <- colorRampPalette(pubu)

# before building the chart, we define a custom theme as a function. 
# To do this, we specify all the elements and their modifications 
# with the help of the theme() function.

# Error in grid.Call(C_textBounds, as.graphicsAnnot(x$label), x$x, x$y,  
#: polygon edge not found
# due to missing the Montserrat font.

# first add google font to mac FontBook.app
# sysfonts::font_add_google("Montserrat", "Montserrat")


theme_calendar <- function(){
  
  theme(aspect.ratio = 1/2,
        
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text = element_text(family = "Georgia"),
        
        panel.grid = element_blank(),
        panel.background = element_blank(),
        
        strip.background = element_blank(),
        strip.text = element_text(family = "Georgia", face = "bold", size = 15),
        
        legend.position = "top",
        legend.text = element_text(family = "Georgia", hjust = .5),
        legend.title = element_text(family = "Georgia", size = 9, hjust = 1),
        
        plot.caption =  element_text(family = "Georgia", hjust = 1, size = 8),
        panel.border = element_rect(colour = "grey", fill=NA, size=1),
        plot.title = element_text(family = "Georgia", hjust = .5, size = 26, 
                                  face = "bold", 
                                  margin = margin(0,0,0.5,0, unit = "cm")),
        plot.subtitle = element_text(family = "Georgia", hjust = .5, size = 16)
  )
}

######
## Finally, we build the final chart using geom_tile() 
# and specify the day of the week as the X axis and the week number as the Y axis

ggplot(dat_pr, 
       aes(weekday, -week, fill = pcat)) +
  geom_tile(colour = "white", size = .4)  + 
  geom_text(aes(label = day, colour = text_col), size = 2.5) +
  guides(fill = guide_colorsteps(barwidth = 25, 
                                 barheight = .4,
                                 title.position = "top")) +
  scale_fill_manual(values = c("white", col_p(13)),
                    na.value = "grey90", drop = FALSE) +
  scale_colour_manual(values = c("black", "white"), guide = FALSE) + 
  facet_wrap(~ month, nrow = 4, ncol = 3, scales = "free") +
  labs(title = "How is 2020 in Victoria?", 
       subtitle = "Precipitation",
       caption = "Data: Env Can",
       fill = "mm") +
  theme_calendar()




# To export we will use the ragg package, 
# which provides higher performance and quality than 
# the standard raster devices provided by grDevices.

ggsave("pr_calendar.png", height = 10, width = 8, device = agg_png())


