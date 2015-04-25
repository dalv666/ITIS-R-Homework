setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/PAKDD2014/task1")
source("_include.R")
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/PAKDD2014/task1/data")  # Директория с данными

sale.src <- read.csv("SaleTrain.csv", header=TRUE)
repair.src <- read.csv("RepairTrain.csv", header=TRUE)
#repair.src <- repair.src[1:100000,]

setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/PAKDD2014/task1/out")  # Директория для вывода
sink(file = "compare.out.txt")
pdf(file =  "compare.out.pdf")

components <- sort(unique(sale.src$component_category))

for(component in components[4])
{
  print(c(component_category = component))

  # Выделяем из исходных данных данные, относящиеся к рассматриваемому компоненту
  sale <- subset(sale.src, sale.src$component_category==component)
  repair <- subset(repair.src, repair.src$component_category==component)
  # Отбрасываем ставшие ненужными столбцы модуль/компонент
  sale <- sale[3:4]
  repair <- repair[3:5]

  # Суммируем данные по продажам для одинаковых year/month  
  year.month.col <- unique(sale$year.month)
  number_sale.col <- c()
  for(ym in year.month.col)
  {
    data <- subset(sale, sale$year.month==ym)
    number_sale.col <- c(number_sale.col, sum(data$number_sale))
  }
  sale <- data.frame(year.month = year.month.col, number_sale = number_sale.col)
  
  # Объединяем данные по продажам и заменам в одну таблицу
  joint <- merge(x=repair, y=sale, by.x="year.month.sale.", by.y="year.month", all.x = TRUE)
  print(joint)
  
  # Вычисляем время в месяцах, прошедшее с момента продажи до замены
  period.col <- c()
  for(i in 1:length(joint[,1]))
  {
    period.col[i] <- get.period(start = joint[i, "year.month.sale."],
                               end = joint[i, "year.month.repair."])
  }
  joint <- data.frame(period=period.col, joint["number_repair"], joint["number_sale"])
  
  joint[is.na(joint)] <- 0 # Заменяем значения NA на нули

  joint <- joint[ joint$number_sale > 0, ]  # Оставляем только те значения, которые > 0
  joint <- joint[ order(joint$period), ]

  print(joint)
  
  periods = unique(joint$period)
  periods <- periods[ periods >=0 ]

  if(length(periods) == 0)
    next

  # Объединяем данные по продажам и заменам с одинаковыми месяцами, прошедшими между продажей и заменой 
  number_repair.col <- c()
  number_sale.col <- c()
  for(p in periods)
  {
    data <- subset(joint, joint$period == p)
    number_repair.col <- c(number_repair.col, sum(data$number_repair))
    number_sale.col <- c(number_sale.col, sum(data$number_sale))
  }
  joint <- data.frame(period = periods, number_repair = number_repair.col, number_sale = number_sale.col)

  print(joint)
  
  n <- 10000000
  
  # "Нормируем" данные по продажам
  joint <- data.frame(period = periods, prob = number_repair.col/number_sale.col,
    number_repair = number_repair.col/number_sale.col*n, number_sale = number_sale.col/number_sale.col*n)
  print(joint)


myPeriod = 5
columnsCount = (max(periods) %/% myPeriod) + 1


  bars <- NULL
  for (i in 1:columnsCount) {
    bars[i] <- 0
    for(j in 1:length(joint[,1]))
      if((i-1)*myPeriod <= joint[j, "period"] && joint[j, "period"] < i*myPeriod)
        bars[i] <- bars[i] + joint[j, "prob"]
  }


rates <- (2:7) * 0.000001
for(rate in rates)
{
  rbars <- NULL
  for (i in 1:columnsCount) {
    rbars[i] <- pexp(i*myPeriod, rate) - pexp((i-1)*myPeriod, rate)
  }
    barplot(rbars);
}
}

dev.off()