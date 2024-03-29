% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chart_rsi.R
\name{rsi}
\alias{rsi}
\title{Add RSI indicators to your
chart}
\usage{
rsi(
  n = 14,
  maType = "SMA",
  upper_limit = 80,
  lower_limit = 20,
  internal = list(),
  ...
)
}
\arguments{
\item{n}{Number of periods for moving averages.}

\item{maType}{Either:
\enumerate{
  \item A function or a string naming the function to be called.
  \item A \emph{list} with the first component like (1) above, and
    additional parameters specified as \emph{named} components.
    See Examples.
}}

\item{upper_limit}{A \link{numeric}-vector of \link{length} 1. 80 by default. Sets the upper limit of the \link[TTR:RSI]{TTR::RSI}.}

\item{lower_limit}{A \link{numeric}-vector of \link{length} 1. 20 by default. Sets the lower limit of the \link[TTR:RSI]{TTR::RSI}.}

\item{internal}{An empty \link{list}. Used for internal purposes. Ignore.}

\item{...}{Other arguments to be passed to the \code{maType} function in
case (1) above.}
}
\value{
Invisbly returns a plotly object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

The RSI can be customized with different look-back periods to suit various trading strategies and timeframes.
It is a valuable tool for assessing the momentum and relative strength of an asset, helping traders make more informed decisions in financial markets.
}
\examples{
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
}
\seealso{
Other chart indicators: 
\code{\link{add_event}()},
\code{\link{alma}()},
\code{\link{bollinger_bands}()},
\code{\link{chart}()},
\code{\link{dema}()},
\code{\link{ema}()},
\code{\link{evwma}()},
\code{\link{fgi}()},
\code{\link{hma}()},
\code{\link{lsr}()},
\code{\link{macd}()},
\code{\link{sma}()},
\code{\link{volume}()},
\code{\link{vwap}()},
\code{\link{wma}()},
\code{\link{zlema}()}

Other subcharts: 
\code{\link{add_event}()},
\code{\link{fgi}()},
\code{\link{lsr}()},
\code{\link{macd}()},
\code{\link{volume}()}
}
\concept{chart indicators}
\concept{subcharts}
