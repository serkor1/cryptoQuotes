# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()



bars <- function() {
  chart(
    ticker = cryptoQuotes:::control_data$quote,
    main   = ohlc(),
    indicator = list(
      bollinger_bands(),
      sma(n = 10),
      sma(n = 15),
      sma(n = 14)
    ),
    sub = list(
      macd(),
      rsi(),
      fgi(cryptoQuotes:::control_data$fgindex),
      lsr(cryptoQuotes:::control_data$lsratio)
    ),
    options = list(
      deficiency = FALSE
    )
  )

}

bars()


# script end;
