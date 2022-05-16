\name{year_week_day}
\alias{year_week_day}
\title{
Convert any date to Day of the Week
}
\description{
What is the name of the day of the week of any date?
}
\usage{
year_week_day(yyyy, mm, dd)
}
\references{
https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strptime
}
\author{
Wendy Anthony
}
\examples{
year_week_day(2022, 05, 13)
    > [1] "Friday"

## The function is currently defined as
function (yyyy, mm, dd)
{
    str1 <- yyyy
    str2 <- mm
    str3 <- dd
    date <- paste(str1, str2, str3, sep = "-")
    date1 <- as.Date(date, format = "\%Y-\%m-\%d")
    strftime(date1, format = "\%A")
  }
}
