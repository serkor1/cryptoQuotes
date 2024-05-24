# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()

get_openinterest(
  "PF_SUIUSD",
  source = "kraken",
  interval = "1h"
)


test <- source_parameters(
  source = "kraken",
  futures = TRUE,
  type = "interest",
  ticker = "PF_SUIUSD",
  interval = "1h",
  from = as.POSIXct(Sys.Date() - 1),
  to   = Sys.time()
)


response <- GET(
  url = baseUrl(
    source = "kraken",
    futures = TRUE
  ),
  endpoint = endPoint(
    "kraken",
    type = "interest",
    futures = TRUE
  ),
  query = test$query,
  path  = test$path
)

response <- flatten(
  response
)

idx <- vapply(
  X = response,
  FUN.VALUE = logical(1),
  FUN = inherits,
  what = c('array', 'matrix', 'data.frame')
)

response <- tryCatch(
  expr = {
    response[[which(idx)]]
  },
  error = function(error){
    do.call(
      data.frame,
      response
    )
    #as.data.frame(response)
  }
)


# 3) Extract source specific
# response parameters
parameters <- get(
  paste0(
    "kraken", 'Response'
  )
)(
  type = "interest",
  futures = TRUE
)

# 3.1) wrap parameters
# in tryCatch to check wether
# the columns exists
column_list <- tryCatch(
  expr = {
    list(
      index = response[, parameters$index_location],
      core  = rbind(response[,parameters$colum_location])
    )
  },
  error = function(error) {

    assert(
      FALSE,
      error_message = error_message
    )

  }
)

# 3.1.1) extract the values
# from the list
index <- column_list$index
core  <- column_list$core

# 3.1.2) convert
# all to as.numeric
core <- apply(
  X = core,
  MARGIN = 2,
  FUN = as.numeric
)

# 3.1.3) convert dates
# to positxct
index <- get(
  paste0(
    "kraken", 'Dates'
  )
)(
  futures = TRUE,
  dates   = index,
  is_response = TRUE,
  type    = "interest"
)




# 4) convert to xts
# from data.frame
# NOTE: This throws an error
# for KRAKEN no idea why
response <- xts::as.xts(
  zoo::as.zoo(
    core
  ),
  index
)
# 4.1) set column
# names
colnames(response) <- parameters$colum_names


response

# NOTE: The error in the Kraken exchange is in the
# way that unix are passed.

# script end;
