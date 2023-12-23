# script: startup messages
# date: 2023-12-23
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

.onAttach <- function(libname, pkgname) {

  # packageStartupMessage(
  #   startup_message(
  #     pkgname = pkgname,
  #     pkgversion = utils::packageVersion(
  #       pkgname
  #     )
  #   )
  # )

  msg <- startup_message(
    pkgname = pkgname,
    pkgversion = utils::packageVersion(
      pkgname
    )
  )

  rlang::inform(
    msg,
    class = "packageStartupMessage"
    )


}

# script end;

