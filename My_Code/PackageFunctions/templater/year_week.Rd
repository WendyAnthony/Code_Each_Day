\name{year_week}
\alias{year_week}
\title{
Convert any week of any year to a number
}
\description{
Find any week of any year as a number out of 52
}
\usage{
year_week(yyyy, mm, dd)
}
\arguments{
  \item{yyyy}{
year
}
  \item{mm}{
month in numbers with a leading 0 e.g. 04 for April
}
  \item{dd}{
date
}
}
\references{
https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strptime
}
\author{
Wendy Anthony
}
\examples{
year_week(2022, 05, 13)
    > [1] "5"

## The function is currently defined as
function (yyyy, mm, dd)
{
    str1 <- yyyy
    str2 <- mm
    str3 <- dd
    date <- paste(str1, str2, str3, sep = "-")
    date1 <- as.Date(date, format = "\%Y-\%m-\%d")
    strftime(date1, format = "\%U")
  }
}
