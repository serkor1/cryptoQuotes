# Create a list of layout elements on subcharts

Create a list of layout elements on subcharts

## Usage

``` r
chart_layout(x, layout_element, layout_attribute)
```

## Arguments

- x:

  [integer](https://rdrr.io/r/base/integer.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.

- layout_element:

  [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. plotly::layout
  elements. See example.

- layout_attribute:

  [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. plotly::layout element
  value. See example.

## Value

A [list](https://rdrr.io/r/base/list.html) of layout elements.

## See also

Other development tools:
[`GET()`](https://serkor1.github.io/cryptoQuotes/reference/GET.md),
[`convert_date()`](https://serkor1.github.io/cryptoQuotes/reference/convert_date.md),
[`default_dates()`](https://serkor1.github.io/cryptoQuotes/reference/default_dates.md),
[`fetch()`](https://serkor1.github.io/cryptoQuotes/reference/fetch.md),
[`flatten()`](https://serkor1.github.io/cryptoQuotes/reference/flatten.md),
[`is.date()`](https://serkor1.github.io/cryptoQuotes/reference/is.date.md)

## Examples

``` r
if (FALSE) { # \dontrun{
chart_layout(
  x = 1:plot_list_length,
  layout_element = "yaxis",
  layout_attribute = list(
  gridcolor = if (dark) "#40454c" else  '#D3D3D3' # Was CCCCCC
    )
)
} # }

```
