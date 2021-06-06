#############################################
#############################################
# Shiny leaflet app for iNaturalist obs
# coded by Wendy Anthony
# Arbutus menziesii
# 2020-10-13  >> created first iNat app
# 2021-01-25 << fixed spider cluster zoom
# 2021-06-05 >> try with less max to 
# "    "     >> Shiny publish
# >>> add casual/needs ID >> works @15:03
# try to add ARME project >> project doesn't include image??


### Read-Me
#' Research-grade iNaturalist ARME observations in an interactive leaflet map Shiny app
#' To get the Shiny app to work on your local computer in RStudio:
#' * Download app.R
#' * Open in RStudio
#' 
#' * I'm sorry to say that this app doesn't seem to always play nice with the 'Run App' button ... so ...
#' 
#' * highlight the whole file code and press keys Command+Enter (Mac) - probably Control+Enter(Win)
#' 
#' * NOTE: downloading 10,000 observations from iNaturalist will take a few minutes
#' 
#' >>> the Shiny app should open in a separate popup window
#' 
#' >>> to open Shiny app in browser, click button "Open in Browser" 
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

### Search by lat long Bounds
#############################################
### Filter by lat long bounds: North >>> ++ results
### *** use this one >>> more observations ***

n_bounds_3 <- c(46.8968, -134.36279, 55.25956, -117.33398)
iNat_ARME_n_bounds_3 <- get_inat_obs(
  query = "Arbutus menziesii",
  bounds = n_bounds_3,
  maxresults = 6000   #5292 actual  #5300 worked to publish
)
#############################################
### Filter for Research Grade Results

iNat_ARME_research_n_bounds_3 <- iNat_ARME_n_bounds_3[which(iNat_ARME_n_bounds_3$quality_grade == "research" ),] 

#############################################
### Filter for Casual Results

iNat_ARME_casual_n_bounds_3 <- iNat_ARME_n_bounds_3[which(iNat_ARME_n_bounds_3$quality_grade == "casual" ),] 

#############################################
### Filter for needs id Results

iNat_ARME_needs_id_n_bounds_3 <- iNat_ARME_n_bounds_3[which(iNat_ARME_n_bounds_3$quality_grade == "needs_id" ),] 

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
### write csv files to working directory

# write.csv(iNat_ARME_research, "iNat_ARME_research.csv", row.names = FALSE)
# write.csv(iNat_ARME_research_n_bounds_3, "iNat_ARME_research_n_bounds_3.csv", row.names = FALSE)
# write.csv(iNat_ARME_proj, "iNat_ARME_proj.csv", row.names = FALSE)

#############################################
### info about data

# str(iNat_ARME_research_n_bounds_3) # data type
# class(iNat_ARME_research_n_bounds_3) # data frame
# View(iNat_ARME_research_n_bounds_3) # view spreadsheet
# str(iNat_ARME_proj$latitude) # data type: character
# str(iNat_ARME_research_n_bounds_3$latitude) # data type: number

