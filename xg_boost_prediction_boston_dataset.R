library(xgboost)
install.packages("caret")
library(caret)


data = MASS::Boston

View(data)

str(data)

set.seed(0)

#split into training (80%) and testing set (20%)
parts = createDataPartition(data$medv,p = 0.8, list = F)
train = data[parts,]
test = data[-parts,]

#define predictor and response variables in training set


train_x = data.matrix(train[,-13])
train_y = train[,13]

#define predictor and response variables in testing set

test_x = data.matrix(test[,-13])
test_y = test[,13]

# Define final train and test data 
xgb_train = xgb.DMatrix(data = train_x, label = train_y)
xgb_test = xgb.DMatrix(data = test_x, label = test_y)

#Define Watchlist
watchlist = list(train=xgb_train, test = xgb_test)

#fit XGBoost model and display training and testing data at each round (RMSE - Root Mean Squared Error) 
##From the output we can see that the minimum testing RMSE is achieved at 56 rounds. Beyond this point, the test RMSE actually begins to increase, which is a sign that we're overfitting the training data.
model = xgb.train(data = xgb_train, max.depth = 3, watchlist = watchlist, nrounds = 70)

#define final model 
final = xgboost(data = xgb_train,max.depth = 3, nrounds = 56, verbose = 0)

#use model to make predictions on test data
pred_y = predict(final, xgb_test)

mean((test_y - pred_y)^2) #MSE
caret::MAE(test_y, pred_y) #MAE
caret::RMSE(test_y, pred_y) #RMSE
