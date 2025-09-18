# script: Test Global Market Capitalization
# author: Serkan Korkmaz
# objective: Test the function
# date: 2024-10-03
# start of script; ###

testthat::test_that(desc = "Test that `get_mktcap()`-function returns sensible values", code = {
  # test for both
  # altcoin and global
  for (lgl in c(TRUE, FALSE)) {
    # 1) get mktcap
    mktcap <- testthat::expect_no_condition(
      get_mktcap(
        altcoin = lgl
      )
    )

    # 2) test that
    # its a xts-object
    testthat::expect_true(
      object = inherits(
        x = mktcap,
        what = "xts"
      )
    )
  }
})

# end of script
