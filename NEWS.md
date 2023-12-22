# cryptoQuotes 1.2.0

`getQuotes` now returns up to 100 pips preceding the specified `to` date, when `from = NULL`. It returns 100 pips, or up to `Sys.Date()`, from the specified `from` date.

The `getQuote()`-function can now be used as follows;

```
## Specifying from
## date only;
##
## Returns 10 pips
getQuote(
 ticker   = 'BTCUSDT',
 interval = '1d'
 from     = as.character(Sys.Date() - 10)
 )
```

```
## Specifying to
## date only;
##
## Returns 100 pips
getQuote(
 ticker   = 'BTCUSDT',
 interval = '1d'
 to     = as.character(Sys.Date())
 )
```


# cryptoQuotes 1.1.0

## Frontend

`getQuote()` now returns up to 100 pips when `to` and `from` is `NULL`

## Backend

* All code has been rewritten so its compatible with `httr2`, the package used `httr` at version `1.0.0`.

## Future releases

In the next release, three more exchanges will be supported. 

## Known bugs

The returned `quotes` are in local timezone, this is an unintentional feature and will be fixed in a bugfix.


# cryptoQuotes 1.0.0

* Initial CRAN submission.
