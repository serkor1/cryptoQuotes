# Get the daily Fear and Greed Index in the cryptocurrency market

**\[stable\]**

Get the daily fear and greed index.

## Usage

``` r
get_fgindex(
 from = NULL,
 to   = NULL
)
```

## Arguments

- from:

  An optional [character](https://rdrr.io/r/base/character.html)-,
  [date](https://rdrr.io/r/base/date.html)- or
  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [NULL](https://rdrr.io/r/base/NULL.html) by default.

- to:

  An optional [character](https://rdrr.io/r/base/character.html)-,
  [date](https://rdrr.io/r/base/date.html)- or
  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [NULL](https://rdrr.io/r/base/NULL.html) by default.

## Value

An \<\[[xts](https://rdrr.io/pkg/xts/man/xts.html)\]\>-object
containing,

- index:

  \<[POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)\> the
  time-index

- fgi:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> the daily fear and
  greed index value

**Sample output**

    #>                     fgi
    #> 2024-05-12 02:00:00  56
    #> 2024-05-13 02:00:00  57
    #> 2024-05-14 02:00:00  66
    #> 2024-05-15 02:00:00  64
    #> 2024-05-16 02:00:00  70
    #> 2024-05-17 02:00:00  74

## Details

### Classification

The Fear and Greed Index goes from 0-100, and can be classified as
follows,

- 0-24, Extreme Fear

- 25-44, Fear

- 45-55, Neutral

- 56-75, Greed

- 76-100, Extreme Greed

### About the Fear and Greed Index

The fear and greed index is a market sentiment indicator that measures
investor emotions to gauge whether they are generally fearful
(indicating potential selling pressure) or greedy (indicating potential
buying enthusiasm).

### Source

This index is fetched from
[alternative.me](https://alternative.me/crypto/fear-and-greed-index/),
and can be different from the one provided by
[coinmarketcap](https://coinmarketcap.com/charts/#fear-and-greed-index).

## See also

Other get-functions:
[`get_fundingrate()`](https://serkor1.github.io/cryptoQuotes/reference/get_fundingrate.md),
[`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md),
[`get_mktcap()`](https://serkor1.github.io/cryptoQuotes/reference/get_mktcap.md),
[`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md),
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  # 1) get the fear and greed index
  # for the last 7 days
  tail(
    fgi <- cryptoQuotes::get_fgindex(
      from = Sys.Date() - 7
    )
  )

  # script end;
} # }
```
