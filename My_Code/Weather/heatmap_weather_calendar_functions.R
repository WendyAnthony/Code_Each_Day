# https://dominicroye.github.io/en/2020/a-heatmap-as-calendar/
# https://xeo81.shinyapps.io/MeteoExtremosGalicia/

# libraries
library(tidyverse)
library(lubridate)
library(ragg)
library(ggplot2)

getwd()

#########################################################################
#########################################################################
#########################################################################
#########################################################################

#########################################################################
## Functions
# hmcal_file() # to read csv
# hmcal_data() # to change column names of parameters
#########################################################################

# ################## Function
# -----------------------------------------------------------------------
## Function for calendar theme
# from
# https://dominicroye.github.io/en/2020/a-heatmap-as-calendar/
# https://xeo81.shinyapps.io/MeteoExtremosGalicia/

# palettes
pubu <- RColorBrewer::brewer.pal(9, "PuBu")
col_p <- colorRampPalette(pubu)

library(viridis)
col_v <-colorRampPalette(viridis(13)) # this would create 13 viridis colors

theme_calendar <- function(){
  ## Vizualization
  # color ramp
  # create a color ramp from Brewer colors.

  theme(aspect.ratio = 1/2,

        axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text = element_text(family = "Montserrat"),

        panel.grid = element_blank(),
        panel.background = element_blank(),

        strip.background = element_blank(),
        strip.text = element_text(family = "Montserrat",
                                  face = "bold", size = 15),

        legend.position = "top",
        legend.text = element_text(family = "Montserrat", hjust = .5),
        legend.title = element_text(family = "Montserrat",
                                    size = 9, hjust = 1),

        plot.caption =  element_text(family = "Montserrat",
                                     hjust = 1, size = 8),
        panel.border = element_rect(colour = "grey", fill=NA, size=1),
        plot.title = element_text(family = "Montserrat", hjust = .5, size = 26,
                                  face = "bold",
                                  margin = margin(0,0,0.5,0, unit = "cm")),
        plot.subtitle = element_text(family = "Montserrat",
                                     hjust = .5, size = 16)
  )
}

