## http://www.baoruidata.com/examples/082-word-cloud/
## Author: Fereshteh Karimeddini <fereshteh@rstudio.com>

function(input, output, session) {
  # Define a reactive expression for document TermMatrix
  terms <- reactive({
    # Change with "update" button
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })

  # Make the wordcloud drawing repeatable
  # larger scale # makes words larger > was 4,0.5, and makes whole image larger
  wordcloud_rep <- repeatable(wordcloud)

  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(7,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Set1"), random.order = FALSE)
    # colors=brewer.pal(8, "Dark2"))
    # colors=brewer.pal(11, "Spectral")
  })

  output$downloadPlot <- downloadHandler(
    filename = function() { paste(input$dataset, '.png', sep='') },
    content = function(file) {
      png(file)
      print(plotInput())
      dev.off()
    })
}
