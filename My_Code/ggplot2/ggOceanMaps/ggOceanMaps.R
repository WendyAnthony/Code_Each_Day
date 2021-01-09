# https://d2xy2u667w9tvp.cloudfront.net/LAYDB-1-BlueMarbleWithBathymetry-data/1072915200000/0/3/3_2.jpg

# install.packages("ggOceanMaps", repos = c("https://mikkovihtakari.github.io/drat", "https://cloud.r-project.org"))
# Due to the package size limitations, ggOceanMaps requires the ggOceanMapsData package 
# which stores the shapefiles and should be installed automatically when ggOceanMaps is loaded. 
# Note that actual installation size of the package is larger (about 35 Mb) than stated on CRAN due to shapefiles used by ggOceanMaps.
# devtools::install_github("MikkoVihtakari/ggOceanMapsData") # required by ggOceanMaps
library(ggOceanMaps)
library(ggOceanMapsData)

citation("ggOceanMaps")

# The limits argument can be defined either as a numeric vector of length 1 or 4. Specifying the argument 
# as a single integer between 30 and 88 or -88 and -30 plots a polar stereographic map for the Arctic or Antarctic, respectively.
### circular map
basemap(limits = 88) # blank? white - ocean
basemap(limits = -88) # blank? grey - land
basemap(limits = 60) # arctic
basemap(limits = 40) # arctic
basemap(limits = 30) # north hemisphere
basemap(limits = -30) # south hemisphere
basemap(limits = -60) # Antarctica

## square map
# Rectangular maps are plotted by specifying the limits argument 
# as a numeric vector of length 4 where the first element defines the start longitude, 
# the second element the end longitude, the third element the minimum latitude
# and the fourth element the maximum latitude of the bounding box:
basemap(limits = c(-20, 20, 40, 59)) # UK and N Europe
basemap(limits = c(-120, -60, 30, 80)) # north NAmerica
basemap(limits = c(-120, -65, 30, 80)) # Canada

#  limit your map first and only then plot bathymetry and glaciers 
# to save the processing time of your computer (the bathymetry shapes can be large). 
basemap(limits = c(-120, -65, 30, 80)) # Canada
basemap(limits = c(-120, -65, 30, 80), glaciers = TRUE, bathymetry = TRUE) # Canada bathymetry

dt <- data.frame(lon = c(-30, -30, 30, 30), lat = c(50, 80, 80, 50))
# Using lon and lat as longitude and latitude columns, respectively.
# projection transformed from +init=epsg:4326 to +init=epsg:3995
basemap(data = dt, bathymetry = TRUE) + 
  geom_polygon(data = transform_coord(dt), aes(x = lon, y = lat), color = "red", fill = NA)

# Adding data to maps
dt <- data.frame(lon = c(seq(-180, 0, 30), seq(30, 180, 30)), lat = -70)
basemap(limits = -60, glaciers = TRUE) + geom_spatial_point(data = dt, aes(x = lon, y = lat), color = "red")

# 'ggplot functions can also be used, but the coordinates need to be transformed to 
# the basemap projection first using the transform_coord function:'
basemap(limits = -60, glaciers = TRUE) +
  geom_point(data = transform_coord(dt), aes(x = lon, y = lat), color = "red")

# 'Note that the maps plotted in temperate and tropical regions are not projected.
# Consequently, decimal degrees work for such maps directly'
dt <- data.frame(lon = c(-100, -80, -60), lat = c(10, 25, 40), var = c("a", "a", "b"))
basemap(data = dt) + geom_point(data = dt, aes(x = lon, y = lat), color = "red") # Florida Key / Gulf of Mexico

# 'The transform_coord function detects the projection automatically, 
# given that the map is limited using a similar range of coordinates. 
# Therefore you can use the transform_coord as demonstrated above whenever using standard ggplot layers.'
transform_coord(data.frame(lon = -80, lat = 25), bind = TRUE)
#>   lon lat lon.proj lat.proj
#> 1 -80  25      -80       25

## Rotating maps
basemap(limits = c(-160, -80, 60, 85), rotate = TRUE) # northern Canada Islands
basemap(limits = c(-135, -60, 42, 90), rotate = TRUE) # northern NA / Canada

basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, glaciers = TRUE, bathymetry = TRUE) # northern NA / Canada bathymetry

# bathy.style = "contour_grey"
basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, glaciers = TRUE, bathymetry = TRUE, bathy.style = "contour_blues") # northern NA / Canada bathymetry

## Customizing bathymetry styles
basemap(limits = c(-140, -105, 20, 40), bathymetry = TRUE) + scale_fill_viridis_d("Water depth (m)") # Baja California

basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, glaciers = TRUE, bathymetry = TRUE) + scale_fill_viridis_d("Water depth (m)") # northern NA / Canada bathymetry

basemap(limits = c(0, 60, 68, 80), bathymetry = TRUE, bathy.style = "contour_blues") + scale_color_hue()

###### ***********
###### ***********
basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, glaciers = TRUE, bathymetry = TRUE) # northern NA / Canada bathymetry
basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, bathymetry = TRUE, bathy.style = "contour_blues") + scale_color_hue() # Canada
basemap(limits = c(-140, -50, 42, 90), rotate = TRUE, glaciers = TRUE, bathymetry = TRUE) + scale_fill_viridis_d("Water depth (m)") # northern NA / Canada bathymetry
ggsave("ggOceanMaps_Canada_bathymetry.png", height = 10, width = 8)
###### ***********
###### ***********

## Graphical parameters
basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, glaciers = TRUE,
        bathymetry = TRUE, bathy.style = "poly_greys",
        land.col = "#eeeac4", gla.col = "cadetblue",
        land.border.col = NA, gla.border.col = NA,
        grid.size = 0.05)

# Grid lines can be removed by setting the grid.col to NA. 
# Axis labels can be manipulated using standard ggplot code:
basemap(limits = c(-135, -60, 42, 90), rotate = TRUE, grid.col = NA) + labs(x = NULL, y = "Only latitude for you, ...")
