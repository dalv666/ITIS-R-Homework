setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task8/data")  # Директория с данными

# makes the random forest submission

library(randomForest)

train.src <- read.csv("train.csv", header=TRUE)
test.src <- read.csv("test.csv", header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task8/out")  # Директория для вывода
sink(file = "predict.out.txt")


labels <- as.factor(train.src[,length(train.src)])
train <- train.src[,-1]
train <- train[,-ncol(train)]
test <- test.src[,-1]
test <- test[,-ncol(test)]

tree = 1000
rf <- randomForest(train, labels, xtest=test, ntree=tree)
predictions <- levels(labels)[rf$test$predicted]

mistake <- 0
for(i in 1:length(predictions)){
	class = toString(test.src[i,length(test.src)])
	if(predictions[i]!=class){
		mistake = mistake + 1
	}
}
qa = 100 - (mistake/length(predictions)*100)
if(qa<0){
	qa = qa * -1
}
result = paste(c("Quality of prediction is ", qa ," with " , tree, " tree"), collapse = "")
print(result)