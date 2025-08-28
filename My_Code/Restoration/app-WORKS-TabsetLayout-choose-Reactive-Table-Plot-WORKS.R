# https://stackoverflow.com/questions/44569739/r-shiny-how-to-make-selectinput-choices-reactive-to-each-other-while-subsetting

## Table is Responsive
## LEAFLET NOT WORKING

#Sites_eccc <- read.csv("SiteDetails-TEST-GOE-Monitor.csv", header = TRUE, sep = ",")
#names(Sites_eccc)
geo_eccc_sites_2 <- read.csv("geo_eccc_all_site_data.csv", header = TRUE, sep = ",")

#l <- NULL
#l$name <- c('b','e','d','b','b','d','e')
#l$age <- c(20,20,21,21,20,22,22)
#l <- as.data.frame(l)
#l$name <- as.character(l$name)
#l$age <- as.numeric(l$age)

library(shiny)
library(leaflet)
library(ggplot2)


ui <- fluidPage(
  # app Title
  titlePanel("Exploring GOE Monitoring Dataviz"),
sidebarLayout(
  sidebarPanel(width = 3,
    selectInput("Box1","Choose a Subregion", choices = c("All",unique(geo_eccc_sites_2$Subregion))),
    selectInput("Box2","Choose an Site", choices = c("All",unique(geo_eccc_sites_2$Site)))
  ),

  mainPanel(
tabsetPanel(
  id = "tabset",
  selected = "Table Output",
tabPanel("Table Output",  tableOutput("table1")),
tabPanel("Subregion Plots",
         fluidRow(
            column(6, plotOutput("plot2")),
            column(6, plotOutput("plot3")),
            column(6, plotOutput("plot8")),
            column(6, plotOutput("plot9"))
         )),
# tabs seem to break if I tryto reuse plot
tabPanel("Comparing Sites",
         fluidRow(
           column(6, plotOutput("plot5")),
           column(6, plotOutput("plot6")),
           column(6, plotOutput("plot10")),
           column(6, plotOutput("plot11"))
         )),
tabPanel("Plot Output",  plotOutput("plot")),
# tabPanel("Subregion Plots Output",  plotOutput("plot2")),
tabPanel("Comparing Site Plots Output",  plotOutput("plot4")),
# tabPanel("More Subregion Plots Output",  plotOutput("plot5")),
# tabPanel("More Subregion Plots Output",  plotOutput("plot6")),
 tabPanel("Plotly Output",  plotlyOutput("plot7")),
tabPanel("Map Output",  leafletOutput("map",height = 650,width=605))
)
  )

)

# end Fluid Page
)


