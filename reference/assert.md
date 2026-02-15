# Assert truthfulness of conditions before evaluation

This function is a wrapper of
[`stopifnot()`](https://rdrr.io/r/base/stopifnot.html),
[`tryCatch()`](https://rdrr.io/r/base/conditions.html) and
[`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html) and
asserts the truthfulness of the passed expression(s).

## Usage

``` r
assert(..., error_message = NULL)
```

## Arguments

- ...:

  expressions \>= 1. If named the names are used as error messages,
  otherwise R's internal error-messages are thrown

- error_message:

  character. An error message, supports
  [cli::cli](https://cli.r-lib.org/reference/cli.html)-formatting.

## Value

[NULL](https://rdrr.io/r/base/NULL.html) if all statements in ... are
[TRUE](https://rdrr.io/r/base/logical.html)

## See also

[`stopifnot()`](https://rdrr.io/r/base/stopifnot.html),
[`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html),
[`tryCatch()`](https://rdrr.io/r/base/conditions.html)

## Examples

``` r
if (FALSE) { # \dontrun{
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
} # }
```
