\dontrun{
  # script start;

  # 1) get global
  # market capitalization
  tail(
    mktcap <- cryptoQuotes::get_mktcap()
  )

  # 2) get global
  # altcoin martket capitalization
  tail(
    alt_mktcap <- cryptoQuotes::get_mktcap(
      altcoin = TRUE
    )
  )

  # script end;
}
