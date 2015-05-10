setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task6/data")  # Директория с данными

train.src <- read.csv("train.csv",header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task6/out")  # Директория для вывода
#sink(file = "predict.out.txt")


train.src <- train.src[sample(nrow(train.src)),]

part <- nrow(train.src) %/% 4

firstTest <- train.src[1:(part*3), ]
secondTest <- train.src[(part*3+1):nrow(train.src), ]

write.csv(firstTest, "firstTrain.csv",row.names=FALSE,quote=FALSE)
write.csv(secondTest, "secondTrain.csv",row.names=FALSE,quote=FALSE)