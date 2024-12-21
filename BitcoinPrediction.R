install.packages("anytime")
install.packages("xts")
install.packages("ggfortify")
install.packages("forecast")
install.packages("quantmod")
library(anytime)
library(xts)
library(ggfortify)
library(forecast)
library(quantmod)

#Importing the Bitcoin Historical Data : 
train_data <- read.csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Bitcoin/BTC-2021min.csv",header = TRUE)

head(train_data, n=10)
summary(train_data)
train_data <- na.omit(train_data)
colnames(train_data)

head(train_data)

##Converting data for analysis : formatting timestamp: 
train_data$date <- as.POSIXct(train_data$date, origin = "1970-01-01",tz = "GMT")
train_data$date <- as.Date(train_data$date)
train_data$Volume.BTC <- as.numeric(train_data$Volume.BTC)
train_data <- train_data[,c(8,1,2,3,4,5,6,7)]
View(train_data)
#Data for the price comparison at the end : 
test_data <- train_data[,5]
head(test_data)

cp <- ggplot(data = train_data, aes(date,close) + geom_line()+
               scale_x_date(date_breaks = "years", date_labels = "%Y",
                            limits = as.Date(c("2020-01-01","2022-01-02")))+
               ylab("Closing Price ($")+xlab("Year") +ylim(0,55000))