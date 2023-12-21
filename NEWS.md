# cryptoQuotes 1.1.0

## Frontend

`getQuotes` now returns up to 100 pips, when `to` and `from` is `NULL`

## Backend

* All code has been rewritten so its compatible with `httr2`, the package used `httr` at version `1.0.0`.

## Future releases

In the next release, three more exchanges will be supported. 

## Known bugs

The returned `quotes` are in local timezone, this is an unintentional feature and will be fixed in a bugfix.


# cryptoQuotes 1.0.0

* Initial CRAN submission.
