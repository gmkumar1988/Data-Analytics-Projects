install.packages("gplots")
library(gplots)
library(ggplot2)
install.packages("ROCR")
library(ROCR)

file.choose()

gold <- read.csv("/Users/maheshgurumoorthi/Dropbox/BSE-BOM590111.csv", header = TRUE)

str(gold)

summary(gold)

View(gold)

#Creating Binary Plot of Gold with Closing Price on daily basis 
plot(density(gold$Close), main = "Distibution of Gold Stock Price using ROC")
polygon(density(gold$Close), col = "pink")
abline(v= 10, lwd = 3, col = "skyblue")

#Creating Binary Plot Of Gold Shares Purchased on daily basis
options(scipen = 9999999)
plot(density(gold$No..of.Shares), main = "Distibution of Gold Shares Purchased using ROC View")
polygon(density(gold$No..of.Shares), col = "pink")
abline(v= 100000, lwd = 3, col = "skyblue")

gold$isexpensive <- gold$Close > 1.00

set.seed(1)
istest <- runif(nrow(gold)) >0.70
train <- gold[istest == FALSE,]
test <- gold[istest ==TRUE,]

# fit1 <- glm(isexpensive ~Open.,data = gold, family = binomial())
#Model 1 : Open as the only predictor:
fit1 <- glm(gold$isexpensive ~ gold$Open, data = gold, family = binomial())
fit1

#Model 2 : High as the only predictor:
fit2 <- glm(gold$isexpensive ~ gold$High, data = gold, family = binomial())
fit2

#Model 3 : Close as the only predictor: 
fit3 <- glm(gold$isexpensive ~ gold$Close, data = gold, family = binomial())
fit3

plot(fit1,colorize = TRUE,lwd = 3, main = "ROC Curves")
plot(fit2, add = TRUE,colorize = TRUE,lwd = 3)
plot(fit3, add = TRUE, colorize = TRUE, lwd = 3)
abline(a = 0, b=1, lty = 2, lwd = 3, col = "black")

