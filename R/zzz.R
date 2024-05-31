# script: startup messages
# date: 2023-12-23
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

.onAttach <- function(
    libname,
    pkgname,
    ...) {

  # 1) set options
  # for xts suppressing
  # timezone messages
  options(
    xts_check_TZ = FALSE
  )


  cli::cli_inform(
    message = pkg_header(
      pkgname
    ),
    ...,
    class = "packageStartupMessage"
  )

  cli::cli_inform(
    message = pkg_information(),
    ...,
    class = "packageStartupMessage"
  )


}

.onDetach <- function(
    libpath,
    ...) {

  # 1) reset options
  # for xts suppressing
  # timezone messages
  options(
    xts_check_TZ = TRUE
  )

}

# script end;
