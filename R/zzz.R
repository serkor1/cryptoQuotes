# script: startup messages
# date: 2023-12-23
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

.onAttach <- function(
    libname,
    pkgname,
    ...) {

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



# script end;
