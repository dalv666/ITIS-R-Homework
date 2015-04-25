options("width"=200)
options("max.print" = 1000000)

source("_include.R")
setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/PAKDD2014/task3/data")  # Директория с данными

sale.src <- read.csv("SaleTrain.csv", header=TRUE)
repair.src <- read.csv("RepairTrain.csv", header=TRUE)
target.src <- read.csv("Output_TargetID_Mapping.csv", header=TRUE)
rate.src <- read.csv("Category_Component_Rate.csv", header=TRUE)

setwd("D:/Education/R/HomeWork/ITIS-R-Homework/src/PAKDD2014/task3/out")  # Директория для вывода
sink(file = "predict.out.txt")


findRateByComponentAndCategory <- function(module, component,source){
rate <- subset(source, source$component_category==component & source$module_category==module)
if(length(rate$rate) == 0){
  return(5e-6)
}
return(rate$rate)
}

# Функция прогнозирует количество отказов для данного модуля и данной компоненты
# основываясь на заданной интенсивности отказов (rate)
exp.predict <- function(module, component, sale, repair, rate)
{
  # Выделим данные, соответствующие данным значениям модуль/компонент
  sale   <- subset(sale,     sale$component_category==component &   sale$module_category==module)
  repair <- subset(repair, repair$component_category==component & repair$module_category==module)
  # Удалим столбцы модуль/компонент за ненадобностью
  sale <- sale[c(3,4)]
  repair <- repair[c(3,4,5)]
  
  # Суммируем количество продаж для одинаковых year/month
  year.month.col <- unique(sale$year.month)
  number_sale.col <- c()
  for(ym in year.month.col)
  {
    data <- subset(sale, sale$year.month==ym)
    number_sale.col <- c(number_sale.col, sum(data$number_sale))
  }
  sale <- data.frame(year.month = year.month.col, number_sale = number_sale.col)
  sale <- subset(sale, number_sale!=0) # Удаляем нулевые значения продаж
  
  fill.year.month.col <- function(start)
  {
    year.month <- strsplit(as.character(start), split="/")[[1]]
    year <- as.numeric(year.month[1])
    month <- as.numeric(year.month[2])
    year.month.col <- c()
    while( !(year>=2011 && month>7) )
    {
      year.month.col <- c(year.month.col, paste(year, month, sep="/"))
      month <- month+1
      if(month>12)
      {
        month <- 1
        year <- year+1
      }
    }
    return(year.month.col)
  }
  
  predicted <- NULL
  for(sale.row in 1:length(sale[,1]))
  {
    n <- as.integer(sale[sale.row, "number_sale"])
    year.month.repair.col <- fill.year.month.col(start = sale[sale.row, "year.month"])
    year.month.sale.col <- as.character(rep(sale[sale.row, "year.month"], length(year.month.repair.col)))
    number_predicted.col <- NULL
    # Вероятность отказа между (t-1)-м и t-м моментом времени
    # расчитывается в соответствии с экспоненциальным законом распределения.
    # Вероятность отказа умножается на общее количество проданных деталей.
    # Так получается предсказание количества отказавших деталей 
    # в интервале времени (t-1, t).
    for(t in 1:length(year.month.repair.col))
      number_predicted.col[t]  <- n*(pexp(t, rate) - pexp(t-1, rate))
    # Более подробно о связи экспоненциального распределения с отказами электронных компонент
    # ищите по ключевым словам "exponential distribution electronic systems"
  
    predicted=rbind(predicted, data.frame(
      year.month.sale.  =year.month.sale.col,
      year.month.repair.=year.month.repair.col,
      number_predicted    =number_predicted.col))
  }
  
  predicted <- merge(x=predicted, y=repair, by=c("year.month.sale.", "year.month.repair."), all.x = TRUE)
  
  # Отвязываемся от year/month(sale).
  predicted <- predicted[c(2,3,4)]
  year.month.col <- unique(predicted$year.month.repair.)
  number_predicted.col <- c()
  number_repair.col  <- c()
  for(ym in year.month.col)
  {
    data <- subset(predicted, predicted$year.month.repair. == ym)
    number_predicted.col <- c(number_predicted.col, sum(data$number_predicted))
    number_repair.col <- c(number_repair.col, sum(data$number_repair))
  }
  
  return(data.frame(
    module_category   =rep(module,    length(number_predicted.col)),
    component_category=rep(component, length(number_predicted.col)),
    year.month.repair. = year.month.col,
    number_predicted = number_predicted.col,
    number_repair = number_repair.col,
    discrepancy = number_predicted.col - number_repair.col))
}  
  
predicted <- NULL
sumDiscrepancy = 0
sumNumberRepair = 0
module.component <- unique(target.src[1:2])
row.names(module.component) <- NULL

# Прогнозируем данные об отказах для каждой пары модуль/компонент
for(i in 1:length(module.component[,1]))
{
  module    <- as.character(module.component[i, "module_category"])
  component <- as.character(module.component[i, "component_category"])
print(c(module = module, component = component))

  rate <- findRateByComponentAndCategory(module,component,rate.src)
  newPredict = exp.predict(module, component, sale=sale.src, repair=repair.src, rate)
  sumDiscrepancy = sumDiscrepancy + sum(newPredict$discrepancy, na.rm = TRUE)
  sumNumberRepair = sumNumberRepair + sum(newPredict$number_repair, na.rm = TRUE)
  print(sumNumberRepair)
  predicted <- rbind(predicted, newPredict)
}

print(predicted)

# Представим year/month из target.csv в виде,
# совместимом с таблицами repair, sale и predicted
year.month.repair.col <- c()
for(i in 1:length(target.src[,1]))
  year.month.repair.col[i] <- paste(as.character(target.src[i, "year"]), as.character(target.src[i, "month"]), sep="/")
target <- data.frame(target.src[1:2], year.month.repair.=year.month.repair.col)

# Формируем выходную таблицу. Проходимся по всем строкам в target.
submit <- data.frame(id = numeric(), target = numeric())
for(i in 1:length(row.names(target)))
{
  module     <- as.character(target[i, "module_category"])
  component  <- as.character(target[i, "component_category"])
  year.month <- as.character(target[i, "year.month.repair."])
  print(c(module=module, component=component, year.month=year.month))
  # Выбираем из таблицы спрогнозированных данных об отказах строку,
  # соответствующую данным месяцу, модулю и компоненту
  data <- subset(predicted, predicted$year.month.repair. == year.month &
    predicted$module_category == module & predicted$component_category == component)
  submit <- rbind(submit, c(i, data[1, "number_predicted"]))
}
names(submit) <- c("id", "target")
write.csv(submit, "submit.csv", row.names = FALSE, quote = FALSE)
write.csv(round(submit), "submit.round.csv", row.names = FALSE, quote = FALSE)
qa = sumDiscrepancy/sumNumberRepair*100
if(qa<0){
  qa = qa * -1
}
result = paste(c("Quality of prediction is ", qa,"%"), collapse = "")
print(result)