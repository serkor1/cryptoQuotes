# script: Assert truthfullness
# of functions
# date: 2024-02-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Demonstrate the use of the error-function. This is
# mainly for contributers, and for my future self on how to use
# this function properly
#
#
# NOTE: As these are wrapped in try
# they are not properly formatted.
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
try(
  foo(
    a = "1",
    b = "2"
  )
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
try(
  foo(
    a = "1",
    b = "2"
  )
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
try(
  foo(
    a = "1"
  )
)





# script end;
