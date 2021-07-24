file.choose()
install.packages("readr")
library(readr)
library(dplyr)
peopledataset <- read.csv("/Users/maheshgurumoorthi/Dropbox/People Analytics Dataset/hr_analytics.csv")

glimpse(peopledataset)

sum(is.na(peopledataset))

set.seed(1000)
subsIndex <- sample(1:nrow(peopledataset), 0.2*nrow(peopledataset))
View(subsIndex)
subs <- peopledataset[subsIndex,]

attach(subs)

plot(last_evaluation,satisfaction_level, main = "Performance View of Satisfaction Level Last Vs Recent ", 
     xlab = " Last Evaluation:", ylab = "Satisfaction Level:")

#Salary and Time Spent : 
library(ggplot2)
plot(subs$salary,subs$time_spend_company)

attach(subs)
plot(factor(salary), time_spend_company, main = " Time and Salary Spent by an Organization",
     xlab = "Salary", ylab = "Time Spent at Company", pch = 19)

plot(average_montly_hours, time_spend_company, main = " Average Monthly Hours and Salary Spent by an Organization",
     xlab = "Salary USD$", ylab = "Time Spent at Company in Hrs", pch = 19)


