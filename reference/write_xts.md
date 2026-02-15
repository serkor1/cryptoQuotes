# Read and Write `xts`-objects

**\[experimental\]**

The `write_xts()`- and `read_xts()`-functions are
[`zoo::write.zoo()`](https://rdrr.io/pkg/zoo/man/read.zoo.html)- and
[`zoo::read.zoo()`](https://rdrr.io/pkg/zoo/man/read.zoo.html)-wrapper
functions.

## Usage

``` r
# write XTS-object
write_xts(
 x,
 file,
 ...
)

# read XTS-object
read_xts(
file
)
```

## Arguments

- x:

  An \<\[[xts](https://rdrr.io/pkg/xts/man/xts.html)\]\>-object.

- file:

  character string or strings giving the name of the file(s) which the
  data are to be read from/written to. See
  [`read.table`](https://rdrr.io/r/utils/read.table.html) and
  [`write.table`](https://rdrr.io/r/utils/write.table.html) for more
  information. Alternatively, in `read.zoo`, `file` can be a
  `connection` or a `data.frame` (e.g., resulting from a previous
  `read.table` call) that is subsequently processed to a `"zoo"` series.

- ...:

  further arguments passed to other functions. In the `read.*.zoo` the
  arguments are passed to the function specified in `read` (unless
  `file` is a `data.frame` already). In `write.zoo` the arguments are
  passed to [`write.table`](https://rdrr.io/r/utils/write.table.html).

## Details

When reading and writing
\<\[[xts](https://rdrr.io/pkg/xts/man/xts.html)\]\>-objects the
[attributes](https://rdrr.io/r/base/attributes.html) does not follow the
object.

## See also

Other utility:
[`calibrate_window()`](https://serkor1.github.io/cryptoQuotes/reference/calibrate_window.md),
[`remove_bound()`](https://serkor1.github.io/cryptoQuotes/reference/remove_bound.md),
[`split_window()`](https://serkor1.github.io/cryptoQuotes/reference/split_window.md)

Other utility:
[`calibrate_window()`](https://serkor1.github.io/cryptoQuotes/reference/calibrate_window.md),
[`remove_bound()`](https://serkor1.github.io/cryptoQuotes/reference/remove_bound.md),
[`split_window()`](https://serkor1.github.io/cryptoQuotes/reference/split_window.md)

## Author

Serkan Korkmaz
