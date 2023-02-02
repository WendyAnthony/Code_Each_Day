## -----------------------------------------
## -----------------------------------------
## Mermaid Shiny App File created by Wendy Anthony
# 2023-02-01 10:51
## for Interactive UVic Geography Course Planning
## app inspiration from:
## https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
## -----------------------------------------
## -----------------------------------------

## -----------------------------------------
## Load Shiny Library ----------------------
# uncomment the install.packages code to
# install packeage, then re-comment to avoid
# intalling packages each time the app is run
# calling the library after installation is enough
#
# install.packages("shiny")
# install.packages("DiagrammeR")
library(shiny)
library(DiagrammeR)

## -----------------------------------------
## Define UI for app -----------------------
ui <- fluidPage (

  ## ---------------------------------------
  ## Application title -------------------
  titlePanel(title = span("Interactive Shiny Mermaid Flow Chart", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #f0f6e8;} .button{margin: auto;}
                       .button-center{text-align: left;}")),


        ## ------------------------------------
        ## Begin mainPanel --------------------
        mainPanel(

          ## ----------------------------------
          ## Begin someOutput -----------------


          ## -------------------------------------------------------
          # Begin Mermaid --------------------------------------------

          ## Begin Mermaid tableOutput -----------------------------------
          ## -------------------------------------------------------
          # https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
          tableOutput("mermaid"),

                   ## Begin Mermaid textInput -----------------------------------
                   ## -------------------------------------------------------
                   textAreaInput(inputId = "inText", label = NULL, width = "900px", height = "370px", rows = 15, value = "
graph LR;
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
E8a[GEOG 319]
E8b[GEOG 322]
E8c[GEOG 323]
E9a[GEOG 353]
E9b[GEOG 358]
E10a[GEOG 422]
E10b[GEOG 438]
E11[GEOG 453]

B-->A;
E1-->E5;
E5-->E8a;
E5-->E8b;
E5-->E9b;
E5-->E8c;
E8a-->E10a;
E8b-->E10a;
E3-->E5;
E4-->E6;
E7-->E8;
E7-->E9;
E9-->E11;

                                  "),
                   ## End Mermaid textInput -----------------------------------
                   ## -------------------------------------------------------

                  ## -------------------------------------------------------
                  ## Begin downloadButton --------------------------------------
                    div(class = "button-center", downloadButton("download", "Download textInput.txt", class="button")),
                  ## -------------------------------------------------------
                  ## End downloadButton --------------------------------------

                   ## -------------------------------------------------------
                   ## Begin DiagrammeR --------------------------------------
                   DiagrammeR::DiagrammeROutput(outputId = "diagram", width = "950px", height = "auto"),
                   hr(),
                   h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-02-02",
                      align="left", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px; 
                      text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
                   ## End DiagrammeR ----------------------------------------
                   ## -------------------------------------------------------

                   # # Begin someInput ---------------
                  tableOutput("instruct"),
                  # # End someInput -----------------

          
          # end of Mermaid  ---------------------------------------

          ), # end of mainPanel  ---------------------------------------
          ## -------------------------------------------------------


  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%")

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
      paste("mermaid-flowchart-TextInput-", Sys.Date(), ".txt", sep="")
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
        #   # Output: Mermaid    diagramme
        output$diagram <-
          DiagrammeR::renderDiagrammeR({
            DiagrammeR::mermaid(
              base::paste0(input$inText)
            )
          }) # end of Output: Mermaid    diagramme
  ## ----------------------------------------------
  ## End output$someOutput ------------------------
  ## ----------------------------------------------

      ## ------------------------------------------
      ## Begin output$someOutput ------------------
      ## ------------------------------------------
          ## --------------------------------------
          #   # Output: Mermaid
          output$mermaid <- renderUI({
            HTML("
                   <span><strong>To update the Mermaid Flow Chart in real-time:</strong>
                   <br>* Add letters that correspond to coursel; use arrow keys to show relationships
                   <br>* Download textInput results as mermaid-TextInput.txt file
                   <br><br>")
          }) # end of Output: Mermaid
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
                   <span><strong>How To Use This Interactive Mermaid Flow Chart: </strong>
                   <br>
                       <ul>
                           <li>Edits to text box update Course Flow Chart in real-time</li>
                           <li>Data changes are deleted when exiting webpage unless downloaded as text</li>
                            <li><strong>To Save Text Input to text file</strong>:
                                  <ul>
                                    <li>Download button saves 'gantt-TextInput-currentDate.txt' file</li>
                                    <li>Replace text within 'textAreaInput' area Gantt app.R file</li>
                                    <li>Run app to showGantt updates, which can be edited life again</li>
                                  </ul>
                           </li>
                            <br><pre>
## Begin Mermaid textInput -----------------------------------
  textAreaInput(inputId = 'inText, value='
  PASTE CODE HERE
    '),
## End Mermaid textInput ---------------

                   </span>

")
          }) # end of Output: Mermaid


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
