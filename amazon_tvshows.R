library(dplyr)
library(ggplot2)
library(tidyverse)

dataset <- read.csv('/Users/maheshg/Dropbox/Sample Datasets Kaggle/Amazon Prime TV Shows/titles.csv')

head(dataset)

clean_dataset <- na.omit(dataset)
print(clean_dataset)
colnames(clean_dataset)
str(clean_dataset)
###Finding the values exist in the dataset? 
which(is.na(clean_dataset))
sum(is.na(clean_dataset))
anyNA(clean_dataset) ### This is cleaned dataset omitted na values 
anyNA(dataset) ### There are some NA values exists in the maindataset 

summary(clean_dataset)
str(clean_dataset)
by(clean_dataset,clean_dataset$release_year,summary)

### Additional stats model stat.desc() from the package of 'pastecs':
install.packages("pastecs")
library(pastecs)
options(scipen = 900)
### Checking the coefficient of variation details :
stat.desc(clean_dataset$imdb_score)
stat.desc(clean_dataset$imdb_votes)

### Coefficient Variation : 
sd(clean_dataset$imdb_score) / mean(clean_dataset$imdb_score)
sd(clean_dataset$imdb_votes) / mean(clean_dataset$imdb_votes)

tab <- table(clean_dataset$imdb_score)
print(tab)
tab1 <- table(clean_dataset$imdb_votes)
print(tab1)
sort(table(clean_dataset$imdb_votes),decreasing = TRUE)
sort(table(clean_dataset$imdb_score),decreasing = TRUE)

summary(clean_dataset)

###Identifying the correlation between two variables imdb scores and imdb votes 
cor(clean_dataset$imdb_score,clean_dataset$imdb_votes)
###Creating contingency table 
median(clean_dataset$imdb_votes)
mean(clean_dataset$imdb_votes)
clean_dataset$imdb_votes_size <- ifelse(clean_dataset$imdb_votes < median(clean_dataset$imdb_votes),
                          "average","beyond average")
table(clean_dataset$imdb_votes_size)
clean_dataset$imdb_score_size <- ifelse(clean_dataset$imdb_score < median(clean_dataset$imdb_score),
                          "average","beyond average")
table(clean_dataset$imdb_score_size )
table(clean_dataset$imdb_votes_size,clean_dataset$imdb_score_size )
prop.table(table(clean_dataset$imdb_votes_size,clean_dataset$imdb_score_size ))
round(prop.table(table(clean_dataset$imdb_votes_size,clean_dataset$imdb_score_size ),1),2) ### Percentage by Row
round(prop.table(table(clean_dataset$imdb_votes_size,clean_dataset$imdb_score_size ),2),2) ### Percentage by Column

###Creation of Mosaic Plot : 
mosaicplot(table(clean_dataset$imdb_votes_size,clean_dataset$imdb_score_size ),
           color = TRUE,
           main = "Mosaic Plot View between IMDB Votes vs IMDB Scores",
           xlab = "Votes",
           ylab = "Size")

###Creation of Bar Plot : 
barplot(table(clean_dataset$imdb_votes_size))
barplot(prop.table(table(clean_dataset$imdb_votes_size)))

###Plotting the value 
ggplot(clean_dataset)+
  aes(x=imdb_score_size) +
  geom_bar()

###Histogram 
str(clean_dataset$imdb_score_size)
hist(clean_dataset$release_year,
     main = "Histogram View of all the IMDB Shows based on the release year ")
ggplot(data = clean_dataset) +
  aes(x = clean_dataset$release_year) +
  labs(title = "Plotting the release year imdb shows") +
  # annotate("This gives negative skewed view based on the distribution of the dataset") +
  geom_histogram()

str(clean_dataset)

###Remove the outliers in the release year attribute 
Q1 <- quantile(data = clean_dataset$release_year,0.25)
Q3 <- quantile(data= clean_dataset$release_year,0.75)
IQR <- Q3 - Q1

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

# clean_dataset$score_details <- clean_dataset$imdb_score[(clean_dataset$imdb_score >= lower_bound) & (clean_dataset$imdb_score <= upper_bound)]


###Boxplot details of IMDB Score and IMDB Votes:

# boxplot(clean_dataset$imdb_score ~ clean_dataset$imdb_votes)
par(mfrow = c(2,2))

boxplot(clean_dataset$imdb_score)
boxplot(clean_dataset$imdb_votes)
###Dot Plot View 
install.packages("lattice")
library(lattice)
dotplot(clean_dataset$imdb_votes ~ clean_dataset$imdb_score)

###Stack View Plot : 
ggplot(datat = clean_dataset) + 
  aes(x = clean_dataset$imdb_votes, 
      y = clean_dataset$imdb_score) +
  geom_dotplot(binaxis = "y", stackdir = "center")

### Scatter Plot : 
par(mfrow = c(1,1))
plot(clean_dataset$imdb_score, clean_dataset$imdb_votes)

ggplot(data = clean_dataset) +
  aes(x = clean_dataset$imdb_score, 
      y = clean_dataset$imdb_votes) +
  geom_point() #### Showing strong positive association between two variables 

head(clean_dataset)

ggplot(clean_dataset) +
  aes(x = imdb_votes, 
      y = imdb_score,
      colour = production_countries) +
  labs(title = "Scatter Plot Details based on the IMDB Scores and IMDB Votes grouped by Production Countries") +
  geom_point() +
  scale_color_hue()


###Line Plot : 
plot(clean_dataset$imdb_score,
     type = "l")

### QQ Plot : 
qqnorm(clean_dataset$imdb_score)
qqline(clean_dataset$imdb_votes)

### QQ Plot with confidence from the car package : 
qqplot(clean_dataset$imdb_votes,clean_dataset$imdb_score,plot.it = TRUE)

qqplot(clean_dataset$imdb_score,clean_dataset$imdb_votes, groups = clean_dataset$imdb_score_size)

plot(density(clean_dataset$imdb_score))

ggplot(clean_dataset) +
  aes(x = clean_dataset$imdb_score) +
  geom_density()
 



