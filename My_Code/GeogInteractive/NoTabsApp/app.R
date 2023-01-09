# https://stackoverflow.com/questions/53499066/downloadhandler-with-filtered-data-in-shiny

## -------------------
## LETS RUN WITH THIS ONE
## CHOOSE LESS COLUMNS
## TO MAKE SEARCH BOXES SMALLER ??
## -------------------
library(shiny)
library(shinyWidgets) # set background color
library(DT)

# Choose file to read
tbl <- read.csv("Geog-Course-flowcharts.csv", header = TRUE, sep = ",", stringsAsFactors=TRUE)

# Define UI ----
# change from navbarPage to fluidPage
ui <- fluidPage(
  setBackgroundColor("bonewhite"),
  titlePanel(title = span("UVic Geography Course Exploration", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://www.uvic.ca/brand/assets/images/graphics/misc/Dynamic-edge.jpg", height = 50, width = "100%"),

  # Download Button is at Bottom
  # div(h3("Download")),
  # helpText(" Select the download format"),
  # radioButtons("type", "Select Download Format type:",
  #              choices = c("CSV", "Text (Space Separated)", "Doc")),
  # ### tags$head() is to customize the download button
  # tags$head(tags$style(".butt{background-color:#69A81D;} .butt{color: #e6ebef;}")),
  # downloadButton("download_filtered", "Download Filtered Data", class="butt"),
  # br(),br(),
    # this span appears within top of data table

  span("* To Filter Courses: choose (multiple) Courses from first search box under Course column name"),
  br(),
  span("* Download filtered courses with button at bottom of table"),
  hr(),
  # span("choose (multiple) Courses from first search box under Course column name"),
     # br(),br(),
           DT::dataTableOutput("dt"),  #datatable
           # helpText(" Click on the download button to download the filtered Dataset"),
           # p("Below are the row indices of the data."),
           # verbatimTextOutput("filtered_row"),
           # br(),
           # helpText(" Click on the download button to download the filtered Dataset"),
     # # Download Button needs to be at Bottom
     # div(h3("Download")),
     # helpText(" Select the download format"),
     radioButtons("type", "Select Format type:",
                  choices = c("CSV", "Text (Space Separated)", "Doc")),
     ### tags$head() is to customize the download button
     tags$head(tags$style(".butt{background-color:#69A81D;} .butt{color: #e6ebef;}")),
     downloadButton("download_filtered", "Download Filtered Data", class="butt"),
     br(),
  hr(),
  h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-07", align="center", style = "font-family: sans-serif;
    font-weight: 1px; font-size: 10px; text-shadow: 0px 0px 1px #aaa; line-height: 1;
     color: #404040;"),

     # when trying to add a span of code
     # Warning: Navigation containers expect a collection
     # of `bslib::nav()`/`shiny::tabPanel()`s and/or `bslib::nav_menu()`/`shiny::navbarMenu()`s.
     # Consider using `header` or `footer`
     # if you wish to place content above (or below) every panel's contents.

    #  # sidebarLayout end
    #  hr(),
    #  h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-07", align="center", style = "font-family: sans-serif;
    # font-weight: 1px; font-size: 10px; text-shadow: 0px 0px 1px #aaa; line-height: 1;
    #  color: #404040;"),

  ) # Navbar page ends

server <- function(input, output) {

  #!! I've moved the datatable directly in here as 'thedata()' was a bit redundant and confusing
  output$dt <- DT::renderDataTable({
    datatable(tbl, filter = "top", options =  list(pageLength = 10))
  })

  # #bottom panel with row indices
  # output$filtered_row <-
  #   renderPrint({
  #     input[["dt_rows_all"]]
  #   })

  #file extension for download
  fileext <- reactive({
    switch(input$type,
           "CSV" = "csv", "Text" = "txt", "Doc" = "doc")
  })

  # Download button
  output$download_filtered <- downloadHandler(
    filename = function() {
      paste("GeographyCourses-FilteredData-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      #!! Use tbl and not 'thedata()' to filter. tbl is the data, the other was the datatable
      write.csv(tbl[input[["dt_rows_all"]], ],
                file= file,
                row.names=F)
    }
  )

}

shinyApp(ui, server)
