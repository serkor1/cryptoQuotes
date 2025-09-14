# script: test-charing
# date: 2024-01-31
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Test wether the charting
# functions returns a plotly object without errors
# script start;
testthat::test_that(desc = "Charting with klines and indicators", code = {
  # 1) create chart
  # with klines
  test_chart <- chart(
    ticker = cryptoQuotes:::control_data$quote,
    main = kline(),
    sub = list(
      volume(),
      rsi(),
      macd(),
      smi(),
      fgi(index = cryptoQuotes:::control_data$fgindex),
      lsr(ratio = cryptoQuotes:::control_data$lsratio)
    ),
    indicator = list(
      donchian_channel(),
      dema(),
      ema(),
      evwma(),
      hma(),
      zlema(),
      sma(),
      wma(),
      evwma(),
      vwap(),
      bollinger_bands(),
      alma()
    )
  )

  # 2) check that there is no erros
  testthat::expect_no_error(
    test_chart
  )

  # 3) check that its a plotly
  # object
  testthat::expect_true(
    object = inherits(
      x = test_chart,
      what = "plotly"
    ),
  )
})


testthat::test_that(desc = "Charting with klines and indicators", code = {
  # 1) create chart
  # with klines
  test_chart <- chart(
    ticker = cryptoQuotes:::control_data$quote,
    main = pline(),
    sub = list(
      volume(),
      rsi(),
      macd(),
      smi(),
      fgi(index = cryptoQuotes:::control_data$fgindex),
      lsr(ratio = cryptoQuotes:::control_data$lsratio)
    ),
    indicator = list(
      donchian_channel(),
      dema(),
      ema(),
      evwma(),
      hma(),
      zlema(),
      sma(),
      wma(),
      evwma(),
      vwap(),
      bollinger_bands(),
      alma()
    )
  )

  # 2) check that there is no erros
  testthat::expect_no_condition(
    test_chart
  )

  # 3) check that its a plotly
  # object
  testthat::expect_true(
    object = inherits(
      x = test_chart,
      what = "plotly"
    ),
  )
})


testthat::test_that(desc = "Charting with ohlc bars and indicators", code = {
  # 1) create chart
  # with klines
  test_chart <- chart(
    ticker = cryptoQuotes:::control_data$quote,
    main = ohlc(),
    sub = list(
      volume(),
      rsi(),
      macd(),
      smi(),
      fgi(index = cryptoQuotes:::control_data$fgindex),
      lsr(ratio = cryptoQuotes:::control_data$lsratio)
    ),
    indicator = list(
      donchian_channel(),
      dema(),
      ema(),
      evwma(),
      hma(),
      zlema(),
      sma(),
      wma(),
      evwma(),
      vwap(),
      bollinger_bands(),
      alma()
    )
  )

  # 2) check that there is no erros
  testthat::expect_no_condition(
    test_chart
  )

  # 3) check that its a plotly
  # object
  testthat::expect_true(
    object = inherits(
      x = test_chart,
      what = "plotly"
    )
  )
})


testthat::test_that(desc = "Charting with event data", code = {
  set.seed(1903)
  event_data <- ATOM[
    sample(
      seq_len(nrow(ATOM)),
      size = 2
    )
  ]

  # 1.1) Extract the index
  # from the event data
  index <- zoo::index(
    event_data
  )

  # 1.2) Convert the coredata
  # into a data.frame
  event_data <- as.data.frame(
    zoo::coredata(event_data)
  )

  # 1.3) Add the index into the data.frame
  # case insensitive
  event_data$index <- index

  # 1.4) add events to the data.
  # here we use Buys and Sells.
  event_data$event <- rep(
    x = c('Buy', 'Sell'),
    lenght.out = nrow(event_data)
  )

  # 1.5) add colors based
  # on the event; here buy is colored
  # darkgrey, and if the position is closed
  # with profit the color is green
  event_data$color <- ifelse(
    event_data$event == 'Buy',
    yes = 'darkgrey',
    no = ifelse(
      subset(event_data, event == 'Buy')$Close <
        subset(event_data, event == 'Sell')$Close,
      yes = 'green',
      no = 'red'
    )
  )

  # 1.6) modify the event to add
  # closing price at each event
  event_data$event <- paste0(
    event_data$event,
    ' @',
    event_data$Close
  )

  # 2) Chart the the klines
  # and add the buy and sell events
  testthat::expect_true(
    object = inherits(
      chart(
        ticker = ATOM,
        main = kline(),
        sub = list(
          volume()
        ),
        indicator = list(
          bollinger_bands()
        ),
        event_data = event_data,
        options = list(
          dark = TRUE,
          deficiency = FALSE
        )
      ),
      what = "plotly"
    )
  )
})

# script end;
