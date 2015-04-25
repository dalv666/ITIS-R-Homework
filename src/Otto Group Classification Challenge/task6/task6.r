setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task6/data")  # Директория с данными

train.src <- read.csv("train.csv",header=TRUE)
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/Otto Group Classification Challenge/task6/out")  # Директория для вывода
sink(file = "predict.out.txt")
sorted <- train.src[order(train.src$label),]

uniqueNumbers <- sort(unique(train.src$label))

numbers <- sort(train.src$label)

numbersTable <- table(numbers)

numbersCount <- NULL

for(num in uniqueNumbers){
	numbersCount[num+1] <- numbersTable[names(numbersTable)==num]
}


firstTest <- NULL
secondTest <- NULL

for(num in uniqueNumbers){
	print("_____________________________________")
	print("Num")
	#print(num)
	startOffset <- 0
	if(num == 0){
			startOffset = 1;
		}else{
			for(of in 1:num-1){
		#		print("###ITER###")
		#		print(of)
	#			print("OLD")
	#			print(startOffset)
				startOffset = startOffset + numbersCount[of+1]
#				print("NEW")
#				print(startOffset)
#				print("###ITER###")
			}
		}

#		print("Start")
#		print(startOffset)
		endOffset <- startOffset + (numbersCount[num+1]%/%4)*3
#		print("End")
#		print(endOffset)
		print("First Start")
		print(startOffset)
		print("First End")
		print(endOffset)

		print("Second Start")
		print(endOffset+1)

		print("Second End")
		print(startOffset+numbersCount[num+1]-1)

	firstTest <- rbind(firstTest,  sorted[startOffset:endOffset,]) 
	secondTest <- rbind(secondTest, sorted[(endOffset+1):(startOffset+numbersCount[num+1]-1),])
}
write.csv(firstTest, "firstTrain.csv",row.names=FALSE)
write.csv(secondTest, "secondTrain.csv",row.names=FALSE)
