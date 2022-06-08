\name{photo_leaflet}
\alias{photo_leaflet}
\title{
2. Create leaflet map from folder of jpg images
}
\description{
Create a leaflet map from a folder of jpg images. First do the file cleaning using photo_folder_leaflet.R. To save the finished map, uses inat_leaflet_save() >> inat_leaflet_save(m, filename) >> e.g. inat_leaflet_save(map3, "file.html")

}
\usage{
photo_leaflet(data, var1, var2, var3, var4, var5, var6, var7, var8, folder, tiles)
}
\arguments{
  \item{data}{
Dataframe created and saved as an object in RStudio Environment.
}
  \item{var1}{
Column name for longitude
}
  \item{var2}{
Column name for latitude
}
  \item{var3}{
Column name for SourceFile
}
  \item{var4}{
Column name for DateTimeOriginal
}
  \item{var5}{
Column name for FNumber
}
  \item{var6}{
Column name for ISO
}
  \item{var7}{
Column name for ExposureTime
}
  \item{var8}{
Column name for FocalLength
}
  \item{folder}{
Variable obtained through file photo_folder_leaflet.R
}
  \item{tiles}{
Variable for provider tiles. Options include: "CartoDB.Positron", "OpenStreetMap.Mapnik", "OpenStreetMap.HOT", "OpenTopoMap", "Stamen.TonerBackground", "Stamen.TonerLite", "Stamen.Watercolor", "Stamen.Terrain", "Stamen.TopOSMRelief", "Esri.WorldStreetMap", "Esri.WorldTopoMap", "Esri.WorldTerrain", "Esri.NatGeoWorldMap", "Esri.WorldImagery". More tiles names found at: http://leaflet-extras.github.io/leaflet-providers/preview/index.html

}
}
\author{
Wendy Anthony <o2b.pickin@gmail.com>
}
\examples{
 map3 <- photo_leaflet(dat3, dat3$longitude, dat3$latitude,
 dat3$SourceFile, dat3$DateTimeOriginal, dat3$FNumber,
 dat3$ISO, dat3$ExposureTime, dat3$FocalLength, folder, "Esri.WorldImagery")

 map3

## The function is currently defined as
function (data, var1, var2, var3, var4, var5, var6, var7, var8, folder, tiles)
{
  }
}
