##################################################
# using Directed Studies research with photos 2014
# data from created database using Filemaker Pro 13 >>> exported to csv
# 2021-08-18
# 2022-12-15 Got reactive code to work for select
# based on code from
# https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r
##################################################

library(shiny)
library(leaflet)
library(dplyr) # to use %>% pipes
library(DT) # to create data table

##################################################
##################################################

# Data import and subset
phenology_csv_fmp <- read.csv("Phenology-DirStu-ES490.csv", stringsAsFactors = F)

str(phenology_csv_fmp)

# subset for popup data info
pheno_subset <- phenology_csv_fmp %>% select(CommonName, Species, FileNameOrigin, FileName, Date, Time,
                             LocName, EcoType, Long, Lat, LeafPhase, FlowerPhase, FileNameTb)

str(pheno_subset)
class(pheno_subset)

# subset for datatable to display
pheno_subset_sub <- pheno_subset %>% select(CommonName, Species, FileNameOrigin, Date, Time,
                                             LocName, EcoType, Long, Lat, LeafPhase, FlowerPhase)
class(pheno_subset_sub)
colnames(pheno_subset_sub)

# code from </R/Shiny/ShinyDatabase/FilterTest/DatasetFilter/app-copy.R>
is.not.null <- function(x) !is.null(x)

##################################################
# app
##################################################

# Define UI for application
ui <- fluidPage(
    # Application title
    titlePanel("Wendy's Native Plants Phenological Data"),
    p("Code tweaking, data, and Photos by Wendy Anthony 2022-12-15"),
    br(),br(),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        uiOutput("commonName"),
        uiOutput("locName")
      ),
      mainPanel(
        leafletOutput("Map"),
        tabsetPanel(type = "tabs",
                    tabPanel("Table", DT::dataTableOutput("table_subset")),
                    tabPanel("About", tableOutput("text")),
                    tabPanel("Code",  verbatimTextOutput("code"))
                    )
              )
    ),
)

########################################
# Define server logic
server <- function(input, output) {

  phenodata <- pheno_subset_sub

  class(phenodata)
  str(phenodata)

  # ---------------------
  output$table <- DT::renderDataTable({
    if(is.null(phenodata)){return()}
    DT::datatable(phenodata, options = list(scrollX = T))
  })

  output$commonName <- renderUI({
    selectInput(inputId = "CommonName", "Select Common Name(s)",
                choices = var_commonName(), multiple = T)
  })
#   https://shiny.rstudio.com/reference/shiny/latest/selectinput
  output$locName <- renderUI({
    selectInput(inputId = "LocName", "Select Location(s) (Try adding different location if error appears)",
                choices = var_locName(), multiple = T)
  })

  # ---------------------
  # Reactive Filtered data
  # must refere toreactive object data_filtered() using the ()
  # <<< makes leaflet map reactive
  # https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny
  data_filtered <- reactive({
    filter(pheno_subset_sub, CommonName %in% commonName(), LocName %in% locName())
    #     filter(pheno_subset_sub, Species %in% species(), CommonName %in% commonName(), LocName %in% locName())
  })

  commonName <- reactive({
    if (is.null(input$CommonName)) unique(pheno_subset_sub$CommonName) else input$CommonName
  })

  locName <- reactive({
    if (is.null(input$LocName)) unique(pheno_subset_sub$LocName) else input$LocName
  })

  # ---------------------
  # Get available categories
  var_commonName <- reactive({
    file1 <- phenodata
    if(is.null(phenodata)){return()}
    as.list(unique(file1$CommonName))
  })

  var_locName <- reactive({
    file1 <- phenodata
    if(is.null(phenodata)){return()}
    as.list(unique(file1$LocName))
  })

  # ---------------------
  # Reactive Leaflet map
  output$Map <- renderLeaflet({

    # create popup
    popup <- sprintf("<a href='https://people.geog.uvic.ca/wanthony/website/phenology/images/%s'><img src='https://people.geog.uvic.ca/wanthony/website/phenology/images/%s' alt=''></a><br />
                     <strong>Names: </strong>%s<br /><strong>Species ID: </strong>%s<br /><strong>Location: </strong>%s<br /><strong>Seasonal Date: </strong>%s<br />
                     <strong>Leaf Phase: </strong>%s<br /><strong>Flower Phase: </strong>%s<br /><strong>Ecology: </strong>%s<br />
                     <strong>Image: </strong><a href='https://people.geog.uvic.ca/wanthony/website/phenology/images/%s'>Image</a>",
                     phenology_csv_fmp$FileName, phenology_csv_fmp$FileNameTb, phenology_csv_fmp$CommonName, phenology_csv_fmp$Species,
                     phenology_csv_fmp$LocName, phenology_csv_fmp$Date, phenology_csv_fmp$LeafPhase, phenology_csv_fmp$FlowerPhase, phenology_csv_fmp$EcoType,
                     phenology_csv_fmp$FileName) %>%
      lapply(htmltools::HTML)

    # must reference toreactive object data_filtered() using the ()
    # <<< makes leaflet map reactive
    # https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny

    # create map
    m_fmp <- leaflet(data_filtered()) %>%
      addTiles() %>%
      setView(-123.31209, 48.46313, zoom = 15) %>%
      addCircleMarkers(data_filtered()$Long, data_filtered()$Lat, popup = popup,
                       stroke = FALSE, fillOpacity = 0.4, radius = 5, color = "red",
                       label = ~htmltools::htmlEscape(CommonName),
                       labelOptions = labelOptions(noHide = F, direction = "bottom",
                                       style = list(
                                         "color" = "black",
                                         "font-family" = "serif",
                                         "font-style" = "italic",
                                         "box-shadow" = "3px 3px rgba(0,0,0,0.25)",
                                         "font-size" = "12px",
                                         "border-color" = "rgba(0,0,0,0.5)"
                                       )))
  })

  # ---------------------
  # Reactive Output table
  output$table_subset <- DT::renderDataTable({
    DT::datatable(data_filtered(), options = list(scrollX = T))
  })

  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  output$text <- renderUI({
        str1 <- paste("Say something about this project: I used my Directed Studies research with photos taken 2014, creating a database  using Filemaker Pro 13> I exported to csv. I started this app 2021-08-18, but couldn't get the selection to respond in the table and map.
    2022-12-15 Got reactive code to work.")
        str2 <-   tags$a(href='https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r', 'Code Base for Making Selected Inputs Reactive', target="_blank")
          #paste("Code from https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r")

        str3 <- paste("Tip: Try search box to filter observations e.g. 'fern'")
        HTML(paste(str1, str2, str3, sep = "<br /><br />"))
  })

  output$code <-renderUI({
    string1 <- tags$a(href='', 'Shiny app code', target="_blank")
    HTML(paste(string1))
  })


############
# last curly bracket needed to complete server function
}

# Run application
shinyApp(ui = ui, server = server)
