##################################################
# Re-working my code 2023-01-07
# for UVic Geog Interactive Course search
# from Wendy's Native Plants Phenological Data
# 2021-08-18
# 2022-12-15 Got reactive code to work for select
# based on code from
# https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r
##################################################

library(shiny)
library(shinyjs) # for refresh button
# https://stackoverflow.com/questions/30852356/add-a-page-refresh-button-by-using-r-shiny
library(dplyr) # to use %>% pipes
library(DT) # to create data table
getwd()

##################################################
##################################################

# Data import and subset
geog_course_cl <- read.csv("Geog-Course-flowcharts.csv", stringsAsFactors = F)

# Data clean
# geog_course_cl <- subset(geog_course_cl, select = -c(code, CourseName))
# geog_course_cl$CourseName <- paste(geog_course_cl$Course, "", geog_course_cl$Name)

str(geog_course_cl)
colnames(geog_course_cl)

# code from </R/Shiny/ShinyDatabase/FilterTest/DatasetFilter/app-copy.R>
is.not.null <- function(x) !is.null(x)

##################################################
# app
##################################################

# Define UI for application
ui <- fluidPage(
    # Application title
    titlePanel("UVic Geography Course Exploration"),
    p("Shiny code experiments by Wendy Anthony 2023-01-07"),
    br(),br(),

    sidebarLayout(
      sidebarPanel(
        width = 3,
        uiOutput("course"),
        # uiOutput("CourseName"),
        uiOutput("name"),
        #https://github.com/jienagu/DT-Editor
        tags$head(tags$style(HTML('
                            .modal-lg {
                            width: 1200px;
                            }
                            '))),
        ### tags$head() is to customize the download button
        tags$head(tags$style(".butt{background-color:#230682;} .butt{color: #e6ebef;}")),
        downloadButton("geodata_csv", "Download unfiltered table as CSV", class="butt")
      ),
      mainPanel(
        # leafletOutput("Map"),
        tabsetPanel(type = "tabs",
                    tabPanel("Table", DT::dataTableOutput("table_subset")),
                    tabPanel("About", tableOutput("text")),
                    tabPanel("Code",  tableOutput("code")),
                    tabPanel("PDF",  tableOutput("pdf")),
                    tabPanel("Test2",  tableOutput("test2")),
                    tabPanel("Data Viz", tableOutput("dataviz"))
                    )
              )
    ),
)

########################################
# Define server logic
server <- function(input, output) {

  geodata <- geog_course_cl
  # ---------------------
  output$table <- DT::renderDataTable({
    if(is.null(geodata)){return()}
    DT::datatable(geodata,
                  list(searchHighlight = TRUE,
                       # pageLength = 2000,
                       # lengthMenu = c(10, 25, 50, 100, 500, 1000, 2000),
                       # dom = 'lfBpiSrtQ', # dom = 'tB' doesn't show search or paging  lfipBSrtQ
                       # paging = TRUE,
                       scrollX=TRUE,
                       searching = TRUE,
                       ordering = TRUE
                       ))
  })

  output$course <- renderUI({
    selectInput(inputId = "Course", "Select Course Number(s)",
                selected = "", choices = var_course(), multiple = T)
  })
#   https://shiny.rstudio.com/reference/shiny/latest/selectinput
  output$name <- renderUI({
    selectInput(inputId = "Name", "Select Course Name(s)",
                selected = "", choices = var_name(), multiple = T)
  })


  # https://github.com/jienagu/DT-Editor
  ### This is nothing related to DT Editor but I think it is nice to have a download function in the Shiny so user
  ### can download the table in csv
  output$geodata_csv<- downloadHandler(
    filename = function() {
      paste("Geography Course Data", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(data.frame(geodata), file, row.names = F)
    })

  # ---------------------
  # Reactive Filtered data
  # must refere toreactive object data_filtered() using the ()
  # <<< makes leaflet map reactive
  # https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny
  data_filtered <- reactive({
    filter(geog_course_cl, Course %in% course(), Name %in% name())
    #     filter(pheno_subset_sub, Species %in% species(), CommonName %in% commonName(), LocName %in% locName())
  })

  course <- reactive({
    if (is.null(input$Course)) unique(geog_course_cl$Course) else input$Course
  })

  name <- reactive({
    if (is.null(input$Name)) unique(geog_course_cl$Name) else input$Name
  })

  # ---------------------
  # Get available categories
  var_course <- reactive({
    file1 <- geodata
    if(is.null(geodata)){return()}
    as.list(unique(file1$Course))
  })

  var_name <- reactive({
    file1 <- geodata
    if(is.null(geodata)){return()}
    as.list(unique(file1$Name))
  })

  # ---------------------
  # Reactive Output table
  output$table_subset <- DT::renderDataTable({
    DT::datatable(data_filtered(), options = list(scrollX = T))
  })

  # https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny
  output$text <- renderUI({
        str1 <- paste("I started trying to code this app 2021-08-18 for phenology photo mapping, but couldn't get the selection to respond in the table and map. 2022-12-15 Learned how to get reactive code to work. 2023-01-07: Try out for Geog Interactive Project")
        str2 <-   tags$a(href='https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r', 'Code Base for Making Selected Inputs Reactive on Stack Overflow', target="_blank")
          #paste("Code from https://stackoverflow.com/questions/64242287/selectinput-filter-based-on-a-selection-from-another-selectinput-in-r")

        str3 <- paste("Tip: Try search box to filter observations e.g. '103'")
        str4 <- paste("Tip: Start typing into top 2 search bar; can select multiple choices")
        HTML(paste(str1, str2, str3, str4, sep = "<br /><br />"))
  })

  output$code <-renderUI({
    string1 <- tags$a(href='https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/GeogInteractive', 'Shiny app code on GitHub', target="_blank")
    HTML(paste(string1))
  })

  output$pdf <- renderUI({
    strings1 <- paste("<br><br>Test embedding pdf file from <a href='https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf'>worksheet</a><br><br>")
    strings2 <- tags$iframe(style="height:850px; width:100%", src="https://www.uvic.ca/students/undergraduate/program-planning/program-worksheets/worksheets/ppw-ss-geog-ba.pdf")
    HTML(paste(strings1, strings2))
  })

  output$test2 <- renderUI({
    stringss1 <- paste("")
    HTML(paste(stringss1))
  })

  output$dataviz <- renderUI({
    # strg1 <- paste("A place to test data vizualilzations")
    # strg2 <- paste("Activating this tab seems to freeze app >>> <br>Refresh browser page to access the rest of the app")
    strg3 <- paste("<style type='text/css' media='screen'>
	body { background-color: #000; }
	body,td { font: 1em Gotham, Helvetica Neue, Helvetica, Arial Narrow, Arial; font-weight: 500; color: #666; padding: 0; margin: 0; }
	ul { list-style: none none; margin: 0; padding: 0; display: block; }

	a,a:link { color: #ffcc00; text-decoration: none; }

	td { padding: 4px 4px; text-align: center; border: 1px solid #111; border-width: 1px 0; }
	tr:last-child td { border-bottom-width: 0; }
	tr.header td { padding: 10px 4px; font-size: 1.5em; font-weight: 200; color: #aaa; }
	tr.header td i { font-size: .4em; font-weight: 200; font-style: normal; }

	.items li { margin: 5px 0px; }
	.items li.current span { text-shadow: 0px 0px 8px #79cef4; }
	.arrows li { margin: 5px 0px; color: #898787; }
	.items li span { white-space: nowrap; cursor: pointer; background-color: rgba(0,0,0,0.75); border-radius: 3px; padding: 1px 4px; }


	#canvas { z-index: 1; display: block; position: absolute; left: 0; top: 0; background-color: transparent; }
	#pi { z-index: 2; border-collapse: collapse; position: relative; left: 0; top: 0; }

</style>
</head>
<body>
<table id='pi' border='0' cellpadding='0' cellspacing='0' width='100%'>
<tr class='header'>
<td valign='top' style='text-align: right;'>UVic Geography <br>Course Concentrations</td>
<td valign='top' colspan='3' style='text-align: right;'><br><br>Basics</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year1</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year2</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year3</td>
<td valign='top'></td>
<td valign='top' colspan='3' style='text-align: left;'><br><br>Year4</td>
</tr>
<tr>
<td class='items' style='text-align: right;'>
<ul id='concentrations'>
<li>Base</li>
<li>Coastal</li>
<li>Earth</li>
<li>Environment</li>
<li>Geomatics</li>
<li>Urban</li>
</ul>
</td>
<td colspan='3' class='items' style='text-align: right;'>
<ul id='basics'>
<li class='base'>Geog 101A</li>
<li class='base'>Geog 101B</li>
<li class='base'>Geog 103</li>
<li class='base'>Geog 104</li>
<li class='base'>Geog 130</li>
<li class='base'>First Year Elective Courses</li>

</ul>
</td>
<td>
<ul class='arrows'>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
<li>&rarr;</li>
</ul>
</td>
<td colspan='3' class='items' style='text-align: left;'>
<ul id='year1'>
<li class='geog-101A'>Environment Society and Sustainability</li>
<li class='geog-101B'>Space Place and Society</li>
<li class='geog-103'>Introduction to Physical Geography</li>
<li class='geog-104'>Our Digital Earth</li>
<li class='geog-130'>Climate Change</li>
<li class='first-year-elective-courses'>Second Year Standing</li>

</ul>
</td>
<td class='items'></td>
<td colspan='3' class='items' style='text-align: left;'>
<ul id='year2'>
<li class='urban space-place-and-society'>Geog 218 Social and Cultural Geography</li>
<li class='urban space-place-and-society'>Geog 211 Economic Geography</li>
<li class='urban space-place-and-society environment-society-and-sustainability second-year-standing'>Geog 226 Quatitative Methods</li>
<li class='geomatics space-place-and-society environment-society-and-sustainability second-year-standing'>Geog 222 Introduction to Maps and GIS</li>
<li class='geomatics space-place-and-society environment-society-and-sustainability second-year-standing'>Geog 228 Introduction to Remote Sensing</li>

</ul>
</td>
<td class='items'></td>
<td colspan='3' class='items' style='text-align: left;'>
<ul id='year3'>
<li class='geomatics second-year-standing geog-222-introduction-to-maps-and-gis'>Geog 322 Digital Remote Sensing</li>
</ul>
</td>

<td class='items' style=''></td>
<td colspan='3' class='items'  style='text-align: left;'>
<ul id='year4'>
<li class='geomatics geog-322-digital-remote-sensing'>Geog 422 Advanced Topics in Digital Remote Sensing</li>
<li class='geomatics geog-322-digital-remote-sensing'>Geog 420 Field Studies in Coastal Geomatics</li>
</ul>
</td>
</tr>

</table>
<canvas id='canvas'></canvas>

</body>
<script src='https://code.jquery.com/jquery-3.2.1.slim.min.js'></script>
<script>
$(document).ready(function() {
var colors = ['#5D5C5C','#492f1f','#763c19','#f7941d','yellow','#79cef4','#00aeef','lime','green','#304b15'];
$('.items li').css({color:colors[0]});

canvas();
$(window).resize(function() { // todo: get event, only repaint on mouse release
  canvas();
});

// distribute before list to span
$('.items ul li')
.wrapInner($('<span />'))
.each(function() {

  item = lower_case($(this).children('span').html());		// turn item name css compliant
  $(this).attr({ id: item });								// set li id as item name

  if ($(this).parents('ul').attr('id') != 'concentrations') {		// concentrations has no before
    list = $(this).attr('class').split(/\\s+/);			// get before items from li class
    for (i in list) {
      $('#'+list[i]+' span').addClass(item);			// find id with class, inject itself into span as class
    }
  }
})
$('.items')
.on('mouseenter','ul li',function() {
  if (! $('#pi').hasClass('sticky')) {
    $(this).addClass('current');
    $(this).css({color:colors[5]});
    pi_link($(this));
  }
})
.on('mouseleave','ul li',function() {
  if (! $('#pi').hasClass('sticky')) {
    $(this).removeClass('current');
    $('.items li').css({color:colors[0]});
    canvas();
  }
})
.on('click','ul li',function() {

  if (!$(this).hasClass('current')) {
    $('#pi').removeClass('sticky')
  }

  if ($('#pi').hasClass('sticky')) {
    $('#pi').removeClass('sticky')

    $('.items li').removeClass('current').css({color:colors[0]});
  } else {
    $('#pi').addClass('sticky')

    $('.items li').removeClass('current').css({color:colors[0]});
    canvas();

    $(this).addClass('current');
    $(this).css({color:colors[5]});
    pi_link($(this));
  }
})

// $('ul#year1').hover(function() { $('.p1').toggleClass('current'); });
// $('ul#year2').hover(function() { $('.p2').toggleClass('current'); });
// $('ul#specialized').hover(function() { $('.p3').toggleClass('current'); });
// $('ul#year4').hover(function() { $('.p4').toggleClass('current'); });

function lower_case(s) { return s.toLowerCase().replace(/ /g, '-').replace(/\\./g, ''); }
function pi_link(item) {
  pi_link_before(item,-1);
  pi_link_after(item,1);
}
function pi_link_before(item, degree, depth) {
  type   = item.parent('ul').attr('id');
  degree = degree + ((type == 'year1') ? 1 : 0);

  class_prefex = '.items li span.';
  $('.items li span.'+item.attr('id'))
  .each(function() {
    $(this).parent('li').css({color: colors[5+degree]});
    if (type != 'year1' && degree > -4) {
      line(item.children('span'),$(this),colors[5+degree],colors[5+degree+1]);
    }
    pi_link_before($(this).parent('li'),degree-1);
  });
}
function pi_link_after(item, degree, depth) {
  type   = item.parent('ul').attr('id');
  degree = degree + ((type == 'basics') ? -1 : 0);

  $('.items li.'+item.attr('id'))
  .each(function() {
    $(this).css({color: colors[5+degree]});
    if (type != 'basics' && degree < 3) {
      line($(this).children('span'),item.children('span'),colors[5+degree-1],colors[5+degree]);
    }
    pi_link_after($(this),degree+1);
  });
}

$('#disco').toggle(
  function() {
    $(this).text('Disco!');
  }
  ,
  function() {
    $(this).text('Concentrations');
  }
);
});
    function canvas() {
      $('#canvas').attr({
        'height': $('#pi').outerHeight(),
        'width': $('#pi').outerWidth()
      });
    }
    function line(a,b,c1,c2) {
      pad = 0;
      fx  = a.position().left + 4;
      fy  = a.position().top + a.height()/2 + 1;
      tx  = b.position().left + b.width() + 2;
      ty  = b.position().top + b.height()/2 + 1;

      var cvs = document.getElementById('canvas');

      var ctx = cvs.getContext('2d');
      ctx.lineWidth = 1;
      ctx.beginPath();
      ctx.moveTo(tx,ty);
      ctx.lineTo(fx,fy);
      ctx.globalAlpha = 0.5;

      var gdt = ctx.createLinearGradient( tx,ty, fx,fy );
      gdt.addColorStop(0, c1);
      gdt.addColorStop(1, c2);

      ctx.strokeStyle = gdt;
      ctx.stroke();
    }


    pi = {
      concentrations: ['Base', 'Coastal','Earth','Environment','Geomatics','Urban'],
      basics: ['Geog 101A','Geog 101B','Geog 103','Geog 104','Climate Change'],
      years: {
        year1: ['Environment Society and Sustainability','Space, Place and Society','Introduction to Physical Geography','Our Digital Earth','Geog 130'],
        year2: ['Geog 218 Social and Cultural Geography','Geog 211 Economic Geography','Geog 226 Quatitative Methods','Geog 222 Introduction to Maps and GIS','Geog 228 Introduction to Remote Sensing'],
        year3: ['Geog 322 Digital Remote Sensing'],
        year4: ['Geog 422 Advanced Topics in Digital Remote Sensing', 'Geog 420 Field Studies in Coastal Geomatics']
      }
    }
    </script>
      ")
    # HTML(paste(strg1, strg2, strg3, sep = "<br /><br />"))
    HTML(paste(strg3, sep = "<br /><br />"))
  })

############
# last curly bracket needed to complete server function
}

# Run application
shinyApp(ui = ui, server = server)
