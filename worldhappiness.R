# install.packages("shiny")
# library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(plotly)
library(tidyverse)

worldhappiness <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/WorldHappiness2019/2019.csv", 
                           header = TRUE)
head(worldhappiness, n= 10)
View(worldhappiness)
colnames(worldhappiness)
str(worldhappiness)
names(worldhappiness)

# Create A/B groups based on median GDP
median_gdp <- median(worldhappiness$GDP.per.capita, na.rm = TRUE)
print(median_gdp)

worldhappiness$GDP_group <- ifelse(worldhappiness$GDP.per.capita > median_gdp, 
                                   "High GDP", "Low GDP")
print(worldhappiness$GDP_group)
### Checking group accounts 
table(worldhappiness$GDP_group)
### Compare mean happiness scores 
aggregate(Score ~ GDP_group, data = worldhappiness, FUN = mean)
### Running two sample t-test 
ab_test <- t.test(Score ~ GDP_group, data = worldhappiness)
print(ab_test)

install.packages("effsize")
library(effsize)
cohen_d <- cohen.d(Score ~ GDP_group, data = worldhappiness)
print(cohen_d)

### Creating the box plot happiness score by GDP Group 
ggplot(worldhappiness, aes(x = GDP_group, y = Score)) +
  geom_boxplot(fill = c("lightblue", "lightgreen")) +
  labs(title = "Happiness Score by GDP Group",
       x = "GDP Group",
       y = "Happiness Score") +
  theme_minimal()

### Creating the density plot 
ggplot(worldhappiness, aes(x = Score, fill = GDP_group)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Happiness Scores by GDP Group",
       x = "Happiness Score",
       y = "Density") +
  theme_minimal() +
  scale_fill_manual(values = c("lightblue", "lightgreen"))


