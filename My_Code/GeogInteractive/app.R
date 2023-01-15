## -------------------------------------------------------------------
## -------------------------------------------------------------------
# # App to enable Interactive Exploration of UVic Geography Courses
# @ Start 2023-01-07, 2023-01-09 reactive table filter and CSV download
## Updated 2023-01-13 06:24
## Updated 2023-01-15 08:40
# ## Wendy Anthony wanthony@uvic.ca
## -------------------------------------------------------------------
## -------------------------------------------------------------------

## -----------------------------------------
# load libraries
library(shiny)
library(shinyWidgets) # set background color
library(DT) # datatable
library(DiagrammeR) # Gantt Chart
library(ggplot2)
library(plotly)

## -----------------------------------------
# Read Data
geog_dt <- read.csv("Geog-Course-flowcharts.csv", header = TRUE, sep = ",", stringsAsFactors=TRUE)
geog_dt_time <- read.csv("TimeLog-Current.csv", header = TRUE, sep = ",", stringsAsFactors=TRUE)
tl <- read.csv("TimeLog-Current.csv")
## -----------------------------------------
# Define UI -----------
ui <- fluidPage(
  setBackgroundColor("bonewhite"),
  # https://stackoverflow.com/questions/35025145/background-color-of-tabs-in-shiny-tabpanel
  # .tabbable > .nav > li > a[data-value='t1'] {background-color: red;   color:white}
  # .tabbable > .nav > li > a[data-value='t2'] {background-color: blue;  color:white}
  # .tabbable > .nav > li > a[data-value='t3'] {background-color: green; color:white}

  tags$style(HTML("
    .tabbable > .nav > li > a                  {background-color: #c3dca4;  color:black}
    .tabbable > .nav > li[class=active]    > a {background-color: #77be21; color:white}

/* https://stackoverflow.com/questions/72147869/change-selected-cell-background-color-in-a-shiny-dt-table-based-on-rules */
/* Removes background colour of stripes */
/* table.dataTable.stripe tbody tr.odd, table.dataTable.stripe tbody tr.even {
  background-color: #cccccc;
}
table.dataTable tr.odd td.selected:not(.no-highlight) {
  background-color: #ffffff !important;
}
table.dataTable tr.even td.selected:not(.no-highlight) {
  background-color: #69A81D !important;
}
table.dataTable tbody tr td.selected.no-highlight {
  background-color: #cccccc !important;
}*/
  ")),
  titlePanel(title = span("Exploring UVic Geography Courses", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),

  ## -----------------------------------------
  # Main Panel ---------
  mainPanel(
    tabsetPanel(type = "tabs",

## -----------------------------------------
          # Data Table tabPanel
          tabPanel("Data Table",
                HTML("     <h3>Geography Courses Data Table</h3>
              <ul>
                <li><strong>Search Box:</strong> Searches whole table to filter observations from all columns e.g. Type '103'</li>
                  <ul>
                  <li><strong>Tip:</strong> Search partial spelling e.g. 'clim' brings up 'climate' and 'climatology'</li>
                  </ul>
                <li><strong>Filter:</strong> Start typing in box under Course heading; select choice(s); use filter boxes separately</li>
                <li><strong>Sort Order:</strong> each column using arrows next to column name</li>
                <li><strong>Download CSV: </strong> Save Filtered-Search and Sort-Order, with current date, using Button below table</li>
              </ul>
              <hr>"
                ),


                DT::dataTableOutput("dt"),
                ### tags$head() is to customize the download button
                tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #f0f6e8;} .button{margin: auto;}
                       .button-center{text-align: center;}")),
                # Download button needs to be after datatable to be able to save filtered data
                div(class = "button-center", downloadButton("download_filtered", "Download CSV", class="button")),
                hr(),
                h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                   align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
              ), # end of Data Table tabPanel

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
          # Nested Course Planning Data Viz tabPanel
          tabPanel("Course Planning Data Viz",
                   tabsetPanel(

## -----------------------------------------
                     # Nested PDF tabPanel
                     tabPanel("Planning PDFs",  tableOutput("pdf"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-11",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of PDF tabPanel

## -----------------------------------------
                     # Nested tabPanel Data Viz: Course Planning Flowchart
                     tabPanel("Catalogue-linked Flowcharts", tableOutput("flowcharts"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-11",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Concept Maps  Nested tabPanel

## -----------------------------------------
                    # Nested tabPanel Data Viz: mermaid Flow Charts
                    tabPanel("Flow Chart Diagrams", tableOutput("mermaid"),
                             strong("Flow Chart Experiments with Mermaid"),
                             DiagrammeROutput('diagram1', width = "50%"),
                             hr(),
                             DiagrammeROutput('diagram2', width = "50%"),
                             hr(),
                             h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-12",
                                align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
                    text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                             br(),
                    ), # end of mermaid Flow Charts  Nested tabPanel

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
                     tabPanel("Interactive Paths Viz", tableOutput("dataviz"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-13",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Paths Viz Nested tabPanel

## -----------------------------------------
                    # Nested tabPanel About: Links
                    tabPanel("Links", tableOutput("links"),
                             hr(),
                             h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
                                text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                             br(),
                    ), # end of Nested tabPanel About: Links

                   )), # end of Nested Course Planning Data Viz tabPanel

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
          tabPanel("About This App",
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
                    # Nested tabPanel About: Code
                     tabPanel("Code", tableOutput("code"),
                              hr(),
                              h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                 align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                              br(),
                     ), # end of Nested tabPanel About: Code

## -----------------------------------------
                      # Nested tabPanel About: History --------------------
                      tabPanel("History of Changes", tableOutput("history"),
                               hr(),
                               h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-10",
                                  align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
                      text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                               br(),
                      ), # end of Nested tabPanel About: History --------------------

## -----------------------------------------
                    # Work tabPanel --------------------
                    tabPanel("Project Work",
                    # ---------------------

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


# -----------------------------------------
                    # Nested tabPanelWork: --------------------
                             tabsetPanel(
                               # tabPanel("Questions", tableOutput("questions")),

## -----------------------------------------
                                            # Nested tabPanel About: Timelog
                                            tabPanel("TimeLog Plot",
                                                     h3("Time Log for Interactive Geography Classes Code Work"),
                                                     span("Hover over the graphs to discover the time details"),
                                                     br(),br(),
                                                     h4("Sum of Total Hours (to date of plots and datatable)"),
                                                     tableOutput("totalhours"),
                                                     hr(),
                                                     h4("Time Log Plot (tasks: stacked)"),
                                                     plotlyOutput("timelogplotstack"),
                                                     hr(),
                                                     h4("Time Log Plot (tasks: side-by-side)"),
                                                     plotlyOutput("timelogplotside"),
                                                     hr(),
                                                     h4("Time Log Datatable"),
                                                     DT::dataTableOutput("dttime"),
                                                     ### tags$head() is to customize the download button
                                                     tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #f0f6e8;} .button{margin: auto;}
                       .button-center{text-align: center;}")),
                                                     # Download button needs to be after datatable to be able to save filtered data
                                                     div(class = "button-center", downloadButton("download_filtered_time", "Download CSV", class="button")),

                                                     h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-12",
                                                        align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
                  text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                                                     br(),
                                            ), # end of Nested tabPanel About: Timelog

                                              ## -----------------------------------------
                                              # Gantt tabPanel
                                              tabPanel("Gantt Chart",  tableOutput("gantt"),
                                                       textAreaInput(inputId = "inText", label = NULL, width = "900px", height = "370px", rows = 15, value = "
                                                gantt
                                  dateFormat  YYYY-MM-DD
                                  title Designing Interactive Geography Course Planning Gantt Diagram

                                  section Interactive Project
                                  Offered Position       :done,     first_7, 2023-01-05, 2023-01-06
                                  Accepted Position       :done,     first_8, 2023-01-05, 2023-01-06
                                  Started Project      :active,         first_9, 2023-01-06, 90d

                                  section Shiny App
                                  Created Shiny App             :done,          first_1,    2023-01-06, 2023-01-08
                                  Refining Shiny App            :active,        first_5,    2023-01-06, 10d
                                  Created Interactive Downloadable Data Table  :done,  first_6, 2023-01-08, 2023-01-09

                                  section Data Collection
                                  Collecting Course Data        :active,        first_2,    2023-01-09, 10d
                                  Finish Collecting Data       :                first_3,    after first_2, 5d
                                  Do this after that            :               first_4,    after first_3, 5d

                                  section Interactive Data Table
                                  Completed, critical task      :crit, done,    import_1,   2023-01-06,24h
                                  Also done, also critical      :crit, done,    import_2,   after import_1, 2d
                                  Doing this important task now :crit, active,  import_3,   after import_2, 3d
                                  Next critical task            :crit,          import_4,   after import_3, 5d

                                  section Interactive Data Viz
                                  First extras                  :active,        extras_1,   after import_4, 3d
                                  Second helping                :               extras_2,   after extras_1, 20h
                                  More of the extras            :               extras_3,   after extras_1, 48h

                                  "),
                                 DiagrammeR::DiagrammeROutput(outputId = "diagram", width = "950px", height = "auto"),
                                 hr(),
                                 h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-11",
                                    align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                                 br(),
                        ), # end of Gantt tabPanel --------------------

                                        ## -----------------------------------------
                                        # Nested Lists tabPanel
                                        tabPanel("Lists",
                                                 # ---------------------
                                                 # Nested tabPanel Tests:
                                                 tabsetPanel(
                                                   tabPanel("Questions", tableOutput("questions")),
                                                   tabPanel("To Do", tableOutput("todo")),
                                                   tabPanel("Wishlists", tableOutput("wishlists")),
                                                 )), # end of Nested Tests tabPanel

                                            # )), # end of Nested Tests tabPanel


# -----------------------------------------

                             )), # end of NestedWork tabPanel --------------------

                   )), #  # end of Nested About tabPanel --------------------
    ) # tabsetPanel end
  ), # mainPanel end
) # fluidPage ends

## -----------------------------------------
## ############# Server Begins ############
## -----------------------------------------
# Define Server
server <- function(input, output) {

## -----------------------------------------
  #  datatable output
  # https://stackoverflow.com/questions/31486738/how-do-i-suppress-row-names-when-using-dtrenderdatatable-in-r-shiny
  output$dttime <- DT::renderDataTable({

    datatable(geog_dt_time, filter = "top", options =  list(pageLength = 10),
              rownames = FALSE) %>% # suppress row tables, insert after option ()
      # https://stackoverflow.com/questions/42908440/align-to-top-of-cell-in-dt-datatable
      formatStyle(1:9, 'vertical-align'='top') %>%
      formatStyle(1:9, 'text-align' = 'left')
    # trying to add click-able hyper links to table .>> no luck so far ...
    # %>%
    # # no applicable method for 'mutate' applied to an object of class "c('datatables', 'htmlwidget')"
    #   mutate(site = paste0("<a href='", CatLink,"' target='_blank'>", CatLink,"</a>"))
  }) # end of Output: dt renderDataTable

## -----------------------------------------
  # Download button
  output$download_filtered_time <- downloadHandler(
    filename = function() {
      paste("WendyAnthony-TimeLog-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(geog_dt_time[input[["dttime_rows_all"]], ],
                file= file,
                row.names=F)
    }
  ) # end of Output: downloadHandler



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
  }) # end of Output: dt renderDataTable

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
    HTML("
         <h2>Program Planning pdfs</h2>
         <div>
            Embedded pdf file from <a href='https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf' target='_blank'>Program Planning Worksheet</a>
            <br />
            <iframe style='height:790px; width:100%' src='https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf'></iframe>
            <br /><br />

         </div>
         ")
  }) # end of Output: PDF

## -----------------------------------------
  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  # Output: Data Viz: Flowcharts
  output$flowcharts <- renderUI({
    HTML("
        <h2>Flowchart Program Planning pdfs</h2>
          <div>
            <em><strong>Note: </strong>These links open in a new window, as back button won't return to same page<br />Close new window to return to app</em>
              <br /><br />
            <strong>To Use: </strong>Click Course-box links to go to UVic Catalogue item
          </div>
            <hr>
        <h3>Environment And Sustainability</h3>
          <div>
            Embedded pdf file from <a href=' https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf' target='_blank'>Environment and Sustainability Worksheet</a>
              <br />
            Click Course-box links to go to UVic Catalogue item
              <br /><br />
            <iframe style='height:790px; width:100%' src='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf'></iframe>
          </div>
            <hr>
        <h3>Geomatics</h3>
          <div>
            Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf' target='_blank'>Geomatics Worksheet</a>
              <br />
            Click Course-box links to go to UVic Catalogue item
              <br /><br />
            <iframe style='height:790px; width:100%' src='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf'></iframe>
          </div>
            <hr>
          <h3>Human Geography</h3>
          <div>
            Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf' target='_blank'>Human Geography Worksheet</a>
              <br />
            Click Course-box links to go to UVic Catalogue item
              <br /><br />
            <iframe style='height:790px; width:100%' src='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf'></iframe>
          </div>
            <hr>
        <h3>Physical Geography</h3>
          <div>
            Embedded pdf file from <a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf' target='_blank'>Physical Geography Worksheet</a>
              <br />
            Click Course-box links to go to UVic Catalogue item
              <br /><br />
            <iframe style='height:790px; width:100%' src='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf'></iframe>
          </div>
         ")
  }) # end of Output: Data Viz: Flowcharts

  ## -----------------------------------------
  #   # Output: mermaid    diagramme
  output$diagram1 <- renderDiagrammeR({
    mermaid("graph LR;
A[Geography Major BA]
B[Focus: Environment]
E1[GEOG 101A]
E2[GEOG 101B]
E3[GEOG 103]
E4[GEOG 130]
E5[GEOG 226]
E6[GEOG 230]
E7[GEOG 252]
E8[GEOG 304]
E9[GEOG 353]
E10[GEOG 438]
E11[GEOG 453]

B-->A;
E1-->E5;
E3-->E5;
E4-->E6;
E7-->E8;
E7-->E9;
E9-->E11;
")
  })

  ## -----------------------------------------
  #   # Output: mermaid    diagramme
  output$diagram2 <- renderDiagrammeR({
    mermaid("graph LR;
A[Geography Major BA]
B[Focus: Geomatics]
D[Focus: Human]
E[Focus: Environment]
F[Focus: Physical]

A-->B;
A-->D;
A-->E;
A-->F;
")
  })

  ## -----------------------------------------
  #   # Output: Gantt2    diagramme
  output$diagram <-
    DiagrammeR::renderDiagrammeR({
      DiagrammeR::mermaid(
        base::paste0(input$inText)
      )
    }) # end of Output: Gantt2    diagramme

  # ## -----------------------------------------
  #   # Output: Template
  #   output$template <- renderUI({
  #     sp1 <- paste("")
  #     sb <- br()
  #     sp2 <- tags$iframe(style="height:850px; width:100%", src="")
  #     HTML(paste(sp1, sb, sp2))
  #   }) # end of Output: Template

## -----------------------------------------
  # Output: Concept Maps:
  output$conceptmap <- renderUI({
    sc6 <- paste("
<html><head><title>Geog_earth_systems_2012-13.vue</title><script src='http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js' type='text/javascript'></script>
<script type='text/javascript'> jQuery.noConflict(); </script>
<script src='http://vue.tufts.edu/htmlexport-includes/jquery.maphilight.min.js' type='text/javascript'></script>
<script src='http://vue.tufts.edu/htmlexport-includes/v3/tooltip.min.js' type='text/javascript'></script>
<script type='text/javascript'>jQuery(function() {jQuery.fn.maphilight.defaults = { fill: false, fillColor: '000000', fillOpacity: 0.2, stroke: true, strokeColor: '282828', strokeOpacity: 1, strokeWidth: 4, fade: true, alwaysOn: false } jQuery('.example2 img').maphilight(); }); </script>
<style type='text/css'> #tooltip{ position:absolute; border:1px solid #333; background:#f7f5d1; padding:2px 5px; color:#333; display:none; } </style> </head>
<body>
<h2>Concept Maps</h2>
<div><em><strong>Note:</strong> This concept map is from 2016 (with outdated information), with a different visualization technique.</em><br /><br /><strong>To Use: </strong>Click Course-box links to go to UVic Catalogue and registration. Links open in a new window (because back button won't return to same page) - Close new window to return to app</div>
<br />
<div class='example2'><img class='map' src='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/Geog_earth_systems_2015-16.png' width='1018.0' height='827.0' usemap='#vuemap'><map name='vuemap'>
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
HTML(paste(sc6))
  }) # end of OUtput: Concept Maps

## -----------------------------------------
  # Output: Dataviz
  output$dataviz <- renderUI({
    HTML("
         <h2>Data Vizualization of Study Focus Pathways</h2>
         <div>
            <strong>To Use:</strong> Hover over or click any course to see other linked courses<br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scroll sideways to see all 4 Years<br /><br />
            Embedded webpage from <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/interact-flow-edit.html' target='_blank'>Interactive Study Focus Pathways</a>
              <br /><br />
            <iframe style='height:790px; width:100%' src='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/interact-flow-edit.html'></iframe>
         </div>
         ")
  }) # End Output: Dataviz

## -----------------------------------------
  # Output: Links
  output$links <- renderUI({
    HTML("
         <h2>Links to Geog Course Info</h2>
         <div>
              <em>Note: These links open in a new window, as back button won't return to same page<br />Close new window to return to app</em>
                <hr>
            <h3>UVic Course Catalogue</h3>
              <ul>
                <li><a href='https://www.uvic.ca/calendar/future/undergrad/index.php#/content/62daf5e88b7d47001d0fc385' target='_blank'>Undergrad Calendar</a></li>
                <li><a href='https://www.uvic.ca/calendar/future/undergrad/index.php#/programs/H1e0D6Q0GN?searchTerm=geography&bc=true&bcCurrent=Geography&bcItemType=programs' target='_blank'>Undergrad calendar Admission Requirements</a></li>
                <li><a href='https://www.uvic.ca/calendar/future/undergrad/index.php#/Courses?group=Geography%20(GEOG)&bc=true&bcCurrent=Geography%20(GEOG)&bcItemType=Courses' target='_blank'>List of Geography Courses Linked to Calendar</a></li>
                <li><a href='https://www.uvic.ca/socialsciences/geography/undergraduate/advising/study-focus-areas/index.php' target='_blank'>Study Focus Areas</a></li>
              </ul>
                <hr>
            <h3>Course Planning Worksheet and Flowcharts</h3>
              <ul>
                <li><a href='https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf' target='_blank'>Geography Major Planning Worksheet</a></li>
                <li><a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf' target='_blank'>Environment and Sustainability Flowchart</a></li>
                <li><a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf' target='_blank'>Geomatics Flowchart</a></li>
                <li><a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf' target='_blank'>Human Geography Flowchart</a></li>
                <li><a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf' target='_blank'>Physical Geography Flowchart</a></li>
              </ul>
         </div>
         ")
    # TemplateLinks template
    # <hr>
    #   <h3></h3>
    #   <ul>
    #       <li><a href='' target='_blank'></a></li>
    #       <li><a href='' target='_blank'></a></li>
    #       <li><a href='' target='_blank'></a></li>
    #       <li><a href='' target='_blank'></a></li>
    #       <li><a href='' target='_blank'></a></li>
    #   </ul>
  }) # end Output: About: Links


  ## -----------------------------------------
  # Output: Tests:
  #
    output$test1 <- renderUI({
      strings1 <- paste("Testing ... Testing ... 1,2,3")
      HTML(paste(strings1))
    }) # end Output: Tests

    output$test2 <- renderUI({
      strings1 <- paste("Nesting Trials 2")
      HTML(paste(strings1))
    }) # end Output: Tests

    output$test3 <- renderUI({
      strings1 <- paste("Nesting Trials 3")
      HTML(paste(strings1))
    }) # end Output: Tests

    output$test4 <- renderUI({
      strings1 <- paste("Nesting Trials 4")
      HTML(paste(strings1))
    }) # end Output: Tests



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
## ################ About Begins ###########
## -----------------------------------------

## -----------------------------------------
  # Output: About: About
  output$about <- renderUI({
    HTML("
         <h2>About this app</h2>
          <div class='divwidth'>
            <p>This experimental Shiny code sandbox was created to develop an online, interactive interface to facilitate Geography Course Student Planning.</p>
          </div>
         ")
    #paste("Code from https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r")
  }) # end Output: About:

  ## -----------------------------------------
  # Output: About: Coding
  output$code <- renderUI({
    HTML("
         <h2>Coding</h2>
          <div>
            <a href='https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/GeogInteractive/app.R' target='_blank'>Shiny App Code on GitHub</a>
              <br /><br />
            Filtered table code adapted from Stackoverflow <a href='https://stackoverflow.com/questions/53499066/downloadhandler-with-filtered-data-in-shiny' target='_blank'>Downloadhandler with filtered data in Shiny</a>
          </div>
         ")
  }) # end Output: About: Coding

  #
  # <ul>
  #   <li></li>
  #   <li></li>
  #   <li></li>
  # </ul>

## -----------------------------------------
  # Output: About: History
  output$history <- renderUI({
    # shh <-
    HTML("
    <h3>History of Changes</h3>
        <hr>
    <h4>2023-01-15</h4>
      <ul>
        <li>Changed Tab Names and Work Tabs Nesting</li>
      </ul>
    <h4>2023-01-14</h4>
      <ul>
        <li>Created <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/DataTable-shiny-to-web-tabs.html'>Shiny App Web Clone</a></li>
      </ul>
    <h4>2023-01-13</h4>
      <ul>
        <li>Created <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/DataTable-shiny-to-web-tabs.html'>Shiny App Web Clone</a></li>
        <li>Experimented with js tables in HTML - able to get it searching so far! <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/test/DataTable-shiny-to-web.html'>Test Web Table</a></li>
        <li>Tabs now have different background-color, based on UVic Style colour for Geography</li>
        <li>Converted Shiny output$ code from paste('') to HTML('')</li>
      </ul>
    <h4>2023-01-12</h4>
      <ul>
        <li>Finished Course data copy/paste from catalogue</li>
        <li>Data Flow Diagrams and Gantt Charts</li>
        <li>Time Log Data Mining >> create GGPlot2 Chart</li>
      </ul>
    <h4>2023-01-11</h4>
      <ul>
        <li>Add links to course planning flow charts</li>
        <li>Updated more course data, including Study Focus</li>
        <li>Table cells now have no row number, and align to top</li>
      </ul>
    <h4>2023-01-10</h4>
      <ul>
        <li>Add tabs to single page app & publish</li>
      </ul>
    <h4>2023-01-09</h4>
      <ul>
        <li>Created filtered table with downloadable csv button</li>
        <li>Published single page app with filtered table</li>
      </ul>
    <h4>2023-01-08</h4>
      <ul>
        <li>Adding nested links</li>
        <li>Adding images to title header</li>
      </ul>
    <h4>2023-01-07</h4>
      <ul>
        <li>Created Shiny app as testing ground for sandbox experiments</li>
        <li>e.g. Table, iframe embedding of interactive maps</li>
      </ul>
    <h4>2023-01-06</h4>
      <ul>
        <li>Disected code from Interactive gaming website https://hanns.io/pi/</li>
      </ul>
    <h4>2023-01-05</h4>
      <ul>
        <li>David Atkinson, UVic Geog Chair, asked if I would be interested in helping develop an online, interactive interface to Geography Course Planning</li>
        <li>Sent David link to Interactive Concept Map</li>
      </ul>
                 ")
  }) # end Output: About: History

## -----------------------------------------
  # Output: Questions
    output$questions <- renderUI({
      HTML("<h3>Questions</h3>
          <ul>
          <li>What form of reporting is required from me, and how often?</li>
          <li>What font to use (e.g. Serif: Times Roman, or Sans-serif)?</li>
          <li>What's involved with setting up a Geog Shiny Server (ask Rick about this)?</li>
          <ul>
            <li>**Rick Sykes:** Can a Shiny Server be installed?</li>
          </ul>
          <li>What format to use for Course Name?  >> change database
	- GEOG103, Geog103, or Geog 103 >> I chose **GEOG 103</li>
          <li>Make a list of questions to ask David, John, or the student body that David mentioned</li>
          <li>Ask some students what kind of format they like to search geography courses for when planning for example the geography student SOGS, have some examples online and choose make a POLL,test drive</li>
          <ul>
            <li>**Students**: What info would students like to find?</li>
          </ul>
          </ul>
<!--
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
-->
                        ")
    }) # end Output: Questions

## -----------------------------------------
    # Output: Wishlist
    output$wishlists <- renderUI({
      HTML("
      <h3>Need</h3>
          <ul>
          <li>**Data** list of popular electives, class size</li>
          <li>**Data** list of Summer course</li>
          <li>Courses, prerequisites (check to see I have them all)</li>
          </ul>

      <h3>Wishlist</h3>
          <ul>
          <li>Use Chrome Audio Capture extension to record use of app chrome-extension://kfokdmfpdnokpmpbjhjbcabgligoelgp/complete.html</li>
          <li>Video tutorials</li>
          <li>Description for use</li>
          <li>Screenshots</li>
          <li>Presentation of current state/progress, use .rmd, create slides </li>
          <li>Create Gantt chart timeline for progress, completion, meetings, target dates (started 2023-01-12)</li>
          <li>Document workflow, create tab, nest in history </li>
          <li>try making new filter table save csv into one of the test tabs, output like table tab</li>
          <li>add save image / pdf ???</li>
          <li>Create form to fill out based on <a href='https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf'>Program Worksheets</a></li>
          <li>Need a `clear search button` for datatable</li>
          <li>Save image of concept maps</li>
          <li>Highlight path between courses/pre-requisites/concentrations</li>
          </ul>
<!--
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
-->
          <h3>Functions Wishlist</h3>
          <ul>
          <li>Interactive</li>
          <li>Click for more information, link to course catalog</li>
          <li>Highlight the pathways between courses when clicked, or hovering</li>
          <li>Choosing courses will create a dynamic map of prerequisites and future potential</li>
          <li>Choose a path‘s which would be highlighted</li>
          <li>Mobile device and desktop</li>
          <li>Fill in form, like paper form to list courses courses, colour coordinated for once already taken versus ones under consideration</li>
          <li>Ability to print results</li>
          <li>Take image of results</li>
          <li> R shiny interface, different panels with tables, mind map, courses completed, course wish list >> Getting there ...</li>
          </ul>
<!--
<a href=''></a> <a href=''></a>
<a href=''></a> <a href=''></a> <a href=''></a>
<a href=''></a> <a href=''></a> <a href=''></a>
-->
<!--
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
-->
          <h3>Ideas</h3>
          <ul>
          <li><a href='https://app.banner.pdx.edu/cpg/#'>3-Year Course Projections</a></li>
          <li><a href='https://www.georgiancollege.ca/mypath/#video'>Video Orientation</a></li>
          <li><a href='https://www.uvic.ca/services/advising/choose-plan/program-outlines/index.php'>Program Planning</a></li>
          <li><a href='https://www.uvic.ca/socialsciences/geography/undergraduate/advising/study-focus-areas/index.php'>UVic Geog Study Focus Areas</a></li>
          <li><a href='https://www.sccollege.edu/Departments/Counseling/Pages/Online_Education_Plan.aspx'>Online_Education_Plan</a></li>
          <li><a href='https://www.georgiancollege.ca/mypath/#about'>MyPath</a></li>
          </ul>
")
    }) # end Output:Work

## -----------------------------------------
    # Output: To Do
    output$todo <- renderUI({
      HTML("<h3>To Do</h3>
          <ul>
          <li>Can I create HTML webpage from shiny app source code? e.g. hard code links for JavaScript and CSS files write js code?</li>
            <ul><li><strong>Started a web template (2023-01-13), got a seaerchable table working: <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/test/DataTable-shiny-to-web.html'>Searchable Web Table</a></strong></li></ul>
          <li>Update Data Vizualization of Study Focus Pathways <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/interact-flow-edit.html'>Curriculum Maps</a></li>
          <li>Change color of Datatable select (from blue)</li>
          <li>Start to fill-in/update missing course info for Geography Course data table</li>
          <li>Figure out how to use hyperlinks in datatable <a href=' https://stackoverflow.com/questions/73449491/shiny-datatable-hyperlink-column'>shiny-datatable-hyperlink-column</a></li>
          <li>Filter new data table >> choose only columns necessary for filtered search > save to csv
          <li>Use Course Planning Flowchart pdfs:
			<a href='https://uvic.ca/socialsciences/geography/undergraduate/advising/study-focus-areas/index.php#Human-Geog'>Focus Areas: Human</a>,
			<a href='https://www.uvic.ca/services/advising/choose-plan/program-outlines/index.php'>Program Outlines</a>,
			<a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/physical-geography.pdf'>Physical</a>,
			<a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/human-geography.pdf'>Human</a>,
			<a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/environment-and-sustainability.pdf'>Environment</a>,
			<a href='https://www.uvic.ca/socialsciences/geography/assets/docs/Geogplan%20pdfs/geomatics.pdf'>Geomatics</a>
			</li>
<!--			 <a href=''></a> <a href=''></a> <a href=''></a> <a href=''></a> <a href=''></a> <a href=''></a> -->
          <li>Change Colour of Shiny Tabs: <a href='https://stackoverflow.com/questions/35025145/background-color-of-tabs-in-shiny-tabpanel'>Background Tab Colour</a></li>
          <li>Shiny dashboard, different styles, using more of main space, don't use sidebar</li>
          <li>Multi year calendar planner</li>
          <li>Note which courses student has taken</li>
          <li>Convert to PHP, update training on UVic website</li>
          <li>create a form ... add courses (to a form like the planning pdf) for planning purposes; radio buttons / select from list to populate fields >>> save as pdf</li>
          <li>update vIz chart with more courses, figure out how to add relationships to table?</li>
          <li>Add program requirements page / tab</li>
          <li>Add resources tab, links </li>
          <li>Use paper notebook for design ideas, flowcharts </li>
          <li>Make tabs figure bigger</li>
          <li>Take screenshots of each version of the app Shiny app that I create, upload and publish</li>
          </ul>
<hr>

<!--
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li><a href=''></a></li>
          <li><a href=''></a></li>


-->
          <h3>Done ✅</h3>
          <ul>
          <li><strong>Started a web template, got a seaerchable table working: <a href='https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/test/DataTable-shiny-to-web.html'>Searchable Web Table</a></strong></li>
          <li>add signature footer to bottom of page</li>
          <li>Embed links to geography interactive pdf concept maps</li>
          <li>copy/paste Geog course data to datatable (Completed 2023-01-12) ✅  </li>
          <li>DT table row justified to top of cell - also remove remove row number (done 2023-01-11)</li>
          <li>make interactive pdf >> Adobe Acrobot Pro (2023-01-09) >> wrote workflow >> see above</li>
          <li></li>
          <li>Get download button to work with filtered data see new web link</li>
          <li>List of Geography Courses</li>
          <li> **Computer Registration:** Can a 'back-door access link' be obtained to bypass clunky search</li>
          </ul>
                        ")
    }) # end Output:Work

## -----------------------------------------
  # Output: timelogplot
  output$timelogplotstack <- renderPlotly({

    # this is aborting the soession when I click on this tab
    tl <- read.csv("TimeLog-Current.csv")

    ggplot(tl, aes(x = Date, y = TotalTimeHr)) +
      geom_bar(aes(color = TaskType, fill = TaskType),
               stat = "identity", position = position_stack()) +
      labs(title = "Task Time Log",
           subtitle = "Geog Interactive Course Explorations",
           caption = "UVic Geography Wendy Anthony 2023",
           x = "Date", y = "Total Hours") +
      # theme_classic() +
      theme_bw() +
      theme(legend.title = element_blank()) # this needs to go after theme_classic
  # end ggplot -------------

      }) # end Output: timelogplot

  ## -----------------------------------------
  # Output: timelogplot
  output$timelogplotside <- renderPlotly({

    # this is aborting the soession when I click on this tab
    tl <- read.csv("TimeLog-Current.csv")

    ggplot(tl, aes(x = Date, y = TotalTimeHr)) +
      geom_bar(aes(color = TaskType, fill = TaskType),
               stat = "identity", position = "dodge") +
      labs(title = "Task Time Log",
           subtitle = "Geog Interactive Course Explorations",
           caption = "UVic Geography Wendy Anthony 2023",
           x = "Date", y = "Total Hours") +
      # theme_classic() +
      theme_bw() +
      theme(legend.title = element_blank()) # this needs to go after theme_classic
    # end ggplot -------------

  }) # end Output: timelogplot

## -----------------------------------------
    #   # Output: TotalHours
    output$totalhours <- renderUI({
      tl_hours <- read.csv("TimeLog-Current.csv")
      TotalHours <- sum(tl_hours[, 'TotalTimeHr'])
      TotalHours
    }) # end of Output: Gantt


## -----------------------------------------
  #   # Output: Gantt
  output$gantt <- renderUI({
    HTML("<h2>Gantt Chart for Planning Timelines</h2>
                 <span><strong>To Use: </strong>Fill text in text box to update Gantt Chart; <br />This data is not saved locally, but is deleted when exiting page; <br />Page must be edited in original Shiny.R file</span>
                 <br /><br />")
  }) # end of Output: Gantt

## -----------------------------------------
} # end of server function

## -----------------------------------------
# Run app
shinyApp(ui, server)
