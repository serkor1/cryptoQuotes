# script: startup messages
# date: 2023-12-23
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

# 1) on attach
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

  # 1) package
  # header
  rlang::inform(
    header(
      pkgname = pkgname,
      pkgversion = utils::packageVersion(
        pkgname
      )
    ),
    ...,
    class = "packageStartupMessage"
  )

  # 2) package information
  # to the user
  rlang::inform(
    pkg_information(),
    ...,
    class = "packageStartupMessage"
  )

}


# 1) on detach
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
