\dontrun{
  # script start;

  # 1) unnamed assert
  # expressions
  foo <- function(
    a,
    b) {

    # assert without
    # named expressions
    cryptoQuotes:::assert(
      is.numeric(a),
      is.numeric(b)
    )

    a + b

  }

  # 1.1) returns
  # the regular R error
  # messages in cli-format
  foo(
    a = "1",
    b = "2"
  )

  # 2) named assert
  # expressions
  foo <- function(
    a,
    b) {

    cryptoQuotes:::assert(
      "{.arg a} is not {.cls numeric}" =  is.numeric(a),
      "{.arg a} is not {.cls numeric}" = is.numeric(b)
    )

    a + b

  }

  # 2.2) Returns
  # custom error-messages
  # in cli-format
  foo(
    a = "1",
    b = "2"
  )

  # 3) custom error
  # messages on
  foo <- function(
    a) {

    cryptoQuotes:::assert(
      is.numeric(a),
      error_message = sprintf(
        fmt = "{.val %s} is not a numeric value.",
        a
      )
    )

    a

  }

  # 2.2) Returns
  # custom error-messages with
  # passed values in cli-format
  foo(
    a = "1"
  )

  # script end;
}
