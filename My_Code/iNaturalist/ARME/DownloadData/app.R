#############################################
#############################################
# Shiny leaflet app for iNaturalist obs
# coded by Wendy Anthony
# Arbutus menziesii
# 2020-10-13  >> created first iNat app
# 2021-01-25 << fixed spider cluster zoom
# 2021-06-07 @12:49
# >> multiple tabs: North, South, Research, 10,000
### Add download button to .csv file

### Read-Me
#' Research-grade iNaturalist ARME observations in an interactive leaflet map Shiny app
#' 
#' To get the Shiny app to work on your local computer in RStudio:
#'   
#'   * Download app.R
#' * Open in RStudio
#' 
#' * I'm sorry to say that this app doesn't seem to always play nice with the 'Run App' button ... so ...
#' 
#' * Go through each code line to install libraries and download data separately
#' i.e. place cursor at beginning of line library("Shiny") and press keys Command+Enter (Mac) - probably Control+Enter(Win)
#' 
#' * at beginning of Shiny App section, highlight this whole section and press keys Command+Enter (Mac) - probably Control+Enter(Win)
#' 
#' >>> the Shiny app should open in a separate popup window
#' 
#' >>> to open Shiny app in browser, click button "Open in Browser" 
#' 
#' @ 2021-06-04 16:53 PDT

#############################################
#############################################

#############################################
### install / load required packages

## to install packages: un-comment, then => # re-comment
# install.packages("shiny")
# install.packages("leaflet")
# install.packages("rinat")

library("shiny")
library("leaflet")
library("rinat")

#############################################
# check working directory for saving csv files
# getwd()

#############################################
#############################################
### Get data from iNaturalist using rinat

#############################################
### search queary
### 10000 max maxresults

iNat_ARME <- get_inat_obs(
  taxon_id = 51046,
  maxresults = 10000
)

#############################################
### Filter for Research Grade Results

iNat_ARME_research <- iNat_ARME[which(iNat_ARME$quality_grade == "research" ),] 

#############################################
### Filter for Casual Results

iNat_ARME_casual <- iNat_ARME[which(iNat_ARME$quality_grade == "casual" ),] 

#############################################
### Filter for needs id Results

iNat_ARME_needs_id <- iNat_ARME[which(iNat_ARME$quality_grade == "needs_id" ),] 

#############################################

#############################################
### write csv files to working directory

# write.csv(iNat_ARME_research, "iNat_ARME_research.csv", row.names = FALSE)
# write.csv(iNat_ARME, "iNat_ARME.csv", row.names = FALSE)

#############################################
### info about data

# str(iNat_ARME_research) # data type
# class(iNat_ARME_research) # data frame
# View(iNat_ARME_research) # view spreadsheet

#############################################
### search by taxon_name and year

# iNat_ARME <- get_inat_obs(
#   taxon_name = "51046-Arbutus-menziesii", 
#   year = 2020,
#   maxresults = 300
# )

#############################################
### search by taxon_id

# iNat_ARME_id_query <- get_inat_obs(
#   taxon_id = 51046,
#   maxresults = 3000
# )

#############################################
### Search by lat long Bounds
#############################################
### Filter by lat long bounds: North >>> ++ results
### *** use this one >>> more observations ***

n_bounds_2 <- c(46.8968, -134.36279, 55.25956, -117.33398)
iNat_ARME_n_bounds_2 <- get_inat_obs(
  query = "Arbutus menziesii",
  bounds = n_bounds_2,
  maxresults = 10000   #5292 actual
)

#############################################
### Filter by lat long bounds: North

# n_bounds <- c(48.38362, -134.0332, 56.13178, -120.10254)
# iNat_ARME_n_bounds <- get_inat_obs(
#   query = "Arbutus menziesii", 
#   bounds = n_bounds,
#   maxresults = 10000   #3743 actual
# )

#############################################
### Filter by lat long bounds: South
s_bounds_2 <- c(32.74801, -124.67834, 49.21558, -108.67676)
iNat_ARME_s_bounds_2 <- get_inat_obs(
  query = "Arbutus menziesii",
  bounds = s_bounds_2,
  maxresults = 10000 #2530 actual
)

### these diff bounds create same resulting number
# s_bounds <- c(40.37166, -125.68359, 48.2082, -106.17187)
# iNat_ARME_s_bounds <- get_inat_obs(
#   query = "Arbutus menziesii",
#   bounds = s_bounds,
#   maxresults = 10000 #2530 actual
# )

#############################################
### Bounds
#############################################
### Filter by lat long bounds: North
## order of bounds for code
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

