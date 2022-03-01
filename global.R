library(data.table)
library(tidyverse)
library(janitor)
library(plotly)

movies <- fread('./data/imdb_top_1000.csv', encoding = 'UTF-8')
movies_small <- movies %>% 
  clean_names() %>% 
  select(series_title, released_year, certificate, runtime, genre, director, no_of_votes, gross, imdb_rating, meta_score, star1, star2, star3, star4) %>% 
  mutate(runtime_num = as.numeric(gsub(pattern = ' min', replacement = '', x = runtime))) %>% 
  filter(released_year != 'PG') %>% 
  mutate(released_year = as.numeric(released_year)) %>% 
  mutate(gross = as.numeric(gsub(pattern = ',', replacement = '', x = gross)),
         gross_mm = round(gross / 1e6, 2)) %>% 
  unite(col = 'cast', c(star1, star2, star3, star4), sep = ', ', remove = T) %>% 
  select(-gross)

rm(movies)

genres <- movies_small %>% 
  select(genre) %>% 
  separate(col = genre, into = paste0('genre', 1:3), sep = ', ') %>% 
  pivot_longer(cols = genre1:genre3, names_to = 'var', values_to = 'genre') %>% 
  filter(!is.na(genre)) %>% 
  select(genre) %>% 
  distinct() %>% 
  arrange(genre) %>% 
  pull()
genres <- c('', genres)

variables_plot <- movies_small %>% 
  select_if(is.numeric) %>% 
  names()

variables_titles <- data.frame(
  var = variables_plot,
  title = c('Released Year', 'N of Votes', 'IMDb Rating', 'MetaScore', 'Runtime (min)', 'Gross (MM)')
)


