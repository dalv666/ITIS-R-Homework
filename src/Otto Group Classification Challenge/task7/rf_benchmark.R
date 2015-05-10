setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task7/data")  # Директория с данными

# makes the random forest submission

library(randomForest)

train.src <- read.csv("train.csv", header=TRUE)
test.src <- read.csv("test.csv", header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task7/out")  # Директория для вывода
sink(file = "predict.out.txt")


train.src <- as.numeric(train.src)
labels <- as.factor(train.src[,length(test.src)])
train <- train.src[,-1]
#test <- test.src[,-length(test.src)]

test <- test.src[,-1]

rf <- randomForest(train, labels, xtest=test, ntree=1000)
predictions <- levels(labels)[rf$test$predicted]

write(predictions, file="rf_benchmark.csv", ncolumns=1) 