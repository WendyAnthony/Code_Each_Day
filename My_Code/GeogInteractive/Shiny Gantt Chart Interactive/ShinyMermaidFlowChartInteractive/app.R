## -----------------------------------------
## -----------------------------------------
## Mermaid side panel Shiny App File created by Wendy Anthony
## 2023-02-03 03:46
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
  titlePanel(title = span("Interactive Shiny Mermaid Flow Chart", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #f0f6e8;} .button{margin: auto;}
                       .button-center{text-align: left;}")),

  ## ------------------------------------------
    ## Sidebar with some input ----------------
    sidebarLayout(

      ## --------------------------------------
      ## Begin sidebarPanel -------------------
        sidebarPanel(width = 3,

          ## Begin Intro Note --------------------------------------
          #tags$b("How to use this interactive Gantt Chart"),

          ## End Intro Note --------------------------------------


          ## -------------------------------------------------------
          # Begin Mermaid --------------------------------------------

          ## Begin Mermaid textInput -----------------------------------
          ## -------------------------------------------------------
          ## graph LR; Left to Right
          textAreaInput(inputId = "inText", label = NULL, width = "300px", height = "800px", rows = 50, value = "
                       graph TB;
                        Mj[Geography Major BA]
                        FE[Focus: Environment]
                        FG[Focus: Geomatics]
                        FH[Focus: Human]
                        FP[Focus: Physical]
                        A1[GEOG 101A]
                        A2[GEOG 101B]
                        A3[GEOG 103]
                        A4[GEOG 130]
                        A5[2-Year Status]
                        B0[GEOG 222]
                        B1[GEOG 226]
                        B2[GEOG 230]
                        B3[GEOG 252]
                        C1[GEOG 304]
                        C2[GEOG 319]
                        C3[GEOG 322]
                        C4[GEOG 323]
                        C5[GEOG 353]
                        C6[GEOG 358]
                        D1[GEOG 422]
                        D2[GEOG 438]
                        D3[GEOG 453]
                        D4[GEOG 487]

                        FE-->Mj;
                        FG-->Mj;
                        FH-->Mj;
                        FP-->Mj;
                        A1-->B1;
                        A2-->B1;
                        B1-->C2;
                        B0-->C2;
                        B0-->C3;
                        B1-->C3;
                        B1-->C6;
                        B1-->C4;
                        C2-->D1;
                        C3-->D1;
                        A3-->B1;
                        A4-->B2;
                        A5-->B3;
                        A5-->B0;
                        B3-->C1;
                        B3-->C5;
                        C5-->D3;
                        C6-->D4;
                        D2-->FE;
                        D3-->FE;
                        D1-->FG;
                        D1-->FP;
                        D4-->FH;

                        "),
          ## End Mermaid textInput -----------------------------------
          ## -------------------------------------------------------

          ## -------------------------------------------------------
          ## Begin downloadButton --------------------------------------
          div(class = "button-center", downloadButton("download", "Download textInput.txt", class="button")),
          #                  div(class = "button-center", downloadButton("save", "Save image", class="button")),
          ## -------------------------------------------------------
          ## End downloadButton --------------------------------------


          # # Begin someInput ---------------
          tableOutput("instruct"),
            # # End someInput -----------------

        ), ## End sidebarPanel ----------------
        ## ------------------------------------

        ## ------------------------------------
        ## Begin mainPanel --------------------
        mainPanel(width = 9,

          ## ----------------------------------
          ## Begin someOutput -----------------


          ## Begin Mermaid tableOutput -----------------------------------
          ## -------------------------------------------------------
          # https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
          tableOutput("mermaid"),

                   ## -------------------------------------------------------
                   ## Begin DiagrammeR --------------------------------------
                   DiagrammeR::DiagrammeROutput(outputId = "diagram", width = "950px", height = "auto"),
                   hr(),

                   ## End DiagrammeR ----------------------------------------
                   ## -------------------------------------------------------

          # end of Mermaid  ---------------------------------------

          ), # end of mainPanel  ---------------------------------------
          ## -------------------------------------------------------


        ), ## End  of sidebarLayout -------------------
        ## -----------------------------------

  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-02-02",
     align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
     text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),

) ## End fluidPage----------------------------
## -------------------------------------------

## End of UI -----------------------------------------
## -----------------------------------------

## ------------------------------------------------
## Define server function for app  ----------------
server <- function(input, output) {


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
          #   # Output: Mermaid
          output$mermaid <- renderUI({
            HTML("
                   <span><strong>To update the Mermaid Flow Chart in real-time:</strong>
                   <br>* Add letters that correspond to course; use arrow keys to show relationships
                   <br>* Delete course definitions and arrowed connections to show only courses of interest
                   <br>* Download textInput results as mermaid-TextInput.txt file
                   <br><br>")
          }) # end of Output: Mermaid
          ## --------------------------------------
## ------------------------------------------
## End output$someOutput --------------------
## ------------------------------------------

## -----------------------------------------
## Begin output$someOutput instructions ----
## -----------------------------------------
          output$instruct <- renderUI({
            HTML("
                   <span><strong>How To Use Mermaid Course Flow Chart: </strong>
                   <br>
                       <ul>
                           <li>Edit Text box updates Chart in real-time</li>
                            <li><strong>To Save Text Input to text file</strong>:
                                  <ul>
                                    <li>Download saves text file with current date</li>
                                    <li>Replace saved text in 'textAreaInput' of app.R file</li>
                                    <li>Run app to View saved updates</li>
                                  </ul>
                           </li>
                            <br><pre>
## Begin textInput ---------------
  textAreaInput(inputId = 'inText,
  value='
    PASTE / REPLACE CODE HERE
  '),
## End textInput -----------------

                   </span>

")
          }) # end of Output: Mermaid
## -----------------------------------------


## -----------------------------------------
} ## End server function ----------------

## Run app  ----------------
shinyApp(ui, server)
## End Run app ----------------
## ----------------------------
