library(tidyverse)
library(rvest)
library(jsonlite)

#get urls
sheetz.url <- read_html("http://www2.stat.duke.edu/~sms185/data/fuel/bystore/zteehs/regions.html") %>%
  html_nodes(css = ".col-md-2 a") %>%
  head(10) %>% 
  html_attr("href")

#function to parse the url
func.parse <- function(x){
  read_html(x) %>% 
    html_nodes(css = "body") %>% 
    html_text() %>%
    fromJSON() %>% 
    mutate(pickupTimeForAsap = storeAttribute[[2]],
           pickupTimeForAsapCurbside = storeAttribute[[3]],
           paymentConfigType = storeAttribute[[4]]) %>% 
    select(-c(fuelPrice,storeAttribute))
}

#whole df except fuelPrice for sheetz
raw_sheetz <- map_df(sheetz.url, function(x) {
  Sys.sleep(rexp(1) + 4)
  func.parse(x)
}) %>% 
  unnest()

saveRDS(raw_sheetz, "data/sheetz/raw_sheetz.rds")
