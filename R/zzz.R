# script: startup messages
# date: 2023-12-23
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

.onAttach <- function(libname, pkgname,...) {

  # 1) startup message with
  # using cli::rule
  msg <- startup_message(
    pkgname = pkgname,
    pkgversion = utils::packageVersion(
      pkgname
    )
  )


    rlang::inform(
      msg
      ,
      ...,
      class = "packageStartupMessage"
    )








}

# script end;

