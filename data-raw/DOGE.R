## code to prepare `DOGE` dataset goes here

# 1) Extract DOGECOIN
# on the 1 minute chart around
# the time Elon Musk tweeted.
#
# He tweeted at 06:18 UTC on January 14, 2022
DOGE <- get_quote(
  ticker = "DOGEUSDT",
  interval = "1m",
  from =  as.POSIXct("2022-01-14 06:00:00", tz = "UTC"),
  to   =  as.POSIXct("2022-01-14 07:00:00", tz = "UTC")
)

usethis::use_data(DOGE, overwrite = TRUE)

