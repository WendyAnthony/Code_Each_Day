\name{year_day_today}
\alias{year_day_today}
\title{
Which day of the year is it today?
}
\description{
Calculating which day of the year is it today out of 365
}
\usage{
year_day_today()
}
\author{
Wendy Anthony
}
\examples{
year_day_today()
    > [1] "135"

## The function is currently defined as
function ()
{
    date2 <- Sys.Date()
    date3 <- as.Date(date2, format = "\%Y-\%m-\%d")
    strftime(date3, format = "\%j")
  }
}
