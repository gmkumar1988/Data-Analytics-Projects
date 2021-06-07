
###Necessary Packages Installed :
install.packages("dplyr")
install.packages("tidyverse")
install.packages("cluster")
install.packages("factoextra")
install.packages("ggplot")

###Libraries of the pacakges : 
library(dplyr)
library(ggplot2)
library(tidyverse)
library(cluster)
library(factoextra)

###Raw Dataset : 
demographic = read.csv("D://Mahesh Files//Datasets//Demographics_Details.csv", header = TRUE)


###Top 5 rows from the rawdataset to cross verify: 
head(demographic)
View(demographic)

###Cross Verify the 'NA' values available in the demographics dataset: 
is.na(demographic) ### Verified and the dataset has no NA values in the dataset 
demographic = na.omit(demographic) ###Omit the NA values from the rawdataset 
str(demographic)


###Calculation Of Mean Value overall Users Availed the Service : 
summarise(demographic, mean_run = mean(demographic$Total.users))

###Mean Value :  mean_run 985.0407


###df = scale(demographic$Total.users)

str(demographic)


# Visualize the ggplot

ggplot(data = demographic , mapping = aes(x = demographic$Total.users, y = demographic$Country)) + 
geom_point(alpha = 1.1, aes(color = "red", size = 3)) + labs(x = "Total Users", y= "Country Details")

##geom_label(
  ##label=rownames(data), 
  ##nudge_x = 0.25, nudge_y = 0.25, 
  ##check_overlap = T
##)

ggplot(data = demographic , mapping = aes(x = demographic$Total.users, y = demographic$Country)) + 
  geom_point(shape = 21, colour = "black", fill = "green", size = 5, stroke = 5)  + labs(x = "Total Users", y= "Country Details")


# Visualize the number of users in Box Plot Analysis :  
#we can have a better idea of the number of users and of their distribution:

ggplot(data = demographic , mapping = aes(x = demographic$Country, y = demographic$Total.users)) + 
  geom_boxplot() + labs(x = "Country Details", y= "Total Users") +
  geom_jitter(alpha = 0.83, color = "tomato")


###BarPlot Details: 
library(forcats) ## Used for reordering the barplot details:
demographic %>%
    mutate(name = fct_reorder(demographic$Country,demographic$Total.users)) %>%
    ggplot(aes(x = demographic$Country, y= demographic$Total.users)) +
    geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
     coord_flip() +
    xlab("Total Active Users") + ylab("Country Details")
    theme_bw() + geom_label(
      label=rownames(data), 
      nudge_x = 0.25, nudge_y = 0.25, 
      check_overlap = F
      )

###Bar Plot Using Descending Format : 
demographic %>%
      mutate(name = fct_reorder(demographic$Country,desc(demographic$Total.users))) %>%
      ggplot(aes(x = demographic$Country, y= demographic$Total.users)) +
      geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
      coord_flip() +
      xlab("Total Active Users") + ylab("Country Details") 
    theme_bw()    
    


demographic %>% mutate(demographic$Country = demographic$Country, demographic$Total.users) %>%
  ggplot( aes(x=demographic$Country, y=demographic$Total.users)) +
  geom_bar(stat="identity", fill="#f68060", alpha=.6, width=.4) +
  coord_flip() +
  xlab("Total Active Users") + ylab("Country Details")
  theme_bw()






