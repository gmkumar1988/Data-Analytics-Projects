# Installation of necessary libraries
library(tidyverse)
install.packages(c("tidytext","tidytuesdayR","forcats"))
library(tidytext)
library(tidytuesdayR)
library(forcats)

# Loading the necessary dataset:
netflix_tt <- tt_load("2021-04-20")

head(netflix_tt)

# Selecting the films in the data set, creating a numeric variable for film
## duration called "runtime", creating a numeric variable for year added


View(netflix_tt$netflix_titles)

netflix_movies <- netflix_tt$netflix_titles %>% 
  filter (type == "Movie")