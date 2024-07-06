
<!-- README.md is generated from README.Rmd. Please edit that file -->

# {cryptoQuotes}: Open access to cryptocurrency market data <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="154" alt="cryptocurrency in R"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://CRAN.R-project.org/package=cryptoQuotes)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/cryptoQuotes?color=blue)](https://r-pkg.org/pkg/cryptoQuotes)
[![R-CMD-check](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/serkor1/cryptoQuotes/graph/badge.svg?token=D7NF1BPVL5)](https://app.codecov.io/gh/serkor1/cryptoQuotes)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
![GitHub last commit
(branch)](https://img.shields.io/github/last-commit/serkor1/cryptoQuotes/development)
<!-- badges: end -->

## :information_source: About

[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) is a
high-level API client for accessing public market data endpoints on
major cryptocurrency exchanges. It supports open, high, low, close and
volume (OHLC-V) data and a variety of sentiment indicators; the market
data is high quality and can be retrieved in intervals ranging from
*seconds* to *months*. All the market data is accessed and processed
without relying on crawlers, or API keys, ensuring an open, and
reliable, access for researchers, traders and students alike. There are
currently 8 supported cryptocurrency exchanges,

<div align="center">

<table style="width:100%; color: black; margin-left: auto; margin-right: auto;" class="table">
<caption>
All supported exchanges.
</caption>
<tbody>
<tr>
<td style="text-align:center;">
Binance
</td>
<td style="text-align:center;">
BitMart
</td>
<td style="text-align:center;">
Bybit
</td>
<td style="text-align:center;">
Crypto.com
</td>
</tr>
<tr>
<td style="text-align:center;">
Huobi (HTX)
</td>
<td style="text-align:center;">
Kraken
</td>
<td style="text-align:center;">
KuCoin
</td>
<td style="text-align:center;">
MEXC
</td>
</tr>
</tbody>
</table>

</div>

All data is returned as
[{xts}](https://github.com/joshuaulrich/xts)-objects which enables
seamless interaction with with
[{quantmod}](https://github.com/joshuaulrich/quantmod) and
[{TTR}](https://github.com/joshuaulrich/TTR), for developing and
evaluating trading strategies or general purpose cryptocurrency market
analysis with a historical or temporal perspective.

## :information_source: Overview

[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) has *two* main
features; retrieving cryptocurrency market data, and charting. The
market data consists of *OHLC-V* data and sentiment indicators;
including, but not limited to, cryptocurrency *fear and greed index*,
*long-short ratio* and *open interest*. All market data is retrieved
using the family of `get_*`-functions. To get a full overview of the
package and functionality please see the documentation via
[{pkgdown}](https://serkor1.github.io/cryptoQuotes/).

> \[!WARNING\]
>
> Given the nature of crypotcurrency data and general legislative
> restrictions, some `exchanges` may not work in your geolocation.

Below is a quick overview of the package and basic usage examples on
retrieving and charting Bitcoin (BTC) *OHLC-V* and *long-short ratio* in
30 minute intervals.

### :information_source: Cryptocurrency market data

#### OHLC-V

All supported exchanges and markets are listed in the table below,
alongside the available range of intervals available from the respective
exchanges,

<div align="center">

<div id="psmyhlxmwj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  <table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: 16px; font-weight: normal; font-style: normal; background-color: #FFFFFF; width: auto; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" bgcolor="#FFFFFF">
  <caption>Supported exchanges by spot and futures markets with available intervals.</caption>
  <thead style="border-style: none;">
    <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Exchange" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="#FFFFFF" valign="bottom" align="left">Exchange</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Spot" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Spot</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Futures" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Futures</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Available Intervals" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Available Intervals</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Smallest Interval" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Smallest Interval</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Biggest Interval" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Biggest Interval</th>
    </tr>
  </thead>
  <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Binance</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">16</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 second(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 month(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">BitMart</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">13</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 week(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Bybit</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">13</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 month(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Crypto.com</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">12</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 month(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Huobi (HTX)</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">9</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 month(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Kraken</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">10</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">2 week(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">KuCoin</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">13</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 week(s)</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Exchange" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">MEXC</p>
</div></td>
<td headers="Spot" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Futures" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Available.Intervals" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">10</p>
</div></td>
<td headers="Smallest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 minute(s)</p>
</div></td>
<td headers="Biggest.Interval" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">1 month(s)</p>
</div></td></tr>
  </tbody>
  &#10;  
</table>
</div>

</div>

<details>
<summary>
Example: Bitcoin OHLC-V
</summary>

Get USDT denominated Bitcoin (BTC) on the spot market from Binance in
`30m`-intervals using the `get_quote()`-function,

``` r
## BTC OHLC prices
## from Binance spot market
## in 30 minute intervals
BTC <- cryptoQuotes::get_quote(
  ticker   = 'BTCUSDT',
  source   = 'binance',
  futures  = FALSE,
  interval = '30m',
  from     = Sys.Date() - 2
)
```

<div align="center">

<table style="width:100%; color: black; margin-left: auto; margin-right: auto;" class="table">
<caption>
Bitcoin (BTC) OHLC-V data
</caption>
<thead>
<tr>
<th style="text-align:left;">
index
</th>
<th style="text-align:center;">
open
</th>
<th style="text-align:center;">
high
</th>
<th style="text-align:center;">
low
</th>
<th style="text-align:center;">
close
</th>
<th style="text-align:left;">
volume
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2024-07-07 10:00:00
</td>
<td style="text-align:center;">
57369.99
</td>
<td style="text-align:center;">
57540
</td>
<td style="text-align:center;">
57369.98
</td>
<td style="text-align:center;">
57485.12
</td>
<td style="text-align:left;">
352.10478
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 10:30:00
</td>
<td style="text-align:center;">
57485.12
</td>
<td style="text-align:center;">
57661.58
</td>
<td style="text-align:center;">
57439.99
</td>
<td style="text-align:center;">
57650.45
</td>
<td style="text-align:left;">
355.56531
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 11:00:00
</td>
<td style="text-align:center;">
57650.45
</td>
<td style="text-align:center;">
57720.35
</td>
<td style="text-align:center;">
57565.94
</td>
<td style="text-align:center;">
57702.01
</td>
<td style="text-align:left;">
265.19989
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 11:30:00
</td>
<td style="text-align:center;">
57702
</td>
<td style="text-align:center;">
57733.99
</td>
<td style="text-align:center;">
57602
</td>
<td style="text-align:center;">
57733.4
</td>
<td style="text-align:left;">
143.65146
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 12:00:00
</td>
<td style="text-align:center;">
57733.41
</td>
<td style="text-align:center;">
57783.8
</td>
<td style="text-align:center;">
57584.01
</td>
<td style="text-align:center;">
57746
</td>
<td style="text-align:left;">
210.40092
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 12:30:00
</td>
<td style="text-align:center;">
57745.99
</td>
<td style="text-align:center;">
57911.71
</td>
<td style="text-align:center;">
57745.99
</td>
<td style="text-align:center;">
57751.47
</td>
<td style="text-align:left;">
186.96287
</td>
</tr>
</tbody>
</table>

</div>

------------------------------------------------------------------------

</details>

#### Sentiment indicators

The sentiment indicators available in
[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) can be divided
in two; *derived indicators* and *market indicators*. The former is
calculated based on, for example, the price actions such as the *Moving
Average Convergence Divergence* (MACD) indicator. The latter are public
indicators such as the *long-short ratio* or *fear and greed index*;
these are retrieved using the family of `get_*`-functions, while the
derived indicators can be created using, for example,
[{TTR}](https://github.com/joshuaulrich/TTR).

In this overview we are focusing on *market indicators* made public by
the cryptocurrency exchanges. For a full overview of sentiment
indicators please refer to the documentation via
[{pkgdown}](https://serkor1.github.io/cryptoQuotes/). All supported
*market indicators* by exchange are listed in the table below,

<div align="center">

<div id="efckmrneey" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  <table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false" style="-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; display: table; border-collapse: collapse; line-height: normal; margin-left: auto; margin-right: auto; color: #333333; font-size: 16px; font-weight: normal; font-style: normal; background-color: #FFFFFF; width: auto; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;" bgcolor="#FFFFFF">
  <caption>Available sentiment indicators by exchange</caption>
  <thead style="border-style: none;">
    <tr class="gt_col_headings" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Endpoint" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" bgcolor="#FFFFFF" valign="bottom" align="left">Endpoint</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Binance" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Binance</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="BitMart" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">BitMart</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Bybit" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Bybit</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Crypto.com" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Crypto.com</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Huobi (HTX)" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Huobi (HTX)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="Kraken" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">Kraken</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="KuCoin" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">KuCoin</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="MEXC" style="border-style: none; color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: center;" bgcolor="#FFFFFF" valign="bottom" align="center">MEXC</th>
    </tr>
  </thead>
  <tbody class="gt_table_body" style="border-style: none; border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
    <tr style="border-style: none;"><td headers="Endpoint" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Long-Short Ratio</p>
</div></td>
<td headers="Binance" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="BitMart" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Bybit" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Crypto.com" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Huobi (HTX)" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Kraken" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="KuCoin" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="MEXC" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Endpoint" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Open Interest</p>
</div></td>
<td headers="Binance" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="BitMart" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Bybit" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Crypto.com" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Huobi (HTX)" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Kraken" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="KuCoin" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="MEXC" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td></tr>
    <tr style="border-style: none;"><td headers="Endpoint" class="gt_row gt_left" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;" valign="middle" align="left"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">Fundingrate</p>
</div></td>
<td headers="Binance" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="BitMart" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Bybit" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Crypto.com" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="Huobi (HTX)" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="Kraken" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:x:</p>
</div></td>
<td headers="KuCoin" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td>
<td headers="MEXC" class="gt_row gt_center" style="border-style: none; padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: center;" valign="middle" align="center"><div class="gt_from_md"><p style="margin: 0; padding: 0; margin-top: 0; margin-bottom: 0;">:white_check_mark:</p>
</div></td></tr>
  </tbody>
  &#10;  
</table>
</div>

</div>

<details>
<summary>
Example: Bitcoin Long-Short Ratio
</summary>

Get the *long-short ratio* on Bitcoin (BTC) using the
`get_lsratio()`-function,

``` r
## BTC OHLC prices
## from Binance spot market
## in 30 minute intervals
BTC_LS <- cryptoQuotes::get_lsratio(
  ticker   = 'BTCUSDT',
  source   = 'binance',
  interval = '30m',
  from     = Sys.Date() - 2
)
```

<div align="center">

<table style="width:100%; color: black; margin-left: auto; margin-right: auto;" class="table">
<caption>
Long-Short Ratio on Bitcoin (BTC)
</caption>
<thead>
<tr>
<th style="text-align:left;">
index
</th>
<th style="text-align:center;">
long
</th>
<th style="text-align:center;">
short
</th>
<th style="text-align:center;">
ls_ratio
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2024-07-07 10:00:00
</td>
<td style="text-align:center;">
0.669
</td>
<td style="text-align:center;">
0.331
</td>
<td style="text-align:center;">
2.021
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 10:30:00
</td>
<td style="text-align:center;">
0.666
</td>
<td style="text-align:center;">
0.334
</td>
<td style="text-align:center;">
1.997
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 11:00:00
</td>
<td style="text-align:center;">
0.668
</td>
<td style="text-align:center;">
0.332
</td>
<td style="text-align:center;">
2.013
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 11:30:00
</td>
<td style="text-align:center;">
0.669
</td>
<td style="text-align:center;">
0.331
</td>
<td style="text-align:center;">
2.018
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 12:00:00
</td>
<td style="text-align:center;">
0.67
</td>
<td style="text-align:center;">
0.33
</td>
<td style="text-align:center;">
2.028
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-07-07 12:30:00
</td>
<td style="text-align:center;">
0.67
</td>
<td style="text-align:center;">
0.33
</td>
<td style="text-align:center;">
2.028
</td>
</tr>
</tbody>
</table>

</div>

------------------------------------------------------------------------

</details>

### :information_source: Charting

Charting in [{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) is
built on [{plotly}](https://github.com/plotly/plotly.R) for
interactivity. It supports *light* and *dark* themes, and accounts for
*color-deficiency* via the `options`-argument in the `chart()`-function.

#### Charting with indicators

The OHLC-V data and the sentiment indicator can be charted using the
`chart()`-function,

<img src="man/figures/README-chartquote-1.png" alt="cryptocurrency charts in R" style="display: block; margin: auto;" />

<details>
<summary>
Source
</summary>

``` r
## Chart BTC
## using klines, SMA
## Bollinger Bands and
## long-short ratio
cryptoQuotes::chart(
  ticker = BTC,
  main   = cryptoQuotes::kline(),
  sub    = list(
    cryptoQuotes::lsr(ratio = BTC_LS),
    cryptoQuotes::volume()
  ),
  indicator = list(
    cryptoQuotes::sma(n = 7),
    cryptoQuotes::sma(n = 14),
    cryptoQuotes::sma(n = 21),
    cryptoQuotes::bollinger_bands()
  ),
  options = list(
    static     = TRUE
  )
)
```

</details>

## :information_source: Installation

### :shield: Stable version

``` r
## install from CRAN
install.packages(
  pkgs = 'cryptoQuotes',
  dependencies = TRUE
)
```

### :hammer_and_wrench: Development version

``` r
## install from github
devtools::install_github(
  repo = 'https://github.com/serkor1/cryptoQuotes/',
  ref  = 'development'
)
```

## :information_source: Code of Conduct

Please note that the
[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) project is
released with a [Contributor Code of
Conduct](https://serkor1.github.io/cryptoQuotes/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
