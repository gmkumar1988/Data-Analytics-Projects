data("iris")
str(iris)

summary(iris)

set.seed(111)

head(iris)
nrow(iris)

ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.8,0.2))
ind

training = iris[ind == 1,]
testing = iris[ind == 2,]

head(ind)

install.packages("psych")
library(psych)

pairs.panels(training[,-5],
             gap = 0,
             bg = c("red", "yellow", "blue")[training$Species],
             pch=21)


pc <- prcomp(training[,-5],
             center = TRUE,
             scale. = TRUE)

attributes(pc)

pc$center

pc$scale

print(pc)

summary(pc)