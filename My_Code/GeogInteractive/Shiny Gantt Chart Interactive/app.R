## -----------------------------------------
## -----------------------------------------
## Shiny App File created by Wendy Anthony 2023-01-26
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
  titlePanel(title = span("Interactive Gantt Time Management Chart", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),


  ## ------------------------------------------
    ## Sidebar with some input ----------------
    sidebarLayout(

      ## --------------------------------------
      ## Begin sidebarPanel -------------------
        sidebarPanel(

          ## Begin Intro Note --------------------------------------
          #tags$b("How to use this interactive Gantt Chart"),

          ## End Intro Note --------------------------------------

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

          ## Begin Gantt tableOutput -----------------------------------
          ## -------------------------------------------------------
          # https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
          tableOutput("gantt"),

                   ## Begin Gantt textInput -----------------------------------
                   ## -------------------------------------------------------
                   textAreaInput(inputId = "inText", label = NULL, width = "900px", height = "370px", rows = 15, value = "
gantt
dateFormat  YYYY-MM-DD

title Course Planning Gantt Diagram

section Basic Tasks
This is completed             :done,          first_1,    2023-01-06, 2023-01-08
This is active                :active,        first_2,    2023-01-09, 3d
Do this later                 :               first_3,    after first_2, 5d
Do this after that            :               first_4,    after first_3, 5d
Started Project               :active,        first_5,    2023-01-06, 90d

section Other Tasks
This is completed             :done,          second_1,    2023-01-06, 2023-01-08
This is active                :active,        second_2,    2023-01-09, 3d
Do this later                 :               second_3,    after second_2, 5d
Do this after that            :               second_4,    after second_3, 5d
Started Project               :active,        second_5,    2023-01-06, 90d

section Data Collection
Collecting Course Data        :active,        third_2,    2023-01-09, 10d
Finish Collecting Data        :               third_3,    after third_2, 5d
Do this after that            :               third_4,    after third_3, 5d

section Important Things
Completed, critical task      :crit, done,    import_1,   2023-01-06,24h
Also done, also critical      :crit, done,    import_2,   after import_1, 2d
Doing this important task now :crit, active,  import_3,   after import_2, 3d
Next critical task            :crit,          import_4,   after import_3, 5d

section The Extras
First extras                  :active,        extras_1,   after import_4, 3d
Second helping                :               extras_2,   after extras_1, 20h
More of the extras            :               extras_3,   after extras_1, 48h

                                  "),
                   ## End Gantt textInput -----------------------------------
                   ## -------------------------------------------------------


          downloadButton("download", "Download"),

                   ## -------------------------------------------------------
                   ## Begin DiagrammeR --------------------------------------
                   DiagrammeR::DiagrammeROutput(outputId = "diagram", width = "950px", height = "auto"),
                   hr(),
                   h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-26",
                      align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),

                   ## End DiagrammeR ----------------------------------------
                   ## -------------------------------------------------------

          # end of Gantt  ---------------------------------------

          ), # end of mainPanel  ---------------------------------------
          ## -------------------------------------------------------


        ), ## End  of sidebarLayout -------------------
        ## -----------------------------------

  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%")

) ## End fluidPage----------------------------
## -------------------------------------------

## End of UI -----------------------------------------
## -----------------------------------------

## ------------------------------------------------
## Define server function for app  ----------------
server <- function(input, output) {


  output$download <- downloadHandler(
    filename = function() {
      "textarea.txt"
    },
    content = function(file) {
      cat(input$inText, file=file)
    }
  )

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
  ## End output$someOutput ------------------------
  ## ----------------------------------------------

      ## ------------------------------------------
      ## Begin output$someOutput ------------------
      ## ------------------------------------------
          ## --------------------------------------
          #   # Output: Gantt
          output$gantt <- renderUI({
            HTML("
                   <span><strong>Change the section Names and startDates, endDates
                   <br>in this text section to update the lower Gantt Chart in real-time:
                   <br>Scroll down to interact with more sections</strong>


                   <br /><br />")
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
                           <li>Fill text in text box to update Gantt Chart in real-time</li>
                           <li>This data is not saved locally, but is deleted when exiting page</li>
                           <li>To save updated Gantt Chart, code must be edited in original Shiny.R file, <em>(until I can find a way to save the text file ...)</em></li>
                           <li>Some Format can NOT be changed
                                  <ul>
                                      <li>the header with gantt, and dateFormat, all in lower case format</li>
                                      <li>section header, in lower case format; fill in the XXXXX with your own text to head this section</li>
                                      <li>the colon must be placed immediately before the task completion keywords, followed by a comma, with nested keywords also followed by commas:crit, or :done,</li>
                                      <li>keyword after colon can be left blank to use a space-holder for tast </li>
                                      <li>:crit, tasks will be highted in red</li>
                                      <li>use start and end dates, separated by a comma, or end day added by counting days after start date of previously named task</li>
                                  </ul>
                            </li>
                            <li><strong>To Save Text Input to text file</strong>:
                            <br>click Download Button to download textInput.txt file
                            <br>Copy this text to replace the text within the textAreaInput area of this app code
                            <br><pre>
## Begin Gantt textInput -----------------------------------
  textAreaInput(inputId = 'inText, value='
  PASTE CODE HERE
    '),
## End Gantt textInput ---------------
                                </pre>
                            The text file could also be shared by emailing the text file to someone who can paste it into their own Shiny app.R file and run the updated Gantt app locally in their own RStudio desktop program
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
