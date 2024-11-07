# script: Test Read and Write
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-07-04
# objective: Unittests for reading and writing
# objects
# script start;

testthat::test_that(
  desc = "Read and Write <xts>-objects",
  code  = {

    # 0) create temporary
    # file location and name
    temp_file <- paste0(
      tempdir(), "BTC.csv"
    )

    # 1) store in temporary file
    write_xts(
      x    = BTC,
      file = temp_file
    )

    # 2) check if its equal
    # to the original BTC
    # object.
    #
    # NOTE: expect_equal will not
    # work as attributes are missing
    testthat::expect_true(
      setequal(
        x = BTC,
        y = read_xts(
          file = temp_file
        )
      )
    )
    
    # 3) delete file
    # after the test is run
    unlink(temp_file)

  }
)
# script end;

