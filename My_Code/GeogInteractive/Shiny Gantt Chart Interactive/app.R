## -----------------------------------------
## -----------------------------------------
## Gantt Shiny App File created by Wendy Anthony
## 2023-01-26  updated 2023-02-03 04:55
## for Interactive UVic Geography Course Planning
## app inspiration from:
## https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
## -----------------------------------------
## -----------------------------------------

## Load Shiny Library ----------------------
# uncomment the install.packages code to
# install packeage, then re-comment to avoid
# intalling packages each time the app is run
# calling the library after installation is enough
#
#
# install.packages("shiny")
# install.packages("DiagrammeR")
library(shiny)
library(DiagrammeR)

## -----------------------------------------
## Define UI for app -----------------------
ui <- fluidPage(

  ## ---------------------------------------
  ## Application title -------------------
  titlePanel(title = span("Interactive Shiny Gantt Time Management Chart", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #f0f6e8;} .button{margin: auto;}
                       .button-center{text-align: left;}")),

  ## ------------------------------------------
    ## Sidebar with some input ----------------
    sidebarLayout(

      ## --------------------------------------
      ## Begin sidebarPanel -------------------
        sidebarPanel(

          ## Begin Intro Note --------------------------------------
          #tags$b("How to use this interactive Gantt Chart"),

          ## End Intro Note --------------------------------------

                    ## Begin Gantt tableOutput -----------------------------------
          ## -------------------------------------------------------
          # https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
          tableOutput("gantt"),

                   ## Begin Gantt textInput -----------------------------------
                   ## -------------------------------------------------------
                   textAreaInput(inputId = "inText", label = NULL, width = "500px", height = "750px", rows = 55, value = "
gantt
dateFormat  YYYY-MM-DD

title Course Planning Gantt Chart

section GEOG XXX
Course Duration               :               first_1,    2023-01-09, 2023-04-06

section Research Project
Choose Topic                  :done,          third_1,    2023-01-09, 10d
Collecting Data               :active,        third_2,    after third_1, 10d
Readings                      :active         third_3,    after third_1, 40d
Write Report                  :               third_4,    after third_3, 5d
Edit Report                   :               third_5,    after third_4, 5d
Report Due                    :crit,          third_6,    2023-02-13, 1d

section Assignments
Assignment 1                  :crit, done,    import_1,   2023-01-09, 24d
Assignment 2                  :crit, active,  import_2,   after import_1, 2d
Midterm                       :crit, active,  import_3,   after import_2, 3d
Final Exam                    :crit,          import_4,   after import_3, 5d

section Exams
Midterm 1 Study                 :crit, active,  quiz_1,   2023-01-12, 2023-01-26
Midterm 1 Exam                  :crit, done,    quiz_2,   2023-01-27, 1d
Midterm 2 Study                 :crit, active,  quiz_3,   2023-01-31, 2023-02-26
Midterm 2 Exam                  :crit,          quiz_4,   2023-02-27, 1d
Final Exam Study                :crit,          quiz_5,   2023-02-23, 2023-03-26
Final Exam                      :crit,          quiz_6,   2023-03-27, 1d

section Example Task Flow
This is completed             :done,          second_1,    2023-01-06, 2023-01-08
This is active                :active,        second_2,    2023-01-09, 3d
Do this later                 :               second_3,    after second_2, 5d
Do this after that            :               second_4,    after second_3, 5d
Do this after imp task        :crit,          second_5,    after import_4, 3d

                                  "),
                   ## End Gantt textInput -----------------------------------
                   ## -------------------------------------------------------

                  ## -------------------------------------------------------
                  ## Begin downloadButton --------------------------------------
                  div(class = "button-center", downloadButton("download", "Download textInput.txt", class="button")),
                  ## -------------------------------------------------------
                  ## End downloadButton --------------------------------------


            # # Begin someInput ---------------
          tableOutput("instruct"),
            # # End someInput -----------------

        ), ## End sidebarPanel ----------------
        ## ------------------------------------

        ## ------------------------------------
        ## Begin mainPanel --------------------
        mainPanel(

          ## ----------------------------------
          ## Begin someOutput -----------------


          ## -------------------------------------------------------
          # Begin Gantt --------------------------------------------


                   ## -------------------------------------------------------
                   ## Begin DiagrammeR --------------------------------------
                   DiagrammeR::DiagrammeROutput(outputId = "diagram", width = "950px", height = "auto"),
                   hr(),

                   ## End DiagrammeR ----------------------------------------
                   ## -------------------------------------------------------

          # end of Gantt  ---------------------------------------

          ), # end of mainPanel  ---------------------------------------
          ## -------------------------------------------------------


        ), ## End  of sidebarLayout -------------------
        ## -----------------------------------

  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-02-03",
                      align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
                      text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),


) ## End fluidPage----------------------------
## -------------------------------------------

## End of UI -----------------------------------------
## -----------------------------------------

## ------------------------------------------------
## Define server function for app  ----------------
server <- function(input, output) {


  ## ----------------------------------------------
  ## Begin Download Button ----------------------
  ## ----------------------------------------------
  output$download <- downloadHandler(
    filename = function() {
      paste("gantt-TextInput-", Sys.Date(), ".txt", sep="")
    },
    content = function(file) {
      cat(input$inText, file=file)
    }
  )
  ## ----------------------------------------------
  ## End Download Button ----------------------
  ## ----------------------------------------------


  ## ----------------------------------------------
  ## Begin output$someOutput ----------------------
  ## ----------------------------------------------
        #   # Output: Gantt2    diagramme
        output$diagram <-
          DiagrammeR::renderDiagrammeR({
            DiagrammeR::mermaid(
              base::paste0(input$inText)
            )
          }) # end of Output: Gantt2    diagramme
  ## ----------------------------------------------

  ## ------------------------------------------
  ## Begin output$someOutput ------------------
          #   # Output: Gantt
          output$gantt <- renderUI({
            HTML("
                   <span><strong>To update the lower Gantt Chart in real-time:</strong>
                   <br>* Change Section Names, Start, End Dates; Scroll down for more (4) sections
                   <br>* To save, Download textInput results
                   <br><br>")
          }) # end of Output: Gantt
          ## --------------------------------------
      ## ------------------------------------------
      ## End output$someOutput --------------------
      ## ------------------------------------------


          ## -----------------------------------------
          ## -----------------------------------------
          ## Begin output$someOutput ---------------
          ## -----------------------------------------
          ## -----------------------------------------
          ## -----------------------------------------
          output$instruct <- renderUI({
            HTML("
                   <span><strong>How To Use This Interactive Gantt Chart: </strong>
                   <br>
                       <ul>
                           <li>Edits to text box update Gantt Chart in real-time</li>
                           <li>Data changes deleted on page exit - downloaded as text</li>
                           <li>Formatting NOT to be changed
                                  <br>Header with gantt, and dateFormat, all in lower case format
                                  <br>(replace XXXXX with your own text)
                                  <br>
<pre>
gantt
dateFormat  YYYY-MM-DD
title XXXXX
section XXXXX
</pre>
                            </li>
                            <li><strong>Format to code chart</strong>
                                  <br>- Colon placed immediately before task completion keywords, followed by comma;
                                  <br>- Nested keywords also followed by commas :crit, or :done,
                                  <br>- keyword blank after colon used as task space-holder
                                  <br>- Important tasks :crit, are highted in red
                                  <br>- Start, End Dates, separated by comma, or #days after start date of previously named task
                                  <br>- Don't use symbols: &, /, # in section names
                                  <br>
<pre>
Task completed         :done,   second_1, 2023-01-06, 2023-01-08
Task active            :active, second_2, 2023-01-09, 3d
Do later               :        second_3, after second_2, 5d
Do after that          :        second_4, after second_3, 5d
Do after critical task :crit,   second_5, after import_4, 3d
</pre>
                                      </li>
                            <li><strong>To Save Text Input to text file</strong>:
                                  <ul>
                                    <li>Download button saves 'gantt-TextInput-currentDate.txt' file</li>
                                    <li>Replace text within 'textAreaInput' area Gantt app.R file</li>
                                    <li>Run app to showGantt updates, which can be edited live again</li>
                                  </ul>
                           </li>
                            <br><pre>
## Begin Gantt textInput -------------
  textAreaInput(inputId = 'inText,
  value='
     XXX PASTE / REPLACE CODE HERE XXX
  '),
## End Gantt textInput ---------------
                                </pre>
                            Share Text file by email, paste into Shiny app.R file, run updated Gantt app locally
                            in RStudio
                            </li>
                       </ul>
<!--
<pre>
gantt
dateFormat  YYYY-MM-DD

section XXXXXXXXXXX
This task is completed      :done,          first_1,    2023-01-06, 2023-01-08
This task is active         :active,        first_2,    2023-01-09, 3d
Do this task later          :               first_3,    after first_2, 5d

section XXXXXXXXXXX
Completed, critical task    :crit, active,  import_1,   2023-01-06, 24h
Completed, critical task    :crit, done,    import_2,   2023-01-06, 24h
</pre>
-->
                   </span>

")
          }) # end of Output: Gantt


          ## -----------------------------------------
          ## -----------------------------------------
          ## -----------------------------------------
          ## End output$someOutput -------------------
          ## -----------------------------------------
          ## -----------------------------------------







## -----------------------------------------
} ## End server function ----------------

## Run app  ----------------
shinyApp(ui, server)
## End Run app ----------------
