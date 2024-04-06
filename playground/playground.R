# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()

var_ly <- function(
    variable) {

  # 0) extract variable
  # from the source
  variable <- grep(
    pattern     = variable,
    x           = names(get("args",envir = parent.frame())$data),
    ignore.case = TRUE,
    value       = TRUE
  )

  # 1) assert variable
  # existance
  assert(
    !identical(
      variable,
      character(0)
    ) & length(variable) == 1,
    error_message = c(
      "x" = "Error in {.val variable}"
    )
  )

  # 2) return as formula
  as.formula(
    paste(
      '~', variable
    )
  )

}

chart <- function(
    ticker,
    main = ...,
    sub = ...,
    indicator = ...,
    event_data = NULL,
    options = list()){

  # 0) chart options and common
  # independent parameters
  name <- deparse(substitute(ticker))
  interval <- infer_interval(ticker)
  market <- attributes(ticker)$source
  ticker <- toDF(ticker)

  ## 1) set chart options
  ## globally (locally)
  default_options <- list(
    dark       = TRUE,
    slider     = FALSE,
    deficiency = FALSE,
    size       = 0.6
  )

  options <- utils::modifyList(
    x   = default_options,
    val = options,
    keep.null = TRUE
  )

  dark <- options$dark
  deficiency <- options$deficiency
  slider <- options$slider
  size   <- options$size


  candle_color <- movement_color(
    deficiency = deficiency
  )

  # 1) generate list
  # of calls for lazy
  # evaluation
  call_list <- list(
    main = substitute(
      main
    ),
    sub = as.list(
      substitute(sub)
    )[-1],
    indicator = as.list(
      substitute(indicator)
    )[-1]

  )

  # # 2) modify
  # # calls of the main
  # and subcharts
  modify_call <- lapply(
    flatten(
      list(
        call_list$main,
        call_list$sub
      )

    ),
    FUN = function(.f){

      .f$data <- ticker
      .f$slider <- slider
      .f$interval <- interval
      .f$candle_color <- candle_color

      .f
    }
  )

  # 3) evaluate main
  # and subcharts
  #
  # The plot list determines
  # the number of plots
  plot_list <- lapply(
    modify_call,
    eval
  )

  # 3.1) Get length
  # of the plot_list
  plot_list_length <- length(
    plot_list
  )





  plot_list[1] <- lapply(
    X = call_list$indicator,
    function(.f) {

      # 0) modify the call list
      .f$data <- ticker
      .f$candle_color <- candle_color
      .f$plot <- plot_list[[1]]



     plot_list[[1]] <<- eval(.f)

     plot_list[[1]]

    }
  )[length(call_list$indicator)]




  plot <- plotly::subplot(
    plot_list,
    nrows = plot_list_length,
    shareX = TRUE,
    titleY = FALSE,
    titleX = FALSE,
    heights = if (plot_list_length > 1) {

      c(
        size,
        rep(
          x          = (1-size)/ (plot_list_length - 1),
          length.out = plot_list_length - 1
        )
      )


    } else {

      1

    }
  )




  bar(
    dark = dark,
    plot = plot,
    name = name,
    market = market
  )




}


chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume(),
    macd()
  ),
  indicator = list(
    bollinger_bands(),
    sma(n = 5),
    sma(n = 10)
  ),
  options = list(
    dark = TRUE,
    slider = FALSE
  )

)



# script end;
