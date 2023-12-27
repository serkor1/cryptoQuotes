# script: convinience functions
# date: 2023-12-27
# author: Serkan Korkmaz, serkor1@duck.com
# objective: create a set of convinience
# function that makes some processes
# easier
# script start;

# remove bounds; #####
#' remove upper and lower bounds
#' from an XTS object
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The [stats::window()]-function has inclusive upper and lower bounds,
#' which in some cases is an undesirable feature. This high level function
#' removes the bounds if desired
#'
#'
#' @param xts A xts-object that needs its bounds modified.
#' @param bounds A character vector of length 1. Has to be one of `c('upper','lower','both')`. Defaults to Upper.
#'
#'
#' @family convinience
#'
#' @returns Returns an xts-class object with its bounds removed.
#' @export

removeBound <- function(
    xts,
    bounds = c('upper')
) {

  # check if bounds are correctly
  # specified
  if (!grepl(x = bounds, pattern = 'upper|lower|both')){

    rlang::abort(
      message = c(
        'Incorrectly specfied bounds',
        'v' = 'Has to be "upper", "lower" or "both"'
      )
    )

  }

  # this function
  # removes the upper
  # and/or lower row
  # of the xts objects
  #
  #
  # This is needed in the calibration
  # process of adjacent series
  # with different intervals
  xts <- switch(
    bounds,
    upper = xts[-nrow(xts)],
    lower = xts[-1],
    both  = xts[-c(1,nrow(xts))]
  )

  return(
    xts
  )

}

# split window; #####
#' split xts object iteratively in lists of desired intervals
#'
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The [splitWindow()]-function is a high level wrapper of the [stats::window()]-function which restricts
#' the intervals between the first and second index value iteratively
#'
#' @param xts A xts-object that needs needs to be split.
#' @param by A reference [zoo::index()]-object, to be split by.
#' @param bounds A character vector of length 1. Has to be one of `c('upper','lower','both')`. Defaults to Upper.
#'
#'
#' @family convinience
#'
#' @returns Returns a list of iteratively restricted xts objects
#'
#' @export
splitWindow <- function(
    xts,
    by,
    bounds = 'upper'
) {

  # this function splits
  # the xts object in lists
  # in intervals that are comparable
  # to the reference index
  lapply(
    X = seq_along(by),
    FUN = function(i) {

      # 1) extract both
      # indices
      index <- by[i:(i+1)]

      # 2) subset using
      # window and cut the upper
      # bound
      xts <- removeBound(
        xts = stats::window(
          x = xts,
          start = index[1],
          end   = index[2]
        ),
        bounds = bounds
      )

      return(
        xts
      )


    }
  )

}

# calibrate window; ####
#' calibrate the time window of a list of xts objects
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' This function is a high-level wrapper of [do.call] and [lapply] which
#' modifies each xts object stored in a [list()].
#'
#' @param list A list of xts objects.
#' @param FUN A function applied to each element of the
#' list
#' @param ... optional arguments passed to `FUN`.
#'
#'
#' @family convinience
#'
#' @returns Returns a xts object.
#'
#' @export
calibrateWindow <- function(
    list,
    FUN,
    ...
) {

  # This function calibrates
  # the window and returns
  # a XTS object that is comparable
  # to the reference
  # series

  do.call(
    xts::rbind.xts,
    lapply(
      X = list,
      FUN = FUN,
      ...
    )
  )

}





# script end;
