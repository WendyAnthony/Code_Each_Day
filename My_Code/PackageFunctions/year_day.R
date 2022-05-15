year_day <- function(yyyy, mm, dd){

  str1 <- yyyy
  str2 <- mm
  str3 <- dd

  date <- paste(str1, str2, str3, sep = "-")

  date1 <- as.Date(date, format = "%Y-%m-%d")
  # https://stackoverflow.com/questions/7958298/how-do-you-convert-posix-date-to-day-of-year
  strftime(date1, format = "%j")
}
