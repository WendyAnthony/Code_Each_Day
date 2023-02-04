## -----------------------------------------
## -----------------------------------------
## Mermaid incolor side panel Shiny App File created by Wendy Anthony
## 2023-02-04 12:22
## for Interactive UVic Geography Course Planning
## colour: https://colorbrewer2.org/#type=diverging&scheme=BrBG&n=9
## app inspiration from:
## https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
## -----------------------------------------

## -----------------------------------------
## Load Shiny Library ----------------------
# uncomment the install.packages code to
# install package, then re-comment
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

## -------------------------------------------------------
          # Begin Mermaid --------------------------------------------

## -------------------------------------------------------
          ## Begin Mermaid textInput -----------------------------------
          ## graph LR; Left to Right
          textAreaInput(inputId = "inText", label = NULL, width = "400px", height = "800px", rows = 50, value = "
                        graph TB;

                        M[<b>BA<br>Geography Major</b>]
                        FE(<b>Focus: <br>Environment</b>)
                        FG(<b>Focus: <br>Geomatics</b>)
                        FH(<b>Focus: <br>Human</b>)
                        FP(<b>Focus: <br>Physical</b>)
                        A1[GEOG 101A]
                        A2[GEOG 101B]
                        A3[GEOG 103]
                        A4[GEOG 130]
                        A5((2-Year<br>Status))
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

                        FE==>M;
                        FG==>M;
                        FH==>M;
                        FP==>M;
                        A1 -- Pre-req -->B1;
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
                        A5 -.-> B3;
                        A5 -.-> B0;
                        B3-->C1;
                        B3-->C5;
                        C5-->D3;
                        C6-->D4;
                        D2 -.-> FE;
                        D3 -.-> FE;
                        D1 -.-> FG;
                        D1 -.-> FP;
                        D4 -.-> FH;


%% Comments after double percent signs (not added to graph)
%% Add colour
  %% classDef orange fill:#f96,stroke:#333,stroke-width:1px;
  %% classDef yellow fill:#ff0,stroke:#333,stroke-width:1px;
  %% classDef purple fill:#efbbff,stroke:#333,stroke-width:1px
  %% classDef pink fill:#f4cccc,stroke:#333,stroke-width:1px
  %% classDef gold fill:#efcd6b,stroke:#333,stroke-width:1px
     classDef orangeStr fill:#bf812d,stroke:#333,stroke-width:1px
     classDef orangeSoft fill:#f6e8c3,stroke:#333,stroke-width:1px
     classDef orangeVSoft fill:#dfc27d,stroke:#333,stroke-width:1px
     classDef cyanMoDrk fill:#35978f,stroke:#333,stroke-width:1px;
     classDef cyanDesat fill:#80cdc1,stroke:#333,stroke-width:1px;
     classDef cyanLtGrey fill:#c7eae5,stroke:#333,stroke-width:1px;
     class M, cyanMoDrk
  %% class M orange
     class A1,A2,A3,A4 orangeStr
     class A5,B0,B1,B2,B3 orangeVSoft
     class C1,C2,C3,C4,C5,C6 cyanLtGrey
     class FE,FG,FH,FP,D1,D2,D3,D4 cyanDesat

                        "),
          ## End Mermaid textInput -----------------------------------
## -------------------------------------------------------

## -------------------------------------------------------
          ## Begin downloadButton --------------------------------------
          div(class = "button-center", downloadButton("download", "Download textInput.txt", class="button")),
          ## End downloadButton --------------------------------------
## -------------------------------------------------------

## -------------------------------------------------------
## Begin Mermaid tableOutput -----------------------------------
# https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
          tableOutput("mermaid"),

## Begin someInput Instruct ---------------
          tableOutput("instruct"),
## End someInput Instruct -----------------

        ), ## End sidebarPanel ----------------
## ------------------------------------

## ------------------------------------
        ## Begin mainPanel --------------------
        mainPanel(width = 9,

## -------------------------------------------------------
                   ## Begin DiagrammeR --------------------------------------
                   DiagrammeR::DiagrammeROutput(outputId = "diagram", width = "800px", height = "auto"),
                   hr(),
                   ## End DiagrammeR ----------------------------------------
## -------------------------------------------------------
          # end of Mermaid  ---------------------------------------

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

## End of UI ---------------------------------
## -------------------------------------------

## ------------------------------------------------
## ------------------------------------------------

## ------------------------------------------------
## Define server function for app  ----------------
server <- function(input, output) {

  ## ----------------------------------------------
  ## Begin Download Button ------------------------
  output$download <- downloadHandler(
    filename = function() {
      paste("mermaid-flowchart-TextInput-", Sys.Date(), ".txt", sep="")
    },
    content = function(file) {
      cat(input$inText, file=file)
    }
  )   ## ----------------------------------------------
  ## End Download Button ----------------------
  ## ----------------------------------------------

  ## ----------------------------------------------
  ## Begin output$someOutput ----------------------
        ## Output: Mermaid    diagramme
        output$diagram <-
          DiagrammeR::renderDiagrammeR({
            DiagrammeR::mermaid(
              base::paste0(input$inText)
            )
          }) # end of Output: Mermaid    diagramme
  ## ----------------------------------------------

  ## ------------------------------------------
  ## Begin output$Mermaid ------------------
          ## --------------------------------------
          #   # Output: Mermaid
          output$mermaid <- renderUI({
            HTML(" <br>
                   <span><strong>How To Use Mermaid Course Flow Chart:</strong>
                   <br>* Letters correspond to courses; Arrow keys show relationships
                   <br>* Edit Text box updates Chart in real-time
                   <br>* To show only courses of interest, comment out both course name and arrow-pair using `%% `
                   <br>")
          }) # end of Output: Mermaid
          ## --------------------------------------
## End output$Mermaid --------------------
## ------------------------------------------

## -----------------------------------------
## Begin output$instructions ---------------
          output$instruct <- renderUI({
            HTML("<br>
                   <span><strong>To Save Text Input to text file: </strong>
                   <br>* Download textInput results as mermaid-TextInput-currentDate.txt file
                   <br>* Replace saved text in 'textAreaInput' of Shiny app.R file
                   <br>* Save Shiny Mermaid <a href='https://raw.githubusercontent.com/WendyAnthony/Code_Each_Day/master/My_Code/GeogInteractive/Shiny%20Gantt%20Chart%20Interactive/ShinyMermaidFlowChartInteractive/ShinyMermaidColour/app.R' target='_blank'><strong>app.R</strong></a>
                                    file to own computer and run in RStudio
                   <br>* Replace saved text in 'textAreaInput' of local app.R file
                   <br>* Run app in RStudio to View saved updates
                            <br>
<pre>
## Begin textInput ---------------
  textAreaInput(inputId = 'inText,
  value='
    PASTE / REPLACE CODE HERE
  '),
## End textInput -----------------
</pre>
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
