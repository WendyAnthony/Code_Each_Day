## -----------------------------------------
## -----------------------------------------
## App to enable Interactive Exploration of UVic Geography Courses
## Gantt Time Management Course
## Mermaid With COLOUR side panel Shiny App File
## created by Wendy Anthony  wanthony@uvic.ca
## 2023-02-03 11:02
## for Interactive UVic Geography Course Planning
## app inspiration from:
## https://stackoverflow.com/questions/57351127/renderdiagrammer-mermaid-diagram-size-in-a-shiny-document
##
## colour and shape
## https://mermaid.js.org/syntax/examples.html
## -----------------------------------------
## -----------------------------------------


## -----------------------------------------
# load libraries
library(shiny)
library(DiagrammeR)
## -----------------------------------------



## -----------------------------------------
# Define UI -----------
ui <- fluidPage(
  setBackgroundColor("bonewhite"),
  # https://stackoverflow.com/questions/35025145/background-color-of-tabs-in-shiny-tabpanel
  # .tabbable > .nav > li > a[data-value='t1'] {background-color: red;   color:white}
  # .tabbable > .nav > li > a[data-value='t2'] {background-color: blue;  color:white}
  # .tabbable > .nav > li > a[data-value='t3'] {background-color: green; color:white}

  tags$style(HTML("
    .tabbable > .nav > li > a                  {background-color: #c3dca4;  color:black }
    .tabbable > .nav > li[class=active] > a    {background-color: #77be21; color:white }
    #Links li a                                {font-size: .85em; color: #69A81D; }
	  a                                          {font-size: .99em;color: #69A81D; }
  ")),
  titlePanel(title = span("Exploring UVic Geography Courses", img(src = "https://www.uvic.ca/brand/assets/images/graphics/thumbnails/Martlet-SocialSciences.jpg", height = 50))),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  tags$head(tags$style(".button{background-color:#69A81D;} .button{color: #f0f6e8;} .button{margin: auto;}
                       .button-center{text-align: left;}")),

  ## -----------------------------------------
  # Main Panel ---------
  mainPanel(
    tabsetPanel(type = "tabs",

                ## -----------------------------------------
                # begin of Main tabPanel
                tabPanel("Main",
                         HTML("<h2>Interactive Live-update Apps</h2>
                              <p>
                              * These interactive apps can be updated in real-time, but Data is not stored locally
                              <br>* Use Download button to save changes
                              <br><br>
                              * These apps are hosted on Shiny server which has very limited free acrtive use time - please limit your time
                              <br><br>
                              <hr>
                              <strong>To host your own Shiny app:</strong>
                              <br>* If you are an R Studio user, download the app.R file and run it on your own computer:
                              <br>* Copy the app.R to a computer folder (containing no other app.R file in it), open file in R Studio
                              <br>* Make sure the following R libraries are installed: 'shiny', 'DiagrammeR'
                              <br>* Click Run App
                              <br>* When App opens in R Studio window, click top button Open in Browser
                              <br>* If app is kept open in R studio, the browser window stays open
                              <br>* Change text input to see changes in Gantt Chart real-time
                              <br>* Save text file using Download Button
                              <br>* To permanently save Gantt Chart text input changes, Copy/Paste text into textInput section of app.R code to replace surrent text (between value=' ' quotes)
                              </p>
                              <hr>
                              "
                         ),


                ), # end of Main tabPanel

                ## -----------------------------------------
                # Gantt tabPanel
                tabPanel("Gantt Time Management",
                         HTML("<h3>Interactive Gantt Time Management Chart</h3>"),
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
                             textAreaInput(inputId = "inTextGantt", label = NULL, width = "500px", height = "750px", rows = 55, value = "
gantt
dateFormat  YYYY-MM-DD

title Course Planning Gantt Chart 2023

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
                             div(class = "button-center", downloadButton("downloadGantt", "Download textInput.txt", class="button")),
                             ## -------------------------------------------------------
                             ## End downloadButton --------------------------------------


                             # # Begin someInput ---------------
                             tableOutput("instructGantt"),
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
                             DiagrammeR::DiagrammeROutput(outputId = "diagramGantt", width = "950px", height = "auto"),
                             hr(),

                             ## End DiagrammeR ----------------------------------------
                             ## -------------------------------------------------------

                             # end of Gantt  ---------------------------------------

                           ), # end of mainPanel  ---------------------------------------
                           ## -------------------------------------------------------


                         ), ## End  of sidebarLayout -------------------
                         ## -----------------------------------
                         br(),
                ), # end of Gantt tabPanel

                ## -----------------------------------------
                # Mermaid
                tabPanel("Mermaid Flow Chart",
                         HTML("<h3>Interactive Shiny Mermaid Flow Chart</h3>"),
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


                ), # end of Mermaid tabPanel


                ## -----------------------------------------
                # Begin MermaidColour
                tabPanel("Mermaid in Colour",
                         HTML("<h3>Interactive Coloured Shiny Mermaid Flow Chart</h3>"),

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
                                        textAreaInput(inputId = "inTextColour", label = NULL, width = "400px", height = "800px", rows = 50, value = "
                                   graph TB

                        M[<b>BA <br><br>Geography Major</b>]
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
                        A5-->B3;
                        A5-->B0;
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
     classDef green fill:#9f6,stroke:#333,stroke-width:1px;
     classDef orange fill:#f96,stroke:#333,stroke-width:1px;
     classDef yellow fill:#ff0,stroke:#333,stroke-width:1px;
     classDef purple fill:#efbbff,stroke:#333,stroke-width:1px
     classDef pink fill:#f4cccc,stroke:#333,stroke-width:1px
     classDef gold fill:#efcd6b,stroke:#333,stroke-width:1px
     classDef blue fill:#cfe2f3,stroke:#333,stroke-width:1px;
     class FE,FG,FH,FP green
     class M orange
     class A5 yellow
     class A1,A2,A3,A4 purple
     class B0,B1,B2,B3 pink
     class C1,C2,C3,C4,C5,C6 gold
     class D1,D2,D3,D4 blue

                        "),
                                        ## End Mermaid textInput -----------------------------------
                                        ## -------------------------------------------------------

                                        ## -------------------------------------------------------
                                        ## Begin downloadButton --------------------------------------
                                        div(class = "button-center", downloadButton("downloadColour", "Download textInput.txt", class="button")),
                                        #                  div(class = "button-center", downloadButton("save", "Save image", class="button")),
                                        ## -------------------------------------------------------
                                        ## End downloadButton --------------------------------------


                                        # # Begin someInput ---------------
                                        tableOutput("instructColour"),
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
                                     tableOutput("mermaidColour"),

                                     ## -------------------------------------------------------
                                     ## Begin DiagrammeR --------------------------------------
                                     DiagrammeR::DiagrammeROutput(outputId = "diagramColour", width = "950px", height = "auto"),
                                     hr(),

                                     ## End DiagrammeR ----------------------------------------
                                     ## -------------------------------------------------------

                                     # end of MermaidColour  ---------------------------------------

                           ), # end of mainPanel  ---------------------------------------
                           ## -------------------------------------------------------


                         ), ## End  of sidebarLayout -------------------
                         ## -----------------------------------


                ), # end of MermaidColour tabPanel

    ) # tabsetPanel end
  ), # mainPanel end
  hr(),
  tags$img(src = "https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png", height = 50, width = "100%"),
  h6("Shiny code by Wendy Anthony <wanthony@uvic.ca> 2023-01-17",
     align="center", style = "font-family: sans-serif; font-weight: 1px; font-size: 10px;
text-shadow: 0px 0px 1px #aaa; line-height: 1; color: #404040;"),
) # fluidPage ends

## -----------------------------------------
## ############# Server Begins ############
## -----------------------------------------
# Define Server
server <- function(input, output) {




  ## ----------------------------------------------
  ## Begin Download Button ----------------------
  ## ----------------------------------------------
  output$downloadGantt <- downloadHandler(
    filename = function() {
      paste("gantt-TextInput-", Sys.Date(), ".txt", sep="")
    },
    content = function(file) {
      cat(input$inTextGantt, file=file)
    }
  )
  ## ----------------------------------------------
  ## End Download Button ----------------------
  ## ----------------------------------------------


  ## ----------------------------------------------
  ## Begin output$someOutput ----------------------
  ## ----------------------------------------------
  #   # Output: Gantt2    diagramme
  output$diagramGantt <-
    DiagrammeR::renderDiagrammeR({
      DiagrammeR::mermaid(
        base::paste0(input$inTextGantt)
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
  output$instructGantt <- renderUI({
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



  output$downloadColour <- downloadHandler(
    filename = function() {
      paste("mermaid-colour-flowchart-TextInput-", Sys.Date(), ".txt", sep="")
    },
    content = function(file) {
      cat(input$inTextColour, file=file)
    }
  )

  ## ----------------------------------------------
  ## End Download Button ----------------------
  ## ----------------------------------------------


  ## ----------------------------------------------
  ## Begin output$someOutput ----------------------
  ## ----------------------------------------------
  #   # Output: Gantt2    diagramme
  output$diagramColour <-
    DiagrammeR::renderDiagrammeR({
      DiagrammeR::mermaid(
        base::paste0(input$inTextColour)
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

  ## ------------------------------------------
  ## Begin output$someOutput ------------------
  ## ------------------------------------------
  ## --------------------------------------
  #   # Output: MermaidColour
  output$mermaidColour <- renderUI({
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
  output$instructColour <- renderUI({
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
  }) # end of Output: MermaidColour
  ## -----------------------------------------

  ## -----------------------------------------
} # end of server function

## -----------------------------------------
# Run app
shinyApp(ui, server)
