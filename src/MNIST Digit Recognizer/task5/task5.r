setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/MNIST Digit Recognizer/task5/data")  # Директория с данными

train.src <- read.csv("train.csv", header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/MNIST Digit Recognizer/task5/out")  # Директория для вывода

text = paste(c("Enter number line ", " which between 1 and ", nrow(train.src)), collapse = "")
n <- readline(prompt=text)
if(as.integer(n) %in% 1:nrow(train.src)){
	number <- as.numeric(train.src[n,])
	number <- matrix(number[-1], nrow=28, ncol=28)
	library(raster)
	r <- raster(number)
	plot(r)
}else{
	print("...")
}