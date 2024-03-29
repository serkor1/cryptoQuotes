% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_lsratio.R
\name{get_lsratio}
\alias{get_lsratio}
\title{Get the long to short ratio of a cryptocurrency pair}
\usage{
## long-short ratio
get_lsratio(
   ticker,
   interval = '1d',
   source   = 'binance',
   from     = NULL,
   to       = NULL,
   top      = FALSE
)
}
\arguments{
\item{ticker}{A \link{character} vector of \link{length} 1. See \code{\link[=available_tickers]{available_tickers()}} for available tickers.}

\item{interval}{A \link{character} vector of \link{length} 1. See \code{\link[=available_intervals]{available_intervals()}} for available intervals.}

\item{source}{A \link{character}-vector of \link{length} 1. See \code{\link[=available_exchanges]{available_exchanges()}} for details.}

\item{from}{An optional vector of \link{length} 1. Can be \code{\link[=Sys.Date]{Sys.Date()}}-class, \code{\link[=Sys.time]{Sys.time()}}-class or \code{\link[=as.character]{as.character()}} in \%Y-\%m-\%d format.}

\item{to}{An optional vector of \link{length} 1. Can be \code{\link[=Sys.Date]{Sys.Date()}}-class, \code{\link[=Sys.time]{Sys.time()}}-class or \code{\link[=as.character]{as.character()}} in \%Y-\%m-\%d format.}

\item{top}{A \link{logical} vector. \link{FALSE} by default. If \link{TRUE} it returns the top traders Long-Short ratios.}
}
\value{
An \link{xts}-object containing,
\itemize{
\item long (\link{numeric}) - the share of longs
\item short (\link{numeric}) - the share of shorts
\item ls_ratio (\link{numeric}) - the ratio of longs to shorts
}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}

Get the long-short ratio for any \code{\link[=available_tickers]{available_tickers()}} from the \code{\link[=available_exchanges]{available_exchanges()}}
}
\details{
\subsection{On time-zones and dates}{

Values passed to \code{from} or \code{to} must be coercible by \code{\link[=as.Date]{as.Date()}}, or \code{\link[=as.POSIXct]{as.POSIXct()}}, with a format of either \code{"\%Y-\%m-\%d"} or \code{"\%Y-\%m-\%d \%H:\%M:\%S"}. By default
all dates are passed and returned with \code{\link[=Sys.timezone]{Sys.timezone()}}.
}

\subsection{On returns}{

If only \code{from} is provided 200 pips are returned up to \code{Sys.time()}. If only \code{to} is provided 200 pips up to the specified date
is returned.
}
}
\note{
\subsection{Available exchanges}{

See \code{\link[=available_exchanges]{available_exchanges()}} with  for available exchanges.
}

\subsection{Limited return values}{

Binance only supports data for the last 30 days. Use other exchanges if you need beyond that.
}
}
\examples{
\dontrun{
  # Example on loading
  # long-short ratio
  # for the last days
  # on the 15 minute candle
  # wrapped in try to avoid
  # failure on Github

  # 1) long-short ratio
  # on BTCUSDT pair
  ls_ratio <- cryptoQuotes::get_lsratio(
    ticker = 'BTCUSDT',
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )

  # 2) BTCSDT in same period
  # as the long-short ratio;
  BTC <- cryptoQuotes::get_quote(
    ticker = 'BTCUSDT',
    futures = TRUE,
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )

  # 3) plot BTCUSDT-pair
  # with long-short ratio
  cryptoQuotes::chart(
    ticker = BTC,
    main   = cryptoQuotes::kline(),
    sub    = list(
      cryptoQuotes::lsr(ratio = ls_ratio),
      cryptoQuotes::volume()
    ),
    indicator = list(
      cryptoQuotes::bollinger_bands()
    )
  )
}



# end of scrtipt;
}
\seealso{
Other get-function: 
\code{\link{get_fgindex}()},
\code{\link{get_fundingrate}()},
\code{\link{get_openinterest}()},
\code{\link{get_quote}()}
}
\author{
Jonas Cuzulan Hirani
}
\concept{get-function}
