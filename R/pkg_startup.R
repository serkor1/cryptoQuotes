# script: pkg_startup
# date: 2024-01-13
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Conflict resolution
# and verbose startup
# script start;

# reordering of packages;
#
# This function reorders
# all strings so cryptoQuotes
# is listed first
reorder_cryptoQuotes <- function(strings) {
  # Using order() with a logical vector to achieve the same result
  strings[order(!grepl("cryptoQuotes", strings, ignore.case = TRUE))]
}


# request to submit
# bugreports not captured
# by the rlang or cli
request_bugreport <- function(){

  cli::format_inline(message = paste(
    #"\n \t",
    cli::style_italic(
      "\n\t\"All good people submits ",
      cli::col_br_red("bug-reports"),
      " on ",
      cli::style_hyperlink(
        text = cli::col_br_cyan("Github"),
        url = "https://github.com/serkor1/cryptoQuotes/issues"),
      " when they find non-{.val rlang} or non-{.val cli} formatted error-messages.\"",
      cli::style_bold("\n\t- Confucious"), "\n"
    )

  )
  )

}

# header; #####
#
# This is the cryptoQuotes
# header that prints the line
# with pkgname and version
header <- function(
    pkgname,
    pkgversion) {

  cli::rule(
    left = cli::style_bold(pkgname),
    right = cli::style_bold(pkgversion),
    line = 1,
    line_col = cli::make_ansi_style(
      "cyan"
    )
  )

}

# pkg information; #####
#
# TODO: Consider wether this is too much
# information and verbosity
#
#
# This information contains
# links to the development blog, github source code
# and guides
pkg_information <- function(){

  # 1) wrattep in format
  # inline to ensure that the
  # message be supressed at startup
  cli::format_inline(
    c(
      # Source code  link
      paste(
        cli::col_br_yellow(cli::symbol$star),
        "Browse the",
        cli::style_hyperlink(
          text = cli::col_br_green("source code"),
          url = "https://github.com/serkor1/cryptoQuotes/"
        ),
        "on",
        cli::col_br_cyan("Github"),
        "\n"
      ),

      # Link to to the release notes
      paste(
        cli::col_br_yellow(cli::symbol$star),
        "Read the",
        cli::style_hyperlink(
          text = cli::col_br_blue('release notes'),
          url = 'https://serkor1.github.io/cryptoQuotes/news/index.html'
        ),
        "\n"
      ),

      # link to pkgdown website
      paste(
        cli::col_br_yellow(cli::symbol$star),
        "Read the",
        cli::style_hyperlink(
          text = cli::col_br_blue('guides and articles'),
          url = 'https://serkor1.github.io/cryptoQuotes/'
        ),
        "on",
        cli::col_br_cyan("pkgdown"),
        "\n"
      )
      # ,
      #
      # # link to blog
      # paste(
      #   cli::col_br_red(cli::symbol$heart),
      #   "Follow our",
      #   cli::style_hyperlink(
      #     text = cli::col_br_blue('blog'),
      #     url = 'https://serkor1.github.io/cryptoQuotes/news/index.html'
      #   ),
      #   "on",
      #   cli::col_br_cyan("Github pages"),
      #   "for regular updates and use-cases",
      #   "\n"
      # )

    )
  )
}

# caution message; ####
#
#
# Caution about usages and limits
#
# 1) header;
caution_header <- function(){
  cli::rule(
    left = cli::style_bold("Usage"),
    line = 1,
    line_col = cli::make_ansi_style(
      "cyan"
    )
  )
}

# 2) caution message;
caution_message <-function(){
  cli::format_inline(
    c(
      paste0(
        cli::style_underline(cli::style_bold(
          cli::col_red("Note:")
        )),
        " This API client uses public market data endpoints and is therefore completely ",
        cli::col_green("free"),
        " of charge.",
        "\nLimit your calls within each ",
        cli::col_br_cyan("exchange"),
        " to ",
        cli::col_br_cyan("5000"),
        " over the course of 24 hours to avoid getting your IP ",
        cli::style_underline(cli::col_red("blocked")),"!",
        "\n"
      ),

      paste(
        "\nIf you expect to use",
        cli::col_red('more'), "calls than this, please check the",
        cli::col_blue("API documentation"),
        "of the", cli::col_blue("exchange"),
        "that you are interested in.",
        "\n"
      )
    )

  )
}

# conflict handling and verbosity; ####
#
#
# It is expected that users who uses
# quantmod in conjunction with cryptoQuotes
# does this mainly for using cryptocurrencies
# with the quantmod functions - so all
# get* functions will get precendence over similarily named
# function across all libraries.
conflicting_pkg <- function() {

  # 1) check for conflicting
  # packages
  has_conflicts <- conflicted::conflict_scout()

  # 2) if there is conflicts;
  if (!(!length(has_conflicts))) {

    # 2.1) prefer all get* function
    # over all functions
    conflicted::conflict_prefer_matching(
      pattern = "^get",
      winner  = "cryptoQuotes",
      quiet = TRUE
    )

    # 2.2) prefer all quantmod
    # add* functions as, at the current state of
    # cryptoQuotes, not all plotting functionality
    # is up to par
    conflicted::conflict_prefer_matching(
      pattern = "^add",
      winner = "quantmod",
      losers  = "cryptoQuotes",
      quiet   = TRUE
    )

    # 2.3) verbose conflict messaging
    cli::cli_h1('Conflicts')

    # wrap in invisble to avoid
    # NULL outputs;
    invisible(
      lapply(
        X = names(has_conflicts),
        FUN = function(name) {

          # concatenate the text
          # in pkg::foo() form
          text <- paste0(
            cli::col_blue(has_conflicts[[name]]), "::", cli::col_br_green(name), "()"
          )

          # reorder such that
          # cryptoQuotes is always firs;
          text <- reorder_cryptoQuotes(strings = text)

          # alert the the user using
          # cli danger
          cli::cli_alert_danger(
            paste(text, collapse = ', ')
          )


        }
      )
    )


    # 2.4) verbosing get* precendece
    # over all other similar functions;
    cli::cli_h1("Resolution")
    cli::cli_alert_success(
      text = cli::format_inline(
        "All ", cli::col_blue('cryptoQuotes'), "::",cli::col_br_green("get*"),"()-functions are preferred over any other package."
      )
    )
  }

}



# script end;
