# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(rvest)

# set url ----------------------------------------------------------------------

first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# read first page --------------------------------------------------------------

page <- read_html(first_url)

# scrape titles ----------------------------------------------------------------

titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()

titles

# scrape links -----------------------------------------------------------------
links <- page %>%
  html_nodes(".iteminfo") %>% 
  html_node("h3 a") %>% 
  html_attr("href") # get href attribute instead of text

head(links)

## The URL of the page looks like: https://collections.ed.ac.uk/art/record/20929?highlight=*:*
## It differs by the one we scraped here in the way that, for here it looks like: ./record/20929?highlight=*:*

# scrape links -----------------------------------------------------------------
links <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_attr("href") %>%
  str_replace(".", "https://collections.ed.ac.uk/art")

links

# scrape artists ---------------------------------------------------------------

artists <- page %>%
  html_nodes(".iteminfo") %>%
  html_node(".artist") %>%
  html_text() %>%
  str_squish()

artists

# put together in a data frame -------------------------------------------------

first_ten <- tibble(
  title = titles,
  artist = artists,
  link = links
)

# scrape second ten paintings --------------------------------------------------

second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"

page <- read_html(second_url)

titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()

titles

links <- page %>%
  html_nodes(".iteminfo") %>% 
  html_node("h3 a") %>% 
  html_attr("href") # get href attribute instead of text

head(links)

links <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_attr("href") %>%
  str_replace(".", "https://collections.ed.ac.uk/art")

links

artists <- page %>%
  html_nodes(".iteminfo") %>%
  html_node(".artist") %>%
  html_text() %>%
  str_squish()

artists

second_ten <- tibble(
  title = titles,
  artist = artists,
  link = links
)





