##########################################
# Shiny leaflet app for iNaturalist obs
# 2020-10-13  >> 
# 2021-01-25 << fixed spider cluster zoom
# 2021-06-03 >> madrone
##########################################

library("shiny")
library("leaflet")
library("rinat")
library("lubridate") # for dates
library("dplyr") # for mutate
library("data.table")

# getwd()
# setwd("iNaturalist-madrone-shiny-leaflet-app")


# dir <- "/Users/wendyanthony/Documents/R/iNaturalist-shiny-leaflet-app"
# setwd(dir)
# getwd()


# iNat_ARME <- get_inat_obs(
#   taxon_name = "51046-Arbutus-menziesii", 
#   year = 2020,
#   maxresults = 300
# )
# 
# # 10000 max maxresults
# iNat_ARME_query_10000 <- get_inat_obs(
#   query = "Arbutus menziesii", 
#   maxresults = 10000
# )
# 
# iNat_ARME_id_query <- get_inat_obs(
#   taxon_id = 51046,
#   maxresults = 3000
# )
# 
# n_bounds <- c(48.38362, -134.0332, 56.13178, -120.10254)
# iNat_ARME_n_bounds <- get_inat_obs(
#   query = "Arbutus menziesii", 
#   bounds = n_bounds,
#   maxresults = 10000   #3743 actual
# )

### use this one >>> more observations
n_bounds_2 <- c(46.8968, -134.36279, 55.25956, -117.33398)
iNat_ARME_n_bounds_2 <- get_inat_obs(
  query = "Arbutus menziesii", 
  bounds = n_bounds_2,
  maxresults = 10000   #5292 actual
)

s_bounds <- c(40.37166, -125.68359, 48.2082, -106.17187)
iNat_ARME_s_bounds <- get_inat_obs(
  query = "Arbutus menziesii",
  bounds = s_bounds,
  maxresults = 10000 #2530 actual
)

# Bounds
# southern latitude, western longitude, northern latitude, and eastern longitude.

# n_bounds_2
# 46.8968, -134.36279, 55.25956, -117.33398
#NW 55.25956, -134.36279
#SW 46.8968, -134.07715
#SE 47.36022, -117.33398

# southern latitude, western longitude, northern latitude, and eastern longitude.
# s_bounds
# 40.37166, -125.68359, 48.2082, -106.17187
# NW 48.2082, -125.68359
# NE 48.17891, -120.10254
# SW 40.37166, -121.99219
# SE 41.69753, -106.17187

#################
# iNat_ARME_query_10000
# iNat_ARME_n_bounds
# iNat_ARME_n_bounds_2
# View(iNat_ARME_n_bounds_2)
# iNat_ARME_s_bounds
#################

maptypes <- c("Stamen.TerrainBackground",
              "Esri.WorldImagery",
              "OpenStreetMap",
              "Stamen.Watercolor")

### ---------------------------------------
# shiny app
ui <- fluidPage(
  titlePanel("ARME iNaturalist Observations"),
  tags$br(),
  tags$p("Click marker clusters to find individual observations"),
  tags$br(),
  
  mainPanel(
    tabsetPanel(
      tabPanel("iNaturalist ARME Leaflet Map Viz North", leafletOutput("mymap_n")),
      tabPanel("iNaturalist ARME Leaflet Map Viz South", leafletOutput("mymap_s")),
      tabPanel("About", tableOutput("text"))
    )
  )
)  

server <- function(input, output, session) {
  output$mymap_n <- renderLeaflet({
    # leaflet map with popup of many characters & image link
    map <- leaflet(height="3800px", width = "100%") %>%
      setView(lng = -125.52,  # 49.54782, -125.5188
              lat = 49.54,
              zoom = 5) %>% 
      addTiles(group = "OSM (default)",
               options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      
      
      #      addProviderTiles("Esri.WorldImagery") %>% 
      #     addProviderTiles(maptypes[1]) %>% # chose other basemap by number
      addMarkers(lat = iNat_ARME_n_bounds_2$latitude, 
                 lng = iNat_ARME_n_bounds_2$longitude,
                 clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                 #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                 popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_n_bounds_2$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_n_bounds_2$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_n_bounds_2$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_n_bounds_2$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_n_bounds_2$image_url, "'width='200px' />", "<br>", "<b>", "Taxon:", "</b>", iNat_ARME_n_bounds_2$iconic_taxon_name, "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_n_bounds_2$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_n_bounds_2$user_login )) %>%
      addLayersControl(
        baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Nat Geo", "ESRI World"),
        options = layersControlOptions(collapsed = TRUE)
      )
  })
  
  output$mymap_s <- renderLeaflet({
    # leaflet map with popup of many characters & image link
    map <- leaflet(height="3800px", width = "100%") %>%
      setView(lng = -125.52,  # 49.54782, -125.5188
              lat = 49.54,
              zoom = 5) %>% 
      addTiles(group = "OSM (default)",
               options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                       options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
      
      
      #      addProviderTiles("Esri.WorldImagery") %>% 
      #     addProviderTiles(maptypes[1]) %>% # chose other basemap by number
      addMarkers(lat = iNat_ARME_s_bounds$latitude, 
                 lng = iNat_ARME_s_bounds$longitude,
                 clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                 #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                 popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_s_bounds$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_s_bounds$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_s_bounds$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_s_bounds$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_s_bounds$image_url, "'width='200px' />", "<br>", "<b>", "Taxon:", "</b>", iNat_ARME_s_bounds$iconic_taxon_name, "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_s_bounds$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_s_bounds$user_login )) %>%
      addLayersControl(
        baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Nat Geo", "ESRI World"),
        options = layersControlOptions(collapsed = TRUE)
      )
  })
  
  output$text <- renderUI({
    str1 <- tags$h2("iNaturalist observation Visualization")
    str2 <- paste("iNaturalists observations of Arbutus menziesii")
    str3 <- tags$h2("About these observations")
    str4 <- paste("These are the 'research-grade' observations that have been verified by at least one other naturalist @ iNaturalist")
    str5 <- tags$a(href="https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/app.R", "Shiny app Code")
    str6 <- tags$a(href="https://www.inaturalist.org/observations?locale=en&subview=map&taxon_id=51046", "iNaturalist Observations")
    str7 <- paste("Created by Wendy Anthony 2020-01-13, updated 2021-06-03 (fixed spider cluster max zoom)")
    HTML(paste(str1, str2, str3, str4, str5, str6, str7, sep = "<br /><br />"))
  })
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny  
}


shinyApp(ui, server)
