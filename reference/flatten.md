# flatten nested lists

**\[stable\]**

Flatten a nested [list](https://rdrr.io/r/base/list.html), regardless of
its level of nesting.

## Usage

``` r
flatten(x)
```

## Arguments

- x:

  A [list](https://rdrr.io/r/base/list.html)

## Value

An unnested [list](https://rdrr.io/r/base/list.html)

## See also

Other development tools:
[`GET()`](https://serkor1.github.io/cryptoQuotes/reference/GET.md),
[`chart_layout()`](https://serkor1.github.io/cryptoQuotes/reference/chart_layout.md),
[`convert_date()`](https://serkor1.github.io/cryptoQuotes/reference/convert_date.md),
[`default_dates()`](https://serkor1.github.io/cryptoQuotes/reference/default_dates.md),
[`fetch()`](https://serkor1.github.io/cryptoQuotes/reference/fetch.md),
[`is.date()`](https://serkor1.github.io/cryptoQuotes/reference/is.date.md)

## Examples

``` r
# script start;

# 1) create a nested list
nested_list <- list(
  a = 1,
  b = list(
    c = 2,
    d = 3
  )
)

# 2) flatten the
# nested list
cryptoQuotes:::flatten(
  nested_list
)
#> $a
#> [1] 1
#> 
#> $b.c
#> [1] 2
#> 
#> $b.d
#> [1] 3
#> 

# script end;
```
