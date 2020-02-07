# get wawa
library(httr)
library(tidyverse)


base_url <- "http://www2.stat.duke.edu/~sms185/data/fuel/bystore/awaw/awawstore="
ids <- c(sprintf("%05d", seq(0,1000)),
        sprintf("%05d", seq(8000,9000)))

query_wawa <- function(id) {
  query <- paste(base_url, id, ".json", sep = "")
  geturl <- GET(query)
  
  if (geturl$status_code %in% c(200:299)) {
    return (content(geturl))
  }
}

raw_wawa <- map(ids, function(x) {
  Sys.sleep(rexp(1) + 1)
  query_wawa(x)
})

raw_wawa <- raw_wawa[map(raw_wawa, length) != 0]
saveRDS(raw_wawa, "data/wawa/raw_wawa.rds")