# southern latitude, western longitude, northern latitude, and eastern longitude.
# s_bounds_2
# 32.74801, -124.67834, 49.21558, -108.67676
#SW 32.74801, -124.7168
#NW 48.1457, -124.67834
#NE 49.21558, -120.6189
#SE 34.61287, -108.67676

#############################################
#############################################
### data objects created in this app

# iNat_ARME_query_10000
# iNat_ARME_n_bounds
# iNat_ARME_n_bounds_2
# View(iNat_ARME_n_bounds_2)
# iNat_ARME_s_bounds

#############################################
### ARME projec
iNat_ARME_proj <- get_inat_obs_project("arbutus-arme-pacific-madrone", type = c("observations", "info"), raw = TRUE)
# Warning: Error in validateCoords: addMarkers requires numeric longitude/latitude values
# need to change latitude and longitude from character to number
iNat_ARME_proj$latitude <- as.numeric(iNat_ARME_proj$latitude)
iNat_ARME_proj$longitude <- as.numeric(iNat_ARME_proj$longitude)
# str(iNat_ARME_proj$latitude) # data type: character > num
# str(iNat_ARME_proj$longitude) # data type: character > num
# View(iNat_ARME_proj)
#############################################

# write.csv(iNat_ARME_research, "iNat_ARME_research.csv", row.names = FALSE)
# write.csv(iNat_ARME_research_n_bounds_3, "iNat_ARME_research_n_bounds_3.csv", row.names = FALSE)
# write.csv(iNat_ARME_proj, "iNat_ARME_proj.csv", row.names = FALSE)

