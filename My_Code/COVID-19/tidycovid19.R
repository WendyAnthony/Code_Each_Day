# https://joachim-gassen.github.io/2020/05/tidycovid19-new-data-and-doc/
# https://github.com/joachim-gassen/tidycovid19
# https://github.com/joachim-gassen/tidycovid19/blob/master/example_code.R

# remotes::install_github("joachim-gassen/tidycovid19", force = TRUE)
# because I chose not to update any of the suggested packages, it didn't install, nor would it reinstall
# Skipping install of 'tidycovid19' from a github remote, the SHA1 (a06ac1cc) has not changed since last install. Use `force = TRUE` to force installation

library(tidycovid19)
library(tidyverse)
library(ggrepel)
library(gghighlight)
library(zoo)

library(knitr)
library(kableExtra)

# merges data from 9 sources: 
# 1. Covid-19 data from the Johns Hopkins University CSSE Github Repo.
# 2. Covid-19 case data provided by the European Centre for Disease Prevention and Control. 
# 3. Testing data collected by the ‘Our World in Data’ team. 
# 4. Government measures dataset provided by the Assessment Capacities Project (ACAPS).
# 5. Oxford Covid-19 Government Response Tracker
# 6. Mobility Trends Reports provided by Apple 
# 7. Google COVID-19 Community Mobility Reports 
# 8. Google Trends 
# 9. Country level information provided by the World Bank
# "provides a country-day data frame pulling together data from various sources"

# merged <- download_merged_data(silent = TRUE, cached = TRUE)  # silent = TRUE stops show data download functions 
# merged # creates A tibble:  21,928 x 35
merged <- download_merged_data(silent = TRUE, cached = TRUE)

# merged_table <- download_merged_data(silent = TRUE, cached = TRUE) %>%
#   knitr::kable() %>% 
#   kableExtra::kable_styling()
# doesn't seem to save properly - or takes a very long time
# %>%
# kableExtra::save_kable("merged_Mar13toMay13.html")

merged


# create an html table for variable definition dictionary for merged data
tidycofid19_data_def <- tidycovid19_variable_definitions %>%
  select(var_name, var_def) %>%
  knitr::kable() %>% 
  kableExtra::kable_styling()

tidycofid19_data_def


## ----------------------------------
# Visualization Functions
daily_death_change <- plot_covid19_spread(
  merged, type = "deaths", min_cases = 1000, edate_cutoff = 60, cumulative = FALSE, change_ave = 7, highlight = c("USA", "ESP", "ITA", "FRA", "GBR", "DEU", "BRA", "RUS", "TUR"))

png("daily_death_change.png")
daily_death_change
dev.off()

##---------------------------------------------
# create a shiny widget to customize the variables
shiny_covid19_spread()

##---------------------------------------
# veridis stripes
death_stripes <- plot_covid19_stripes(merged, type = "deaths", min_cases = 1000)
# FALSE daily changes
death_stripes

# new cases per day
death_stripes_percap <- plot_covid19_stripes(
  per_capita = TRUE, 
  population_cutoff = TRUE, 
  sort_countries = "magnitude"
)
death_stripes_percap

# to compare specific countries 
death_stripe_country <- plot_covid19_stripes(
  type = "confirmed", 
  countries = c("ITA", "ESP", "FRA", "GBR", "DEU", "USA"),
  sort_countries = "countries"
)
death_stripe_country

png("death_stripes_2020_05_13.png")
death_stripes
dev.off()

##---------------------------------------
# a map with a wierd projection 
# default world
# death_map <- map_covid19(merged)
death_map_NA <- map_covid19(merged, region = 'North America', per_capita = TRUE, date = "2020-05-12")
death_map_NA

death_map_Europe <- map_covid19(merged, type = "confirmed", region = "Europe") 
death_map_Europe

png("death_map_NA_percapita_2020_05_12.png")
death_map_NA
dev.off()

## ------------- DOESN"T WORK ????
# animation - may take awhile 7:25:25
# A vector of dates found. Will create animation. This will take a while...
# anim <- map_covid19(merged, per_capita = T, dates = unique(merged$date))
# Error in transform_polygon(all_frames, states[[i]], ease, nframes[i],  : transformr is required to tween polygons
# crashes
# anim <- map_covid19(merged, type = "confirmed", dates = unique(merged$date))


## -------------------------------
# ACAPS data
#  a quick impression on governmental restrictions are implemented and lifted over time.
acaps <- download_acaps_npi_data(cached = TRUE, silent = TRUE)

df <- acaps %>%
  rename(date = date_implemented) %>%
  mutate(nobs = 1*(log_type == "Introduction / extension of measures") -
           1*(log_type != "Introduction / extension of measures")) %>%
  select(iso3c, date, log_type, category, nobs) %>%
  filter(date <= "2020-05-13")
df

restrictions <- ggplot(df, aes(x = date, fill = category, weight = nobs)) +
  geom_histogram(data = df %>% filter(log_type == "Introduction / extension of measures"),
                 position = "stack", binwidth = 24*3600*7) +
  geom_histogram(data = df %>% filter(log_type != "Introduction / extension of measures"),
                 position = "stack", binwidth = 24*3600*7) +
  theme_minimal() +
  labs(title = "Implementation and Lifting of Interventions over Calendar Time 2020",
       x = NULL,
       y = "Number of interventions",
       fill = "Intervention") +
  theme(legend.position = c(0.25, 0.8),
        legend.background = element_rect(fill = "white", color = NA),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 7))

png("restrictions_2020_05-13.png")
restrictions
dev.off()

