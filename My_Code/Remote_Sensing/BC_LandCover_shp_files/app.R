
library(shiny)
library(leaflet)
library(rgdal)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Land Cover Mapping on Vancouver Island"),
    p("Please be patient as the 8 land cover shape files are read, loaded and mapped ..."),
    leafletOutput("map"),
    br(),
    tags$div(class="header", checked=NA,
             tags$strong("Data source: "),
             tags$a(href="https://catalogue.data.gov.bc.ca/", "Government of BC Data Catalogue"),
    ),
    tags$div(class="header", checked=NA,
             tags$strong("File Format: "),
             tags$em("ArcView Shape"),
    ),
    tags$div(class="header", checked=NA,
             tags$strong("Coordinate System: "),
             tags$em("BC Albers (m)"),
    ),
    tags$div(class="header", checked=NA,
             tags$strong("Products: "),
             tags$em("1:250,000 GeoBase Land Cover"),
    ),
    br(),
    tags$div(class="header", checked=NA,
             tags$strong("Digital Cartographer: "),
             tags$em("Wendy Anthony 2022-04-20"),
    ),
    tags$div(class="header", checked=NA,
             tags$strong("Created in RStudio using Packages: "),
             tags$code("Shiny, Leaflet, and RGdal"),
    ),

    # Add custom CSS & Javascript;
    tags$style(".leaflet-control-layers-expanded{color: black}")
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  ## Area of Interest (AOI) Vancouver Island

  water_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                           layer = "water_aoi_vi_clip",
                           verbose = FALSE)
  coniferous_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                                layer = "coniferous_aoi_vi_clip",
                                verbose = FALSE)
  herbgrass_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                    layer = "herbgrass_aoi_vi_clip",
                    verbose = FALSE)
  exposed_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                            layer = "exposed_aoi_vi_clip",
                            verbose = FALSE)
  other_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                          layer = "other_aoi_vi_clip",
                          verbose = FALSE)
  shrub_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                               layer = "shrub_aoi_vi_clip",
                               verbose = FALSE)
  mixedforest_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                               layer = "mixedforest_aoi_vi_clip",
                               verbose = FALSE)
  broadleaf_vi_clip <- readOGR(dsn = "/Users/wanthony/Documents/R/RemoteSensing/lc_crop_shp/",
                               layer = "broadleaf_aoi_vi_clip",
                               verbose = FALSE)


    output$map <- renderLeaflet({
      leaflet() %>%
        addProviderTiles("Esri.WorldGrayCanvas", group = "Esri World Gray (default)") %>%
        setView( lng = -125.508, lat = 49.4801, zoom = 7) %>%
        addPolygons(data = water_vi_clip, color = "cyan",
                    fillColor = "cyan", weight = 1,
                    fillOpacity = 0.55, group = "Water <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/water-cyan-00FFFF.png' height='10' width='10' />") %>%
        addPolygons(data = coniferous_vi_clip, color = "#98FB98", # pale green
                    fillColor = "#98FB98", weight = 1,
                    fillOpacity = 0.35, group = "Coniferous <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/coniferous-palegreen-98FB98.png' height='10' width='10' />") %>%
        addPolygons(data = herbgrass_vi_clip, color = "green",
                    fillColor = "green", weight = 1,
                    fillOpacity = 0.75, group = "Herbs and Grass <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/herbgrass-green-008000.png' height='10' width='10' />") %>%
        addPolygons(data = other_vi_clip, color = "orange",
                    fillColor = "orange", weight = 1,
                    fillOpacity = 0.75, group = "Other <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/other-orange-FFA500.png' height='10' width='10' />") %>%
        addPolygons(data = exposed_vi_clip, color = "gold",
                    fillColor = "gold", weight = 1,
                    fillOpacity = 0.75, group = "Exposed <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/exposed-gold-FFD700.png' height='10' width='10' />") %>%
        addPolygons(data = shrub_vi_clip, color = "red",
                    fillColor = "red", weight = 1,
                    fillOpacity = 0.75, group = "Shrub <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/shrub-red-FF0000.png' height='10' width='10' />") %>%
        addPolygons(data = mixedforest_vi_clip, color = "purple",
                    fillColor = "purple", weight = 1,
                    fillOpacity = 0.75, group = "Mixed Forest <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/mixedforest-Purple-800080.png' height='10' width='10' />") %>%
        addPolygons(data = broadleaf_vi_clip, color = "magenta",
                    fillColor = "magenta", weight = 1,
                    fillOpacity = 0.75, group = "Broad Leaf <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/broadleaf-magenta-FF00FF.png' height='10' width='10' />") %>%

        addLayersControl(
          position = "bottomleft",
          # images must be hosted online, doesn't work if only on computer
          overlayGroups = c("Water <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/water-cyan-00FFFF.png' height='10' width='10' />",
                            "Coniferous <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/coniferous-palegreen-98FB98.png' height='10' width='10' />",
                            "Herbs and Grass <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/herbgrass-green-008000.png' height='10' width='10' />",
                            "Other <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/other-orange-FFA500.png' height='10' width='10' />",
                            "Exposed <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/exposed-gold-FFD700.png' height='10' width='10' />",
                            "Shrub <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/shrub-red-FF0000.png' height='10' width='10' />",
                            "Mixed Forest <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/mixedforest-Purple-800080.png' height='10' width='10' />",
                            "Broad Leaf <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/broadleaf-magenta-FF00FF.png' height='10' width='10' />"),
          # overlayGroups = c(" <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/water-cyan-00FFFF.png' height='10' width='10'> Water",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/coniferous-palegreen-98FB98.png' height='10' width='10'> Coniferous",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/herbgrass-green-008000.png' height='10' width='10'> Herbs and Grass",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/other-orange-FFA500.png' height='10' width='10'> Other",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/exposed-gold-FFD700.png' height='10' width='10'> Exposed",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/shrub-red-FF0000.png' height='10' width='10'> Shrub",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/mixedforest-Purple-800080.png' height='10' width='10'> Mixed Forest",
          #                   " <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/broadleaf-magenta-FF00FF.png' height='10' width='10'> Broad Leaf"),
          options = layersControlOptions(collapsed = FALSE, autoZIndex = TRUE)
          # autoZIndex - TRUE >>> maintains z order as overlays switch on/off
        ) %>%
        hideGroup("Water <img src='https://people.geog.uvic.ca/wanthony/website/images/colours/water-cyan-00FFFF.png' height='10' width='10' />") %>%
        # this js ends up working, and just grinds R to a halt  >>> creates Label for Layer Control
        htmlwidgets::onRender("
        function() {
            $('.leaflet-control-layers-overlays').prepend('<label style=\"text-align:center; font-weight: bold;\">Land Cover Classes</label>');
        }
    ")
          })
}

# Run the application
shinyApp(ui = ui, server = server)