#############################################
#############################################
### Shiny app, using data objects created
#############################################

  ### ---------------------------------------
  # shiny app
  ui <- fluidPage(
    titlePanel("iNaturalist Observations: Arbutus menziesii"),
    #tags$br(),
    tags$p("Click marker clusters to find individual observations"),
    #tags$br(),
    
    downloadButton("downloadData", "Download data"),
    tags$br(),
    tags$br(),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Research-Grade", leafletOutput("mymap_r")),
        tabPanel("North", leafletOutput("mymap_n")),
        tabPanel("South", leafletOutput("mymap_s_2")),
        tabPanel("ARME Project", leafletOutput("mymap_proj")),    
        tabPanel("Needs ID", leafletOutput("mymap_needs_id")),
        tabPanel("Casual", leafletOutput("mymap_casual")),        
        tabPanel("About", tableOutput("text"))
      )
    )
  )  
  
  server <- function(input, output, session) {
    # Our dataset
    data <- iNat_ARME
    
    output$downloadData <- downloadHandler(
      filename = function() {
        paste("ARME_inat_data_", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(data, file)
      })
    
    output$mymap_r <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="3800px", width = "100%") %>%
        setView(lng = -118.34,  # 47.61912, -118.34473
                lat = 47.61,
                zoom = 4) %>% 
        addTiles(group = "OSM (default)",
                 options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addMarkers(lat = iNat_ARME_research$latitude, 
                   lng = iNat_ARME_research$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_research$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_research$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_research$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_research$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_research$image_url, "'width='200px' />", "<br>", "<b>", "Taxon:", "</b>", iNat_ARME_research$iconic_taxon_name, "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_research$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_research$user_login )) %>%
        addLayersControl(
  #        baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Nat Geo", "ESRI World"),
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })
    
    ##############
    ## 10000 observations - max
    # output$mymap <- renderLeaflet({
    #   # leaflet map with popup of many characters & image link
    #   map <- leaflet(height="3800px", width = "100%") %>%
    #     setView(lng = -118.34,  # 47.61912, -118.34473
    #             lat = 47.61,
    #             zoom = 4) %>% 
    #     addTiles(group = "OSM (default)",
    #              options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
    #     addProviderTiles(providers$Stamen.Toner, group = "Toner",
    #                      options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
    #     addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite",
    #                      options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
    #     addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
    #                      options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
    #     addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
    #                      options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
    #     addMarkers(lat = iNat_ARME$latitude, 
    #                lng = iNat_ARME$longitude,
    #                clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
    #                #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
    #                popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME$image_url, "'width='200px' />", "<br>", "<b>", "Taxon:", "</b>", iNat_ARME$iconic_taxon_name, "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME$user_login )) %>%
    #     addLayersControl(
    #       baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Nat Geo", "ESRI World"),
    #       options = layersControlOptions(collapsed = TRUE)
    #     )
    # })
    
    ##############
    ## map of northern bounds
      output$mymap_n <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="3800px", width = "100%") %>%
        setView(lng = -124.98,  # 54.17369, -125.15625  53.73409, -124.98047  53.9674, -124.98047)
                lat = 51.56,
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
 
    output$mymap_s_2 <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="3800px", width = "100%") %>%
        setView(lng = -118.89,  # 46.81322, -118.16895
                lat = 46.73,
                zoom = 4) %>%
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
        addMarkers(lat = iNat_ARME_s_bounds_2$latitude,
                   lng = iNat_ARME_s_bounds_2$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_s_bounds_2$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_s_bounds_2$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_s_bounds_2$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_s_bounds_2$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_s_bounds_2$image_url, "'width='200px' />", "<br>", "<b>", "<b>", "Observation Date:", "</b>", iNat_ARME_s_bounds_2$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_s_bounds_2$user_login )) %>%
        addLayersControl(
          baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })
    
    ##############
    ## needs_id observations - max
    output$mymap_needs_id <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="3800px", width = "100%") %>%
        setView(lng = -117.20,  # 46.29951, -117.20215
                lat = 46.30,
                zoom = 4) %>% 
        addTiles(group = "OSM (default)",
                 options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addMarkers(lat = iNat_ARME_needs_id$latitude,
                   lng = iNat_ARME_needs_id$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_needs_id$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_needs_id$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_needs_id$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_needs_id$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_needs_id$image_url, "'width='200px' />", "<br>", "<b>", "Description:", "</b>", iNat_ARME_casual$description, "<br><br>", "<b>", "Observation Date:", "</b>", iNat_ARME_needs_id$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_needs_id$user_login )) %>%
        addLayersControl(
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })
    
    ##############
    ## casual observations - max
    output$mymap_casual <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="3800px", width = "100%") %>%
        setView(lng = -117.20,  # 46.29951, -117.20215
                lat = 46.30,
                zoom = 4) %>% 
        addTiles(group = "OSM (default)",
                 options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addMarkers(lat = iNat_ARME_casual$latitude,
                   lng = iNat_ARME_casual$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_casual$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_casual$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_casual$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_casual$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_casual$image_url, "'width='200px' />", "<br>", "<b>", "Description:", "</b>", iNat_ARME_casual$description, "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_casual$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_casual$user_login )) %>%
        addLayersControl(
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })
    
    ##############
    ## ARME Project
    output$mymap_proj <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="3800px", width = "100%") %>%
        setView(lng = -122.01,  # 53.13194, -122.91504  
                lat = 49.51,
                zoom = 5) %>% 
        addTiles(group = "OSM (default)",
                 options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addMarkers(lat = iNat_ARME_proj$latitude,
                   lng = iNat_ARME_proj$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  "Arbutus menziesii", "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_proj$species_guess, "<br>", "<b>", "Place:", "</b>", iNat_ARME_proj$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_proj$uri, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_proj$image_url, "'width='200px' />", "<br>", "<b>", "Description:", "</b>", iNat_ARME_proj$description, "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_proj$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_proj$user_login )) %>%
        addLayersControl(
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })    
    
    output$text <- renderUI({
      str1 <- tags$h3("Leaflet Map Visualization")
      str2 <- tags$p("iNaturalist research-grade observations of the Northern range of Arbutus menziesii (ARME), visualized using interactive Leaflet map")
      str3 <- tags$h4("About these observations")
      str4 <- tags$p("NOTE: ARME Project observations are not showing the imageURL or any observations fields.")
      str5 <- tags$h4("About this app")
      str6 <- paste("Created in RStudio using Shiny, Leaflet and rinat packages. Coding by Wendy Anthony 2021-06-05<br />")
      str7 <- tags$h4("Relevant Links")
      str8 <- tags$a(href="https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/iNaturalist/ARME/Shiny", "Shiny app Code")
      str9 <- tags$a(href="https://www.inaturalist.org/observations?locale=en&subview=map&taxon_id=51046", "iNaturalist Observations")
      str10 <- tags$a(href="https://www.arbutusarme.org/home", "Arubutus website home")
      str11 <- tags$a(href="https://treesnap.org/map/?center=47.66351640199509,-121.52321502871439&zoom=8", "Treesnap Observations")
      str12 <- tags$a(href="https://www.inaturalist.org/projects/arbutus-arme-pacific-madrone", "ARME iNaturalist Project")
      HTML(paste(str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, str11, str12, sep = "<br />"))
    })
    ### text output code idea from https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny  
  }
  
  shinyApp(ui, server)
