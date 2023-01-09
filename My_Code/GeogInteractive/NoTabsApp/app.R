# https://stackoverflow.com/questions/53499066/downloadhandler-with-filtered-data-in-shiny

## -------------------
## WORKS >>> LETS RUN WITH THIS ONE
## CHOOSE LESS COLUMNS TO MAKE SEARCH BOXES SMALLER ??
## -------------------

# ---------------------
# load libraries
library(shiny)
library(shinyWidgets) # set background color
library(DT) # datatable

# ---------------------
# Choose file to read
tbl <- read.csv("Geog-Course-flowcharts.csv", header = TRUE, sep = ",", stringsAsFactors=TRUE)

# ---------------------
# Define UI ----
ui <- fluidPage(
    setBackgroundColor("bonewhite"),
      titlePanel(title = span("UVic Geography Course Exploration", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
      tags$img(src = "https://www.uvic.ca/brand/assets/images/graphics/misc/Dynamic-edge.jpg", height = 50, width = "100%"),

          span("* To Filter Courses: choose (multiple) Courses from first search box under Course column name"),
          br(),
          span("* Download filtered courses with button at bottom of table"),
          hr(),

    # datatable
    DT::dataTableOutput("dt"),  # datatable

    # helpText(" Select the download format"),
    radioButtons("type", "Select Format type:",
    choices = c("CSV", "Text (Space Separated)", "Doc")),
    # Download button needs to be after datatable to be able to save filtered data
    # helpText(" Click on the download button to download the filtered Dataset"),
    ### tags$head() is to customize the download button
    tags$head(tags$style(".butt{background-color:#69A81D;} .butt{color: #e6ebef;}")),
    downloadButton("download_filtered", "Download Filtered Data", class="butt"),
    br(),
    hr(),
    h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-07",
    align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
    text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
    h6("Code adapted from https://stackoverflow.com/questions/53499066/downloadhandler-with-filtered-data-in-shiny",
    align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
    text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),

) # fluidPage ends

# ---------------------
server <- function(input, output) {

    #!!  datatable output
    output$dt <- DT::renderDataTable({
    datatable(tbl, filter = "top", options =  list(pageLength = 10))
    })

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
                write.csv(tbl[input[["dt_rows_all"]], ],
                file= file,
                row.names=F)
                }
      ) # end of downloadHandler
# ---------------------
} # end of server function

shinyApp(ui, server)
