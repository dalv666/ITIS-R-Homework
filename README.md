# ITIS-R-Homework
Семестровый курс по Haskell

####Преподаватель: Петр Андреевич Новиков

##### PAKDD2014:
######Задание№1
Изменить исходный <code>compare.R</code> файл так, чтобы гистограммы строились на основе пары выборочная вероятность/прогнозируемая вероятность без генерации массивов данных.
(Подсказка: использовать barplot).
######Исходники: [sources](/src/PAKDD2014/task1/compare.R)
######Отчет: [report](/src/PAKDD2014/task1/task1.txt)

######Задание№2
Изменить исходный файл <code>predict.R</code> так, чтобы он допускал задание интенсивности <code>rate</code> для конкретной пары модуль/компонент.
######Исходники: [sources](/src/PAKDD2014/task2/predict.R)
######Отчет: [report](/src/PAKDD2014/task2/task2.txt)

######Задание№3
Ввести меру качества прогноза, сравнивая спрогнозированные величины с фактическими величинами.
######Исходники: [sources](/src/PAKDD2014/task3/predict.R)
######Отчет: [report](/src/PAKDD2014/task3/Task3.txt)

######Задание№4
Подобрать параметры rate так, чтобы прогноз на основе экспоненциальной модели был наиболее точен. Насколько подобранные параметры соответствуют гистограммам из <code>compare.R</code>
######Исходники: [sources](/src/MNIST%20Digit%20Recognizer/task5/task5.r)
######Отчет: [report](/src/MNIST%20Digit%20Recognizer/task5/task5.txt)

##### MNIST Digit Recognizer:
######Задание№5
Составить скрипт, выводящий на экран растровый рисунок (цифру), зашифрованный в указанной строке <code>train.csv</code> или <code>test.csv</code>.
######Исходники: [sources](/src/Otto%20Group%20Classification%20Challenge/task6/task6.r)
######Отчет: [report](/src/Otto%20Group%20Classification%20Challenge/task6/task6.txt)

#####Otto Group Classification Challenge
######Задание№6 
Разделить train.csv на две таблицы, условно-тренировочную и условно-тестовую, в отношении 3:1.

######Задание№7 
На основании обучения по условно-тренировочной таблице "предсказать" результаты для условно-тестовой таблицы.
Использовать методы.
a)kNN (package FNN)
b)randomForest (package randomForest)
(В качестве отправной точки используйте R-скрипты Digit Recognizer.)

######Задание№8 
Ввести меру качества прогноза аналогично заданию 3.
Изменяется ли мера качества прогноза, если по-разному выбирать условно-тренировочные и условно-тестовые части?
8a-8b -- аналогично 7a--7b.

######Задание№9
Подобрать метод и его параметры так, чтобы прогноз получался как можно лучше.

######Задание№10
Используя полностью train.csv в качестве обучающего массива, предсказать результаты 

