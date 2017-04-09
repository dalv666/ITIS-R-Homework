# ITIS-R-Homework
Семестровый курс по R

#### Преподаватель: Петр Андреевич Новиков

##### PAKDD2014:   
###### Задание№1
<ul>
<li>Изменить исходный <code>compare.R</code> файл так, чтобы гистограммы строились на основе пары выборочная вероятность/прогнозируемая вероятность без генерации массивов данных.
(Подсказка: использовать barplot).</li>
</ul>
###### Исходники: [sources](/src/PAKDD2014/task1/compare.R)
###### Отчет: [report](/src/PAKDD2014/task1/task1.txt)
___
###### Задание№2
<ul>
<li>Изменить исходный файл <code>predict.R</code> так, чтобы он допускал задание интенсивности <code>rate</code> для конкретной пары модуль/компонент.</li>
</ul>
###### Исходники: [sources](/src/PAKDD2014/task2/predict.R)
###### Отчет: [report](/src/PAKDD2014/task2/task2.txt)
___
###### Задание№3
<ul>
<li>Ввести меру качества прогноза, сравнивая спрогнозированные величины с фактическими величинами.</li>
</ul>
###### Исходники: [sources](/src/PAKDD2014/task3/predict.R)
###### Отчет: [report](/src/PAKDD2014/task3/Task3.txt)
___
###### Задание№4
<ul>
<li>Подобрать параметры rate так, чтобы прогноз на основе экспоненциальной модели был наиболее точен. Насколько подобранные параметры соответствуют гистограммам из <code>compare.R</code></li>
</ul>
###### Исходники: [sources](/src/MNIST%20Digit%20Recognizer/task5/task5.r)
###### Отчет: [report](/src/MNIST%20Digit%20Recognizer/task5/task5.txt)
___
##### MNIST Digit Recognizer:
###### Задание№5
<ul>
<li>Составить скрипт, выводящий на экран растровый рисунок (цифру), зашифрованный в указанной строке <code>train.csv</code> или <code>test.csv</code>.</li>
</ul>
###### Исходники: [sources](/src/MNIST%20Digit%20Recognizer/task5/task5.r)
###### Отчет: [report](/src/MNIST%20Digit%20Recognizer/task5/task5.txt)
___
##### Otto Group Classification Challenge
###### Задание№6 
<ul>
<li>Разделить train.csv на две таблицы, условно-тренировочную и условно-тестовую, в отношении 3:1.</li>
</ul>
###### Исходники: [sources](/src/Otto%20Group%20Classification%20Challenge/task6/task6.r)
###### Отчет: [report](/src/Otto%20Group%20Classification%20Challenge/task6/task6.txt)
___
###### Задание№7 
<ul>
<li>На основании обучения по условно-тренировочной таблице "предсказать" результаты для условно-тестовой таблицы.
Использовать методы.
  <ul>
    <li>kNN (package FNN)</li>
    <li>randomForest (package randomForest)</li>
  </ul>
  (В качестве отправной точки используйте R-скрипты Digit Recognizer.)
</li>
</ul>
###### Исходники: [sources](/src/Otto%20Group%20Classification%20Challenge/task7/)
###### Отчет: [report](/src/Otto%20Group%20Classification%20Challenge/task7/task7.txt)
___
###### Задание№8 
<ul>
<li>Ввести меру качества прогноза аналогично заданию 3.
Изменяется ли мера качества прогноза, если по-разному выбирать условно-тренировочные и условно-тестовые части?
8a-8b -- аналогично 7a--7b.</li>
</ul>
###### Исходники: [sources](/src/Otto%20Group%20Classification%20Challenge/task8/)
###### Отчет: [report](/src/Otto%20Group%20Classification%20Challenge/task8/task8.txt)
___
###### Задание№9
<ul>
<li>Подобрать метод и его параметры так, чтобы прогноз получался как можно лучше.</li>
</ul>
###### Исходники: [sources](/src/Otto%20Group%20Classification%20Challenge/task9/)
###### Отчет: [report](/src/Otto%20Group%20Classification%20Challenge/task9/task9.txt)
___
###### Задание№10
<ul>
<li>Используя полностью train.csv в качестве обучающего массива, предсказать результаты </li>
</ul>
###### Исходники: [sources](/src/Otto%20Group%20Classification%20Challenge/task10/rf_benchmark.R)
###### Отчет: [report](/src/Otto%20Group%20Classification%20Challenge/task10/task10.txt)