server <- shinyServer(function(input, output, session){

  data1 <- reactive({
    if(input$Box1 == "All"){
      geo_eccc_sites_2
    }else{
      geo_eccc_sites_2[which(geo_eccc_sites_2$Subregion == input$Box1),]
    }
  })

  data2 <- reactive({
    if (input$Box2 == "All"){
      geo_eccc_sites_2
    }else{
      geo_eccc_sites_2[which(geo_eccc_sites_2$Site == input$Box2),]
    }
  })

  observe({

    if(input$Box1 != "All"){
      updateSelectInput(session,"Box2","Choose an Site", choices = c("All",unique(data1()$Site)))
    }

    else if(input$Box2 != 'All'){
      updateSelectInput(session,"Box1","Choose a name", choices = c('All',unique(data2()$Subregion)))
    }

    else if (input$Box1 == "All" & input$Box2 == "All"){
      updateSelectInput(session,"Box2","Choose an Site", choices = c('All',unique(geo_eccc_sites_2$Site)))
      updateSelectInput(session,"Box1","Choose a Subregion", choices = c('All',unique(geo_eccc_sites_2$Subregion)))
    }
  })


  data3 <- reactive({
    if(input$Box2 == "All"){
      data1()
    }else if (input$Box1 == "All"){
      data2()
    }else if (input$Box2 == "All" & input$Box1 == "All"){
      geo_eccc_sites_2
    }
    else{
      geo_eccc_sites_2[which(geo_eccc_sites_2$Site == input$Box2 & geo_eccc_sites_2$Subregion == input$Box1),]
    }
  })

  output$table1 <- renderTable({
    data3()
  })

# Plot works
# output$plot <- renderPlot({
#   d <- data3()
#   plot(d$Exotic_species,d$Composite_Index)
# })


# Plot works
output$plot <- renderPlot({
  d <- data3()
  ggplot(d,
         aes(x = Site, y = Percentage_ns)) +
    geom_point(shape = 18, size = 2) +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
    labs(title='Plotting Site by Percentage Native Species',
         subtitle='ECCC',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})

# Plot works
output$plot2 <- renderPlot({
  d <- data3()

  ggplot(d,
         aes(x = Subregion, y = Exotic_species)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Exotic_species',
         subtitle='ECCC',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})


# Plot works
output$plot3 <- renderPlot({
  d <- data3()

  ggplot(d,
         aes(x = Subregion, y = Composite_Index)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Composite_Index',
         subtitle='ECCC',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})

# Plot works
output$plot8 <- renderPlot({
  d <- data3()

  ggplot(d,
         aes(x = Subregion, y = Cultural_species_richness)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Cultural_species_richness',
         subtitle='ECCC',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})

# Plot works
output$plot9 <- renderPlot({
  d <- data3()
names(geo_eccc_sites_2)
  ggplot(d,
         aes(x = Subregion, y = Percentage_ns)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(vjust = 1, size = 9)) +
    labs(title='Plotting Subregion by Percentage_ns',
         subtitle='ECCC',
         caption = "Chart by Wendy Anthony \n 2025-08-04")
})


# Plot works
output$plot4 <- renderPlot({
  d <- data3()

  d %>% arrange(desc(Percentage_ns)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Percentage_ns, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Percentage_ns',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})


# Plot works
output$plot5 <- renderPlot({
  d <- data3()

  d %>% arrange(desc(Exotic_species)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Exotic_species, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Exotic_species',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})



# Plot works
output$plot6 <- renderPlot({
  d <- data3()

  d %>% arrange(desc(Herbivory)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Herbivory, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Herbivory',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})


# Plot works
output$plot10 <- renderPlot({
  d <- data3()

  # d %>% arrange(desc(Exotic_species)) %>%
  #   # updates Site with new arrangement
  #   mutate(Site = factor(Site, levels = Site)) %>%
  d %>% ggplot(
      aes(x = Site, y = Exotic_species, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Exotic_species',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})



# Plot works
output$plot11 <- renderPlot({
  d <- data3()

  # d %>% arrange(desc(Herbivory)) %>%
  #   # updates Site with new arrangement
  #   mutate(Site = factor(Site, levels = Site)) %>%
  d %>% ggplot(
      aes(x = Site, y = Herbivory, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Herbivory',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})

# Plot works
output$plot7 <- renderPlotly({
  d <- data3()

  d %>% arrange(desc(Herbivory)) %>%
    # updates Site with new arrangement
    mutate(Site = factor(Site, levels = Site)) %>%
    ggplot(
      aes(x = Site, y = Herbivory, fill = Subregion, color = Subregion)) +
    # https://www.sthda.com/english/wiki/ggplot2-axis-scales-and-transformations
    ylim(0, 100) +
    geom_bar(stat = "identity") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="bottom") +
    theme(axis.text.x = element_text(angle = 35, vjust = 1, hjust=1, size = 7)) +
    labs(title='Comparinging Sites by Herbivory',
         subtitle='ECCC GOE Site Monitoring',
         caption = "Chart by Wendy Anthony \n 2025-08-19")
})

# # Create the base map
# output$map <- renderLeaflet({
#   leaflet() %>%
#     addProviderTiles("Esri.WorldImagery") %>%
#     setView(-123.44799, 48.64919, 9) # Center of US
# })
#
# # Observer to update markers when filtered data changes
# observe({
#   data <- data3()
#
#   leafletProxy("map") %>%
#     clearMarkers() %>%  # Remove existing markers
#     addCircleMarkers(
#       color = ~pal(Subregion),
#       # size by multiple of Composite_Index
#       radius = ~Composite_Index * 5,
#       stroke = FALSE, fillOpacity = 0.5,
#       data = data,
#       lng = ~Lng,
#       lat = ~Lat,
#       popup = ~paste0("<b>Site:</b> ", "<b>", Site, "</b>", "<br><br>", "<b>Subregion:</b> ", Subregion, "<br>",
#                       "<b>Latitude:</b> ", Lat, "<br>", "<b>Longitude:</b> ", Lng,  "<br><br>",
#                       "<b>Land Manager:</b> ", Land_Manager, "<br>",
#                       "<b>Main Restoration:</b> ", Main_Restoration_Type, "<br>",
#                       "<b>Restoration Intensity:</b> ", Restoration_Intensity, "<br>",
#                       "<b> Area:</b> ", Area_ha, " ha",
#                       "<br><br>",
#                       "<b>Proportion of native species:</b> ", Proportion_of_native_species, "<br>",
#                       "<b>Cultural species richness:</b> ", Cultural_species_richness, "<br>",
#                       "<b>Exotic species:</b> ", Exotic_species, "<br>",
#                       "<b>Trampling:</b> ", Trampling, "<br>",
#                       "<b>Herbivory:</b> ", Herbivory, "<br>",
#                       "<b>Composite Index:</b> ", Composite_Index, "<br>"
#       )
#     )
# })


# end of server
})

shinyApp(ui,server)
