# script: control_data
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-05-17
# objective: The control data is an internal dataset
# for all get_*-functions in daily format to conduct
# thorough testing of charting functions and avoid
# unnecessary bugs
#
# NOTE: Run this function before each PUSH to development
# to incorporate changes to packages
# script start;

# 1) define functions
# for naming datasets
funs <- c(
  "quote",
  "fgindex",
  "lsratio",
  "openinterest",
  "fundingrate"
)

# 2) run functions
# accordingly
control_data <- lapply(
  X = funs,
  FUN = function(FUN) {

    # 2.1) extract function
    # and store as foo
    foo <- get(
      paste0("get_", FUN),
      envir = asNamespace('cryptoQuotes')
    )

    if (!(FUN == "fgindex")) {

      foo(
        ticker   = "BTCUSDT",
        source   = "binance",
        from     = Sys.Date() - 100
      )


    } else {

      foo(
        from = Sys.Date() - 100
      )

    }


  }
)

# 3) set names
# of datasets
names(control_data) <- funs

# write data;
usethis::use_data(
  control_data,
  overwrite = TRUE,
  internal  = TRUE
)

# script end;


