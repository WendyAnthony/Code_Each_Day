week_day <- function(yyyy, mm, dd){

  str1 <- yyyy
  str2 <- mm
  str3 <- dd

  date <- paste(str1, str2, str3, sep = "-")

  date1 <- as.Date(date, format = "%Y-%m-%d")
  # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strptime
  strftime(date1, format = "%V")
}
