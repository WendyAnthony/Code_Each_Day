# Log for #Code_Each_Day - Wendy Anthony

**The log of Round 1 of my #100DaysOfCode challenge. Started on 2020-01-01 (2019-12-28)**  
- [My Code](https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code)
- [2021 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2021.md)
- [2022 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2022.md)


***
## Table of Contents  <a name="toc"/>
- **[Week LII](#weeklii)**  
  - [R1D261 2020-12-30](#r1d365)
  - [R1D261 2020-12-26](#r1d361)
  - [R1D260 2020-12-25](#r1d360)
  - [R1D259 2020-12-24](#r1d359)
  - [R1D258 2020-12-23](#r1d358)  
  - [R1D257 2020-12-22](#r1d357)
- **[Week XXXIII](#weekxxxiii)**  
  - [R1D223 2020-08-10](#r1d223)
- **[Week XX .... (Week IX of COVID-19 Lockdown)](#weekxx)**  
  - [R1D134 2020-05-13](#r1d134)
- **[Week VI](#weekvi)**  
  - [R1D27 2020-02-04](#r1d27)
- **[Week V](#weekv)**  
  - [R1D26 2020-01-31](#r1d26)
  - [R1D25 2020-01-30](#r1d25)
  - [R1D24 2020-01-29](#r1d24)  
  - [R1D23 2020-01-28](#r1d23)
  - [R1D22 2020-01-26](#r1d22)
- **[Week IV](#weekiv)**  
  - [R1D21 2020-01-21](#r1d21)
  - [R1D20 2020-01-20](#r1d20)  
  - [R1D19 2020-01-19](#r1d19)  
- **[Week III](#weekiii)**  
  - [R1D18 2020-01-18](#r1d18)
  - [R1D17 2020-01-17](#r1d17)
  - [R1D16 2020-01-16](#r1d16)
  - [R1D15 2020-01-15](#r1d15)
  - [R1D14 2020-01-14](#r1d14)  
  - [R1D13 2020-01-13](#r1d13)
  - [R1D12 2020-01-12](#r1d12)
- **[Week II](#weekii)**  
  - [R1D11 2020-01-11](#r1d11)
  - [R1D10 2020-01-10](#r1d10)
  - [R1D9 2020-01-09](#r1d9)
  - [R1D8 2020-01-08](#r1d8)
  - [R1D7 2020-01-07](#r1d7)
  - [R1D6 2020-01-06](#r1d6)
  - [R1D5 2020-01-05](#r1d5) 
- **[Week I](#weeki)**    
  - [R1D4 2020-01-04](#r1d4)  
  - [R1D3 2020-01-03](#r1d3)  
  - [R1D2 2020-01-02](#r1d2)  
  - [R1D1 2020-01-01](#r1d1)  
- **[Week 0](#week0)**  
  - [R1D0-3 2019-12-30](#r1d0-3)
  - [R1D0-2 2019-12-29](#r1d0-2)
  - [R1D0-1 2019-12-28](#r1d0-1)
- **[Wishlist](#wishlist)**

***
# Week LII <a name="weeklii"/>
***
## R1D365 2020-12-30 <a name="R1D365"/>
**Today's Progress**: 
- Victoria precip data as a heatmap calendar, a most excellent tutorial by Dominic Royé
  - had to tweak font
  - download Victoria 2020 weather data, change column names
  - Lubridate epiweek()needed to change week start to Sunday vs Monday

**Thoughts:**
- Still finding cool things to do with R data

**Links to code work:** 
- https://dominicroye.github.io/en/2020/a-heatmap-as-calendar/
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/heatmap_calendar.R
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/heatmap_calendar_2020_Precip.png

[TOC](#toc)

***
## R1D361 2020-12-26 <a name="R1D361"/>
**Today's Progress**: 
- playing with Leaflet for R
  - found code to add a search box
  - found code to create to create timeline in Leaflet for R
- found a package & some R code to work with Google Earth Engine `RGEE`

**Thoughts:**
- excited to find different ways to use leaflet

**Links to code work:** 
- [Leaflet Extras](https://www.rdocumentation.org/packages/leaflet.extras/versions/1.0.0)
  - https://www.youtube.com/watch?v=gh8VMFUv91o
  - [Leaftime](https://github.com/timelyportfolio/leaftime)
- `RGEE` https://r-spatial.github.io/rgee/reference/Map.html

[TOC](#toc)

***
## R1D360 2020-12-25 <a name="R1D360"/>
**Today's Progress**: 
- In Google Earth (GE) added placemarks with title, map intro & bibliography, and saved as .kml file 
- in html file, added style for title overlay, and style to allow scrolling long text in the balloons

**Thoughts:**
- excited to find different ways to use kml and leaflet
- I did spend some time trying to figure out how to create different Leaflet layers for different kml folders >> no luck
- I did try converting kml to geojson, but all the icon info is lost!

**Links to code work:** 
- http://people.geog.uvic.ca/wanthony/website/maps/leaflet/leaflet-kml.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/kml
 
[TOC](#toc)

***
## R1D359 2020-12-24 <a name="R1D359"/>
**Today's Progress**: 
- working with Leaflet kml plugin http://people.geog.uvic.ca/wanthony/website/maps/leaflet/leaflet-kml.html to create a interactive map with Leaflet
- using .kml file created in my just-finished Anthropology Indigenous Ethnography & Cartography course: Stólō Territory Ethnography Mapping Project

**Thoughts:**
- excited to find different ways to use kml and leaflet
- now I want to figure out how to create different Leaflet layers for different kml folders

**Links to code work:** 
- http://people.geog.uvic.ca/wanthony/website/maps/leaflet/leaflet-kml.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/kml
 
[TOC](#toc)

***
## R1D358 2020-12-23 <a name="R1D358"/>
**Today's Progress**: 
- revisiting and playing with weather data in R ggplot2

**Thoughts:**
- at end of year download complete 2020 data
- redo some plots

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Weather
 
[TOC](#toc)

***
## R1D357 2020-12-22 <a name="R1D357"/>
**Today's Progress**: 
- 5 hour Learning Sprint with ggplot2 
- using most excellent, and thorough tutorial by https://cedricscherer.netlify.app/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/

**Thoughts:**
- had trouble with Google fonts, had to learn later how to install on Mac to use in R
- want to do more with ggplot2

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Weather
 
[TOC](#toc)

***
# Week weekXXXIII <a name="weekxxxiii"/>
***
## R1D223 2020-08-10 <a name="R1D223"/>
**Today's Progress**: 
- working with Leaflet for R to create another interactive webpage map for my iNaturalist observations, using similar mapping code to my shiny app
- used the R packages ```rinat``` (to access iNaturalist data), ```lubridate``` (to manage the dates), ```leaflet```, ```htmlwidgets``` (to export html file)

**Thoughts:**
- Time to up my game with Leaflet for R
- Marker clusters - when too many markers are close together the clusters aren't separating into single markers (e.g. https://github.com/Leaflet/Leaflet.markercluster)

**Links to code work:** 
 - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/Leaflet-iNaturalistPhoto-Map-Webpage.R
 - https://wendyanthony.shinyapps.io/iNaturalist-shiny-leaflet-app/
 - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/app.R

[TOC](#toc)

***
# Week XX  ..... (Week IX of COVID-19 Lockdown) <a name="weekxx"/>
***
## R1D134 2020-05-13 <a name="R1D134"/>
**Today's Progress**: 
- tried new-to-me package ```tidycovid19```, merging data from 9 different sources, creating familiar charts

**Thoughts:**
- I hadn't done any coding since finishing my Adv Weather Course, exams and assignments, so after a 3 week break I've been itching to play with R ... COVID-19 lockdown time is starting to phase into different stage, and seems like a perfect time to try to make some of the COVID-19 data viz charts I've been seeing on Twitter

**Links to code work:** 
 - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/COVID-19/tidycovid19.R

[TOC](#toc)
***
# Week VI <a name="weekvi"/>
***
## R1D27 2020-02-04 <a name="R1D27"/>
**Today's Progress**:
- ```ImageMagick``` used ```montage``` to create a series of 4 tiles of gifs of weather charts downloaded from Environment Canada
- animating montages with convert

**Thoughts:** 
- trying to find a way to make sense of changing weather patterns by animating upper air charts and surface charts for specific date spans

**Links to code work:** 
- ```montage -label '%f' SurfaceChart-mean-sealevelPressure-2020-02-01-00-947_100.gif SurfaceChart-mean-sealevelPressure-2020-02-01-06-951_100.gif SurfaceChart-mean-sealevelPressure-2020-02-01-12-935_100.gif SurfaceChart-mean-sealevelPressure-2020-02-01-18-941_100.gif -tile x1 -frame 5 -geometry '895x765+10+10>' -pointsize 30 -title 'Surface Charts 2020-02-01-00 to 2020-02-01-18' montage-label-title-size30-tile1-895x765x1790x1531-gap10+10-frame-SurfaceCharts-2020-02-01-00-to-01-18.gif```
- ```convert -delay 1650 montage-label-title-size30*.gif anim-montage-x1-30-surface-mean-sealevel-Pressure-2020-02-01to04_1650.gif```
- ```montage -label '%f' SurfaceChart-mean-sealevelPressure-2020-02-01-00-947_100.gif SurfaceChart-mean-sealevelPressure-2020-02-01-06-951_100.gif SurfaceChart-mean-sealevelPressure-2020-02-01-12-935_100.gif SurfaceChart-mean-sealevelPressure-2020-02-01-18-941_100.gif -tile 2x2 -frame 5 -geometry '+10+10>' -pointsize 50 -title 'Surface Charts 2020-02-01-00 to 2020-02-01-18' montage-label-title-size50-tile2-gap10+10-frame-SurfaceCharts-2020-02-01-00-to-01-18.gif```

[TOC](#toc)

***
# Week V <a name="weekv"/>
***
## R1D26 2020-01-31 <a name="R1D26"/>
**Today's Progress**:
- ```ImageMagick``` used ```convert``` to animate gifs of weather charts downloaded from Environment Canada
- testing different loops (default is 1 time through); open in Chrome to run animation; can also use Powerpoint (use slideshow  > play from current slide)

**Thoughts:** 
- Trying to animate 1700 jpg just hung Terminal for almost an hour (had to use Ctrl+D to quit) - 500 seems about right (500 images takes 7 min; 200 images takes 4 minutes)

**Links to code work:** 
- ```convert -delay 30 goes_wcan*.jpg anim-goes-wcan-2020-01-23to26_30.gif```

[TOC](#toc)

***

## R1D25 2020-01-30 <a name="R1D25"/>
**Today's Progress**:
- trying my hand at Tidy Tuesday's San Francisco's Trees; using ```patchwork``` & ```ggtext``` packages
- learning to use ```GSODR``` to download weather data
- learning to use GEMPAK through VM virtual 
- got help from Prof to see if I'd installed ```ImageMagick``` properly 

**Thoughts:** 
- my image file didn't turn out the same as source, so I played with code a bit
- takes some time to download, but works!!
- GEMPAK - I messed up by trying to copy gem file from download to virtual desktop - should have copied from explorer-finder window
- ```ImageMagick``` can't use ```animate``` as MacOS needs ```QXII```, but ```Homebrew``` won't use options to install

**Links to code work:** 
- https://github.com/cnicault/tidytuesday/blob/master/2020-05-San-Francisco-trees/sf_trees.R
- https://docs.ropensci.org/GSODR/

[TOC](#toc)

***

## R1D24 2020-01-29 <a name="R1D24"/>
**Today's Progress**:
- more mapping in R: inset maps with ```ggplot2```

**Thoughts:** 
- takes a long time for map to process - wasn't sure if I'd done something wrong ... just need patience!

**Links to code work:** 
- https://geocompr.github.io/post/2019/ggplot2-inset-maps/

[TOC](#toc)

***

## R1D23 2020-01-28 <a name="R1D23"/>
**Today's Progress**:
- playing around with leaflet maps, then found a code snippet adding WMS Web Map Service tiles,  https://rstudio.github.io/leaflet/basemaps.html#wms-tiles, did some further searching and found https://mesonet.agron.iastate.edu/docs/nexrad_mosaic/, using mosaics of NEXRAD base reflectivity

**Thoughts:** 
- I get quite excited when I can get some code to work, after tweaking for local relevance
- I'm very interested to do more weather visualizations

**Links to code work:** 
- http://people.geog.uvic.ca/wanthony/website/meteorology/WMS-T-App.html

[TOC](#toc)

***
## R1D22 2020-01-26 <a name="R1D22"/>
**Today's Progress**:
- trying out a variety of R packages ... 
   - found a package ```MapPalettes``` that will ```get_color_from_image("")``` supplying hex colour code for colours found in image 

**Thoughts:** 
- what a cool way to find the colours in an image URL

**Links to code work:** 
- https://github.com/disarm-platform/MapPalettes

[TOC](#toc)

***

# Week IV <a name="weekiv"/>
***
## R1D21 2020-01-21 <a name="R1D21"/>
**Today's Progress**:
- trying some more ```highcharter``` advanced mapping, creating a map by importing geojson files, using code samples from the package maker, with some tweaking; the map shows the continents, country boundaries, plate boundaries, marine currents, volcano locations; with interactive tooltips

**Thoughts:** 
- map wouldn't work, I had to tweak the code, and was successful - I'm pretty proud of myself for figuring out what to do to make the code work! ;)

**Links to code work:** 
- http://jkunst.com/highcharter/highmaps.html
  - tweaked the code to get world map to show: changed to ```data = world``` added ```geojson = TRUE```

[TOC](#toc)

***
## R1D20 2020-01-20 <a name="R1D20"/>
**Today's Progress**:
- trying some more ```highcharter``` functions to make charts with new series of data, bands on the y-axis, grouping together values

**Thoughts:** 
- when there are errors working from someone's demo tutorial, or code doesn't work, don't assume it's me - sometimes the original has code spelling errors, or leaves out repeat info that need to know how to add to without being told

**Links to code work:** 
- https://rstudio-pubs-static.s3.amazonaws.com/136836_45410b2aedcf49a5b46567f3fd6015bc.html 
  - (quite a few code errors)
- http://jkunst.com/highcharter/index.html

[TOC](#toc)

**
## R1D19 2020-01-19 <a name="R1D19"/>
**Today's Progress**:
- trying to get D3 to run with R shiny
- testing ```highcharter``` in ```Shiny```, adding more types & themes, also trying different data

**Thoughts:** 
- very interested in the interactivity of ```D3``` & ```Shiny``` in combination, though having trouble accessing different data
- would like to find a way to add different data choices to ```highcharter``` in ```Shiny```

**Links to code work:** 
- https://github.com/jbkunst/d3wordcloud
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Highcharter

[TOC](#toc)
***

# Week III <a name="weekiii"/>
***
## R1D18 2020-01-18 <a name="R1D18"/>
**Today's Progress**:
- trying to get webscraping html tables to work in R, but had trouble with tables that had columns that spanned over multiple columns

**Thoughts:** 
- make sure I don't create messy tables with multiple spanning columns

[TOC](#toc)
***

## R1D17 2020-01-17 <a name="R1D17"/>
**Today's Progress**:
- trying to get shiny apps to work using ```golem``` package

**Thoughts:** 

[TOC](#toc)
***

## R1D16 2020-01-16 <a name="R1D16"/>
**Today's Progress**:
- found a way to generate animated gifs from environment canada forecasts using Photoshop

**Thoughts:** 
- animating weather forecasts helps to understand change over time

**Make animated gifs with Photoshop (CS5)**  
1. File > Scriptw > Load files into stack > Browse for files > open > OK
2. set loop count (dropdown arrow below first gif)
3. hamburger menu at top right of animation frames window
4. Make frames from layers > select all > set loop count for all selected
5. Play button to view
6. File > Save for Web > Preset: GI  128 Dithered; Colors: 256 > Preview > Save

[TOC](#toc)
***

## R1D15 2020-01-15 <a name="R1D15"/>
**Today's Progress**:
- tried to get cluster code to show more markers when zoomed in

**Thoughts:** 
- cleaning and preparing data takes a lot of work - much more than trying to figure out the code sometimes!

**Links to code work:** 
- https://wendyanthony.shinyapps.io/iNaturalist-shiny-leaflet-app/
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/app.R

[TOC](#toc)
***

## R1D14 2020-01-14 <a name="R1D14"/>
**Today's Progress**:
- learned to make non-linear presentation in Powerpoint, using sections and linking to each section with images in a TOC

**Thoughts:** 
- in older version of Powerpoint 2016, this doesn't work as simply as newer versions, so I had to figure out what would work with older version

[TOC](#toc)
***

## R1D13 2020-01-13 <a name="R1D13"/>
**Today's Progress**:
- created code to access my iNaturalist observations
- created ```leafet r``` map for my 1243 research-grade iNaturalist observations @ https://www.inaturalist.org/observations/wendy_anthony

**Thoughts:** 
- cleaning and preparing data takes a lot of work - much more than trying to figure out the code sometimes!

**Links to code work:** 
- https://wendyanthony.shinyapps.io/iNaturalist-shiny-leaflet-app/
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/app.R

[TOC](#toc)
***

## R1D12 2020-01-12 <a name="R1D12"/>
**Today's Progress**:
- reviewing use of ```Linux UNIX commands``` in ```MacOSX Terminal``` with Unix Tutorial (for Synoptic Meteorology course Geog484)
- trying, without success to 'Compile UNIX software packages' ... couldn't get the syntax correct to ```./configure --prefix=$HOME/units174``` to generate / install in correct directory, after trying multiple different ways (I was able to create new directory, just not configure / install to it - not sure how to find the right syntax)
- working on a ```ggplot2``` precipitation visualization, got it working, then did something to mess it up ... now nothing works!!

**Thoughts:** 
- I always thought compiling programs in terminal would be a challenge, and indeed this is - install not working correctly yet??
- I need to save a code file when it is working, and try other stuff on a copy - 'twould save me a lot of heart-ache!!

**Links to code work:** 

  
[TOC](#toc)
***

# Week II <a name="weekii"/>
***
## R1D11 2020-01-11 <a name="R1D11"/>
**Today's Progress**:
- learn to use ```UNIX commands``` in ```MacOSX Terminal``` with Unix Tutorial (for Synoptic Meteorology course Geog484)
- redid uvic seasonal weather plot in ggplot2 using smaller point size for 'dots' > makes chart easier to read

**Thoughts:** 
- typing commands into terminal is a lot less intimidating than I was expecting
- ```ggplot2``` makes some beautiful charts!

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/vic_UVic_dy_2015_2019_p1.png
  
[TOC](#toc)
***

## R1D10 2020-01-10 <a name="R1D10"/>
**Today's Progress**:
- created ggplot2 weather visualization using ```weathercan``` to download 5 years of UVic weather data, and append rows of another year of data using ```rbind``` 
- created facet plots of multiple yearly plot data together
- created new column for meteorological seasons to create a 5 year temp plot coloured by seasons
- had to spend some time to figure out how to reorder the items on the legend (from alphabetic)
- saved plots to ```.png``` files

**Thoughts:** 
- wanted to do some more weather visualizations using ggplot2, over multiple years, and create facets

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/weather-ug-UVic.R
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/vic_UVic_dy_2015_2019_p1.png
  
[TOC](#toc)
***

## R1D9 2020-01-09 <a name="R1D9"/>
**Today's Progress**: 
- adding more **R resource links** (collected on iPad) to links resource webpage, using ```.rmd``` document knitted to ```.html```
- learning to make dashboards in ```R Markdown``` using ```flexdashboard``` with column layout, multiple pages, & storyboards
- testing some highlighter shiny apps
- testing some weather code using ```ggplot2``` and ```ggridges```

**Thoughts:** 
- was able to create an internal link to another page in the multiple page layout
  - trying, without success to create internal links to one of the storyboards

**Links to code work:** 
- http://people.geog.uvic.ca/wanthony/website/etc/R_Stats_Links.html  
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Dashboards  
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/weather-underground.R  
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/2019-MinTemp-VictoriaInnerHarbour.png
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/2019-MeanTemp-VictoriaInnerHarbour.png
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/2019-MaxTemp-VictoriaInnerHarbour.png
  
[TOC](#toc)
***

## R1D8 2020-01-08 <a name="R1D8"/>
**Today's Progress**: 
- **Victoria Census shiny app**: Changed column names; added data dictionary to map column names from original data; added raw data table
- **Vancouver Census shiny app**: copy/paste change Victoria to Vancouver
- put both Vancouver & Victoria Census app in an iframe
- created screenshots of 2018 monthly max temperature using GEE NASA/ORNL/DAYMET_V3 dataset
  - created animation using [R code](https://stackoverflow.com/questions/51310892/import-png-files-and-convert-to-animation-mp4-in-r)
  - created animation using [photoshop](https://blog.hootsuite.com/how-to-make-gif/)

**Thoughts:** 
- would like to figure out how to put both Victoria & Vancouver Census apps in one shiny app, with options to choose one or the other

**Links to code work:** 
- https://wendyanthony.shinyapps.io/VicCensusApp/
- https://wendyanthony.shinyapps.io/VanCensus/
- [iFrame for Victoria & Vancouver Census shiny apps](http://people.geog.uvic.ca/wanthony/website/etc/test-shiny-iframe.htm)
- [GEEE NASA/ORNL/DAYMET_V3 dataset](https://code.earthengine.google.com/c01f76167e79b77ca062d19b40af166e)
  - [2018 monthly max temp animated gif loop](http://people.geog.uvic.ca/wanthony/website/etc/animation.gif)
  - [2018 monthly max temp animated gif_once](http://people.geog.uvic.ca/wanthony/website/etc/2018-month-maxtemp-NASA-ORNL-DAYMET_V3.gif)

[TOC](#toc)
***
## R1D7 2020-01-07 <a name="R1D7"/>
**Today's Progress**: 
- Playing around in **Google Earth Engine GEE**, with scripts for Canadian Datasets: NRC_CDEM, NASA/ORNL/DAYMET_V3 (learned to change date range, map centre & zoom)

**Thoughts:** 
- would like to know how to export the map image created

**Links to code work:** 
- [NRC_CDEM](https://code.earthengine.google.com/d189afb0edbfe9906a415169c8477069)
- [NASA/ORNL/DAYMET_V3](https://code.earthengine.google.com/1ff3a12cac70d5e5d5836dd58dcb7a1c)

[TOC](#toc)
***
## R1D6 2020-01-06 <a name="R1D6"/>
**Today's Progress**: 
- learning to organize my **forked github repositories** by making new 'organizations' and 'transfering ownership' from my main repository (200+ forked repositories) to new forked-organizations

**Thoughts:** 
- too bad github didn't build-in some way to simplify organization of repositories, to make them easier to find than a search
  - I had originally set-up a repository for a list of my personal respositories, and 'pinned' to top of repository page
- Transfer forked repository to new organization: 
  - in Repository, click 'Settings'
  - in 'Danger Zone' click 'Transfer'
  - type name of original repository
  - type or copy/paste name of organization to transfer to

**Links to code work:** 
- https://github.com/WendyAnthony

[TOC](#toc)
***
## R1D5 2020-01-05 <a name="R1D5"/>
**Today's Progress**: 
- experimenting using **highcharts r wrapper** ```highcharter```
- trying to get **iNaturalist** to work in R ```library("rinat")```  
  - finally got my personal iNaturalist observations to show in R !!!

**Thoughts:** 
- though I've used highcharts code for dataviz, the ```highcharter``` 'wrapper' uses different code styles for same charts
- tutorial samples work, but not with projects I'm involved with e.g. bc-parks  
  - bc-parks is an umbrella project with other individual BC Parks Projects
  - ```rinat``` gives an error; I've tried a few suggestions (a common error with rinat) but no luck so far

**Links to code work:** 
- to extract my personal observations  
  - ```get_inat_obs_user("wendy_anthony", maxresults = "3000")```
  - default is 110 results > I actually have 2200 uploaded observations between Aug 2019 & May 2015
- to Extract just research grade observations  
  - ```wa_inat_userstats_research <- wa_inat_userstats[which(wa_inat_userstats$quality_grade == "research" ),] ```

[TOC](#toc)
***
# Week I <a name="weeki"/>
***
## R1D4 2020-01-04 <a name="R1D4"/>
**Today's Progress**: 
- Continued work on **my UVic website**
- Learning more about ```.md``` styling 
  - e.g. Table of Contents, list items
- trying ```eBird auk``` [auk](https://cran.r-project.org/web/packages/auk/vignettes/auk.html) package

**Thoughts:** 
- using examples from packages work fine (e.g ```auk```), but when trying to import real data, not so much ...

**Links to code work:** 

[TOC](#toc)
***

## R1D3 2020-01-03 <a name="R1D3"/>
**Today's Progress**: Fixed absolute URLs in **my UVic student website** (over 2400 files)

**Thoughts:** Continued work with weather data to better understand how to process it

**Links to code work:**  http://people.geog.uvic.ca/wanthony/website/index.html 

[TOC](#toc)
***

## R1D2 2020-01-02 <a name="R1D2"/>
**Today's Progress**: 
1. [x] Reworked ```Shiny App``` for **Victoria Census data**, creating normalized value columns for comparing polygons (variable / #households)
2. [x] Figured out how to make **windrose** with weather data  

**Thoughts:** 

**Links to code work:**  
1. https://wendyanthony.shinyapps.io/VicCensusApp/
2. https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Vic_Census_Shiny/app.R
3. https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Weather/windrose.R

[TOC](#toc)
***

## R1D1 2020-01-01 <a name="R1D1"/>
**Today's Progress**: Started a **Weather App**. Worked on the draft layout of the app, struggled with ```OpenWeather API```  

**Thoughts:** Coding takes patience and lots of trial-&-errors, then EUREKA!!

[TOC](#toc)
***
# Week 0 <a name="week0"/>
***

## R1D0-3 2019-12-30 <a name="R1D0-3"/>
**Today's Progress**: 
- updating [R Stats Resource Links](https://wendyanthony.github.io/R_Stats_Links-io.html)

**Thoughts:** 
- I'd like to do some coding every day, when I first get up

[TOC](#toc)
***

## R1D0-2 2019-12-29 <a name="R1D0-2"/>
**Today's Progress**: 
- learning how to make a **Shiny [US Census app](https://shiny.rstudio.com/tutorial/written-tutorial/lesson5/)**

**Thoughts:** 
- I'd like to make a Census app using Victoria Census info
- https://www.shinyapps.io/admin/#/dashboard


[TOC](#toc)
***

## R1D0-1 2019-12-28 <a name="R1D0-1"/>
**Today's Progress**: Learning to create a **[Wordcloud in R](http://www.baoruidata.com/examples/082-word-cloud/)** with Old-Time Tunes titles, and text from books

**Thoughts:** 
- based on text from Gutenberg library - I added list of Old-Time Tunes titles

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Wordcloud

[TOC](#toc)
***  
***
# Wish-List <a name="wishlist"/>  
- [x] Create log of coding work done as progress
- [x] Make UVic website responsive & with more up-to-date styling
- [x] Formatting ```.md``` pages (like this one)
- [x] become more comfortable using ```github```
- Use eBird data
- [x] Use iNaturalist data
- use historical weather data
- Shiny - add different choices
- learn to do more stuff with R [R Resource Links @ github.io](https://wendyanthony.github.io/R_Stats_Links-io.html)  
  - http://people.geog.uvic.ca/wanthony/website/etc/R_Stats_Links.html
- learn to use highcharts with R in ```highcharter```

[TOC](#toc)

