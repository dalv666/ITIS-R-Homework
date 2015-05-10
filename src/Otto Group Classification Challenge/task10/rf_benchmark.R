setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task9/data")  # Директория с данными

# makes the random forest submission

library(randomForest)

train.src <- read.csv("train.csv", header=TRUE)
test.src <- read.csv("test.csv", header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task9/out")  # Директория для вывода
sink(file = "predict.out.txt")


labels <- as.factor(train.src[,length(train.src)])
train <- train.src[,-1]
train <- train[,-ncol(train)]
test <- test.src[,-1]

tree = 1000
rf <- randomForest(train, labels, xtest=test, ntree=tree)
predictions <- levels(labels)[rf$test$predicted]

zeroReplicate.data = rep.int(0, length(test.src[,1]))

result <- data.frame(row.names = NULL,id=test.src[,1],Class_1=zeroReplicate.data,Class_2=zeroReplicate.data,Class_3=zeroReplicate.data,Class_4=zeroReplicate.data,Class_5=zeroReplicate.data,Class_6=zeroReplicate.data,Class_7=zeroReplicate.data,Class_8=zeroReplicate.data,Class_9=zeroReplicate.data)

for(i in 1:length(predictions)){
	class = toString(predictions[i])
	classLength = nchar(class)
	classNum = as.numeric(substr(class, classLength,classLength))
	result[i,(classNum+1)] = 1
}
write.csv(result, "knn_benchmark_result.csv", row.names=FALSE,quote=FALSE)