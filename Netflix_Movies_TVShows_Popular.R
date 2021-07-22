library(tidyverse)
netflix_titles <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-20/netflix_titles.csv")

netflix_titles%>% count(type)

str(netflix_titles)

netflix_titles %>%
  slice_sample(n = 20) %>%
  pull(description)

library(tidytext)

netflix_titles %>%
  unnest_tokens(word,description) %>%
  anti_join(get_stopwords()) %>%
  count(type, word, sort = TRUE) %>%
  group_by(type) %>%
  slice_max(n, n = 20) %>%
  ungroup() %>%
  mutate(word = reorder_within(word,n, type)) %>%
  ggplot(aes(n,word,fill = type)) + 
  geom_col(show.legend = FALSE,alpha = 0.8) +
  scale_y_reordered() + 
  facet_wrap(~type,scales = "free") +
  labs(
    x = "Frequency of Words - Netflix Database" ,
    y = "Most used words in the movie description",
    title = "Number of Movies Based on Genre(s)",
    subtitle = "Based on the stopword function"
    
    
  )