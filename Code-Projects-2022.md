# Log for #Code_Each_Day - Wendy Anthony

**The log of Round 3 of my #100DaysOfCode challenge. Started on 2022-01-09**  
- [My Code](https://github.com/WendyAnthony/Code_Each_Day/tree/master/My_Code)
- [2020 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2020.md)
- [2021 Code Projects](https://github.com/WendyAnthony/Code_Each_Day/blob/master/Code-Projects-2021.md)

***
## Table of Contents  <a name="TOC"/>
- **[Week XII](#weekXII)**    
  - [R3D84 2022-03-25](#R3D84)
  - [R3D83 2022-03-24](#R3D83)
  - [R3D80 2022-03-21](#R3D80) 
- **[Week XI](#weekXI)**    
  - [R3D72 2022-03-13](#R3D72)  
- **[Week III](#weekIII)**    
  - [R3D9 2022-01-09](#R3D9)
- **[Week II](#weekII)**    
  - [R3D3 2022-01-03](#R3D3)
- **[Wishlist](#wishlist)**  
  
***
# Week XII <a name="weekXII"/>
***
## R3D83 2022-03-25 <a name="R3D84"/>
**Today's Progress**: 
- create code to create `.csv` and 'leaflet map` from folder of images
- learned how to rename files in image folder with exif info, and folder name

**Thoughts:** 
- lots of trial and error

**Links to code work:** 
- 

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
# Week XI <a name="weekXI"/>
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
