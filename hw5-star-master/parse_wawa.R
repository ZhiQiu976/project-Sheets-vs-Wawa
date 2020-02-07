library(tidyverse)

raw_wawa <- readRDS("data/wawa/raw_wawa.rds")

varnames <- map(raw_wawa, ~ names(.x)) %>% unlist() %>% unique()

create_df <- function(store) {
  # addresses
  store$latitude = list((store$addresses[[2]]$loc %>% unlist)[1])
  store$longitude = list((store$addresses[[2]]$loc %>% unlist)[2])
  
  df1 = as_tibble(store[varnames[11]])                # storeNumber
  df2 = as_tibble(store[[varnames[14]]][[1]][1:5])    # address infos
  df3 = as_tibble(store[c("latitude","longitude")])   # latitude,longitude
  
  return (cbind(df1,df2,df3) %>% as_tibble())
}

wawa <- map_df(raw_wawa, ~ create_df(.x)) %>%
  map_df(unlist)
saveRDS(wawa, "data/wawa/wawa.rds")
