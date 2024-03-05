# script: scr_charting
# date: 2023-10-25
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Charting in general
# script start;

## charting the klines
## with indicators as
## subcharts
chart(
  ticker     = BTC,
  main       = kline(),
  sub        = list(
    volume(),
    macd()
  ),
  indicator = list(
    bollinger_bands(),
    sma(),
    alma()
  ),
  options = list(
    dark = TRUE,
    deficiency = FALSE
  )
)

## charting the MACD-indicator
## with klines as subcharts
chart(
  ticker     = BTC,
  main       = macd(),
  sub        = list(
    volume(),
    kline()
  ),
  indicator = list(
    bollinger_bands(),
    sma()
  ),
  options = list(
    dark = TRUE,
    deficiency = FALSE
  )
)

# script end;
