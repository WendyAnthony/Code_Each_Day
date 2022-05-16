\name{year_day_today}
\alias{year_day_today}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Which day of the year is it today?
}
\description{
Calculating which day of the year is it today out of 365
}
\usage{
year_day_today()
}
%- maybe also 'usage' for other objects documented here.
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Wendy Anthony
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
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
