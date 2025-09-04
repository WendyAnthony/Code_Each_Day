# Log for #Code_Each_Day - Wendy Anthony

**The log of Round 2 of my #100DaysOfCode challenge. Started on 2021-01-01**  
- [My Code](https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code)
- [2020 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2020.md)
- [2022 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2022.md)
- [2023 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2023.md)
- [2025 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2025.md)


***
## Table of Contents  <a name="toc"/>
- **[Week XXV](#weekxxv)**  
  - [R2D173 2021-06-21](#r2d173)
- **[Week XXIII](#weekxxiii)**  
  - [R2D158 2021-06-07](#r2d158)
  - [R2D157 2021-06-06](#r2d157)
- **[Week XXII](#weekxxii)**  
  - [R2D156 2021-06-05](#r2d156)
  - [R2D154 2021-06-03](#r2d154)
- **[Week XIX](#weekxix)**  
  - [R2D130 2021-05-10](#r2d130)
  - [R2D129 2021-05-09](#r2d129)
- **[Week XII](#weekxii)**  
  - [R2D74 2021-03-15](#r2d74)
- **[Week XI](#weekxi)**  
  - [R2D70 2021-03-11](#r2d70)
- **[Week IX](#weekix)**  
  - [R2D46 2021-02-25](#r2d46)
- **[Week V](#weekv)**  
  - [R2D25 2021-01-25](#r2d25)
- **[Week III](#weekiii)**  
  - [R2D16 2021-01-16](#r2d16)
  - [R2D15 2021-01-15](#r2d15)
  - [R2D14 2021-01-14](#r2d14)
  - [R2D13 2021-01-13](#r2d13)
- **[Week II](#weekii)**  
  - [R2D9 2021-01-09](#r2d9)
  - [R2D4 2021-01-04](#r2d4)  
  - [R2D3 2021-01-03](#r2d3)
- **[Week I](#weeki)**    
  - [R2D2 2021-01-02](#r2d2)  
  - [R2D1 2021-01-01](#r2d1)
- **[Wishlist](#wishlist)**  
  
***
# Week XXV <a name="weekxxv"/>
***
## R2D173 2021-06-21 <a name="r2d173"/>
**Today's Progress**: 
- revisit getting exif data from photo and plotting on R leaflet map

**Thoughts:** 
- had to do some tweaking, and figure out why lib folder of dependencies wasn't copying (not sure why, but I did finally get it to work)
  - I think the fix was htmlwidgets::saveWidget(selfcontained = TRUE) vs FALSE

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/photo-exif-map-test-lib.R

   
[TOC](#toc)

***
# Week XXII <a name="weekxxiii"/>
***
## R2D158 2021-06-07 <a name="r2d158"/>
**Today's Progress**: 
- created a single local-loading Shiny app 
- to include download button, research, north, south, needs-ID, casual

**Thoughts:** 
- would like to figure out how to use JSON query to download iNat observations, including annotations
- I wonder if I can figure out how to get around using Shiny and figure out how to make api calls to a leaflet map?

**Links to code work:** 
- https://wendyanthony.shinyapps.io/iNaturalist-madrone-shiny-leaflet-app/
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/iNaturalist/ARME/DownloadData

   
[TOC](#toc)

***
## R2D157 2021-06-06 <a name="r2d157"/>
**Today's Progress**: 
- created a download button for .csv data for iNat shiny app, 
- but download button won't show up when published ???

**Thoughts:** 
- I need to learn more about the intricicacies of Shiny publishing
- I wonder if a Shiny server could be installed in Geography website - I might ask Rick to see?

**Links to code work:** 
- https://wendyanthony.shinyapps.io/iNaturalist-madrone-shiny-leaflet-app/
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/ARME/Shiny/app.R
   
[TOC](#toc)

***
# Week XXII <a name="weekxxii"/>
***
## R2D156 2021-06-05 <a name="r2d156"/>
**Today's Progress**: 
- finally got the ARME iNaturalist Shiny App to publish

**Thoughts:** 
- worked with a search of 6000 records, but would NOT work when searching max 10,000 records
- I'd like to try to find a way to do more searches from the shiny app, and also export a csv of results
- I'd like to find out how to access the observation fields for ARME Project

**Links to code work:** 
- https://wendyanthony.shinyapps.io/iNaturalist-madrone-shiny-leaflet-app/
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/ARME/Shiny/app.R
   
[TOC](#toc)

***
## R2D154 2021-06-03 <a name="r2d154"/>
**Today's Progress**: 
- recreate Shiny app for iNaturalist observations of Arbutus menziesii

**Thoughts:** 
- I had trouble getting date formatting, though I didn't need it for this app
- Shiny app won't open/publish in Shinyapps.io online: 
  - Error Message: "An error has occurred: Unable to connect to worker after 60.00 seconds; startup took too long."
  - I'd like to try to figure out how to import iNaturalist info separate from app and just use the shiny app to visualize data already downloaded ??

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/ARME/app.R
   
[TOC](#toc)

***
# Week XIX <a name="weekxix"/>
***

## R2D130 2021-05-10 <a name="r2d130"/>
**Today's Progress**: 
- revisiting my ```Climatology``` Rscript to remember how to make a column of named months from numerical months, and to create a column for seasons

**Thoughts:** 
- I need to find some way of documenting my hard-won code snippets in order to find easier when needed next

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Climate/Visualizing_Climate_Data
   
[TOC](#toc)

***
## R2D129 2021-05-09 <a name="r2d129"/>
**Today's Progress**: 
- Trying to map Geo-referenced photos using ```R``` and ```Leaflet```
- access EXIF data from photos ```exifr```
  - ```exifr(files)``` doesn't work, but ```read_exif(files)``` does!
- .csv and .html files will be saved to working directory - I tried to find a way not to have to keep changing directory, but no luck
- get popup to show image >>> had to make image smaller to fit in popup window
  - added ```markerClusterOptions()``` to show how many images in one place, but then map Tiles don't show at highest zoom - was able to get ```Stamen.TonerLite``` to work
  - figured out how to add text to popup window

**Thoughts:** 
- I need to cull my photos, or at least put the special ones in a separate directory
- wasn't able to figure out how to make the resulting map responsive html?
- even when working from someone else's code, there is likely to be some command that no longer works

**Links to code work:** 
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/photo-exif-map-popPhoto.R
- [Extracting EXIF data from photos using R](https://www.r-bloggers.com/2016/11/extracting-exif-data-from-photos-using-r/) by Bluecology blog
- Website to find [Days of the week](https://www.calendar-365.com/day-numbers/2021.html)
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Climate/Warming_Stripes
   
[TOC](#toc)

***
# Week XII <a name="weekxii"/>
***
## R2D74 2021-03-15 <a name="r2d74"/>
**Today's Progress**: 
- wanting to find out the colour palette from an image of Herring spawn, I found R package `imgpalr`, which finds the hex colour values
- using a 'dummy' plot to test with different colours, instead of copy/paste different hex codes, I used the relative position of hex code in the character string of values e.g. str(imgpal) >> ##  chr [1:9] "#67A49B" "#487977" "#66A398" "#355B5A" "#3F6E61" "#233C3E" ... >> imgpal[3] >> ## [1] "#66A398"
- interested to know the name of some of these hex colour I found code to create a dataframe of hex colour names, but couldn't yet find a way to use these in plots
- reworked Climate Stripes code

**Thoughts:** 
- I see a need, then look for how to fullfill it through trial & error ...
- Best results: crop image to reduce amount of background colour i.e. I was only interested in milky blue cyans, so I cropped-out the darker pixel areas, and got better colour palette results
- test-driving new code in a  `.rmd` file instead of regular script, for reproducability 
- need to find a way to clean up Environment Canada historic climate date within R

**Links to code work:** 
- https://rdrr.io/cran/imgpalr/
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Images/imgpalr.Rmd
- 
  
[TOC](#toc)

***
# Week XI <a name="weekxi"/>
***
## R2D70 2021-03-11 <a name="r2d70"/>
**Today's Progress**: 
- updating list of R website resources
- playing with wordcloud shiny app to visualize readings for final assignment

**Thoughts:** 
- time to try out some of these new R links / packages
- just add new text file to Wordcloud global file, and include file.txt in the same directory as global.r ui.r server.r

**Links to code work:** 
- [R Resource Links @ github.io](https://wendyanthony.github.io/R_Stats_Links-io.html)  
  - http://people.geog.uvic.ca/wanthony/website/etc/R_Stats_Links.html
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/R_Code/R_Stats_Links.Rmd
- https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code/Wordcloud
  
[TOC](#toc)

***
# Week IX <a name="weekix"/>
***
## R2D46 2021-02-25 <a name="r2d46"/>
**Today's Progress**: 
- learning to use  R programs ```pagedown``` and ```pagedreport``` to create business cards, resume, thesis

**Thoughts:** 
- having a hard time figuring out the paging ... learned to add css @page

**Links to code work:** 
- CSS Remove page numbers:
  - @page: first{@bottom-right {content: none;}}

[TOC](#toc)

***
# Week V <a name="weekv"/>
***
## R2D25 2021-01-25 <a name="r2d25"/>
**Today's Progress**: 
1. learned you can add a background image to RStudio!! (thanx to Ihaddaden M. EL Fodil, Ph.D @moh_fodil)
2. updated ```Shiny iNaturalist app``` to allow cluster markers to spiderfy for all zoom levels

**Thoughts:** 
1. playing around with tech tricks instead of ```serious``` work ;)
2. trial and error testing until something works

**Links to code work:** 
1. https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/RStudio/RStudio-devtools-AddBackgroundImg-rclick-InspectElements.png
2. https://wendyanthony.shinyapps.io/iNaturalist-shiny-leaflet-app/  
  2.b. https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/iNaturalist/app.R

[TOC](#toc)

***
# Week III <a name="weekiii"/>
***
## R2D16 2021-01-16 <a name="r2d16"/>
**Today's Progress**: 
- test drive of r package ```{googledrive}```

**Thoughts:** 
- need to give access to googledrive api
  - not so obvious to see any folder structure / url link of resource
  - want to find out created/modified time

**Links to code work:** 
- [GoogleDrive R Package Documentation Website](https://googledrive.tidyverse.org/index.html)
  - [How to get modified date from Google Drive files](https://community.rstudio.com/t/googledrive-resources-how-to-get-modified-date/6247/2)
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/Google/googledrive_fileListTime_csv.R

[TOC](#toc)

***
## R2D15 2021-01-15 <a name="r2d15"/>
**Today's Progress**: 
- #tidytuesday tweets created a ```.rmd``` file
  - San Fransisco trees
  - Ausie fires rain plot
- ```gggiraph```

**Thoughts:** 

**Links to code work:** 

[TOC](#toc)

***
## R2D14 2021-01-14 <a name="r2d14"/>
**Today's Progress**: 
- working through lecture notes chapter 2 for ES482 R Stats course
  - created a ```.rmd``` file
- ```ggOceanMaps``` Canada_bathymetry  
  
**Thoughts:** 

**Links to code work:** 

[TOC](#toc)

***
## R2D13 2021-01-13 <a name="r2d13"/>
**Today's Progress**: 
- working through lecture notes chapter 1 for ES482 R Stats course
  - created a ```.rmd``` file

**Thoughts:** 

**Links to code work:** 

[TOC](#toc)

***
# Week II <a name="weekii"/>
***
## R2D9 2021-01-09 <a name="r2d9"/>
**Today's Progress**: 
- more ```R Stats``` ... plotting bathymetry and glacier data with ```ggOceanMaps``` and ```ggplot2```

**Thoughts:** 
- playing with different colour palletes and lat/long bounds

**Links to code work:** 
- https://mikkovihtakari.github.io/ggOceanMaps/articles/ggOceanMaps.html
  - https://github.com/MikkoVihtakari/ggOceanMaps
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/ggplot2/ggOceanMaps/ggOceanMaps_Canada_bathymetry_viridis.png
  - https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/ggplot2/ggOceanMaps/ggOceanMaps.R

[TOC](#toc)

***
## R2D4 2021-01-04 <a name="r2d4"/>
**Today's Progress**: 
- tried to get code working for my ```R Shiny``` app of Victoria Census ...
- Just for fun tried making Voronoi tesselations in R, and creating mandalas in random palettes and ```ggplot2```

**Thoughts:** 
- though my ```R Shiny``` app online works, I couldn't get the code to work in R Studio - not sure why, but very early in am, and not quite making sense of finding the problem
- doing something simply for the beauty in it, without actually understanding the math behind it ...

**Links to code work:** 
- https://wendyanthony.shinyapps.io/VicCensusApp/
  - https://github.com/WendyAnthony/ShinyStuff
- [Veroni Mandala Workshop](https://bitbucket.org/aschinchon/estalmat_0218/src/master/) <i>in Spanish</i>
  - [Colored Mandalas Tutorial](https://fronkonstin.com/2018/03/11/mandalas-colored/)

[TOC](#toc)

***
## R2D3 2021-01-03 <a name="r2d3"/>
**Today's Progress**: 
- revisiting ```R Shiny``` apps formatting, including using a ```global.R``` file for the data prep ...
  - refound my ```R Shiny``` Wordcloud app code, I added Trump-only text, needing to up the word count to 7000!

**Thoughts:** 
- after hearing fragments of Trump's 1-hour recorded rant/request of 'finding' GA votes, I decided to find a transcript to analyze using an ```R``` Wordcloud

**Links to code work:** 
- https://github.com/WendyAnthony/ShinyStuff/tree/master/Wordcloud
  - https://github.com/WendyAnthony/ShinyStuff

[TOC](#toc)

***
# Week I <a name="weeki"/>
***
## R2D1 2021-01-01 <a name="r2d1"/>
**Today's Progress**: 
- playing with ```calendR.R``` to create gridded calendars

**Thoughts:** 
- learned how to create different coloured backgrounds for specific days, and how to make more than one day the same colour

**Links to code work:** 
- https://r-coder.com/calendar-plot-r/
  - https://github.com/soundarya24/MyRSpace/blob/main/MyCalendar2021/my2021_calendar_github.R
- https://github.com/WendyAnthony/Code_Each_Day/blob/master/My_Code/ggplot2/ggOceanMaps/ggOceanMaps_Canada_bathymetry_viridis.png

[TOC](#toc)

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

[TOC](#toc)
