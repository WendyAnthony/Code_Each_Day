library("shiny")
library("highcharter")

# http://jkunst.com/highcharter/shiny.html
# Highcharter-demo

 data(citytemp)
# data(pokemon)
# glimpse(pokemon)

ui <- fluidPage(
  h1("Highcharter Demo"),
  fluidRow(
    column(width = 4, class = "panel",
           selectInput("type", label = "Type", width = "100%",
                       choices = c("line", "column", "bar", "spline", "area", "areaspline", "column", "bar", "waterfall" , "funnel", "pyramid", "pie" , "treemap", "scatter", "arearange", "areasplinerange", "columnrange", "polygon", "coloredarea", "coloredline", "polarline", "polarcolumn", "polarcolumnrange", "bubble", "errorbar")), 
#           selectInput("stacked", label = "Stacked",  width = "100%",
#                       choices = c(FALSE, "normal", "percent")),
           selectInput("theme", label = "Theme",  width = "100%",
                       choices = c(FALSE, "fivethirtyeight", "economist", "darkunica", "gridlight", "sandsignika", "null", "handdrawn", "chalk", "db", "elementary", "ffx", "flat", "flatdark", "ft", "ggplot2", "google", "monokai", "smpl", "sparkline", "superheroes", "tufte", "tufte2" ))
    ),
    column(width = 8,
           highchartOutput("hcontainer",height = "500px")
    )
  )
)

server = function(input, output) {
  
  output$hcontainer <- renderHighchart({
# http://jkunst.com/highcharter/highcharts-api.html    
    hc <- highchart() %>% 
      hc_xAxis(categories = citytemp$month) %>% 
            hc_add_series(name = "Tokyo", data = citytemp$tokyo) %>% 
            hc_add_series(name = "London", data = citytemp$london) %>% 
            hc_add_series(name = "Berlin", data = citytemp$berlin) %>% 
            hc_add_series(name = "Other city [(Tokyo + London) /2]",
                         data = (citytemp$tokyo + citytemp$london)/2)%>%
            hc_chart(type = input$type)
    
# data(pokemon)      
#      hc_xAxis(categories = pokemon$pokemon) %>%
#      hc_add_series(name = "Height", data = pokemon$height) %>%
#      hc_add_series(name = "Weight", data = pokemon$weight) %>%
#      hc_chart(type = input$type)
    
      
## data(citytemp)       
#      hc_xAxis(categories = citytemp$month) %>% 
#      hc_add_series(name = "Tokyo", data = citytemp$tokyo) %>% 
#      hc_add_series(name = "London", data = citytemp$london) %>% 
#      hc_add_series(name = "Berlin", data = citytemp$berlin) %>% 
#      hc_add_series(name = "Other city [(Tokyo + London) /2]",
#                   data = (citytemp$tokyo + citytemp$london)/2)%>%
#      hc_chart(type = input$type)
    
        
# demo    
#    hc <- highcharts_demo() %>%
#      hc_rm_series("Berlin") %>% 
#      hc_chart(type = input$type)
      
# add border         
#    %>%
#      hc_chart(borderColor = '#EBBA95',
#               borderRadius = 10,
#               borderWidth = 2)
#    
# add border     & background color
#    %>%
#      hc_chart(borderColor = '#EBBA95',
#                borderRadius = 10,
#                borderWidth = 2,
#                backgroundColor = list(
#                  linearGradient = c(0, 0, 500, 500),
#                  stops = list(
#                    list(0, 'rgb(255, 255, 255)'),
#                    list(1, 'rgb(200, 200, 255)')
#                  )))
    
#    if (input$stacked != FALSE) {
#      hc <- hc %>%
#        hc_plotOptions(series = list(stacking = input$stacked))
#    }
    
    if (input$theme != FALSE) {
      theme <- switch(input$theme,
                      null = hc_theme_null(),
                      darkunica = hc_theme_darkunica(),
                      gridlight = hc_theme_gridlight(),
                      sandsignika = hc_theme_sandsignika(),
                      fivethirtyeight = hc_theme_538(),
                      economist = hc_theme_economist(),
                      db = hc_theme_db(),
                      elementary = hc_theme_elementary(),
                      ffx = hc_theme_ffx(),
                      flat = hc_theme_flat(),
                      flatdark = hc_theme_flatdark(),
                      ft = hc_theme_ft(),
                      ggplot2 = hc_theme_ggplot2(),
                      google = hc_theme_google(),
                      merge = hc_theme_merge(),
                      monokai = hc_theme_monokai(),
                      smpl = hc_theme_smpl(),
                      sparkline = hc_theme_sparkline(),
                      superheroes = hc_theme_superheroes(),
                      tufte = hc_theme_tufte(),
                      tufte2 = hc_theme_tufte2(),
                      chalk = hc_theme_chalk(),
                      handdrawn = hc_theme_handdrawn()
      )
      
      hc <- hc %>% hc_add_theme(theme)
      
    }
    
    hc
    
  })
  
}

shinyApp(ui = ui, server = server)