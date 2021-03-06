##########################################
# Shiny leaflet app for iNaturalist obs
# 2020-10-13  >> fixed spider cluster zoom
##########################################

library("shiny")
library("leaflet")
library("rinat")
#library("lubridate") # for dates
library("data.table")

# dir <- "/Users/wendyanthony/Documents/R/iNaturalist-shiny-leaflet-app"
# setwd(dir)
# getwd()

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
wa_inat_userstats_research$months <- as.Date(wa_inat_userstats_research$observed_on_string, format = "%y-%b-%d") 
str(wa_inat_userstats_research) # Date

# 2, change new column with year from column y/m/d
wa_inat_userstats_research$months <- month(wa_inat_userstats_research$observed_on) 
class(wa_inat_userstats_research$month)
str(wa_inat_userstats_research)
class(wa_inat_userstats_research) # [1] "data.frame"

# create new columns by copying other column data
wa_inat_userstats_research$scientific_name_test <- wa_inat_userstats_research$scientific_name

names(wa_inat_userstats_research)
str(wa_inat_userstats_research)

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
wa_inat_userstats_research <- cbind(wa_inat_userstats_research, out2)
wa_inat_userstats_research_append <- wa_inat_userstats_research

write.csv(wa_inat_userstats_research_append, "wendy_anthony_inat_research_obs_clean.csv", row.names = FALSE)

maptypes <- c("Stamen.TerrainBackground",
              "Esri.WorldImagery",
              "OpenStreetMap",
              "Stamen.Watercolor")

### ---------------------------------------
# shiny app
ui <- fluidPage(
    titlePanel("My Research-grade iNaturalist Observations"),
    tags$br(),
    tags$p("Click marker clusters to find individual observations"),
    tags$br(),
    
    mainPanel(
        tabsetPanel(
            tabPanel("iNaturalist Leaflet Map Viz", leafletOutput("mymap")),
            tabPanel("About", tableOutput("text"))
        )
    )
)  

server <- function(input, output, session) {
    output$mymap <- renderLeaflet({
        # leaflet map with popup of many characters & image link
        map <- leaflet(height="3800px", width = "100%") %>%
            setView(lng = -125.52,  # 49.54782, -125.5188
                    lat = 49.54,
                    zoom = 7) %>% 
            addTiles(group = "OSM (default)",
                     options = providerTileOptions(minZoom = 3, maxZoom = 25)) %>%
            addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
            addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
            addProviderTiles(providers$Stamen.TerrainBackground, group = "Terrain") %>%
            addProviderTiles(providers$Esri.WorldImagery, group = "ESRI World") %>%
            
            
            #      addProviderTiles("Esri.WorldImagery") %>% 
            #     addProviderTiles(maptypes[1]) %>% # chose other basemap by number
            addMarkers(lat = wa_inat_userstats_research_append$latitude, 
                       lng = wa_inat_userstats_research_append$longitude,
                       clusterOptions = markerClusterOptions(spiderfyOnMaxZoom = T),
                       #    clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F),
                       popup = paste("<b>", "Scientific Name:", "</b>",  "<i>",  wa_inat_userstats_research_append$scientific_name, "</i>", "<br>", "<b>", "Common Name:", "</b>", wa_inat_userstats_research_append$common_name, "<br>", "<b>", "Place:", "</b>", wa_inat_userstats_research_append$place_guess, "<br>", "<b>", "iNaturalist Link:", "</b>", "<a href='", wa_inat_userstats_research_append$url, "<b>",  "'>Observation</a>", "<br>", "<img src='", wa_inat_userstats_research_append$image_url, "'width='200px' />", "<br>", "<b>", "Taxon:", "</b>", wa_inat_userstats_research_append$iconic_taxon_name, "<br>", "<b>", "Observation Date:", "</b>", wa_inat_userstats_research_append$observed_on_string, "<br>", "<b>", "Citizen Scientist / Photographer:", "</b>", wa_inat_userstats_research_append$user_login )) %>%
            addLayersControl(
                baseGroups = c("OSM (default)", "Toner", "Toner Lite", "Terrain", "ESRI World"),
                options = layersControlOptions(collapsed = TRUE)
            )
    })
    
    output$text <- renderUI({
        str1 <- tags$h2("iNaturalist observation Visualization")
        str2 <- paste("iNaturalists observations by Wendy Anthony")
        str3 <- tags$h2("About these observations")
        str4 <- paste("These are the 'research-grade' observations that have been verified by at least one other naturalist @ iNaturalist")
        str5 <- tags$a(href="https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/app.R", "Shiny app Code")
        str6 <- tags$a(href="https://www.inaturalist.org/observations/wendy_anthony", "iNaturalist Observations")
        str7 <- paste("Created by Wendy Anthony 2020-01-13, updated 2020-01-25")
        HTML(paste(str1, str2, str3, str4, str5, str6, str7, sep = "<br /><br />"))
    })
    # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny  
}



shinyApp(ui, server)