#########################################################################
# -----------------------------------------------------------------------
# ################## Function
## Function to read csv file
hmcal_read_file <- function(csvfile){

  data <- read_csv(csvfile)
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use hmcal_read_file() function to read csv file
hmcal_data <- hmcal_read_file("VIA_en_climate_daily_BC_1018621_2022_P1D.csv")
hmcal_data

colnames(hmcal_data)

# ################## Function
# -----------------------------------------------------------------------
## Function to change column names of parameters
hmcal_data_col_rename <- function(data_name){

  cname <- colnames(data_name)

  cname[5] <- "Date"
  cname[24] <- "Precip"
  cname[10] <- "TempMaxC"
  cname[12] <- "TempMinC"
  cname[14] <- "TempMeanC"
  cname[28] <- "WindDir10"
  cname[30] <- "WindSpeed"

  colnames(data_name) <- cname
  colnames(data_name)
  data_name
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use hmcal_data_col_rename() function to rename columns
hmcal_data_renamed_cols <- hmcal_data_col_rename(hmcal_data)
hmcal_data_renamed_cols

# add new column
hmcal_data_renamed_cols$WindDir360 <- ""
hmcal_data_renamed_cols$WindDir360 <- hmcal_data_renamed_cols$WindDir10 * 10
hmcal_data_renamed_cols

#########################################################################
#########################################################################

# ################## Function
# -----------------------------------------------------------------------
## Function to create week start

hmcal_week_start <- function(data_object, year_start, year_end){

  # arrange weekday start
  data_object <- data_object %>%
    complete(Date = seq(ymd(year_start),
                        ymd(year_end),
                        "day")) %>%
    mutate(weekday = wday(Date, label = T, week_start = 7),
           # week_start - 7, calendar days start Sunday
           month = month(Date, label = T, abbr = F),
           week = epiweek(Date), # epiweek() starts Sunday re: Lubridate
           day = day(Date)) %>%
  mutate(data_object,
         week = case_when(month == "December" & week == 1 ~ 53,
                          month == "January" & week %in% 52:53 ~ 0,
                          TRUE ~ week))
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use hmcal_week_start() to calculate when weekday starts
heat_cal_weeks <- hmcal_week_start(hmcal_data_renamed_cols,
                                    "2022-01-01", "2022-12-31")
heat_cal_weeks

# data_object = hmcal_data_precip

colnames(heat_cal_weeks)

# ################## Function
# -----------------------------------------------------------------------
## Function to create data objects for each weather parameter of concern

hmcal_data_objects <- function(data, var){
  data[, c("Date", var, "weekday", "month", "week", "day")]
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use hmcal_data_objects() to create data objects for weather parameter to chart
hmcal_data_precip <- hmcal_data_objects(heat_cal_weeks, "Precip")
hmcal_data_precip

hmcal_data_tempavg <- hmcal_data_objects(heat_cal_weeks, "TempMeanC")
hmcal_data_tempavg

hmcal_data_tempmax <- hmcal_data_objects(heat_cal_weeks, "TempMaxC")
hmcal_data_tempmax

hmcal_data_tempmin <- hmcal_data_objects(heat_cal_weeks, "TempMinC")
hmcal_data_tempmin

colnames(heat_cal_weeks)

# ################## Function
# -----------------------------------------------------------------------
## Function
# and create 2 new columns:
# categorize precipitation into 14 classes and on the other,
# define a white text color for darker tones in the heatmap.


newcols_precip <- function(dat_obj){

  mutate(dat_obj,
         pcat = cut(Precip, c(-1, 0, .5, 1:5, 7, 9, 15, 20, 25, 30, 300)),
         text_col = ifelse(pcat %in%
                             c("(15,20]", "(20,25]", "(25,30]", "(30,300]"),
                           "white", "black"))
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use newcols_precip
hmcal_data_precip_newcols <- newcols_precip(hmcal_data_precip)
hmcal_data_precip_newcols

####################################################################
####################################################################

# ################## Functions
# -----------------------------------------------------------------------
# newcols_tempavg() to add new column for categories

newcols_tempavg <- function(dat_obj){

  dat_obj <- mutate(dat_obj,
                    week = case_when(month == "December" & week == 1 ~ 53,
                                     month == "January" & week %in% 52:53 ~ 0,
                                     TRUE ~ week),
            pcat = cut(TempMeanC,
                       c(-15, -10, -5, 0, 2, 5, 8, 10, 12, 15, 18, 20, 25, 30)),
            text_col = ifelse(pcat %in%
            c("(-15,-10]","(-10,-5]","(-5,0]", "(20,25]", "(25,30]", "(30,35]"),
          "white", "black"))
}



# ################## Use Function
# -----------------------------------------------------------------------
# Use newcols_precip
hmcal_data_tempavg_newcols <- newcols_tempavg(hmcal_data_tempavg)
hmcal_data_tempavg_newcols


# ################## Use Functions
# -----------------------------------------------------------------------
# use functions to create temp maps

newcols_tempmin <- function(dat_obj){

  dat_obj <- mutate(dat_obj,
                    week = case_when(month == "December" & week == 1 ~ 53,
                                     month == "January" & week %in% 52:53 ~ 0,
                                     TRUE ~ week),
                    pcat = cut(TempMinC,
                      c(-15, -10, -5, 0, 2, 5, 8, 10, 12, 15, 18, 20, 25, 30)),
                    text_col = ifelse(pcat %in% c("(-10,-5]", "(20,25]"),
                                      "white", "black"))
}



# ################## Use Function
# -----------------------------------------------------------------------
# Use newcols_precip
hmcal_data_tempmin_newcols <- newcols_tempmin(hmcal_data_tempmin)
hmcal_data_tempmin_newcols


# ################## Use Functions
# -----------------------------------------------------------------------
# use functions to create temp maps

newcols_tempmax <- function(dat_obj){

  dat_obj <- mutate(dat_obj,
                    week = case_when(month == "December" & week == 1 ~ 53,
                                     month == "January" & week %in% 52:53 ~ 0,
                                     TRUE ~ week),
        pcat = cut(TempMaxC,
                   c(-15, -10, -5, 0, 2, 5, 8, 10, 12, 15, 18, 20, 25, 30)),
        text_col = ifelse(pcat %in%
          c("(-15,-10]","(-10,-5]","(-5,0]", "(20,25]", "(25,30]", "(30,35]"),
                                      "white", "black"))
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use newcols_precip
hmcal_data_tempmax_newcols <- newcols_tempmax(hmcal_data_tempmax)
hmcal_data_tempmax_newcols


# ################## Function
# -----------------------------------------------------------------------
## Function to create and save chart

create_save_chart <- function(data_object, title, subtitle,
                              caption, fill, palette, save_png_lg, save_png_sm){
  ggplot(data_object,
         aes(weekday, -week, fill = pcat))  +
    # -week days of week at bottom
    geom_tile(colour = "white", linewidth = .4)  +
    # Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
    # Please use `linewidth` instead.
    geom_text(aes(label = day, colour = text_col), size = 2.5) +
    guides(fill = guide_colorsteps(barwidth = 25,
                                   barheight = .4,
                                   title.position = "top")) +
    scale_fill_manual(values = c("white", palette(13)),
                      na.value = "grey90", drop = FALSE) +
    scale_colour_manual(values = c("black", "white"), guide = "none") +
    facet_wrap(~ month, nrow = 4, ncol = 3, scales = "free") +
    labs(title = title,
         subtitle = subtitle,
         caption = caption,
         fill = fill) +
    theme_calendar()

  ggsave(save_png_lg, height = 10, width = 8, device = agg_png())
  ggsave(save_png_sm, height = 8, width = 6, device = agg_png())
}

# ################## Use Function
# -----------------------------------------------------------------------
# Use create_chart()
create_save_chart(hmcal_data_precip_newcols,
                  "How was 2022 in Victoria?",
                  "Precipitation", "Data: Env Can", "mm",
                  col_p,
                  "pr_calendar_2022_44.png",
                  "pr_calendar_2022_sm_44.png")
dev.off()


create_save_chart(hmcal_data_tempavg_newcols,
                  "How was 2022 in Victoria?",
                  "Temperature - Average", "Data: Env Can", "C°",
                  col_v,
                  "tavg_calendar_2022_44.png",
                  "tavg_calendar_2022_sm_44.png")
dev.off()


create_save_chart(hmcal_data_tempmax_newcols,
                  "How was 2022 in Victoria?",
                  "Temperature - Maximum", "Data: Env Can", "C°",
                  col_v,
                  "tmax_calendar_2022_44.png",
                  "tmax_calendar_2022_sm_44.png")
dev.off()

create_save_chart(hmcal_data_tempmin_newcols,
                  "How was 2022 in Victoria?",
                  "Temperature - Minimum", "Data: Env Can", "C°",
                  col_v,
                  "tmin_calendar_2022_44.png",
                  "tmin_calendar_2022_sm_44.png")
dev.off()

