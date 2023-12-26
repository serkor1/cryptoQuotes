testthat::test_that(
  desc = "getFNG returns 100 values",
  code = {

    # 1) skip on github
    testthat::skip_on_ci()

    # 2) load FGI
    FGI <- getFGIndex()

    # 3) test that its an
    # xts object
    testthat::expect_true(
      object = rlang::inherits_any(
        x = FGI,
        class = c('xts')
      )
    )

    # 4) check that it returns
    # 100 rows
    testthat::expect_equal(
      object   = nrow(FGI),
      expected = 100
    )

  }
)

