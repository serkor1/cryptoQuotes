## code to prepare `FGIndex` dataset goes here


# 1) Extract Fear and Greed
# index
FGIndex <- get_fgindex(
  from = "2023-01-01",
  to   = "2023-12-31"
)

usethis::use_data(FGIndex, overwrite = TRUE)
