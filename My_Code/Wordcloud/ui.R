# http://www.baoruidata.com/examples/082-word-cloud/
## Author: Fereshteh Karimeddini <fereshteh@rstudio.com>

fluidPage(
  # Application title
  titlePanel("Word Cloud for Writings"),

  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a text:",
                  choices = books),
      actionButton("update", "Change text"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 200, value = 5),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 7200,  value = 200)
    ),

    # Show Word Cloud - 600px
    mainPanel(
      textOutput('text1'),
      p("Please wait while text is analyzed ..."),
      plotOutput("plot", height = "600px"),
      htmlOutput('text2'),
      htmlOutput('text3')
    )
  )
)
