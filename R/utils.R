# script: utils
# author: Serkan Korkmaz
# date: 2023-09-20
# objective: Generate a set of functions
# to ease the process of getting cryptoQuotes
# script start; ####
source_parameters <- function(
    source,
    futures,
    ticker,
    interval,
    from,
    to
) {

  get(
    paste0(
      source, 'Parameters'
    )
  )(
    futures  = futures,
    ticker   = ticker,
    interval = interval,
    from     = from,
    to       = to
  )

}


# base-url;
baseUrl <- function(
    source = 'binance',
    futures
) {
  # 1) construct function
  # based on source
  baseUrl <- get(paste0(source, 'Url'))(
    futures = futures
  )

  # 2) return the baseUrl
  return(
    baseUrl
  )
}

# endpoint
endPoint <- function(
    source,
    ohlc = TRUE,
    futures
) {

  # 1) construct function
  # based on source
  endPoint <- get(paste0(source, 'Endpoint'))(
    futures = futures,
    ohlc = ohlc
  )

  # 2) return the endpoint
  return(
    endPoint
  )

}



# 0) Main API
# call for the api
api_call <- function(
    source,
    ohlc,
    parameters
) {


  path <- parameters$path
  query <- parameters$query


  # 1) construct the basic path
  # which are universal for all
  # calls;
  #
  # This is a mix of baseurl
  # and endpoint
  baseCall <- httr2::req_url_path(
    req = httr2::request(
      base_url = baseUrl(
        source = source,
        futures = parameters$futures
      )
    ),
    endpoint = endPoint(
      source = source,
      futures = parameters$futures,
      ohlc = ohlc
    )
  )

  # 2) construct
  # a path if such exists
  # and is declared
  if (!is.null(path)) {

    is_path_based <- TRUE

    baseCall <- httr2::req_url_path_append(
      req = baseCall,
      path
    )

  } else {

    is_path_based <- FALSE

    baseCall <- httr2::req_url_query(
      baseCall,
      !!!query
    )

  }


  if (is_path_based & !is.null(query)) {

    baseCall <- httr2::req_url_query(
      baseCall,
      !!!query
    )

  }


  # 3) perform the call
  # with returned errors
  getResponse <- httr2::req_perform(
    httr2::req_error(
      req = baseCall,
      is_error = \(repoonse) FALSE
    )
  )

  return(
    list(
      response = getResponse,
      futures  = parameters$futures,
      source   = parameters$source,
      ticker   = parameters$ticker,
      interval = parameters$interval

    )

  )


}


ticker_response <- function(
    response
) {


  # 0) extract source
  # response object
  source_response <- get(
    paste0(
      response$source, 'Response'
    )
  )(
    ohlc = FALSE,
    futures = response$futures
  )

  # 1) get response ojson
  response <- httr2::resp_body_json(
    resp = response$response,
    simplifyVector = TRUE
  )


  response <- rlang::eval_bare(
    source_response$code,
    env = rlang::caller_env(n = 0)
  )



  return(response)

}



quote_response <- function(
    response
) {

  response_ <- response$response

  # 0) Extract informations
  interval <-  response$interval
  ticker   <-  response$ticker
  market   <-  ifelse(response$futures,'PERPETUAL', 'Spot')
  source   <-  response$source
  futures  <-  response$futures

  # 1) get json response
  # from the call
  response <- flatten(
    httr2::resp_body_json(
      resp = response$response,
      simplifyVector = TRUE
    )
  )


  idx <- sapply(
    response,
    inherits,
    c('array', 'matrix', 'data.frame')
  )

  # 2) format response
  response <- try(
    response[idx][[1]],
    silent = TRUE
  )

  # 1.3) Error handling

  if (inherits(response, 'try-error')) {

    check_for_errors(
      response = response_,
      futures = futures,
      source  = source
    )


  }

  # 2.1) get response oobject
  # based on the exchange
  response_object <- get(
    paste0(
      source, 'Response'
    )
  )(
    ohlc = TRUE,
    futures = futures
  )




  # 2.2) extract OHLCV
  # and index by location
  response_index <- response[,response_object$index_location]
  response <-  rbind(response[,response_object$colum_location])


  # 2.2.1) convert dates
  # to positxct
  response_index <- get(
    paste0(
      source, 'Dates'
    )
  )(
    futures = futures,
    dates   = response_index,
    is_response = TRUE
  )

  response_order <- order(
    decreasing = FALSE,
    response_index
  )

  # 3) construct
  # zoo object
  response <- zoo::as.zoo(
    rbind(response[response_order,])
  )

  zoo::index(response) <- response_index[response_order]

  # 2.3) set column
  # names
  colnames(response) <- response_object$colum_names



  response <- response[,c('Open', 'High', 'Low', 'Close', 'Volume')]

  response <- apply(
    response,
    c(1,2),
    as.numeric
  )

  # 2.4) set order to decreasing
  # to comply with zoo/xts
  response <- xts::as.xts(
    response
  )


  # 4) construct
  # attributes for further
  # functionality
  attributes(response)$tickerInfo <- list(
    source   = source,
    interval = interval,
    ticker   = ticker,
    market   = market
  )


  return(
    response
  )
}

# end of script; ####