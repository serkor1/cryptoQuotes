## R CMD check results

0 errors ✔ | 0 warnings ✔ | 3 notes ✖


❯ checking installed package size ... NOTE
    installed size is 13.1Mb
    sub-directories of 1Mb or more:
      doc   11.7Mb
      help   1.2Mb

This is beyond my technical knowledge, but here is a related SO-post:
https://stackoverflow.com/questions/38639266/r-cmd-check-unusual-checking-installed-package-size-note

❯ checking for future file timestamps ... NOTE
  unable to verify current time

It seems that this is out of my hand. See the following SO-post:
https://stackoverflow.com/questions/63613301/r-cmd-check-note-unable-to-verify-current-time

❯ checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'RtmpIPBrDJBTC.csv'

It seems that this is not an issue when built on CRAN. See the following SO-post:
https://stackoverflow.com/questions/62456137/r-cran-check-detritus-in-temp-directory 




