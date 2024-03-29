% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chart_bollingerbands.R
\name{bollinger_bands}
\alias{bollinger_bands}
\title{Add Bollinger Bands
to the chart}
\usage{
bollinger_bands(n = 20, sd = 2, maType = "SMA", internal = list(), ...)
}
\arguments{
\item{n}{Number of periods for moving average.}

\item{sd}{The number of standard deviations to use.}

\item{maType}{A function or a string naming the function to be called.}

\item{internal}{An empty \link{list}. Used for internal purposes. Ignore.}

\item{...}{Other arguments to be passed to the \code{maType} function.}
}
\value{
Invisbly returns a plotly object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

Bollinger Bands provide a visual representation of price volatility and are widely used by traders
and investors to assess potential price reversals and trade opportunities in various financial markets, including stocks, forex, and commodities.
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
\code{\link{chart}()},
\code{\link{dema}()},
\code{\link{ema}()},
\code{\link{evwma}()},
\code{\link{fgi}()},
\code{\link{hma}()},
\code{\link{lsr}()},
\code{\link{macd}()},
\code{\link{rsi}()},
\code{\link{sma}()},
\code{\link{volume}()},
\code{\link{vwap}()},
\code{\link{wma}()},
\code{\link{zlema}()}
}
\concept{chart indicators}
