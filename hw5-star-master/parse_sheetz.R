library(tidyverse)

sheetz.df <- readRDS("data/sheetz/raw_sheetz.rds")

sheetz.t3 <- sheetz.df %>% 
  select(1:9)

saveRDS(sheetz.t3, "data/sheetz/sheetz.rds")