# script: startup messages
# date: 2023-12-23
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

.onAttach <- function(
    libname,
    pkgname,
    ...) {



  # 1) bugreport
  # requests
  rlang::inform(
    request_bugreport(),
    ...,
    class = "packageStartupMessage"
  )

  # 2) package
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

  # 3) package information
  # to the user
  rlang::inform(
    pkg_information(),
    ...,
    class = "packageStartupMessage"
  )

  # 4) caution to the user
  # 4.1) caution header
  rlang::inform(
    caution_header(),
    ...,
    class = "packageStartupMessage"
  )

  # 4.2) caution message
  rlang::inform(
    caution_message(),
    ...,
    class = "packageStartupMessage"
  )

  # 5) conflict handling
  # will only print if
  # conflicts occur
  rlang::inform(
    conflicting_pkg(),
    ...,
    class = "packageStartupMessage"
  )

}



# script end;
