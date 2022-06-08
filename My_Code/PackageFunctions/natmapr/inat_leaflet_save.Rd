\name{inat_leaflet_save}
\alias{inat_leaflet_save}
\title{
3. Save leaflet map object as html webpage
}
\description{
Save leaflet map object as html webpage, including the required .css and .js files. To save the finished map, uses inat_leaflet_save() >> inat_leaflet_save(m, filename) >> e.g. inat_leaflet_save(map3, file = "file.html")
}
\usage{
inat_leaflet_save(m, filename)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{m}{
Name of leaflet map object created by inat_leaflet(). Run m <- inat_leaflet(data, long, lat, var1, var2, var3, var4, var5, var6) to get the object m to use to save the leaflet map.
}
  \item{filename}{
The "filename.html" used to save the leaflet map object as an html file.
}
}

\author{
Wendy Anthony <o2b.pickin@gmail.com>
}
\examples{

# m <- inat_leaflet(
#        inat_esqlag,
#        inat_esqlag$longitude,
#        inat_esqlag$latitude,
#        inat_esqlag$common_name,
#        inat_esqlag$scientific_name,
#        inat_esqlag$observed_on_string,
#        inat_esqlag$place_guess,
#        inat_esqlag$url, inat_esqlag$image_url)

# inat_leaflet_save(m, "./inst/extdata/esq_lag.html")

## The function is currently defined as
function (m, filename)
{
  htmlwidgets::saveWidget(m, file = filename)
  }
}
