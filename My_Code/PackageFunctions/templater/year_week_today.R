year_week_today <- function(){

  date2 <- Sys.Date()

  date3 <- as.Date(date2, format = "%Y-%m-%d")
  # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strptime
  strftime(date3, format = "%V")
}
