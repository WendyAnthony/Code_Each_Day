##################################################
# Re-working my code 2023-01-07
# for UVic Geog Interactive Course search
# from Wendy's Native Plants Phenological Data
# 2021-08-18
# 2022-12-15 Got reactive code to work for select
# based on code from
# https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r
##################################################

library(shiny)
library(dplyr) # to use %>% pipes
library(DT) # to create data table
getwd()

##################################################
##################################################

# Data import and subset
geog_course <- read.csv("Geog-Course-flowcharts.csv", stringsAsFactors = F)

# Data clean
geog_course_cl <- subset(geog_course, select = -code)
geog_course_cl$CourseName <- paste(geog_course_cl$Course, "", geog_course_cl$Name)

str(geog_course_cl)
colnames(geog_course_cl)

# code from </R/Shiny/ShinyDatabase/FilterTest/DatasetFilter/app-copy.R>
is.not.null <- function(x) !is.null(x)

##################################################
# app
##################################################

# Define UI for application
ui <- fluidPage(
    # Application title
    titlePanel("UVic Geography Course Exploration"),
    p("Shiny code experiments by Wendy Anthony 2023-01-07"),
    br(),br(),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        uiOutput("course"),
        # uiOutput("CourseName"),
        uiOutput("name")
      ),
      mainPanel(
        # leafletOutput("Map"),
        tabsetPanel(type = "tabs",
                    tabPanel("Table", DT::dataTableOutput("table_subset")),
                    tabPanel("About", tableOutput("text")),
                    tabPanel("Code",  tableOutput("code")),
                    tabPanel("Data Viz", tableOutput("dataviz"))
                    )
              )
    ),
)

########################################
# Define server logic
server <- function(input, output) {

  geodata <- geog_course_cl
  # ---------------------
  output$table <- DT::renderDataTable({
    if(is.null(geodata)){return()}
    DT::datatable(geodata, options = list(scrollX = T))
  })

  output$course <- renderUI({
    selectInput(inputId = "Course", "Select Course Number(s)",
                selected = "", choices = var_course(), multiple = T)
  })
#   https://shiny.rstudio.com/reference/shiny/latest/selectinput
  output$name <- renderUI({
    selectInput(inputId = "Name", "Select Course Name(s)",
                selected = "", choices = var_name(), multiple = T)
  })

  # ---------------------
  # Reactive Filtered data
  # must refere toreactive object data_filtered() using the ()
  # <<< makes leaflet map reactive
  # https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny
  data_filtered <- reactive({
    filter(geog_course_cl, Course %in% course(), Name %in% name())
    #     filter(pheno_subset_sub, Species %in% species(), CommonName %in% commonName(), LocName %in% locName())
  })

  course <- reactive({
    if (is.null(input$Course)) unique(geog_course_cl$Course) else input$Course
  })

  name <- reactive({
    if (is.null(input$Name)) unique(geog_course_cl$Name) else input$Name
  })

  # ---------------------
  # Get available categories
  var_course <- reactive({
    file1 <- geodata
    if(is.null(geodata)){return()}
    as.list(unique(file1$Course))
  })

  var_name <- reactive({
    file1 <- geodata
    if(is.null(geodata)){return()}
    as.list(unique(file1$Name))
  })

  # ---------------------
  # Reactive Output table
  output$table_subset <- DT::renderDataTable({
    DT::datatable(data_filtered(), options = list(scrollX = T))
  })

  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  output$text <- renderUI({
        str1 <- paste("I started trying to code this app 2021-08-18 for phenology photo mapping, but couldn't get the selection to respond in the table and map. 2022-12-15 Learned how to get reactive code to work. 2023-01-07: Try out for Geog Interactive Project")
        str2 <-   tags$a(href='https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r', 'Code Base for Making Selected Inputs Reactive on Stack Overflow', target="_blank")
          #paste("Code from https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r")

        str3 <- paste("Tip: Try search box to filter observations e.g. '103'")
        HTML(paste(str1, str2, str3, sep = "<br /><br />"))
  })

  output$code <-renderUI({
    string1 <- tags$a(href='https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/GeogInteractive', 'Shiny app code on GitHub', target="_blank")
    HTML(paste(string1))
  })

  output$dataviz <- renderUI({
    strg1 <- paste("A place to test data vizualilzations")
    HTML(paste(strg1))
  })

############
# last curly bracket needed to complete server function
}

# Run application
shinyApp(ui = ui, server = server)
