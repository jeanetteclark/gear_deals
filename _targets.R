library(targets)
source("functions.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("httr","dplyr", "rvest", "DT"))
url <- "https://www.steepandcheap.com/rock-climbing-shoes?sort=-discountpercent&p=brand%3AScarpa%7CBrand%3A100000327&nf=1"
list(
  tar_target(
    sc_webpage_up,
    http_error(url),
  ),
  tar_target(
    data,
    steep_and_cheap(url)
  ),
  tar_target(
    webpage,
    rmarkdown::render("sale_information.Rmd")
  )
)