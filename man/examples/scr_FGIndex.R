\dontrun{
  # script: Fear and Greed Index
  # date: 2023-12-26
  # author: Serkan Korkmaz, serkor1@duck.com
  # objective: Retrieve and Plot the
  # index
  # script start;

  # 1) get the fear and greed index
  # for the last 7 days
  tail(
    fgi <- cryptoQuotes::get_fgindex(
      from = Sys.Date() - 7
    )
  )

  # script end;
}