## -------------------------
# Association between testing and deaths
# "Is there an association between testing during the fist 30 days of the spread and the amount of deaths that a country observes?"
early_tests <- merged %>%
  group_by(iso3c) %>%
  filter(population > 10e6) %>%
  filter(confirmed > 0) %>%
  filter(!all(is.na(total_tests))) %>%
  mutate(total_tests = na.approx(c(0, total_tests), rule = 2)[-1]) %>%
  filter(date - min(date) < 30) %>%
  summarise(early_tests = unique(1e5*max(total_tests, na.rm = TRUE)/population)) %>%
  filter(!is.na(early_tests))

deaths <- merged %>%  
  group_by(iso3c) %>%
  filter(deaths > 1000) %>%
  filter(population > 10e6) %>%
  summarise(deaths = unique(1e5*max(deaths, na.rm = TRUE)/population)) 

deaths_tests <- deaths %>% left_join(early_tests, by = "iso3c") %>%
  filter(!is.na(early_tests)) %>%
  ggplot(aes(x = early_tests, y = deaths)) + 
  geom_point() +
  theme_minimal() + 
  geom_label_repel(aes(label = iso3c)) +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    x = "Tests within the first 30 days by 100,000 inhabitants (interpolated)",
    y = "Deaths per 100,000 inhabitants",
    caption = "Case data: JHU CSSE, Test data: Our World in Data."
  )

png("deaths_tests.png")
deaths_tests
dev.off()

## ------------------------
# Google data
# Regional variance in individual behavior
gcmr <- download_google_cmr_data(type = "country_region", cached = TRUE, silent = TRUE)

east_regions <- c("Berlin", "Brandenburg", "Mecklenburg-Vorpommern", "Saxony", "Saxony-Anhalt", "Thuringia")

df_1 <- gcmr %>% 
  filter(iso3c == "DEU") %>%
  mutate(east = ifelse(region %in% east_regions, "East Germany", "West Germany")) %>%
  select(-iso3c, -region, -timestamp) %>%
  group_by(date, east) %>%
  summarise_all(mean)

shopping_changes <- ggplot(df_1, aes(x = date, y = retail_recreation, color = east)) +
  geom_line() +
  theme_minimal() +
  labs(
    x = NULL,
    y = "Percentage change of visits in retail shopping\nand recreational areas",
    caption = "Movement data: Google CMR."
  ) + 
  gghighlight(TRUE, label_key = east)

png("shopping_changes_Germany_East_West.png")
shopping_changes
dev.off()

## ----------------------------
# same using Apple data
amtr <- download_apple_mtr_data(type = "country_region", cached = TRUE, silent = TRUE)

east_regions <- c("Brandenburg", "Mecklenburg-Vorpommern",
                  "Saxony", "Saxony-Anhalt", "Thuringia")

df <- amtr %>% 
  filter(iso3c == "DEU") %>%
  mutate(east = ifelse(region %in% east_regions, "East Germany", "West Germany")) %>%
  select(-iso3c, -region, -timestamp) %>%
  group_by(date, east) %>%
  summarise_all(mean)

ggplot(df, aes(x = date, y = driving, color = east)) +
  geom_line() +
  theme_minimal() +
  labs(
    x = NULL,
    y = "Percentage change of Apple Map requests\nfor driving directions",
    caption = "Movement data: Apple MTR."
  ) + 
  gghighlight(TRUE, label_key = east)


##-------------------------------
# Compare Apple Mobility Trend Reports across major European cities For driving directions:
amtr <- download_apple_mtr_data(type = "country_city", cached = TRUE, silent = TRUE)

cities <- c("Berlin", "London", "Madrid", 
            "Paris", "Rome", "Stockholm")

df <- amtr %>% 
  filter(city %in% cities) %>%
  select(-iso3c, -timestamp) %>%
  group_by(date, city) %>%
  summarise_all(mean)

ggplot(df, aes(x = date, y = driving, color = city)) +
  geom_line() +
  theme_minimal() +
  labs(
    x = NULL,
    y = "Percentage change of Apple Map\nrequests for driving directions",
    caption = "Movement data: Apple MTR."
  ) + 
  gghighlight(TRUE, label_key = city)

##-------------------------------------
# And for public transport directions:

ggplot(df, aes(x = date, y = transit, color = city)) +
  geom_line() +
  theme_minimal() +
  labs(
    x = NULL,
    y = "Percentage change of Apple Map requests\nfor public transport directions",
    caption = "Movement data: Apple MTR."
  ) + 
  gghighlight(TRUE, label_key = city)


##------------------------------
# https://github.com/joachim-gassen/tidycovid19
# 
df_merged <- download_merged_data(cached = TRUE, silent = TRUE)

df_merged %>%
  filter(iso3c == "ITA") %>%
  mutate(
    new_cases = confirmed - lag(confirmed),
    ave_new_cases = rollmean(new_cases, 7, na.pad=TRUE, align="right")
  ) %>%
  filter(!is.na(new_cases), !is.na(ave_new_cases)) %>%
  ggplot(aes(x = date)) +
  geom_bar(aes(y = new_cases), stat = "identity", fill = "lightblue") +
  geom_line(aes(y = ave_new_cases), color ="red") +
  theme_minimal()


##-----------------
# https://github.com/joachim-gassen/tidycovid19
# First 60 days reported deaths
plot_covid19_spread(
  merged, highlight = c("ITA", "ESP", "GBR", "FRA", "DEU", "USA"),
  intervention = "lockdown", edate_cutoff = 60
)

##-----------------
# 