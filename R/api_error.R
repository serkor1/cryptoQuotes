# script: Error codes
# date: 2023-12-21
# author: Serkan Korkmaz, serkor1@duck.com
# objective: This script captures
# all errors using rlang; the APIs doesnt
# necessarily return any HTTP error; so this has to be done
# manually
# script start;

# bitmart;
bitmartError <- function(
    response,
    futures = NULL
) {

  code <- rlang::expr(
    httr2::resp_body_json(response)$message
  )

  return(
    code
  )

}


# kucoin;
kucoinError <- function(
    response,
    futures = NULL
) {

  code <- rlang::expr(
    httr2::resp_body_json(response)$msg
  )

  return(
    code
  )

}

#binance;
binanceError <- function(
    response,
    futures = NULL
) {

  code <- rlang::expr(
    httr2::resp_body_json(response)$msg
  )

  return(
    code
  )

}

# kraken error
krakenError <- function(
    response,
    futures
) {

  if (futures) {

    code <- httr2::resp_body_string(
      response
    )

  } else {

    code <- rlang::expr(
      httr2::resp_body_json(response)$error[[1]]
    )

  }


  return(
    code
  )

}

# script end;
