---
title: "Homework 5"
author: '[Member names]'
date: "10/17/2019"
output: 
  html_document:
    highlight: tango
    keep_md: yes
    theme: united
    toc: yes
    toc_float: yes
  pdf_document:
    toc: yes
---

<style>
# Change TOC text hover colour
.list-group-item.active, .list-group-item.active:focus, .list-group-item.active:hover{
    color: white;
}
table {
  white-space: nowrap;
}
</style>





```r
library(tidyverse)
library(ggmap)
```



```r
wawa <- readRDS("data/wawa/wawa")
wawa.t3 <- wawa %>%
  select(storeNumber, city, state, longitude, latitude) %>%
  map_df(unlist) %>%
  mutate(store = "Wawa")

sheetz <- readRDS("data/sheetz/sheetz")
sheetz.t3 <- sheetz %>%
  select(storeNumber, city, state, longitude, latitude) %>%
  mutate(store = "Sheetz")
```


General Picture


```r
rbind(wawa.t3, sheetz.t3) %>%
  qmplot(longitude, latitude, data = ., maptype = "toner-lite",
         color = store, extent = "panel") + 
  guides(size=FALSE)
```

![](hw5_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

Focus on City


```r
city.wawa <- wawa.t3 %>% 
  filter(state == "PA") %>% 
  group_by(city) %>% 
  count() %>% 
  mutate(store = "wawa")
city.sheetz <- sheetz.t3 %>%
  group_by(city) %>% 
  count() %>% 
  mutate(store = "sheetz")
city.df <- rbind(city.wawa[which(city.wawa$city %in% city.sheetz$city),],
              city.sheetz[which(city.sheetz$city %in% city.wawa$city),])
#plot
ggplot(data=city.df, aes(x=city, y=n, fill=store)) +
  geom_bar(stat="identity", position=position_dodge())+
  scale_fill_brewer(palette="Paired")+
  theme_minimal() +
  labs(title = "Stores in the same city") +
  ylab("number of stores")
```

![](hw5_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

Overlapped store regions


```r
#narrowed dfs
city.sheetz2 <- sheetz.t3 %>% 
  filter(city %in% city.df$city) %>% 
  select(city, latitude, longitude) %>% 
  mutate(store = "sheetz")
city.wawa2 <- wawa.t3 %>% 
  filter(city %in% city.df$city) %>% 
  select(city, latitude, longitude) %>% 
  mutate(store = "wawa")
city.df2 <- rbind(city.wawa2, city.sheetz2)
```



```r
qmplot(longitude, latitude, data = city.df2, maptype = "toner-lite",
       color = store, size = 0.05, extent = "panel") + 
  guides(size=FALSE) +
  labs(title = "Overlapped Store Regions")
```

![](hw5_files/figure-html/unnamed-chunk-4-1.png)<!-- -->






