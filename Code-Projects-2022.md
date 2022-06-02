# Log for #Code_Each_Day - Wendy Anthony

**The log of Round 3 of my #100DaysOfCode challenge. Started on 2022-01-03**  
- [My Code](https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code)
- [2020 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2020.md)
- [2021 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2021.md)

***
## Table of Contents  <a name="TOC"/>
- **[Week XXII](#weekXXII)**    
  - [R3D152 2022-06-01](#R3D152)
- **[Week XIX](#weekXIX)**    
  - [R3D135 2022-05-15](#R3D135)
- **[Week XVIII](#weekXVIII)**    
  - [R3D126 2022-05-06](#R3D126)
- **[Week XVI](#weekXVI)**    
  - [R3D111 2022-04-21](#R3D111)
  - [R3D110 2022-04-20](#R3D110)
  - [R3D109 2022-04-19](#R3D109)
  - [R3D108 2022-04-18](#R3D108)
  - [R3D107 2022-04-17](#R3D107)
- **[Week XV](#weekXV)**    
  - [R3D106 2022-04-16](#R3D106)
  - [R3D105 2022-04-15](#R3D105)
- **[Week XIV](#weekXIV)**    
  - [R3D97 2022-04-08](#R3D97)
  - [R3D93 2022-04-04](#R3D93)
- **[Week XII](#weekXII)**    
  - [R3D86 2022-03-27](#R3D86)
  - [R3D85 2022-03-26](#R3D85)
  - [R3D84 2022-03-25](#R3D84)
  - [R3D83 2022-03-24](#R3D83)
  - [R3D80 2022-03-21](#R3D80) 
- **[Week VII](#weekVii)**    
  - [R3D72 2022-03-13](#R3D72)  
- **[Week III](#weekIII)**    
  - [R3D9 2022-01-09](#R3D9)
- **[Week II](#weekII)**    
  - [R3D3 2022-01-03](#R3D3)
- **[Wishlist](#wishlist)**  

***
# Week XXII <a name="weeXXII"/>
***
## R3D152 2022-06-01 <a name="R3D152"/>
**Today's Progress**: 
- I was reminded that a geojson file on github will automatically produce a mapbox map in the github window (not an actual webpage)
- I learned to make a webpage for a github repro
  - https://holtzy.github.io/Pimp-my-rmd/#share_it_online
  - https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site

**Thoughts:** 
- I'd like to learn more about using github's functionality
- has to be in a high level repository, no sub folders

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/geojson/Mapping-Upriver-Sto%CC%81lo%CC%84-Ethnography-trial-3.geojson
  - https://gist.github.com/WendyAnthony/5497fd20edee5aece2611b15c115dbd2
- https://wendyanthony.github.io/Code_Each_Day/

[TOC](#TOC)

***
# Week XIX <a name="weekXIX"/>
***
## R3D135 2022-05-15 <a name="R3D135"/>
**Today's Progress**: 
- I created my first ```R``` Package - called ```templater```!!
  - I created templates for my ```.Rmd``` file YAML headers
  - I created 2 functions!! 1. to find the day of the year 135/365 and week of the year 19/52

**Thoughts:** 
- I'm so proud of myself to try to create a package

**Links to code work:** 
- haven't uploaded code yet ... not sure how to upload a package to github ... I'll have to learn how ;)
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/PackageFunctions/templater

[TOC](#TOC)

***
# Week XVIII <a name="weekXVIII"/>
***
## R3D126 2022-05-06 <a name="R3D126"/>
**Today's Progress**: 
- Revisiting Wordcloud Shiny app
  - Created a tutorial for use
- I tried to create a one file app from ```ui.R``` and ```server.R``` but didn't have success

**Thoughts:** 
- Did this to help a mentor learn to use R while creating a word cloud for his writing
- The base of this code was originally written by Fereshteh Karimeddini <fereshteh@rstudio.com> that I used to figure out how to adapt to my own needs

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Wordcloud
- Tutorial: https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Wordcloud/WordcloudCreation.html
- zip file including all app files, 3 sample text files, html tutorial created in ```RMarkdown``` https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Wordcloud/Wordcloud-app.zip
- Original Code version idea http://www.baoruidata.com/examples/082-word-cloud/ by Fereshteh Karimeddini <fereshteh@rstudio.com>
- Text Analysis wordcloud used for my final paper: https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Wordcloud/text_analysis/TextAnalysis.html

[TOC](#TOC)

***
# Week XVI <a name="weekXVI"/>
***
## R3D111 2022-04-21 <a name="R3D111"/>
**Today's Progress**: 
- Continuing land cover data mapping
  - classifying land use data
- styling Shiny app

**Thoughts:** 
- Leaflet map works in Shiny app, also with ```htmlwidgets::saveWidget```

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Remote_Sensing/BC_LandCover_shp_files
- **Screenshot image (with no water):** https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Remote_Sensing/BC_LandCover_shp_files/LandcoverMapping-app-result-nowater-ss.png
- **Screenshot image (with water):** https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Remote_Sensing/BC_LandCover_shp_files/LandcoverMapping-app-result-water-ss.png

[TOC](#TOC)

***
## R3D110 2022-04-20 <a name="R3D110"/>
**Today's Progress**: 
- BC Land Cover data >> still trying to reduce data set size
  - QGIS couldn't get to clip square AOI region to only Vancouver Island
  - ```raster``` package clip worked GREAT!!
  - Leaflet map loaded much quicker with smaller dataset files to work with

**Thoughts:** 
- Takes lots of time to figure out, search error messages, try something different >>> until it just WORKS!

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Remote_Sensing/BC_LandCover_shp_files

[TOC](#TOC)

***
## R3D109 2022-04-19 <a name="R3D109"/>
**Today's Progress**: 
- BC Land Cover data >> still trying to reduce data set size
- Takes too long to read very large, province wide shp files, and reduce data
  - Used QGIS to select features contained in AOI, but result is a square extent, including much of mainland coast 

**Thoughts:** 
- trial and error + patience + lots of time
- computer needs more RAM ... R really slogs things down
  - need to close Chrome tabs, Zotero, most Finder windows, to use less computer processing power ...

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Remote_Sensing/BC_LandCover_shp_files

[TOC](#TOC)

***
## R3D108 2022-04-18 <a name="R3D108"/>
**Today's Progress**: 
- continued work on using ```raster``` to learn to do some remote sensing viz
  - classifying land use data

**Thoughts:** 
- I may need to review some of my remote sensing lab notes
- I'd like to try some local Landsat data so I understand what I'm seeing a bit better

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Remote_Sensing/RemoteSensing.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Remote_Sensing
- original tutorial: https://rspatial.org/raster/rs/3-basicmath.html

[TOC](#TOC)

***
## R3D107 2022-04-17 <a name="R3D107"/>
**Today's Progress**: 
- continued work on using ```raster``` to learn to do some remote sensing viz
  - learning to use band math to viz land use spectra

**Thoughts:** 
- I may need to review some of my remote sensing lab notes
- I'd like to try some local Landsat data so I understand what I'm seeing a bit better

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Remote_Sensing/RemoteSensing.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Remote_Sensing
- original tutorial: https://rspatial.org/raster/rs/3-basicmath.html

[TOC](#TOC)

***
# Week XV <a name="weekXV"/>
***
## R3D106 2022-04-16 <a name="R3D106"/>
**Today's Progress**: 
- continued work on using ```raster``` to learn to do some remote sensing viz
  - learning to use band math to viz land use spectra

**Thoughts:** 
- I may need to review some of my remote sensing lab notes
- I'd like to try some local Landsat data so I understand what I'm seeing a bit better

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Remote_Sensing/RemoteSensing.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Remote_Sensing
- original tutorial: https://rspatial.org/raster/rs/index.html

[TOC](#TOC)

***
## R3D105 2022-04-15 <a name="R3D105"/>
**Today's Progress**: 
- created a leaflet html map using json
- created json object from .csv in ```R```
- copied json file text to html file
- start work on using ```raster``` to learn to do some remote sensing viz

**Thoughts:** 
- I haven't done a leaflet html map for awhile
- I also haven't worked with javascript much since playing around with leaflet in r ...
- I had to take some time to get the json format right
  - new column: Name had to have a value, as did Desc for code to work

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Leaflet/JSON_Mapping/json_mapping.html
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Leaflet/JSON_Mapping/images/Leaflet-Map-list-json.png
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Leaflet/JSON_Mapping/images/Leaflet-Map-list-json-open.png
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Leaflet/JSON_Mapping

[TOC](#TOC)

***
# Week XIV <a name="weekXIV"/>
***
## R3D97 2022-04-08 <a name="R3D97"/>
**Today's Progress**: 
- text analysis in ```r```
  - created a wordcloud as I finished my final paper on BC Climate Change Mitigation Strategies

**Thoughts:** 
- wordcloud helped me to visualize the main themes
- creating a separate word cloud for a decrease in minimum word frequency showed progression of thought through word use

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Wordcloud/text_analysis/TextAnalysis.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Wordcloud/text_analysis

[TOC](#TOC)

***
## R3D93 2022-04-04 <a name="R3D93"/>
**Today's Progress**: 
- created a leaflet for ```r``` map using ```GPX``` track and ```.csv``` waypoint data from Garmin GPS
- tried different markers

**Thoughts:** 
- I haven't done a leaflet map in ```r``` for awhile
- thought of other tools to add to map: inset map; drawing tools

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Leaflet/GPX_Track/leaflet-mapping.html
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Leaflet/GPX_Track

[TOC](#TOC)

***
# Week XII <a name="weekXII"/>
***
## R3D86 2022-03-27 <a name="R3D86"/>
**Today's Progress**: 
- tried out creating maps from image folder at scale
  - downloaded 8000+ images from camera to one folder on different computer
  - the code worked!!!


**Thoughts:** 
- took longer to download images from camera than to run coade
- getting the photo meta-data into `.csv` form took the longest of process

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Sound/Sound.html
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Sound/Sound.Rmd

[TOC](#TOC)

***
## R3D85 2022-03-26 <a name="R3D85"/>
**Today's Progress**: 
- refined code for creating maps from images in folder
- refined code to rename files in image folder with exif info, and folder name

**Thoughts:** 
- more trial and error
- gotta be careful when making little shifts that might not work, but copying code before testing
- r scripts must be located in folder of images for them to work properly
- copying images from same location into location folder so I can map all images for a location over time
- I'd like to figure out some `r leaflet` code to map images over time
- once images are on map, I'd like to find leaflet code that I can draw boundary around markers and export data (e.g.to see what plants are all in one place - to help with naming, etc)

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/z-1-rename-files-folder.R
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/z-2-Photo-Map-Folder.Rmd

[TOC](#TOC)

***
## R3D83 2022-03-25 <a name="R3D84"/>
**Today's Progress**: 
- create code to create `.csv` and 'leaflet map` from folder of images
- learned how to rename files in image folder with exif info, and folder name
- CV: testing how to make ```.pdf``` files from ```rmarkdown```
  - kept trying to change the font from Times New Roman >> couldn't (I don't like the serif of TNR) 

**Thoughts:** 
- lots of trial and error
- r scripts must be located in folder of images for them to work properly
- I'd like to play around more with ```rmarkdown``` pdf formating ```knitr``` and ```latex```

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/rename-folder-files.R
- Webpage: https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Images/photoFolder-exif-map-WORKS-in-photo-folder.html
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/photoFolder-exif-map-WORKS-in-photo-folder.Rmd

[TOC](#TOC)

***
## R3D83 2022-03-24 <a name="R3D83"/>
**Today's Progress**: 
- making functions for some of COVID-Canada.Rmd code chunks
  - interactive tooltips
  - for creating data object excluding 'notprov'
  - create data object, choosing Date and 2 different columns !!

**Thoughts:** 
- very proud of myself as this is the first time I've tried to create a function in R - and it worked!!

**Links to code work:** 
- New with functions, html version: https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/COVID-19/output/COVID-Canada.html
- Old html version: https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/COVID-19/output/COVID-Canada-2022-03-21.html
- [COVID-Canada.Rmd](https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/COVID-19/COVID-Canada.Rmd)

[TOC](#TOC)

***
## R3D80 2022-03-21 <a name="R3D80"/>
**Today's Progress**: 
- interactive ggplot graphs in R with ```ggiraph```
- Created interactive linked map / chart for Canada COVID vaccination status
- multiple charts linked together for different vaccination status, early & late dates
- created columns for % vaccinated, and found way to make new column in % format vs decimal

**Thoughts:** 
- I had to find Canada map, to replace US map in code

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/COVID-19/output/COVID-Canada.html
- [COVID-Canada.Rmd](https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/COVID-19/COVID-Canada.Rmd)
- [Interactive COVID-Canada Vaccine web Widget](https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/COVID-19/output/my_widget_page-multi.html)
- used Canada map https://github.com/kjhealy/canmap  
- inspired by https://www.infoworld.com/article/3626911/easy-interactive-ggplot-graphs-in-r-with-ggiraph.html

[TOC](#TOC)

***
***
# Week VII <a name="weekVII"/>
***
## R3D72 2022-03-13 <a name="R3D72"/>
**Today's Progress**: 
- Revisited Climate Warming Stripes code
- learned to make presentation slides RMarkdown output: ioslides_presentation 
- learned hack to use github as webserver
  - get github URL for page, change URL to remove ```blob/```, add raw. and change github to githack
  - https:// raw.githack.com/ ... with only /master/, not /blob/master/

**Thoughts:** 
- nice way to make slides from Rmd document >> learn to make concise

**Links to code work:** 
- https://raw.githack.com/WendyAnthony/Code_Each_Day/master/My_Code/Climate/Warming_Stripes/Warming-Stripes-present-Victoria.html#1
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Climate/Warming_Stripes/Warming-Stripes-present-Victoria.Rmd

[TOC](#TOC)

***
***
## R3D9 2022-01-09 <a name="R3D9"/>
**Today's Progress**: 
- Revisited Climate Warming Stripes code and updated to 2021
  - added code for anomaly temp based on 1971-2000 Climate normals

**Thoughts:** 
- had to redo a few things as I was using different data
- takes time, but google searches found what I needed

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Climate/Warming_Stripes/Warming-Stripes-Victoria.Rmd
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Climate/Warming_Stripes/VictoriaClimateStripes-1941-2021-lg-anom.png
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Climate/Warming_Stripes/VictoriaClimateStripes-1941-2021-lg.png
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Climate/Warming_Stripes

[TOC](#TOC)

***
***
# Week II <a name="weekII"/>
***
## R3D3 2022-01-03 <a name="R3D3"/>
**Today's Progress**: 
- Created chart of my thyroid RX daily consumption, from csv exported from .xls file using `ggplot2`
- using point, line, and smooth (central line of mean and shaded error)
- combined plots for Imitrex (points) &amp; Thyroid (line) - was able to use one axis
  - couldn't also add the smooth line with error ???
- couldn't seem to get 2nd y-axis to work

**Thoughts:** 
- couldn't seem to get 2nd y-axis to work >>> tried lots of different things

**Links to code work:** 
- 

[TOC](#TOC)

***  
***
# Wish-List <a name="wishlist"/>  
- [x] Create log of coding work done as progress
- [] Make UVic website responsive & with more up-to-date styling
- Use eBird data
- [] Use iNaturalist data
- use historical weather data
- Shiny - add different choices
- learn to do more stuff with R [R Resource Links @ github.io](https://wendyanthony.github.io/R_Stats_Links-io.html)  
  - http://people.geog.uvic.ca/wanthony/website/etc/R_Stats_Links.html
- learn to use highcharts with R in ```highcharter```

[TOC](#TOC)
