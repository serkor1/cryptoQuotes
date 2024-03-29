% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/available_intervals.R
\name{available_intervals}
\alias{available_intervals}
\title{Get available intervals}
\usage{
available_intervals(source = "binance", type = "ohlc", futures = TRUE)
}
\arguments{
\item{source}{A \link{character}-vector of \link{length} 1. \code{binance} by default. See \code{\link[=available_exchanges]{available_exchanges()}} for available exchanges.}

\item{type}{\link{character}-vector of length 1. See details}

\item{futures}{A \link{logical}-vector of \link{length} 1. \link{TRUE} by default. Returns futures market if \link{TRUE}, spot market otherwise.}
}
\value{
An \code{\link[=invisible]{invisible()}} \link{character} vector containing the  available intervals on
the exchange, market and endpoint
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}

Get available intervals for the \code{\link[=available_tickers]{available_tickers()}} on the \code{\link[=available_exchanges]{available_exchanges()}}.
}
\details{
\subsection{Available types}{
\itemize{
\item ohlc: Open, High, Low, Close and Volume
\item lsratio: Long-Short ratio
\item fundingrate: Funding rates
\item interest: Open perpetual contracts on both sides
}
}

\subsection{Limits}{

The endpoints supported by the \code{\link[=available_exchanges]{available_exchanges()}} are not uniform,
so exchanges available for, say, \code{\link[=get_lsratio]{get_lsratio()}} is not necessarily the same as those available for \code{\link[=get_quote]{get_quote()}}
}
}
\examples{
\dontrun{
  # script:
  # date: 2023-10-06
  # author: Serkan Korkmaz, serkor1@duck.com
  # objective:
  # script start;

  # available intervals
  # at kucoin futures market
  cryptoQuotes::available_intervals(
    source = 'kucoin',
    futures = TRUE
  )

  # available intervals
  # at kraken spot market
  cryptoQuotes::available_intervals(
    source = 'kraken',
    futures = FALSE
  )

  # script end;
}
}
\seealso{
Other supported calls: 
\code{\link{available_exchanges}()},
\code{\link{available_tickers}()}
}
\author{
Serkan Korkmaz
}
\concept{supported calls}
