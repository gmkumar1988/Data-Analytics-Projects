# Installation of necessary libraries
library(dplyr)
library(tidyverse)
install.packages(c("tidytext","tidytuesdayR","forcats"))
library(tidytext)
library(tidytuesdayR)
library(forcats)
install.packages("stringr")
library(stringr) #to be used whenever we use str_sub
library(ggplot2)

# Loading the necessary dataset:
netflix_tt <- tt_load("2021-04-20")
head(netflix_tt)

# Selecting the films in the data set, creating a numeric variable for film
## duration called "runtime", creating a numeric variable for year added

View(netflix_tt$netflix_titles)
str(netflix_tt$netflix_titles)

#Adding Two Columns in the dataframe for analysis: 
netflix_tt_movies <- netflix_tt$netflix_titles %>%
  filter(type == "Movie") %>%
  mutate(runtime = as.numeric(str_sub(duration, end = -5))) %>%
  mutate (year_added = as.numeric(str_sub(date_added, start = -4)))

#Creating a vector Moition Poster Animated Film Ratings for segregation :
mpa_tt <- c("General Audience","With Parent Guidance","Strongly Cautioned People","Strictly Restricted","Adults Only")

str(mpa_tt)

#Creating Top Categories listed on the netflix dataset : 

str(netflix_tt_movies)
top_netflix_movies <- netflix_tt$netflix_titles %>%
  tidyr::separate_rows(listed_in, sep = ", ") %>%
  count(listed_in, sort = TRUE) %>%
  select(listed_in) %>%
  head()

#Creating Frequent Occurence Words in the dataset of the above categories: 
top_netflix__movies_words <- netflix_tt$netflix_titles %>%
  tidyr::separate_rows(listed_in, sep = ",") %>%
  filter(listed_in %in% top_netflix_movies$listed_in ) %>%
  select(listed_in, description) %>%
  unnest_tokens(word,description) %>%
  anti_join(stop_words, by = "word") %>%
  count(listed_in, word, sort = TRUE)

# Plotting the graph: 
netflix_tt_movies %>%
  filter(type == "Movie" & !is.na(rating)) %>%
  filter(rating %in% mpa_tt) %>%
  mutate(rating = factor(rating, levels = rev(mpa_tt))) %>%
  ggplot(aes(x = rating, y = runtime, fill = rating)) +
  geom_abline() +
  geom_hline(yintercept = 90, linetype = 5) +
  coord_flip() +
  theme_classic() +
  scale_fill_viridis_d() + 
  theme(legend.position = "none") +
  labs(x = "Film Rating", y = "Film Duration (in minutes)",
       title = "Film Rating vs Duration in minutes, straight line at 90 minutes",
       subtitle = "Films focused at younger audiences tends to be lesser than others")
  



#Plotting the graph in alternate view : 
netflix_tt_movies %>%
  filter(rating %in% mpa_tt & !is.na(year_added)) %>%
  select(year_added, rating) %>%
  group_by(year_added) %>%
  count(rating) %>%
  mutate(percentage = n/ sum(n)) %>%
  mutate (rating = factor(rating, levels = rev(mpa_tt)))%>%
  ggplot(aes(x = year_added, y = percentage, fill = rating)) +
  geom_bar() +
  theme_classic() +
  scale_fill_viridis_d() +
  scale_x_continuous(breaks = seq(2010, 2021, by = 1)) +
  scale_y_continuous(labels = scales::percent_format(scale = 100)) +
  labs(y = "Percentage Films got added in Netflix", x = "Year Details", fill = "Motion Poster Animated Films",
       title = "Motion Poster Animated rated films added to Netflix on yearly basis",
       subtitle = "Year vs Percentage of Motion Picture Association (MPA) rated films added")


