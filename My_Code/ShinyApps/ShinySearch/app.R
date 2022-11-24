## based on idea from https://medium.com/@michaeltvu/local-file-searching-application-using-r-and-shiny-app-782f53a0305e
###
## Adding download buttons
## https://stackoverflow.com/questions/50039186/add-download-buttons-in-dtrenderdatatable

# file_list <- file.info(list.files(path = "/Users/wanthony/Documents/R/", recursive = TRUE, ignore.case = TRUE,  full.names = TRUE))
# file_list <- data.frame(file_list)
# print(file_list)

library(shiny)
library(tidyverse)
library(dplyr)
library(DT)

shinyApp(
  ui = basicPage(
    h1("Find Files Info App"),
    tags$style(HTML("body {font-size: 12px; color: grey; background-color: Ivory;}
                    h1, h2 {font-size: 30px; color: purple;}
                    .shiny-input-container {color: purple; font-size: 16px;}
                    .shiny-bound-input {color: black; font-size: 12px;}
                        /* label for directory input box */
                    #dir_input-label {color: purple;}
                        /* input text for directory input box */
                    #dir_input.form-control.shiny-bound-input {color: black;}
                    #dir_input.form-control {background-color: Azure; height: 30px;}
                    .input-group {background-color: Azure; height: 15px;}
                    #pattern_input.form-control {background-color: Azure; height: 30px;}
                    #dir_input {font-size: 12px;}
                    #file_list_dir {background-color: Ivory;}
                    #dataTables_filter {background-color: Azure;}
                    th {background-color: Ivory;}
                    .dataTables_length {background-color: Ivory;}
                        /* Search filter */
                    #DataTables_Table_0_filter {background-color: Ivory;}
                        /* Table cells */
                    #DataTables_Table_0 {background-color: Azure;}
                    .dt-buttons {margin-left: 50px;}
                    ")),
    textInput("dir_input",
              value = "/Users/wanthony/Documents/R",
              "Enter the directory:", placeholder = "Please paste your directory",
              width = "300px"),
    em("(e.g. Don't include trailing / ... /Users/wanthony/Documents/R')"),
    br(),
    em("(e.g. '/Volumes/MyPassportForMac/Documents/!My-Personal-Stuff')"),
    br(),
    br(),
    textInput("dir_base",
              value = "/Users/wanthony/Documents/",
              "Paste base directory (for better output):", placeholder = "Paste base directory",
              width = "300px"),
    br(),
    fileInput("mydir", "Browse to find directory name"), # this allows a local file to be chosen and uploaded!
    textInput("pattern_input", value = ".*$","Enter the file pattern:", placeholder = "Please add file pattern e.g. .pdf$"),
    em("(e.g. .pdf$, .txt$, .*$)"),
    br(),
    hr(),
    h2("Table of Info about the files"),
    dataTableOutput("file_list_dir"),
    br(),
    hr(),
    htmlOutput("html_test"),
    br(),
    hr(),
    div("Experiments with initial idea from: ",
        tags$br(),
        style = "text-align: center;",
        tags$a(href="https://medium.com/@michaeltvu/local-file-searching-application-using-r-and-shiny-app-782f53a0305e", "Create Your Own Google Using R and Shiny App")),
    br()
  ),

  server = function(input, output) {

    output$file_list_dir <- renderDataTable(server = FALSE, {
        # server = FALSE downloads whole table even if not all results are shown on page
      file_list <- file.info(list.files(path = input$dir_input, recursive = TRUE, ignore.case = TRUE,  full.names = TRUE))
      file_list <- data.frame(file_list)

      # proof case for specific path
      # file_list <- file.info(list.files(path = "/Users/wanthony/Documents/R", recursive = TRUE, ignore.case = TRUE,  full.names = TRUE))
      # file_list <- cbind(rownames(file_list), data.frame(file_list, row.names=NULL))
      # colnames(file_list)[1] <- "filepath"
      # file_list

      # get base file names
      file_list$filename = basename(rownames(file_list))
      file_list$dirname = dirname(rownames(file_list))

      # make row names into first column
      file_list <- cbind(rownames(file_list), data.frame(file_list, row.names=NULL))
      # rename first column
      colnames(file_list)[1] <- "filepath"

      #string split _ remove base of dir
      library(stringr)
#      file_list$dir <- file_list$dirname %>% str_replace("/Users/wanthony/Documents/", "")
      file_list$dir <- file_list$dirname %>% str_replace(input$dir_base, "")

      # create new column for file link
      file_list["filelink"] <- paste("file://", file_list$dir, "/", file_list$filename, sep = "")
      file_list["clicklink"] <- paste('<a href="', file_list$filepath, '" target="_blank" class="btn btn-primary link">', file_list$filename, '</a>', sep = "")
      file_list["pathclicklink"] <- paste('<a href="', file_list$filepath, '" target="_blank" class="btn btn-primary link">', file_list$filepath, '</a>', sep = "")
      file_list["path_sep_clicklink"] <- paste(file_list$dir, "/  ", '<a href="', file_list$filepath, '" target="_blank" class="btn btn-primary link">', file_list$filename, '</a>', sep = "")
      file_list["date_path_sep_clicklink"] <- paste(file_list$mtime, "  >>  ", file_list$dir, "/  ", '<a href="', file_list$filepath, '" target="_blank" class="btn btn-primary link">', file_list$filename, '</a>', sep = "")

      # select columns from df
      file_list <- file_list %>% select(dir, filename, size, mtime, ctime, filelink, clicklink, filepath, pathclicklink, path_sep_clicklink, date_path_sep_clicklink)

# created datatable with buttons
      DT::datatable(file_list,
                    extensions = 'Buttons', # adds the buttons listed below
                    list(searchHighlight = TRUE,
                        pageLength = 2000,
                        lengthMenu = c(10, 25, 50, 100, 500, 1000, 2000),
                        dom = 'lfBpiSrtQ', # dom = 'tB' doesn't show search or paging  lfipBSrtQ
                        paging = TRUE,
                        scrollX=TRUE,
                        searching = TRUE,
                        ordering = TRUE,
                        buttons = c('copy', 'csv', 'excel', 'pdf'))) # default = 10
      # dom l=length changing input control; b=Button; S=scroller; Q=SearchBuilder
      # i=table info summary; p=pagination control; f=filtering input
      # t=the table; r=processing display element

      # DataTables warning: table id=DataTables_Table_0 - Requested unknown parameter '3' for row 0, column 3.
      # For more information about this error, please see http://datatables.net/tn/4
      # had to list which columns to include ... didn't like column 3 mode
    })

  }
)
