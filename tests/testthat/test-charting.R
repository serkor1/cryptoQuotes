testthat::test_that("Charting with klines, SMA and MACD works as intended", {
  testthat::expect_no_error(
    {
      cryptoQuotes::chart(
        chart = {
          cryptoQuotes::kline(
            quote = cryptoQuotes::ATOMUSDT

          ) %>% cryptoQuotes::addMA(
            FUN = TTR::SMA,
            n = 10
          ) %>%
            cryptoQuotes::addMACD() %>%
            cryptoQuotes::addRSI() %>%
            cryptoQuotes::addVolume() %>%
            cryptoQuotes::addBBands()
        }
      )

    }
  )
}
)


testthat::test_that("Charting with ohlc, SMA and MACD works as intended", {
  testthat::expect_no_error(
    {
      cryptoQuotes::chart(
        chart = {
          cryptoQuotes::ohlc(
            quote = cryptoQuotes::ATOMUSDT

          ) %>% cryptoQuotes::addMA(
            FUN = TTR::SMA,
            n = 10
          ) %>% cryptoQuotes::addMACD() %>%
            cryptoQuotes::addRSI() %>%
            cryptoQuotes::addVolume() %>%
            cryptoQuotes::addBBands()
        }
      )

    }
  )
}
)

testthat::test_that("Charting with klines and adding Eventlines", {
  testthat::expect_no_error(
    {

      # Create Eventdata
      set.seed(1903)
      event_data <- cryptoQuotes::ATOMUSDT[
        sample(1:nrow(cryptoQuotes::ATOMUSDT), size = 2)
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
        no  = ifelse(
          subset(event_data, event == 'Buy')$Close < subset(event_data, event == 'Sell')$Close,
          yes = 'green',
          no  = 'red'
        )
      )

      # 1.6) modify the event to add
      # closing price at each event
      event_data$event <- paste0(
        event_data$event, ' @', event_data$Close
      )

      # 2) Chart the the klines
      # and add the buy and sell events
      cryptoQuotes::chart(
        chart = cryptoQuotes::kline(
          ATOMUSDT
        ) %>% cryptoQuotes::addEvents(
          event = event_data
        )
      )



    }
  )
}
)

