# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


output <- get_quote("BTC_USDT", source = "bitmart", futures = FALSE, interval = "1h")


output[!output$open >= output$low]

# Error on Bitmart hourly
# open     high   low    close   volume
# 2024-06-23 08:00:00 64379.98 64413.59 64380 64386.48 121228.1



# script end;
