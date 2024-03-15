# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()

BTC <- cryptoQuotes::get_quote(
  ticker   = 'BTCUSD',
  interval = '1d',
  source   = 'kraken',
  futures  = FALSE,
  from     = Sys.Date() - 1000,
  to       = Sys.Date()
)

nrow(BTC)


head(BTC)
head(BTC)



length(
  seq(
    from = coerce_date(Sys.Date() - 10),
    to   = coerce_date(Sys.Date() - 1),
    by   = "+15 mins"
  )
)


default_dates(
  interval = "15m",
  from = coerce_date(Sys.Date() - 10),
  to   = coerce_date(Sys.Date() - 1)
)

# script end;


origin_date <- '1970-01-01'

as.POSIXct(
  trunc(as.double(coerce_date(Sys.Date() - 10))/(15*60))*(15*60),
  tz = 'UTC',
  origin = origin_date
)
