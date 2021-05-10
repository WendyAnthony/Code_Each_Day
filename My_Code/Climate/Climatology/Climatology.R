################################################################################
### Creating climate visualizations
## Wendy Anthony - revisiting from 2019
################################################################################

# Load libraries
library("ggplot2")
library("tidyverse")

# read csv file and create data.frame
Vic_IntA_2000_2019_df <- as.data.frame(read_csv("Vic_IntA_2000_2019.csv"))
Vic_IntA_2000_2019_df$YEAR

# Rename column names
colnames(Vic_IntA_2000_2019_df)
cname <- colnames(Vic_IntA_2000_2019_df)
cname[12] <- "Year"
cname[13] <- "Month"
cname[34] <- "Rain"
cname[16] <- "Temp"
cname[18] <- "DewPt"
cname[11] <- "Date"
colnames(Vic_IntA_2000_2019_df) <- cname
colnames(Vic_IntA_2000_2019_df)

# add column which converts numerical month to named month
months <-c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
Vic_IntA_2000_2019_df$Months <- months[Vic_IntA_2000_2019_df$Month]

Vic_IntA_2000_2019_df$Months
Vic_IntA_2000_2019_df
head(Vic_IntA_2000_2019_df)
str(Vic_IntA_2000_2019_df)

View(Vic_IntA_2000_2019_df)

# add new column for seasons
# https://community.rstudio.com/t/creating-seasons-from-date-and-time-columns/80257
Vic_IntA_2000_2019_df$Season <-"Winter" # default for all values until changed >>
Vic_IntA_2000_2019_df$Season[Vic_IntA_2000_2019_df$Month>11&Vic_IntA_2000_2019_df$Month<4]<-"Winter"
Vic_IntA_2000_2019_df$Season[Vic_IntA_2000_2019_df$Month>2&Vic_IntA_2000_2019_df$Month<6]<-"Spring"
Vic_IntA_2000_2019_df$Season[Vic_IntA_2000_2019_df$Month>5&Vic_IntA_2000_2019_df$Month<9]<-"Summer"
Vic_IntA_2000_2019_df$Season[Vic_IntA_2000_2019_df$Month>8&Vic_IntA_2000_2019_df$Month<12]<-"Autumn"

theme_set(theme_bw())

#######################################################
# change order of legend seasons
Vic_IntA_2000_2019_df$Season <-
  factor(Vic_IntA_2000_2019_df$Season,
         levels = c("Winter", "Spring", "Summer", "Autumn"))

#######################################################
# Temp

ggplot(Vic_IntA_2000_2019_df, aes(x = Date, y = Temp, color = Season)) +
  geom_point() +
  labs(x = "Year", y = "Temperature (°C)",
       title = "Victoria International Airport Temperature (°C)",
       subtitle = "(2000-2019)",
       caption = "Data: Env. Canada") +
  theme(legend.key = element_rect(fill = NA),
        legend.title = element_text(color = "chocolate",
                                    size = 14, face = 2)) +
   scale_color_discrete("Seasons:") +
  guides(color = guide_legend(override.aes = list(size = 6)))+
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 10, face = "bold"))


###
# Using a sequential colour variable for continuous values
mid <- mean(Vic_IntA_2000_2019_df$Temp)  ## midpoint

VIA <- ggplot(Vic_IntA_2000_2019_df, aes(x = Date, y = Temp, color = Temp)) +
  geom_point() +
  labs(x = "Year", y = "Temperature (°C)",
       title = "Victoria International Airport Temperature (°C)",
       subtitle = "(2000-2019)",
       caption = "Data: Env. Canada") +
  theme(legend.key = element_rect(fill = NA),
        legend.title = element_text(color = "chocolate",
                                    size = 14, face = 2)) +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 10, face = "bold"))


VIA + scale_color_continuous()
VIA + scale_color_gradient2(midpoint = mid)
VIA + scale_color_gradient2(midpoint = mid, low = "#dd8a0b",
                           mid = "grey92", high = "#32a676")
VIA + scale_color_viridis_c(option = "inferno")
VIA + scale_color_viridis_c(option = "plasma")
VIA + scale_color_viridis_c(option = "cividis")
VIA + scale_color_viridis_c()  # default

#######################################################
# facets

VIA <- ggplot(Vic_IntA_2000_2019_df, aes(x = Date, y = Temp, color = Season)) +
  geom_point(size = 0.00005) +
  labs(x = "Year", y = "Temperature (°C)",
       title = "Victoria International Airport Temperature (°C)",
       subtitle = "(2000-2019)",
       caption = "Data: Env. Canada") +
  theme(legend.key = element_rect(fill = NA),
        legend.title = element_blank(),
        legend.position = "bottom") +
  guides(color = guide_legend(override.aes = list(size = 3))) +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 10, face = "bold"),
        plot.caption = element_text(size = 7, face = "italic"),
        axis.text.x = element_text(angle = 0, vjust = 1, hjust = 0.6, size = 6),
        axis.text.y = element_text(vjust = 1, hjust = 1, size = 7)) +
  scale_color_discrete("Seasons:")
###  BEST
VIA + facet_wrap(~ Year, nrow = 5, scales = "free_x")

ggsave(
  "VIA_temp_2000_2019-00005.png",
  plot = last_plot(),
  device = NULL,
  path = NULL,
  scale = 1,
  width = NA,
  height = NA,
  units = c("in", "cm", "mm"),
  dpi = 300,
  limitsize = TRUE,
)


# VIA + facet_wrap(~ Year, nrow = 5)
# too crowed with double header, etc
# VIA + facet_wrap(Year ~ Season, nrow = 10, scales = "free")
# VIA + facet_wrap(Year ~ Season, nrow = 20, scales = "free")

#######################################################
# Precip
ggplot(Vic_IntA_2000_2019_df, aes(x = Date, y = Rain, color = Season)) +
  geom_point() +
  labs(x = "Year", y = "Rain (mm)",
       title = "Victoria International Airport Precipitation",
       subtitle = "(2000-2019)",
       caption = "Data: Env. Canada") +
  theme(legend.key = element_rect(fill = NA),
        legend.title = element_text(color = "chocolate",
                                    size = 14, face = 2)) +
  scale_color_discrete("Seasons:") +
  guides(color = guide_legend(override.aes = list(size = 6)))+
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 10, face = "bold"))

ggplot(Vic_IntA_2000_2019_df, aes(x = Date, y = Rain)) +
  geom_point(aes(color = "point")) +
  labs(x = "Date", y = "Rain (mm)")

ggplot(Vic_IntA_2000_2019_df,
       aes(x = Date, y = Temp, color = Temp)) +
  geom_point() +
  labs(x = "Year", y = "Temperature (°C)", color = "Temperature (°C)") +
  guides(color = guide_legend())

