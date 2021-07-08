###Library Importing 

library(recommenderlab)
library(reshape2)
library(data.table)
library(ggplot2) #visualization


### Retrieving Dataset in CSV format:

movie_dataset = read.csv("D://Mahesh Files//Datasets//IMDBMovie//IMDb movies.csv", header = TRUE, stringsAsFactors = FALSE)

rating_dataset = read.csv("D://Mahesh Files//Datasets//IMDBMovie//IMDb ratings.csv", header = TRUE,stringsAsFactors = FALSE)

###structure of the dataset:
str(movie_dataset)
str(rating_dataset)

###Tabular View 
data.table(movie_dataset)
data.table(rating_dataset)

View(movie_dataset)
View(rating_dataset)

###Summary of the dataset : 
summary(movie_dataset)
summary(rating_dataset)

movie_genre <- as.data.frame(movie_dataset$genre,stringsAsFactors = FALSE)
movie_genre2 <- as.data.frame(tstrsplit(movie_genre[,],"[|]",type.convert = TRUE),stringsAsFactors = FALSE)

View(movie_genre2)
