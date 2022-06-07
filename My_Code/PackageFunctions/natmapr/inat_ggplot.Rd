\name{inat_ggplot}
\alias{inat_ggplot}
\title{
Create ggplot from iNaturalist observations
}
\description{
Create a ggplot from iNaturalist observations, defining the location place name,
    which is also included as the ggplot subtitle,
    and the name of the file saving the ggplot image.
}
\arguments{
  \item{place}{
A dataframe with all observations from the same location.
}
  \item{titleplace}{
The "place name" (within quotes) as it will appear in the ggplot subtitle.
}
  \item{filename}{
The "file name.jpg" (within quotes) to save the ggplot image.
}
  \item{colx}{
The column name used for the x axis in ggplot e.g. Scientific Name.
  Note: the coord_flip() function actually makes this the y axis.
}
  \item{coly}{
The column name used for the y axis in ggplot e.g. Date (make sure this is a date object using lubridate package).
  Note: the coord_flip() function actually makes this the x axis.
}
}
\details{
Some data cleaning will be needed in order to first create the dataframe
    (e.g. ensure date column is a date object using lubridate package.
    Read RDS file, find column names to find place name.
    Use function as described.
}
\author{
Wendy Anthony <o2b.pickin@gmail.com>
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.


## Read Data
# inat_esqlag <- readRDS("./inst/extdata/esquimalt_lagoon_sub.RDS")
## find column names
# colnames(inat_esqlag)
## find place name
# inat_esqlag$place
## create and save ggplot.jpg
# inat_ggplot(inat_esqlag, "Esquimalt Lagoon", "./inst/extdata/inat_ggplot_bw.jpg",
# inat_esqlag$scientific_name, inat_esqlag$date)


## The function is currently defined as
function (place, titleplace, filename, colx, coly)
{
  }
}
