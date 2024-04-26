\dontrun{
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

