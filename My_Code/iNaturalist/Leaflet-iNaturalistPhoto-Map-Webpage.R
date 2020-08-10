
library("rinat")
library("lubridate") # for dates

dir <- "/Users/wendyanthony/Documents/R/inaturalist"
setwd(dir)
getwd()

# get user stats
wa_inat_userstats <- get_inat_obs_user("wendy_anthony", maxresults = "3000")
wa_inat_userstats_research <- wa_inat_userstats[which(wa_inat_userstats$quality_grade == "research" ),] #Extract just research grade observations

# WORKS 
# 1. create new column with date format year
wa_inat_userstats$year <- as.Date(wa_inat_userstats$observed_on_string, format = "%y-%b-%d") 
str(wa_inat_userstats) # Date
wa_inat_userstats_research$year <- as.Date(wa_inat_userstats_research$observed_on_string, format = "%y-%b-%d") 
str(wa_inat_userstats_research) # Date

# 2, change new column with year from column y/m/d
wa_inat_userstats$year <- year(wa_inat_userstats$observed_on) 
wa_inat_userstats_research$year <- year(wa_inat_userstats_research$observed_on) 
class(wa_inat_userstats$year) # Date
str(wa_inat_userstats_research)
class(wa_inat_userstats_research) # [1] "data.frame"

# 1. create new column with date format month
wa_inat_userstats$months <- as.Date(wa_inat_userstats$observed_on_string, format = "%y-%b-%d") 
str(wa_inat_userstats) # Date
wa_inat_userstats_research$months <- as.Date(wa_inat_userstats_research$observed_on_string, format = "%y-%b-%d") 
str(wa_inat_userstats_research) # Date
str(wa_inat_userstats) # Date

# 2, change new column with year from column y/m/d
wa_inat_userstats$months <- month(wa_inat_userstats$observed_on) 
wa_inat_userstats_research$months <- month(wa_inat_userstats_research$observed_on) 
class(wa_inat_userstats$month) # Date
class(wa_inat_userstats_research$month)
str(wa_inat_userstats_research)
class(wa_inat_userstats_research) # [1] "data.frame"


# create new columns by copying other column data
wa_inat_userstats_research$scientific_name_test <- wa_inat_userstats_research$scientific_name

names(wa_inat_userstats_research)
str(wa_inat_userstats_research)

# remove columns
# wa_inat_userstats_research <- subset(wa_inat_userstats_research, select = -c(Genus, species, ssp))


# YEAH WORKS
# creates a dataframe out of a stringsplit list of different lengths
# https://stackoverflow.com/questions/15201305/how-to-convert-a-list-consisting-of-vector-of-different-lengths-to-a-usable-data

# separate column into a list object
out <- strsplit(as.character(wa_inat_userstats_research$scientific_name),' ') 
scnamlist <- do.call(rbind, out)
class(out)

out2 <- plyr::ldply(out, rbind)
class(out2) # [1] "data.frame"
str(out2) # factors

# rename new columns
setnames(out2, old = c('1','2', '3'), new = c('Genus','species', 'ssp'))

# append dataframes
nrow(out2) #1243
nrow(wa_inat_userstats_research) #1243
wa_inat_userstats_research_append <- cbind(wa_inat_userstats_research, out2)

wa_inat_userstats_research_append

write.csv(wa_inat_userstats_research_append, "wendy_anthony_inat_research_obs_clean.csv", row.names = FALSE)



library(leaflet)
library(mapview)


map <- leaflet(height="800px", width = "100%") %>%
  setView(lng = -124.953,
          lat = 49.04664,
          zoom = 8) %>% 
  addTiles(group = "OSM (default)") %>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  addProviderTiles(providers$Stamen.TerrainBackground, group = "Terrain") %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World") %>%
  
  
  #      addProviderTiles("Esri.WorldImagery") %>% 
  #     addProviderTiles(maptypes[1]) %>% # chose other basemap by number
  addMarkers(lat = wa_inat_userstats_research_append$latitude, 
             lng = wa_inat_userstats_research_append$longitude,
             clusterOptions = markerClusterOptions(),
             #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
             popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  wa_inat_userstats_research_append$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", wa_inat_userstats_research_append$common_name, "<br>", "<b>", "Place:", "</b>", wa_inat_userstats_research_append$place_guess, "<br>", "<b>", "Image Link:", "</b>", "<a href='", wa_inat_userstats_research_append$image_url, "<b>",  "'>Image</a>", "<br>", "<img src='", wa_inat_userstats_research_append$image_url, "'width='200px' />", "<br>", "<b>", "Taxon:", "</b>", wa_inat_userstats_research_append$iconic_taxon_name, "<br>", "<b>", "Observation Date:", "</b>", wa_inat_userstats_research_append$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", wa_inat_userstats_research_append$user_login )) %>%
  addLayersControl(
    baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Terrain", "ESRI World"),
    options = layersControlOptions(collapsed = TRUE)
  )
map

# export as html file
library(htmlwidgets)
saveWidget(map, file="/Users/wendyanthony/Documents/R/iNaturalist/My-iNaturalist.html")
