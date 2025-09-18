# script: get_mcap
# author: Serkan Korkmaz
# objective: Retrieve the global marketcapitalization
# from CMC
# date: 2024-10-03
# start of script; ###

#' @title Get the global market capitalization
#'
#' @description
#'
#' The [get_mktcap()]-functions returns the global cryptocurrency market capitalization.
#'
#'
#' @inherit get_quote
#' @param altcoin A [logical]-vector of [length] 1. [FALSE] by default. Returns altcoin market capitalization
#' if [TRUE]
#' @param reported A [logical]-vector of [length] 1. [FALSE] by default. Returns reported volume if [TRUE].
#'
#'
#' @returns An <[\link[xts]{xts}]>-object containing,
#'
#' \item{index}{<[POSIXct]> The time-index}
#' \item{marketcap}{<[numeric]> Market capitalization}
#' \item{volume}{<[numeric]> Trading volume}
#'
#' @family get-functions
#' @export
get_mktcap <- function(
  interval = "1d",
  from = NULL,
  to = NULL,
  altcoin = FALSE,
  reported = FALSE
) {
  from <- coerce_date(from)
  to <- coerce_date(to)

  if (is.null(from) | is.null(to)) {
    # to ensure consistency across
    # APIs if no date is set the output
    # is limited to 200 pips
    forced_dates <- default_dates(
      interval = interval,
      from = from,
      to = to,
      limit = NULL
    )

    # generate from
    # to variables
    from <- forced_dates$from
    to <- forced_dates$to
  }

  # x) get request
  request <- GET(
    url = 'https://api.coinmarketcap.com',
    endpoint = "data-api/v3/global-metrics/quotes/historical",
    query = list(
      convertId = 2781,
      timeStart = from,
      timeEnd = to,
      interval = interval
    )
  )

  request <- do.call(
    rbind,
    request$data[[1]]$quote
  )[,
    c(
      "timestamp",
      grep(
        pattern = if (altcoin) "altcoin" else "total",
        x = colnames(request$data[[1]]$quote[[1]]),
        ignore.case = TRUE,
        value = TRUE
      )
    )
  ]

  colnames(request) <- tolower(colnames(request))

  colnames(request) <- gsub(
    pattern = "altcoin|[0-9]|total|h",
    replacement = "",
    x = colnames(request)
  )

  request$timestamp <- convert_date(
    as.numeric(
      strptime(
        request$timestamp,
        "%Y-%m-%dT%H:%M:%S"
      )
    ),
    multiplier = 1
  )

  if (reported) {
    request <- request[,
      grep(
        pattern = "timestamp|marketcap|^volumereported",
        x = colnames(request),
        value = TRUE,
        perl = TRUE
      )
    ]
  } else {
    request <- request[,
      grep(
        pattern = "timestamp|marketcap|^volume(?![a-zA-Z0-9])",
        x = colnames(request),
        value = TRUE,
        perl = TRUE
      )
    ]
  }

  xts::as.xts(
    request[, c("timestamp", "marketcap", "volume")]
  )
}

# end of script; ###
