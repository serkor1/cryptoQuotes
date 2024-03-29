% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FUN.R
\name{calibrate_window}
\alias{calibrate_window}
\title{calibrate the time window of a list of xts objects}
\usage{
calibrate_window(list, FUN, ...)
}
\arguments{
\item{list}{A list of xts objects.}

\item{FUN}{A function applied to each element of the
list}

\item{...}{optional arguments passed to \code{FUN}.}
}
\value{
Returns a xts object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

This function is a high-level wrapper of \link{do.call} and \link{lapply} which
modifies each xts object stored in a \code{\link[=list]{list()}}.
}
\examples{
# script: scr_FUN
# date: 2023-12-27
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Demonstrate the use of the convinience
# funtions
# script start;

# by default the Fear and Greed Index
# is given daily. So to align these values
# with, say, weekly candles it has to be aggregated
#
# In this example the built-in data are used

# 1) check index of BTCUSDT and
# the Fear and Greed Index
setequal(
  zoo::index(BTC),
  zoo::index(FGIndex)
)

# 2) to align the indices,
# we use the convincience functions
# by splitting the FGI by the BTC index.
FGIndex <- split_window(
  xts = FGIndex,
  by  = zoo::index(BTC),

  # Remove upper bounds of the
  # index to avoid overlap between
  # the dates.
  #
  # This ensures that the FGI is split
  # according to start of each weekly
  # BTC candle
  bounds = 'upper'
)

# 3) as splitWindow returns a list
# it needs to passed into calibrateWindow
# to ensure comparability
FGIndex <- calibrate_window(
  list = FGIndex,

  # As each element in the list can include
  # more than one row, each element needs to be aggregated
  # or summarised.
  #
  # using xts::first gives the first element
  # of each list, along with its values
  FUN  = xts::first
)


# 3) check if candles aligns
# accordingly
setequal(
  zoo::index(BTC),
  zoo::index(FGIndex)
)


# As the dates are now aligned
# and the Fear and Greed Index being summarised by
# the first value, the Fear and Greed Index is the opening
# Fear and Greed Index value, at each candle.

# script end;
}
\seealso{
Other convinience: 
\code{\link{remove_bound}()},
\code{\link{split_window}()}
}
\concept{convinience}
