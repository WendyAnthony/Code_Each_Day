

# Data
wa_inat <- readRDS("wa_inat_userstats_research_append.RDS")

# Subset data
colnames(wa_inat)
wa_inat_sel <- subset(wa_inat, select = c(1,4,5,6,8,9,10,15,18,40,41))


# leaflet map with popup
leaflet() %>%
  addTiles()%>%
  addCircleMarkers(data = wa_inat_sel,
                   fillOpacity = 0.5, radius = 0.8, color = "red",
                   ~longitude,
                   ~latitude,
                   #                   popup = ~htmlEscape(common_name),
                   popup = paste0(
                     "<strong>Common Name: </strong> ", "<strong>", wa_inat_sel$common_name, "</strong>",
                     "<br />", "<strong>Scientific Name: </strong>", "<i>", wa_inat_sel$scientific_name, "</i>",
                     "<br />", "<strong>Date/Time: </strong>", wa_inat_sel$observed_on_string,
                     "<br />", "<strong>Place: </strong>", wa_inat_sel$place_guess,
                     "<br /><br />", "<img src='", wa_inat_sel$image_url, "' height='200'>"
                   ),
                   group = "myMarkers")



# test map without popup
map <- leaflet() %>%
  addTiles()%>%
  addCircleMarkers(data = wa_inat_sel,
                   fillOpacity = 0.5, radius = 0.8, color = "red",
                   ~longitude,
                   ~latitude,
                   group = "myMarkers")
map

######################################################################
######################################################################
######################################################################

# FUNCTION for leaflet and iNaturalist

inat_map_obs_leaflet <- function(data, var1, var2, var3, var4, var5) {
  leaflet() %>%
    addTiles()%>%
    addCircleMarkers(data = data,
                     fillOpacity = 0.5, radius = 0.8, color = "red",
                     ~longitude,
                     ~latitude,
                     popup = paste0(
                       "<strong>Common Name: </strong> ", "<strong>", var1, "</strong>",
                       "<br />", "<strong>Scientific Name: </strong>", "<i>", var2, "</i>",
                       "<br />", "<strong>Date/Time: </strong>", var3,
                       "<br />", "<strong>Place: </strong>", var4,
                       "<br /><br />", "<img src='", var5, "' height='200'>"
                     ),
                     group = "myMarkers")
}

inat_map_obs_leaflet(
  wa_inat_sel,
  wa_inat_sel$common_name,
  wa_inat_sel$scientific_name,
  wa_inat_sel$observed_on_string,
  wa_inat_sel$place_guess,
  wa_inat_sel$image_url)

######################################################################
######################################################################
######################################################################

