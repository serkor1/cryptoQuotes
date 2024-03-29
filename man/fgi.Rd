% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chart_fgi.R
\name{fgi}
\alias{fgi}
\title{Chart the Fear and Greed Index}
\usage{
fgi(index, internal = list())
}
\arguments{
\item{index}{The Fear and Greed Index created by \code{\link[=getFGIndex]{getFGIndex()}}}

\item{internal}{An empty \link{list}. Used for internal purposes. Ignore.}
}
\value{
Invisbly returns a plotly object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

The fear and greed index is a market sentiment indicator that measures investor emotions to
gauge whether they are generally fearful (indicating potential selling pressure) or greedy (indicating potential buying enthusiasm)
}
\details{
The Fear and Greed Index goes from 0-100, and can be classifed as follows

\itemize{
\item 0-24, Extreme Fear
\item 25-44, Fear
\item 45-55, Neutral
\item 56-75, Greed
\item 76-100, Extreme Greed
}
}
\examples{
\dontrun{
  # script: Fear and Greed Index
  # date: 2023-12-26
  # author: Serkan Korkmaz, serkor1@duck.com
  # objective: Retrieve and Plot the
  # index
  # script start;

  # 1) get the fear and greed index
  # for the last 7 days
  tail(
    fgi <- cryptoQuotes::get_fgindex(
      from = Sys.Date() - 7
    )
  )

  # script end;
}

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
\code{\link{hma}()},
\code{\link{lsr}()},
\code{\link{macd}()},
\code{\link{rsi}()},
\code{\link{sma}()},
\code{\link{volume}()},
\code{\link{vwap}()},
\code{\link{wma}()},
\code{\link{zlema}()}

Other sentiment indicators: 
\code{\link{lsr}()}

Other subcharts: 
\code{\link{add_event}()},
\code{\link{lsr}()},
\code{\link{macd}()},
\code{\link{rsi}()},
\code{\link{volume}()}
}
\concept{chart indicators}
\concept{sentiment indicators}
\concept{subcharts}
