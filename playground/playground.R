# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()

DOGE <- cryptoQuotes::get_quote(
  ticker   = 'DOGEUSDTM',
  interval = '1m',
  source   = 'kucoin',
  futures  = TRUE
)



# script end;
