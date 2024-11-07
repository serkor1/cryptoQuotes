# script: Read and Write XTS
# objects
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-07-04
# objective: These convience functions makes it
# easy to read and write XTS objects.
# script start;

#' @title
#' Read and Write `xts`-objects
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' The [write_xts()]- and [read_xts()]-functions are  [zoo::write.zoo()]- and [zoo::read.zoo()]-wrapper functions.
#'
#' @usage
#' # write XTS-object
#' write_xts(
#'  x,
#'  file,
#'  ...
#' )
#'
#' @param x An <[\link[xts]{xts}]>-object.
#' @inheritParams zoo::write.zoo
#' @inheritParams zoo::read.zoo
#'
#' @details
#' When reading and writing <[\link[xts]{xts}]>-objects the [attributes] does not follow the object.
#'
#'
#' @author
#' Serkan Korkmaz
#'
#' @family utility
#'
#' @export
write_xts <- function(
    x,
    file,
    ...) {

  assert(
    inherits(x = x, what = "xts"),
    error_message = c(
      "x" = "{.arg x} must be a {.cls xts}-object"
    )
  )

  assert(
    is.character(file) & length(file == 1),
    error_message = c(
      "x" = "{.arg file} has to be a {.cls character} of length 1."
    )
  )

  zoo::write.zoo(
    x          = x,
    file       = file,
    index.name = "index",
    col.names  = TRUE,
    row.names  = FALSE,
    ...
  )

}

#' @rdname
#' write_xts
#'
#' @usage
#' # read XTS-object
#' read_xts(
#' file
#' )
#'
#' @family utility
#' @export
read_xts <- function(
    file) {

  assert(
    is.character(file) & length(file == 1),
    error_message = c(
      "x" = "{.arg file} has to be a {.cls character} of length 1."
    )
  )

  xts::as.xts(
    x = zoo::read.zoo(
      file         = file,
      index.column = 1,
      header       = TRUE
    )
  )


}

# script end;
