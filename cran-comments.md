## R CMD check results

0 errors ✔ | 0 warnings ✔ | 1 note ✖

### The note

```
  The Title field should be in title case. Current version is:
  'A Streamlined Access to Cryptocurrency OHLC-V Market Data and Sentiment Indicators'
  In title case that is:
  'A Streamlined Access to Cryptocurrency OHLC-v Market Data and Sentiment Indicators'
```

This `note` is related to `OHLC-V`, and since `OHLC-V` is an accepted shorthand for Open, High, Low, Close and Volume I believe this `note` should
be ignored.

## Resubmission

This is a resubmission. In this version I have updated many elements in the library, but
most importantly the unittests are being conducted in a manner that is robust to timing
errors.


