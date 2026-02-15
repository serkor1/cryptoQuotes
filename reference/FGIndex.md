# Fear and Greed Index (FGI) values for the cryptocurrency market in daily intervals

This dataset contains daily values of the Fear and Greed Index for the
year 2023, which is used to measure the sentiments of investors in the
market. The data spans from January 1, 2023, to December 31, 2023.

## Usage

``` r
FGIndex
```

## Format

An [`xts::xts()`](https://rdrr.io/pkg/xts/man/xts.html)-object with 364
rows and 1 columns,

- index:

  \<[POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)\> The
  time-index

- fgi:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\< The daily fear and
  greed index value

## Details

The Fear and Greed Index goes from 0-100, and can be classified as
follows,

- 0-24, Extreme Fear

- 25-44, Fear

- 45-55, Neutral

- 56-75, Greed

- 76-100, Extreme Greed

## Examples

``` r
# Load the dataset
data("FGIndex")

# Get a summary of index values
summary(FGIndex)
#>      Index                          fgi       
#>  Min.   :2023-01-01 01:00:00   Min.   :25.00  
#>  1st Qu.:2023-04-01 20:00:00   1st Qu.:49.00  
#>  Median :2023-07-01 14:00:00   Median :53.00  
#>  Mean   :2023-07-01 14:00:00   Mean   :54.67  
#>  3rd Qu.:2023-09-30 08:00:00   3rd Qu.:63.00  
#>  Max.   :2023-12-30 01:00:00   Max.   :75.00  
```
