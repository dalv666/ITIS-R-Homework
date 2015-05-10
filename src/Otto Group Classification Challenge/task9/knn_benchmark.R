setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task8/data")  # Директория с данными

# makes the random forest submission

library(FNN)

train.src <- read.csv("train.csv", header=TRUE)
test.src <- read.csv("test.csv", header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task8/out")  # Директория для вывода
sink(file = "predict.out.txt")


labels <- train.src[,ncol(train.src)]
train <- train.src[,-1]
train <- train[,-ncol(train)]
test <- test.src[,-1]
test <- test[,-ncol(test)]

results <- knn(train, test, labels, k = 10, algorithm="cover_tree")
print("--------")
mistake <- 0
for(i in 1:length(results)){
	class = toString(test.src[i,length(test.src)])
	classLength = nchar(class)
	classNum = as.numeric(substr(class, classLength,classLength))
	if(as.numeric(results[i])!=classNum){
		mistake = mistake + 1
		result = paste(c(results[i], classNum), collapse = " ")
	}
}
qa = 100 - (mistake/length(results)*100)
if(qa<0){
	qa = qa * -1
}
result = paste(c("Quality of prediction is ", qa), collapse = "")
print(result)