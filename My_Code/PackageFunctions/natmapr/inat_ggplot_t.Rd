\name{inat_ggplot_t}
\alias{inat_ggplot_t}
\title{
  Create ggplot from iNaturalist observations, specifying legend title
}
\description{
Create a ggplot from iNaturalist observations, defining the location place name,
  which is also included as the ggplot subtitle,
  the name of the file saving the ggplot image, and the chart axis labels.
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
The column name used for the x axis in ggplot e.g. inat_esqlag$scientific_name.
    Note: the coord_flip() function actually makes this the y axis.
  }
  \item{coly}{
The column name used for the y axis in ggplot e.g. e.g. inat_esqlag$date (make sure this is a date object using   lubridate package). Note: the coord_flip() function actually makes this the x axis.
  }
  \item{colfill}{
The column name used to generate a colour fill in the ggplot. e.g. inat_esqlag$Genus
  }
 \item{xlabel}{
The "column name" (within quotes) used to label the x axis.
  }
 \item{ylabel}{
The "column name" (within quotes) used to label the y axis.
  }
 \item{legtitle}{
The "column name" (within quotes) used for the legend title.
  }
}
\author{
Wendy Anthony
}
\examples{
## Read Data
# inat_esqlag <- readRDS("./inst/extdata/esquimalt_lagoon_sub.RDS")
## find column names
# colnames(inat_esqlag)
## find place name
# inat_esqlag$place
## create and save ggplot.jpg
# inat_ggplot_t(inat_esqlag, "Esquimalt Lagoon",
# "./inst/extdata/inat_ggplot_legtitle.jpg", inat_esqlag$scientific_name,
# inat_esqlag$date, inat_esqlag$Genus, "Scientific Name", "Date", "Genus")

## The function is currently defined as
function (place, titleplace, filename, colx, coly, colfill, xlabel, ylabel, legtitle)
{
  }
}
