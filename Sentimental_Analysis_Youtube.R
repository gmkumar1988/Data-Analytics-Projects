

#Required Package: 
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
install.packages("syuzhet") # for sentiment analysis
install.packages("ggplot2") # for plotting graphs

#Loading the library: 
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(syuzhet)
library(ggplot2)


#Reading the data from csv file: 
sentimental_dataset <- read.csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/Youtube_data/UScomments.csv",header = TRUE)
str(sentimental_dataset)
head(sentimental_dataset, n= 10)


#loading the data as corpus to clean the dataset from the file : 
textdocument <- Corpus(VectorSource(sentimental_dataset))

#Replacing "/", "@" and "|" with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
textdocument <- tm_map(textdocument, toSpace, "/")
textdocument <- tm_map(textdocument, toSpace, "@")
textdocument <- tm_map(textdocument, toSpace, "\\|")

#Converting the text to lower case: 
textdocument <- tm_map(textdocument, content_transformer(tolower))

#Remove Numbers:
textdocument <- tm_map(textdocument, removeNumbers)

#Remove english common stop words: 
textdocument <- tm_map(textdocument,removeWords, stopwords("english"))

#Remove punctuations: 
textdocument <- tm_map(textdocument, removePunctuation)

#Eliminate White Spaces: 
textdocument <- tm_map(textdocument, stripWhitespace)

#Text stemming - which reduces the word to their root form : 
textdocument <- tm_map(textdocument, stemDocument)

###Building the term document matrix: 
textdocument_matrix <- TermDocumentMatrix(textdocument)
dtm_matrix <- as.matrix(textdocument_matrix)

#Sort by decreasing value of frequency: 
dtm_v <- sort(rowSums(dtm_matrix),decreasing = TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq = dtm_v)

#Display the top 5 most frequency words : 
head(dtm_d,5)

#Plot the most frequent words 
barplot(dtm_d[1:5,]$freq,las = 2,names.arg = dtm_d[1:5,]$word,
        col = "lightgreen",main = "Top 5 most frequent words",
        ylab = "Most Frequent words used in Youtube")