## -------------------------------------------------------------------
## -------------------------------------------------------------------
# # App to enable Interactive Exploration of UVic Geography Courses
# @ Start 2023-01-07, 2023-01-09 reactive table filter and CSV download
# ## Wendy Anthony wanthony@uvic.ca
## -------------------------------------------------------------------
## -------------------------------------------------------------------

## -----------------------------------------
# load libraries
library(shiny)
library(shinyWidgets) # set background color
library(DT) # datatable
# library(tidyverse) # trying to mutate link in DT

## -----------------------------------------
# Read Data
geog_dt <- read.csv("Geog-Course-flowcharts.csv", header = TRUE, sep = ",", stringsAsFactors=TRUE)

## -----------------------------------------
# Define UI -----------
ui <- fluidPage(
  setBackgroundColor("bonewhite"),
  titlePanel(title = span("Exploring UVic Geography Courses", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://www.uvic.ca/brand/assets/images/graphics/misc/Dynamic-edge.jpg", height = 50, width = "100%"),

  ## -----------------------------------------
  # Main Panel ---------
  mainPanel(
    tabsetPanel(type = "tabs",

## -----------------------------------------
          # Data Table tabPanel
          tabPanel("Data Table",
                HTML("<strong>Tips to Filter Courses:</strong> Choose multiple Courses from first drop-down search box under Course heading<br />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Search</strong> each column separately, <strong>or</strong> use Search Box to search the whole table<br />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Sort Order</strong> each column using arrows next to column name
             <br/><strong>Download CSV: </strong> Save Filtered-Search and Sort-Order, with current date, using Button below table<br/><br/>"
                ),
                DT::dataTableOutput("dt"),
                ### tags$head() is to customize the download button
                tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #e6ebef;} .button{margin: auto;}
                       .button-center{text-align: center;}")),
                # Download button needs to be after datatable to be able to save filtered data
                div(class = "button-center", downloadButton("download_filtered", "Download CSV", class="button")),
                hr(),
                h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                   align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
              ), # end of Data Table tabPanel

## -----------------------------------------
          # PDF tabPanel
          tabPanel("Planning PDFs",  tableOutput("pdf"),
                   hr(),
                   h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-11",
                      align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                   br(),
          ), # end of PDF tabPanel

# ## -----------------------------------------
# # Template tabPanel
# tabPanel("Template",  tableOutput("template"),
#          # Put content here
#          hr(),
#          h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
#             align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
# text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
#          br(),
# ), # end of Template tabPanel

## -----------------------------------------
          # Nested Data Viz tabPanel
          tabPanel("Data Viz",
                   tabsetPanel(

## -----------------------------------------
                     # Nested tabPanel Data Viz: Course Planning Flowchart
                     tabPanel("Course Planning Flowcharts", tableOutput("flowcharts"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-11",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Concept Maps  Nested tabPanel



## -----------------------------------------
                     # Nested tabPanel Data Viz: Concept Maps
                     tabPanel("Concept Maps", tableOutput("conceptmap"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Concept Maps  Nested tabPanel

## -----------------------------------------
                     # Nested tabPanel Data Viz: Paths Viz
                     tabPanel("Paths Viz", tableOutput("dataviz"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Paths Viz Nested tabPanel

## -----------------------------------------
# Nested tabPanel Data Viz: Test Viz
#                      tabPanel("TestViz", tableOutput("testviz"),
#                               hr(),
#                               h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
#                                  align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
# text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
#                               br(),

                   )), # end of Nested Data Viz tabPanel

## -----------------------------------------
            # Nested tabPanel About: Links
            tabPanel("Links", tableOutput("links"),
                     hr(),
                     h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                        align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
            text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                     br(),
            ), # end of Nested tabPanel About: Links

## -----------------------------------------
          # Test tabPanel
          # tabPanel("Tests",
          # ---------------------
          # # Nested tabPanel Tests:
          #          tabsetPanel(
          #            tabPanel("Test1", tableOutput("test1")),
          #            tabPanel("Test2", tableOutput("test2")),
          #            tabPanel("Test3", tableOutput("test3")),
          #            tabPanel("Test4", tableOutput("test4"))
          #          )), # end of Nested Tests tabPanel

## -----------------------------------------
          # About tabPanel
          tabPanel("About",
                   tabsetPanel(
## -----------------------------------------
                     # Nested tabPanel About: About
                     tabPanel("About", tableOutput("about"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Nested tabPanel About

## -----------------------------------------
                    # Nested tabPanel About: Tips
                     tabPanel("Tips", tableOutput("tips"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Nested tabPanel About: Tips

## -----------------------------------------
                    # Nested tabPanel About: Code
                     tabPanel("Code", tableOutput("code"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Nested tabPanel About: Code

## -----------------------------------------
                    # Nested tabPanel About: History
                     tabPanel("History", tableOutput("history"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ) # end of Nested tabPanel About: History
                   )), #  # end of Nested About tabPanel
    ) # tabsetPanel end
  ), # mainPanel end
) # fluidPage ends

## -----------------------------------------
# Define Server
server <- function(input, output) {

## -----------------------------------------
  #  datatable output
  # https://stackoverflow.com/questions/31486738/how-do-i-suppress-row-names-when-using-dtrenderdatatable-in-r-shiny
  output$dt <- DT::renderDataTable({

    datatable(geog_dt, filter = "top", options =  list(pageLength = 10),
              rownames = FALSE) %>% # suppress row tables, insert after option ()
      # https://stackoverflow.com/questions/42908440/align-to-top-of-cell-in-dt-datatable
      formatStyle(1:9, 'vertical-align'='top') %>%
      formatStyle(1:9, 'text-align' = 'left')
    # trying to add click-able hyper links to table .>> no luck so far ...
    # %>%
    # # no applicable method for 'mutate' applied to an object of class "c('datatables', 'htmlwidget')"
    #   mutate(site = paste0("<a href='", CatLink,"' target='_blank'>", CatLink,"</a>"))


  }) # end of Output: Data Table

## -----------------------------------------
  # Download button
  output$download_filtered <- downloadHandler(
    filename = function() {
      paste("GeographyCourses-FilteredData-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(geog_dt[input[["dt_rows_all"]], ],
                file= file,
                row.names=F)
    }
  ) # end of Output: downloadHandler

## -----------------------------------------
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  # Output: PDF
  output$pdf <- renderUI({
    sp <- tags$h2("Program Planning pdfs")
    spa <- HTML("<em><strong>Note: </strong>These links open in a new window, as back button won't return to same page<br />Close new window to return to app</em>")
    sp1 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf' target='_blank'>Program Planning Worksheet</a>")
    sb <- br()
    sp1a <- tags$iframe(style="height:850px; width:100%", src="https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf")
    sp2 <- paste("<br><br>Embedded pdf file from <a href=' https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf' target='_blank'>Environment and Sustainability Worksheet</a>")
    sb <- br()
    sp2.1 <- HTML("<strong>To Use: </strong>Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sp2a <- tags$iframe(style="height:790px; width:100%", src=" https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf")
    sp3 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf' target='_blank'>Geomatics Worksheet</a>")
    sb <- br()
    sp3.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sp3a <- tags$iframe(style="height:790px; width:100%", src="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf")
    sp4 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf' target='_blank'>Human Geography Worksheet</a>")
    sb <- br()
    sp4.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sp4a <- tags$iframe(style="height:790px; width:100%", src="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf")
    sp5 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf' target='_blank'>Physical Geography Worksheet</a>")
    sb <- br()
    sp5.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sp5a <- tags$iframe(style="height:790px; width:100%", src="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf")


    HTML(paste(sp, spa, sp1, sb, sb, sp1a, sp2, sb, sp2.1, sb, sb, sp2a, sp3, sb, sp3.1, sb, sb, sp3a, sp4, sb, sp4.1, sb, sb, sp4a, sp5, sb, sp5.1, sb, sb, sp5a))
  }) # end of Output: PDF

# ## -----------------------------------------
#   # Output: Template
#   output$template <- renderUI({
#     sp1 <- paste("")
#     sb <- br()
#     sp2 <- tags$iframe(style="height:850px; width:100%", src="")
#     HTML(paste(sp1, sb, sp2))
#   }) # end of Output: Template

## -----------------------------------------
  # Output: Test Viz
  # output$testviz <- renderUI({
  #   s1 <- tags$h2("Testing data vizualizations")
  #   s2 <- paste("Test viz goes here")
  #   HTML(paste(s1, s2))
  # }) # end of Output: Test Viz

## -----------------------------------------
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  # Output: Data Viz: Flowcharts
  output$flowcharts <- renderUI({
    sf <- tags$h2("Program Planning pdfs")
    sf1 <- HTML("<em><strong>Note: </strong>These links open in a new window, as back button won't return to same page<br />Close new window to return to app</em>")
    sf2 <- paste("<br><br>Embedded pdf file from <a href=' https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf' target='_blank'>Environment and Sustainability Worksheet</a>")
    sb <- br()
    sf2.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sf2a <- tags$iframe(style="height:790px; width:100%", src=" https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf")
    sf3 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf' target='_blank'>Geomatics Worksheet</a>")
    sb <- br()
    sf3.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sf3a <- tags$iframe(style="height:790px; width:100%", src="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf")
    sf4 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf' target='_blank'>Human Geography Worksheet</a>")
    sb <- br()
    sf4.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sf4a <- tags$iframe(style="height:790px; width:100%", src="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf")
    sf5 <- paste("<br><br>Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf' target='_blank'>Physical Geography Worksheet</a>")
    sb <- br()
    sf5.1 <- paste("Click Course-box links to go to UVic Catalogue item")
    sb <- br()
    sf5a <- tags$iframe(style="height:790px; width:100%", src="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf")


    HTML(paste(sf, sf1, sf2, sb, sf2.1, sb, sb, sf2a, sf3, sb, sf3.1, sb, sb, sf3a, sf4, sb, sf4.1, sb, sb, sf4a, sf5, sb, sf5.1, sb, sb, sf5a))
  }) # end of Output: Data Viz: Flowcharts

## -----------------------------------------
  # Output: Concept Maps:
  output$conceptmap <- renderUI({
    sc <- tags$h2("Concept Maps")
    sc1 <- HTML("<em><strong>Note:</strong> This concept map is from 2016 (with outdated information), with a different visualization technique.</em><br /><br /><strong>To Use: </strong>Click Course-box links to go to UVic Catalogue and registration. Links open in a new window (because back button won't return to same page) - Close new window to return to app")
    sb <- br()
    # sc2 <- tags$iframe(style="height:850px; width:100%", src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/GeomaticStudies-Concentrations-wendy-Jun9-2012-2.html")
    # sc3 <- tags$iframe(style="height:850px; width:100%", src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/Concentrations%20in%20Coastal%20Studies%2004-wendy-Jun8-2012.html")
    # sc4 <- tags$iframe(style="height:850px; width:100%", src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/Geog_urban_development_2015-16.html")
    # sc5 <- tags$iframe(style="height:850px; width:100%", src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/Geog_enviro_sust_2015-16.html")
    # sc6 <- tags$iframe(style="height:850px; width:100%", src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/Geog_earth_systems_2015-16.html")
    sc6 <- paste("
<html><head><title>Geog_earth_systems_2012-13.vue</title><script src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js' type='text/javascript'></script>
<script type='text/javascript'> jQuery.noConflict(); </script>
<script src='http://vue.tufts.edu/htmlexport-includes/jquery.maphilight.min.js' type='text/javascript'></script>
<script src='http://vue.tufts.edu/htmlexport-includes/v3/tooltip.min.js' type='text/javascript'></script>
<script type='text/javascript'>jQuery(function() {jQuery.fn.maphilight.defaults = { fill: false, fillColor: '000000', fillOpacity: 0.2, stroke: true, strokeColor: '282828', strokeOpacity: 1, strokeWidth: 4, fade: true, alwaysOn: false } jQuery('.example2 img').maphilight(); }); </script>
<style type='text/css'> #tooltip{ position:absolute; border:1px solid #333; background:#f7f5d1; padding:2px 5px; color:#333; display:none; } </style> </head>
<body> <div class='example2'><img class='map' src='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/Geog_earth_systems_2015-16.png' width='1018.0' height='827.0' usemap='#vuemap'><map name='vuemap'>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=484&schd_in=' target='_blank' class='tooltip' title='Detailed examination of atmospheric structures and processes underlying weather and climate. Practical work focuses on analysis of vertical stability and utilizing computer weather model data.' id='node42' shape='rect' coords='574,193,652,214'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=477&schd_in=' target='_blank' class='tooltip' title='The nature of scientific research in physical geography is examined through field and laboratory techniques. Includes a week- long field camp where basic approaches, methodologies and techniques are used to prepare a series of reports based on field data and collected samples. A field trip fee may be applied. Note: Credit will be granted for only one of 477, 471D.' id='node39' shape='rect' coords='433,191,511,212'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=476&schd_in=' target='_blank' class='tooltip' title='Focusing on various geomorphologic themes, students will complete a major research project based on field work to supplement lectures, seminars and field/lab projects. Note: Credit will be granted for only one of 476, 471C.' id='node36' shape='rect' coords='111,196,189,217'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=373&schd_in=' target='_blank' class='tooltip' title='A study of the application of physical principles to practical problems in climatology and the reciprocal interaction between climate and human activities. Topics include: urban effects on climate; air pollution; human bioclimatology; agricultural climatology; and methods of microclimatic modification.' id='node29' shape='rect' coords='580,369,658,389'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=370&schd_in=' target='_blank' class='tooltip' title='An overview of hydrological processes, measurement techniques and data analysis. The movement of water in the hydrologic cycle via precipitation, interception, evapotranspiration, surface runoff, infiltration, soil moisture, groundwater flow and streamflow generation are examined. Applied aspects and local examples will be discussed. Involves laboratory assignments and a field trip. Note: 1.5 units of 100- level MATH recommended.' id='node26' shape='rect' coords='435,355,513,375'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=376&schd_in=' target='_blank' class='tooltip' title='An investigation of the physical processes that create and maintain landforms. Focus on measurement and analysis of morphodynamic processes in fluvial, aeolian, coastal, glacial, hillslope, and/or periglacial landscapes (e.g., sediment transport, erosion, wind/wave energy, river discharge, glacial dynamics, weathering rates). Involves a field trip and/or a group project.' id='node23' shape='rect' coords='187,360,262,380'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=376&sched_in=' target='_blank' class='tooltip' title='An investigation of the physical processes that create and maintain landforms. Focus on measurement and analysis of morphodynamic processes in fluvial, aeolian, coastal, glacial, hillslope, and/or periglacial landscapes (e.g., sediment transport, erosion, wind/wave energy, river discharge, glacial dynamics, weathering rates). Involves a field trip and/or a group project.' id='node22' shape='rect' coords='187,384,265,405'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=272&schd_in=' target='_blank' class='tooltip' title='An investigation of the fundmental processes controlling climate and hydrology. Explores various factors and interactions that determine the spatial and temporal variations of individual climate elements. Special attention is given to the mutual interaction of climate with the Earth's surface and the role that ground surface type or cover plays in moderating local climate and hydrology.' id='node17' shape='rect' coords='510,534,585,554'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=274&schd_in=' target='_blank' class='tooltip' title='Examines the relationships among organisms - principally plants and animals - and their environment, emphasizing their distributions across a range of spatial and temporal scales. Examines basic ecological and evolutionary concepts affecting biogeographic processes of dispersal, speciation and extinction; how patterns of biodiversity change over space and time from early earth history to the contemporary environment; the nature of changing biotic distributions with increasing human impacts and global change.' id='node14' shape='rect' coords='828,510,906,531'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=276&schd_in=' target='_blank' class='tooltip' title='Introduction to Earth surface process and landforms including riverine, desert, coastal, glacial, hillslope and permafrost environments. Focus on regional and Canadian landscapes. Involves a field trip.' id='node11' shape='rect' coords='186,512,264,533'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=101A&schd_in=' target='_blank' class='tooltip' title='Introduction to the functioning of the biosphere, the ways in which humans alter natural processes, environmental consequences of these alterations and the implications for sustainability. Topics include: energy flows, biogeochemical cycles, ecosystem structure and dynamics, pollution, global change, water resources, biodiversity, endangered species, protected areas, agriculture and food, forestry, marine resources, poverty and development and different worldviews. Potential for a sustainable society is discussed.' id='node8' shape='rect' coords='803,679,884,700'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=101A&schd_in=' target='_blank' class='tooltip' title='Introduction to the functioning of the biosphere, the ways in which humans alter natural processes, environmental consequences of these alterations and the implications for sustainability. Topics include: energy flows, biogeochemical cycles, ecosystem structure and dynamics, pollution, global change, water resources, biodiversity, endangered species, protected areas, agriculture and food, forestry, marine resources, poverty and development and different worldviews. Potential for a sustainable society is discussed.' id='node7' shape='rect' coords='803,704,887,725'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=103&schd_in=' target='_blank' class='tooltip' title='Introduces Physical Geography using an earth- systems approach. Topics include atmospheric, ecologic, and geomorphic systems drviving the creation of weather and climate, landforms, biomes and ecosystems. The interrelationship between these systems as awell as the role of human agency will be discussed.' id='node3' shape='rect' coords='490,679,571,699'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=103&schd_in=' target='_blank' class='tooltip' title='Introduces Physical Geography using an earth- systems approach. Topics include atmospheric, ecologic, and geomorphic systems drviving the creation of weather and climate, landforms, biomes and ecosystems. The interrelationship between these systems as awell as the role of human agency will be discussed.' id='node2' shape='rect' coords='490,703,574,724'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=103&schd_in=' target='_blank' id='node0' shape='rect' coords='490,679,571,699'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=103&schd_in=' target='_blank' id='node1' shape='rect' coords='490,703,574,724'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/358.html' target='_blank' class='tooltip' title='Introduces Physical Geography using an earth- systems approach. Topics include atmospheric, ecologic, and geomorphic systems drviving the creation of weather and climate, landforms, biomes and ecosystems. The interrelationship between these systems as awell as the role of human agency will be discussed.' id='node4' shape='rect' coords='456,629,621,730'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=101A&schd_in=' target='_blank' id='node5' shape='rect' coords='803,679,884,700'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=101A&schd_in=' target='_blank' id='node6' shape='rect' coords='803,704,887,725'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/101A.html' target='_blank' class='tooltip' title='Introduction to the functioning of the biosphere, the ways in which humans alter natural processes, environmental consequences of these alterations and the implications for sustainability. Topics include: energy flows, biogeochemical cycles, ecosystem structure and dynamics, pollution, global change, water resources, biodiversity, endangered species, protected areas, agriculture and food, forestry, marine resources, poverty and development and different worldviews. Potential for a sustainable society is discussed.' id='node9' shape='rect' coords='769,629,934,731'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=276&schd_in=' target='_blank' id='node10' shape='rect' coords='186,512,264,533'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/276.html' target='_blank' class='tooltip' title='Introduction to Earth surface process and landforms including riverine, desert, coastal, glacial, hillslope and permafrost environments. Focus on regional and Canadian landscapes. Involves a field trip.' id='node12' shape='rect' coords='152,462,282,539'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=274&schd_in=' target='_blank' id='node13' shape='rect' coords='828,510,906,531'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/274.html' target='_blank' class='tooltip' title='Examines the relationships among organisms - principally plants and animals - and their environment, emphasizing their distributions across a range of spatial and temporal scales. Examines basic ecological and evolutionary concepts affecting biogeographic processes of dispersal, speciation and extinction; how patterns of biodiversity change over space and time from early earth history to the contemporary environment; the nature of changing biotic distributions with increasing human impacts and global change.' id='node15' shape='rect' coords='794,460,911,537'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=272&schd_in=' target='_blank' id='node16' shape='rect' coords='510,534,585,554'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/272.html' target='_blank' class='tooltip' title='An investigation of the fundmental processes controlling climate and hydrology. Explores various factors and interactions that determine the spatial and temporal variations of individual climate elements. Special attention is given to the mutual interaction of climate with the Earth's surface and the role that ground surface type or cover plays in moderating local climate and hydrology.' id='node18' shape='rect' coords='476,470,605,563'></area>
<area class='tooltip' title='Note: Biology 12 or BIOL 150B recommended. Prerequisites: 101A or 103.' id='node19' shape='rect' coords='790,561,915,606'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=376&schd_in=' target='_blank' id='node20' shape='rect' coords='187,360,262,380'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=376&sched_in=' target='_blank' id='node21' shape='rect' coords='187,384,265,405'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/376.html' target='_blank' class='tooltip' title='An investigation of the physical processes that create and maintain landforms. Focus on measurement and analysis of morphodynamic processes in fluvial, aeolian, coastal, glacial, hillslope, and/or periglacial landscapes (e.g., sediment transport, erosion, wind/wave energy, river discharge, glacial dynamics, weathering rates). Involves a field trip and/or a group project.' id='node24' shape='rect' coords='153,310,283,411'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=370&schd_in=' target='_blank' id='node25' shape='rect' coords='435,355,513,375'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/370.html' target='_blank' class='tooltip' title='An overview of hydrological processes, measurement techniques and data analysis. The movement of water in the hydrologic cycle via precipitation, interception, evapotranspiration, surface runoff, infiltration, soil moisture, groundwater flow and streamflow generation are examined. Applied aspects and local examples will be discussed. Involves laboratory assignments and a field trip. Note: 1.5 units of 100- level MATH recommended.' id='node27' shape='rect' coords='401,319,518,381'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=373&schd_in=' target='_blank' id='node28' shape='rect' coords='580,369,658,389'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/373.html' target='_blank' class='tooltip' title='A study of the application of physical principles to practical problems in climatology and the reciprocal interaction between climate and human activities. Topics include: urban effects on climate; air pollution; human bioclimatology; agricultural climatology; and methods of microclimatic modification.' id='node30' shape='rect' coords='546,319,663,395'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/358.html' target='_blank' class='tooltip' title='Landscape ecology emphasizes the interaction between spatial pattern and ecological processes. Focuses on the role of spatial heterogeneity across a range of scales. Focus is on the role of spatial heterogeneity in affecting the distribution and abundance of organisms, mass and energy transfers, and alterations of this structure by natural or anthropogenic forces. Implications for resource management and conservation are discussed. Note: 274 recommended.' id='node31' shape='rect' coords='700,317,800,367'></area>
<area class='tooltip' title='Note: 274 recommended. Prerequisites: One of 272, 274, 276.' id='node32' shape='rect' coords='638,413,811,462'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/424.html' target='_blank' class='tooltip' title='An advanced, field- based exploration of coastal geomorphic processes and landforms. Involves a week- long field trip to local coastal sites where students apply geomorphic concepts and methods towards a series of independent research assignments and/or group projects. Areas of investigation will span nearshore to backshore environments and wave, tidal, fluvial/estuarine, and aeolian processes. A field trip fee may be applied. ' id='node33' shape='rect' coords='223,132,350,196'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/474.html' target='_blank' class='tooltip' title='A field-research course in biogeography based on a combination of reading, discussion, and data analysis. Involves a week- long field trip; a field trip fee may be applied.' id='node34' shape='rect' coords='789,132,919,185'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=476&schd_in=' target='_blank' id='node35' shape='rect' coords='111,196,189,217'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/476.html' target='_blank' class='tooltip' title='Focusing on various geomorphologic themes, students will complete a major research project based on field work to supplement lectures, seminars and field/lab projects. Note: Credit will be granted for only one of 476, 471C.' id='node37' shape='rect' coords='77,132,204,223'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201509&subj_in=GEOG&crse_in=477&schd_in=' target='_blank' id='node38' shape='rect' coords='433,191,511,212'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/477.html' target='_blank' class='tooltip' title='The nature of scientific research in physical geography is examined through field and laboratory techniques. Includes a week- long field camp where basic approaches, methodologies and techniques are used to prepare a series of reports based on field data and collected samples. A field trip fee may be applied. Note: Credit will be granted for only one of 477, 471D.' id='node40' shape='rect' coords='399,127,516,218'></area>
<area href='https://www.uvic.ca/BAN2P/bwckctlg.p_disp_listcrse?term_in=201601&subj_in=GEOG&crse_in=484&schd_in=' target='_blank' id='node41' shape='rect' coords='574,193,652,214'></area>
<area href='http://web.uvic.ca/calendar2015-09/CDs/GEOG/484.html' target='_blank' class='tooltip' title='Detailed examination of atmospheric structures and processes underlying weather and climate. Practical work focuses on analysis of vertical stability and utilizing computer weather model data.' id='node43' shape='rect' coords='540,129,678,220'></area>
<area class='tooltip' title='Prerequisites: 376 and one of 370, 372, 373, 374; permission of the department by 15 March of previous Winter Session.' id='node44' shape='rect' coords='212,229,358,276'></area>
<area class='tooltip' title='Prerequisites: One of 274, 358, 370, 373, 376; permission of the department by 15 March of previous Winter Session.' id='node45' shape='rect' coords='385,238,535,286'></area>
<area id='node46' shape='rect' coords='15,16,1001,810'></area> </map></div></body></html>")
    # HTML(paste(sc, sc1, sb, sb, sc2, sb, sc3, sb, sc4, sb, sc5, sb, sc6))
    HTML(paste(sc, sc1, sb, sb, sc6))
  }) # end of OUtput: Concept Maps

## -----------------------------------------
  # Output: Dataviz
  output$dataviz <- renderUI({
    sdv1 <- tags$h2("Data Vizualization of Study Focus Pathways")
    sdv1a <- HTML("<em><strong>Note:</strong> This link opens in a new window, as back button won't return to same page. Close new window to return to app</em><br /><br />
                  <strong>To Use:</strong> Hover over or click any course to see other linked courses")
    sb <- br()
    sdv2 <- paste("<br><br>Embedded webpage from <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/interact-flow-edit-1.html' target='_blank'>Interactive Study Focus Pathways</a>")
    sb <- br()
    sdv3 <- tags$iframe(style="height:850px; width:100%", src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/interact-flow-edit-1.html")
    sdv4 <- paste("<html><head><title>UVic Geog Curriculum Mapping</title>style type='text/css' media='screen'	body { background-color: #000; }
	body,td { font: 1em Gotham, Helvetica Neue, Helvetica, Arial Narrow, Arial; font-weight: 500; color: #666; padding: 0; margin: 0; }
	ul { list-style: none none; margin: 0; padding: 0; display: block; }

	a,a:link { color: #ffcc00; text-decoration: none; }

	td { padding: 4px 4px; text-align: center; border: 1px solid #111; border-width: 1px 0; }
	tr:last-child td { border-bottom-width: 0; }
	tr.header td { padding: 10px 4px; font-size: 1.5em; font-weight: 200; color: #aaa; }
	tr.header td i { font-size: .4em; font-weight: 200; font-style: normal; }

	.items li { margin: 5px 0px; }
	.items li.current span { text-shadow: 0px 0px 8px #79cef4; }
	.arrows li { margin: 5px 0px; color: #898787; }
	.items li span { white-space: nowrap; cursor: pointer; background-color: rgba(0,0,0,0.75); border-radius: 3px; padding: 1px 4px; }


	#canvas { z-index: 1; display: block; position: absolute; left: 0; top: 0; background-color: transparent; }
	#pi { z-index: 2; border-collapse: collapse; position: relative; left: 0; top: 0; }

</style>
</head>
<body>
<table id='pi' border='0' cellpadding='0' cellspacing='0' width='100%'>
<tr class='header'>
<td valign='top' style='text-align: right;'>UVic Geography <br>Course Concentrations</td>
<td valign='top' colspan='3' style='text-align: right;'><br><br>Basics</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year1</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year2</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year3</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year4</td>
</tr>
<tr>
<td class='items' style='text-align: right;'>
<ul id='concentrations'>
<li>Base</li>
<li>Coastal</li>
<li>Earth</li>
<li>Environment</li>
<li>Geomatics</li>
<li>Urban</li>
</ul>
</td>
<td colspan='3' class='items' style='text-align: right;'>
<ul id='basics'>
<li class='base'>Geog 101A</li>
<li class='base'>Geog 101B</li>
<li class='base'>Geog 103</li>
<li class='base'>Geog 104</li>
<li class='base'>Geog 130</li>
<li class='base'>First Year Elective Courses</li>

</ul>
</td>
<td>
<ul class='arrows'>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
</ul>
</td>
<td colspan='3' class='items' style='text-align: left;'>
<ul id='year1'>
<li class='geog-101A'>Environment Society and Sustainability</li>
<li class='geog-101B'>Space Place and Society</li>
<li class='geog-103'>Introduction to Physical Geography</li>
<li class='geog-104'>Our Digital Earth</li>
<li class='geog-130'>Climate Change</li>
<li class='first-year-elective-courses'>Second Year Standing</li>

</ul>
</td>
<td class='items'></td>
<td colspan='3' class='items' style='text-align: left;'>
<ul id='year2'>
<li class='urban space-place-and-society'>Geog 218 Social and Cultural Geography</li>
<li class='urban space-place-and-society'>Geog 211 Economic Geography</li>
<li class='urban space-place-and-society environment-society-and-sustainability second-year-standing'>Geog 226 Quatitative Methods</li>
<li class='geomatics space-place-and-society environment-society-and-sustainability second-year-standing'>Geog 222 Introduction to Maps and GIS</li>
<li class='geomatics space-place-and-society environment-society-and-sustainability second-year-standing'>Geog 228 Introduction to Remote Sensing</li>

</ul>
</td>
<td class='items'></td>
<td colspan='3' class='items' style='text-align: left;'>
<ul id='year3'>
<li class='geomatics second-year-standing geog-222-introduction-to-maps-and-gis'>Geog 322 Digital Remote Sensing</li>
</ul>
</td>

<td class='items' style=''></td>
<td colspan='3' class='items'  style='text-align: left;'>
<ul id='year4'>
<li class='geomatics geog-322-digital-remote-sensing'>Geog 422 Advanced Topics in Digital Remote Sensing</li>
<li class='geomatics geog-322-digital-remote-sensing'>Geog 420 Field Studies in Coastal Geomatics</li>
</ul>
</td>
</tr>

</table>
<canvas id='canvas'></canvas>

</body>
<script src='https://code.jquery.com/jquery-3.2.1.slim.min.js'></script>
<script>
$(document).ready(function() {
var colors = ['#5D5C5C','#492f1f','#763c19','#f7941d','yellow','#79cef4','#00aeef','lime','green','#304b15'];
$('.items li').css({color:colors[0]});

canvas();
$(window).resize(function() { // todo: get event, only repaint on mouse release
  canvas();
});

// distribute before list to span
$('.items ul li')
.wrapInner($('<span />'))
.each(function() {

  item = lower_case($(this).children('span').html());		// turn item name css compliant
  $(this).attr({ id: item });								// set li id as item name

  if ($(this).parents('ul').attr('id') != 'concentrations') {		// concentrations has no before
    list = $(this).attr('class').split(/\\s+/);			// get before items from li class
    for (i in list) {
      $('#'+list[i]+' span').addClass(item);			// find id with class, inject itself into span as class
    }
  }
})
$('.items')
.on('mouseenter','ul li',function() {
  if (! $('#pi').hasClass('sticky')) {
    $(this).addClass('current');
    $(this).css({color:colors[5]});
    pi_link($(this));
  }
})
.on('mouseleave','ul li',function() {
  if (! $('#pi').hasClass('sticky')) {
    $(this).removeClass('current');
    $('.items li').css({color:colors[0]});
    canvas();
  }
})
.on('click','ul li',function() {

  if (!$(this).hasClass('current')) {
    $('#pi').removeClass('sticky')
  }

  if ($('#pi').hasClass('sticky')) {
    $('#pi').removeClass('sticky')

    $('.items li').removeClass('current').css({color:colors[0]});
  } else {
    $('#pi').addClass('sticky')

    $('.items li').removeClass('current').css({color:colors[0]});
    canvas();

    $(this).addClass('current');
    $(this).css({color:colors[5]});
    pi_link($(this));
  }
})

// $('ul#year1').hover(function() { $('.p1').toggleClass('current'); });
// $('ul#year2').hover(function() { $('.p2').toggleClass('current'); });
// $('ul#specialized').hover(function() { $('.p3').toggleClass('current'); });
// $('ul#year4').hover(function() { $('.p4').toggleClass('current'); });

function lower_case(s) { return s.toLowerCase().replace(/ /g, '-').replace(/\\./g, ''); }
function pi_link(item) {
  pi_link_before(item,-1);
  pi_link_after(item,1);
}
function pi_link_before(item, degree, depth) {
  type   = item.parent('ul').attr('id');
  degree = degree + ((type == 'year1') ? 1 : 0);

  class_prefex = '.items li span.';
  $('.items li span.'+item.attr('id'))
  .each(function() {
    $(this).parent('li').css({color: colors[5+degree]});
    if (type != 'year1' && degree > -4) {
      line(item.children('span'),$(this),colors[5+degree],colors[5+degree+1]);
    }
    pi_link_before($(this).parent('li'),degree-1);
  });
}
function pi_link_after(item, degree, depth) {
  type   = item.parent('ul').attr('id');
  degree = degree + ((type == 'basics') ? -1 : 0);

  $('.items li.'+item.attr('id'))
  .each(function() {
    $(this).css({color: colors[5+degree]});
    if (type != 'basics' && degree < 3) {
      line($(this).children('span'),item.children('span'),colors[5+degree-1],colors[5+degree]);
    }
    pi_link_after($(this),degree+1);
  });
}

$('#disco').toggle(
  function() {
    $(this).text('Disco!');
  }
  ,
  function() {
    $(this).text('Concentrations');
  }
);
});
    function canvas() {
      $('#canvas').attr({
        'height': $('#pi').outerHeight(),
        'width': $('#pi').outerWidth()
      });
    }
    function line(a,b,c1,c2) {
      pad = 0;
      fx  = a.position().left + 4;
      fy  = a.position().top + a.height()/2 + 1;
      tx  = b.position().left + b.width() + 2;
      ty  = b.position().top + b.height()/2 + 1;

      var cvs = document.getElementById('canvas');

      var ctx = cvs.getContext('2d');
      ctx.lineWidth = 1;
      ctx.beginPath();
      ctx.moveTo(tx,ty);
      ctx.lineTo(fx,fy);
      ctx.globalAlpha = 0.5;

      var gdt = ctx.createLinearGradient( tx,ty, fx,fy );
      gdt.addColorStop(0, c1);
      gdt.addColorStop(1, c2);

      ctx.strokeStyle = gdt;
      ctx.stroke();
    }

    pi = {
      concentrations: ['Base', 'Coastal','Earth','Environment','Geomatics','Urban'],
      basics: ['Geog 101A','Geog 101B','Geog 103','Geog 104','Climate Change'],
      years: {
        year1: ['Environment Society and Sustainability','Space, Place and Society','Introduction to Physical Geography','Our Digital Earth','Geog 130'],
        year2: ['Geog 218 Social and Cultural Geography','Geog 211 Economic Geography','Geog 226 Quatitative Methods','Geog 222 Introduction to Maps and GIS','Geog 228 Introduction to Remote Sensing'],
        year3: ['Geog 322 Digital Remote Sensing'],
        year4: ['Geog 422 Advanced Topics in Digital Remote Sensing', 'Geog 420 Field Studies in Coastal Geomatics']
      }
    }
    </script></html>
      ")
     # HTML(paste(sdv1, sdv1a, sdv2, sb, sb, sdv3))
     HTML(paste(sdv1, sdv1a, sdv2, sb, sb, sdv3, sb, sb, sdv4))
    # HTML(paste(sdv1, sdv1a, sb, sdv2))
  }) # End Output: Dataviz

## -----------------------------------------
  # Output: Links
  output$links <- renderUI({
    sl <- tags$h2("Links to Geog Course Info")
    sl1 <- HTML("<em>Note: These links open in a new window, as back button won't return to same page<br />Close new window to return to app</em>")
    sl1a <- strong("UVic Course Catalogue")
    sl2 <- tags$a(href="https://www.uvic.ca/calendar/future/undergrad/index.php#/content/62daf5e88b7d47001d0fc385", target="_blank", "Undergrad Calendar")
    sl3 <- tags$a(href="https://www.uvic.ca/calendar/future/undergrad/index.php#/programs/H1e0D6Q0GN?searchTerm=geography&bc=true&bcCurrent=Geography&bcItemType=programs", target="_blank", "Undergrad calendar Admission Requirements")
    sl3a <- tags$a(href="https://www.uvic.ca/calendar/future/undergrad/index.php#/Courses?group=Geography%20(GEOG)&bc=true&bcCurrent=Geography%20(GEOG)&bcItemType=Courses", target="_blank", "List of Geography Courses Linked to Calendar")
    sb <- br()
    sb <- br()
    sl4 <- strong("Course Planning Worksheet and Flowcharts")
    sl5 <- tags$a(href="https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf", target="_blank", "Geography Major Planning Worksheet")
    sl6 <- tags$a(href="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf", target="_blank", "Environment and Sustainability Flowchart")
    sl7 <- tags$a(href="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf", target="_blank", "Geomatics Flowchart")
    sl8 <- tags$a(href="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf", target="_blank", "Human Geography Flowchart")
    sl9 <- tags$a(href="https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf", target="_blank", "Physical Geography Flowchart")

    HTML(paste(sl, sl1, sb, sb, sl1a, sb, sl2, sb, sl3, sb, sl3a, sb, sb, sl4, sb, sl5, sb, sl6, sb, sl7, sb, sl8, sb, sl9))
  }) # end Output: About: Links

## -----------------------------------------
  # Output: Tests:
#
#   output$test1 <- renderUI({
#     strings1 <- paste("Testing ... Testing ... 1,2,3")
#     HTML(paste(strings1))
#   }) # end Output: Tests
#
#   output$test2 <- renderUI({
#     strings1 <- paste("Nesting Trials 2")
#     HTML(paste(strings1))
#   }) # end Output: Tests
#
#   output$test3 <- renderUI({
#     strings1 <- paste("Nesting Trials 3")
#     HTML(paste(strings1))
#   }) # end Output: Tests
#
#   output$test4 <- renderUI({
#     strings1 <- paste("Nesting Trials 4")
#     HTML(paste(strings1))
#   }) # end Output: Tests

## -----------------------------------------
  # Output: About: About
  output$about <- renderUI({
    sa1 <- tags$h2("About this app")
    sa2 <- paste("This experimental Shiny code sandbox was created to develop an online, interactive interface to Geography Course Planning")
    #paste("Code from https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r")
    HTML(paste(sa1, sa2))
  }) # end Output: About:

## -----------------------------------------
  # Output: About: Tips
  output$tips <- renderUI({
    st <- tags$h2("Search Tips")
    st1 <- paste("#1: Try search box above table to filter observations e.g. '103'")
    sb <- br()
    st2 <- paste("#2: Start typing into top filter box; can select multiple choices")
    st3 <- paste("#3: Only use one of 2 filter boxes, not both")
    HTML(paste(st, st1, sb, sb, st2, sb, sb, st3))
  }) # end Output: About: Tips

## -----------------------------------------
  # Output: About: Coding
  output$code <- renderUI({
    sc <- tags$h2("Coding")
    sc1 <- tags$a(href="https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/GeogInteractive/app.R", target="_blank", "Shiny app code on GitHub")
    sb <- br()
    sc2 <- HTML("Filtered table code adapted from <a href='https://stackoverflow.com/questions/53499066/downloadhandler-with-filtered-data-in-shiny' target='_blank'>Stackoverflow</a>")
    HTML(paste(sc, sc1, sb, sb, sc2))
  }) # end Output: About: Coding

## -----------------------------------------
  # Output: About: History
  output$history <- renderUI({
    sh <- tags$h2("History of Changes")
    sh7 <- tags$b("2023-01-11")
    sh7a <- paste("* Add links to course planning flow charts")
    sh7b <- paste("* Updated more course data, including Study Focus")
    sh7c <- paste("* Table cells now have no row number, and align to top")
    sb <- br()
    sh6 <- tags$b("2023-01-10")
    sh6a <- paste("* Add tabs to single page app & publish")
    sb <- br()
    sh5 <- tags$b("2023-01-09")
    sh5a <- paste("* Created filtered table with downloadable csv button")
    sh5b <- paste("* Published single page app with filtered table")
    sb <- br()
    sh4 <- tags$b("2023-01-08")
    sh4a <- paste("* Adding nested links")
    sh4b <- paste("* Adding images to title header")
    sb <- br()
    sh3 <- tags$b("2023-01-07")
    sh3a <- paste("* Created Shiny app as testing ground for sandbox experiments: Table, iframe embedding of interactive maps")
    sh2 <- tags$b("2023-01-06")
    sh2a <- paste("* Disected code from Interactive gaming website https://hanns.io/pi/")
    sh1 <- tags$b("2023-01-05")
    sh1a <- paste("* David Atkinson, UVic Geog Chair, asked if I would be interested in helping develop an online, interactive interface to Geography Course Planning")
    sh1b <- paste("* Sent link to Interactive Concept Map")
    HTML(paste(
      sh, sh7, sb, sh7a, sb, sh7b, sb, sh7c, sb, sb, sh6, sb, sh6a, sb, sb, sh5, sb, sh5a, sb, sh5b, sb, sb, sh4, sb, sh4a, sb, sh4b, sb, sb,
      sh3, sb, sh3a, sb, sb,
      sh2, sb, sh2a, sb, sb,
      sh1, sb, sh1a, sb, sh1b, sb, sb))
  }) # end Output: About: History

## -----------------------------------------
} # end of server function

## -----------------------------------------
# Run app
shinyApp(ui, server)
