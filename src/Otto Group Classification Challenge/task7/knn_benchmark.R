setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task7/data")  # Директория с данными

# makes the random forest submission

library(FNN)

train.src <- read.csv("train.csv", header=TRUE)
test.src <- read.csv("test.csv", header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task7/out")  # Директория для вывода
sink(file = "predict.out.txt")


labels <- train.src[,ncol(train.src)]
train <- train.src[,-1]
train <- train[,-ncol(train)]
test <- test.src[,-1]
test <- test[,-ncol(test)]

results <- knn(train, test, labels, k = 10, algorithm="cover_tree")

write(results, file="knn_benchmark.csv", ncolumns=1)