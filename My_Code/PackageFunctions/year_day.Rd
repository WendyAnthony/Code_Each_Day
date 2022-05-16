\name{year_day}
\alias{year_day}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert any date to number of days in year
}
\description{
Find any date as a number out of 365
}
\usage{
year_day()
}
\details{
yyyy is year, mm is month e.g. 04 for April, dd is day e.g. 03
}
\value{
returned value is number of days out of 365
}
\references{
https://stackoverflow.com/questions/7958298/how-do-you-convert-posix-date-to-day-of-year
}
\author{
Wendy Anthony
}
\examples{
year_day(2022, 05, 13)
    > [1] "133"
}
