library(dplyr)
file.choose()

master_absent <- read.csv("/Users/maheshgurumoorthi/Dropbox/Absenteeism_at_work_Project.csv")

View(master_absent)

str(master_absent)

install.packages("plyr")
library(plyr)

summary(master_absent)

statuscount <- as.data.frame(master_absent %>%
                               group_by(Month.of.absence))
                               # select(Absenteeism.time.in.hours) %>%
                               # table())
View(statuscount)
