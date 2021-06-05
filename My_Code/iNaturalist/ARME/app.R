#############################################
#############################################
# Shiny leaflet app for iNaturalist obs
# coded by Wendy Anthony
# Arbutus menziesii
# 2020-10-13  >> created first iNat app
# 2021-01-25 << fixed spider cluster zoom
# 2021-06-03 >> 

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

iNat_ARME_research <- iNat_ARME[which(iNat_ARME$quality_grade == "research" ), ] 

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
    
    mainPanel(
      tabsetPanel(
        tabPanel("ARME Research-Grade", leafletOutput("mymap_r")),
        tabPanel("About", tableOutput("text"))
      )
    )
  )  
  
  server <- function(input, output, session) {
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
          baseGroups = c("OSM (default)", "Nat Geo", "ESRI World"),
          options = layersControlOptions(collapsed = TRUE)
        )
    })
    
    output$text <- renderUI({
      str1 <- tags$h2("Leaflet Map Visualization")
      str2 <- paste("iNaturalist research-grade observations of Arbutus menziesii (ARME) visualized using interactive Leaflet map ")
      str3 <- paste("<hr>")
      str4 <- tags$h3("About these observations")
      str5 <- tags$a(href="https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/ARME/app.R", "Shiny app Code")
      str6 <- tags$a(href="https://www.inaturalist.org/observations?locale=en&subview=map&taxon_id=51046", "iNaturalist Observations")
      str7 <- tags$a(href="https://www.arbutusarme.org/home", "Arubutus website home")
      str8 <- tags$a(href="https://treesnap.org/map/?center=47.66351640199509,-121.52321502871439&zoom=8", "Treesnap Observations")
      str9 <- paste("<hr>")
      str10 <- paste("Created by Wendy Anthony 2021-06-03")
      HTML(paste(str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, sep = "<br />"))
    })
    ### text output code idea from https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny  
  }
  
  shinyApp(ui, server)