#############################################
#############################################
### Shiny app, using data objects created
#############################################

  ### ---------------------------------------
  # shiny app
  ui <- fluidPage(
    titlePanel("iNaturalist Observations: Arbutus menziesii (North)"),
    #tags$br(),
    tags$p("Click marker clusters to find individual observations"),
    #tags$br(),
    
    mainPanel(
      tabsetPanel(
        tabPanel("ARME Research-Grade", leafletOutput("mymap_r_n_3")),
        tabPanel("ARME Needs ID", leafletOutput("mymap_needs_id")),
        tabPanel("ARME Casual", leafletOutput("mymap_casual")),        
        tabPanel("ARME Project", leafletOutput("mymap_proj")),        
        tabPanel("About", tableOutput("text"))
      )
    )
  )  
  
  server <- function(input, output, session) {
    # research grade observation map
    output$mymap_r_n_3 <- renderLeaflet({
      # leaflet map with popup of many characters & image link
      map <- leaflet(height="100%", width = "auto") %>%
        setView(lng = -122.01,  # 53.13194, -122.91504  
                lat = 49.51,
                zoom = 5) %>% 
        addTiles(group = "OSM (default)",
                 options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addMarkers(lat = iNat_ARME_research_n_bounds_3$latitude, 
                   lng = iNat_ARME_research_n_bounds_3$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_research_n_bounds_3$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_research_n_bounds_3$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_research_n_bounds_3$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_research_n_bounds_3$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_research_n_bounds_3$image_url, "'width='200px' />", "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_research_n_bounds_3$observed_on_string, "<br>", "<b>", "Description:", "</b>", iNat_ARME_research_n_bounds_3$description, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_research_n_bounds_3$user_login )) %>%
        addLayersControl(
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })
    
    ##############
    ## needs_id observations - max
    output$mymap_needs_id <- renderLeaflet({
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
        addMarkers(lat = iNat_ARME_needs_id_n_bounds_3$latitude,
                   lng = iNat_ARME_needs_id_n_bounds_3$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_needs_id_n_bounds_3$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_needs_id_n_bounds_3$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_needs_id_n_bounds_3$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_needs_id_n_bounds_3$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_needs_id_n_bounds_3$image_url, "'width='200px' />", "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_needs_id_n_bounds_3$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_needs_id_n_bounds_3$user_login )) %>%
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
        setView(lng = -122.01,  # 53.13194, -122.91504  
                lat = 49.51,
                zoom = 5) %>% 
        addTiles(group = "OSM (default)",
                 options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap, group = "Nat Geo",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World",
                         options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
        addMarkers(lat = iNat_ARME_casual_n_bounds_3$latitude,
                   lng = iNat_ARME_casual_n_bounds_3$longitude,
                   clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                   #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_casual_n_bounds_3$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_casual_n_bounds_3$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_casual_n_bounds_3$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_casual_n_bounds_3$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_casual_n_bounds_3$image_url, "'width='200px' />", "<br>", "<b>", "Observation Date:", "</b>", iNat_ARME_casual_n_bounds_3$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_casual_n_bounds_3$user_login )) %>%
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
                   popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  iNat_ARME_proj$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", iNat_ARME_proj$common_name, "<br>", "<b>", "Place:", "</b>", iNat_ARME_proj$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", iNat_ARME_proj$uri, "<b>",  "'>Observation</a>", "<br>", "<img src='", iNat_ARME_proj$image_url, "'width='200px' />", "<br>", "<b>", "Description:", "</b>", iNat_ARME_proj$description, "<br><br>", "<b>", "Observation Date:", "</b>", iNat_ARME_proj$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", iNat_ARME_proj$user_login )) %>%
        addLayersControl(
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })    
    
    output$text <- renderUI({
      str1 <- tags$h2("Leaflet Map Visualization")
      str2 <- paste("iNaturalist research-grade observations of the Northern range of Arbutus menziesii (ARME), visualized using interactive Leaflet map <hr>")
      str3 <- tags$h3("About these observations")
      str4 <- paste("NOTE: ARME Project observations are not showing the imageURL or any observations fields <hr>")
      str5 <- tags$h3("Relevant Links")
      str6 <- tags$a(href="https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/iNaturalist/ARME/Shiny", "Shiny app Code")
      str7 <- tags$a(href="https://www.inaturalist.org/observations?locale=en&subview=map&taxon_id=51046", "iNaturalist Observations")
      str8 <- tags$a(href="https://www.arbutusarme.org/home", "Arubutus website home")
      str9 <- tags$a(href="https://treesnap.org/map/?center=47.66351640199509,-121.52321502871439&zoom=8", "Treesnap Observations")
      str10 <- tags$a(href="https://www.inaturalist.org/projects/arbutus-arme-pacific-madrone", "ARME iNaturalist Project")
      str11 <- paste("<hr>")
      str12 <- paste("Created by Wendy Anthony 2021-06-05")
      HTML(paste(str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, str11, str12, sep = "<br />"))
    })
    ### text output code idea from https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny  
  }
  
  shinyApp(ui, server)
