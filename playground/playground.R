# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()




foo <- function(
    x) {

  y <- try(
    xts::as.xts(
      x
    )
  )

  if (!inherits(y, "try-error")) {

    x <- do.call(
      what = cbind,
      lapply(
        c("open", "high", "low", "close", "volume"),
        pull,
        from = y
      )
    )

  } else {

    x <- zoo::fortify.zoo(
      do.call(
        what = cbind,
        setNames(
          lapply(
            c("open", "high", "low", "close", "volume"),
            pull,
            from = x
          ),
          nm = c("open", "high", "low", "close", "volume")
        )

      ),
      names = c(
        "index"
      )
    )



  }

  x

}




chart(
  ticker = BTC,
  main = kline(),
  sub = list(
    volume()
  ),
  indicator = list(
    sma(n = 10),
    sma(n = 20),
    bollinger_bands(
      n = 20
    )
  )
)


# script end;
