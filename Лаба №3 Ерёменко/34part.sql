use Tpark

------------------------------------ Декартовое произведение двух таблиц (вывод 2 таблиц)
select Drivers.name, Drivers.surname, Motor_transport.name from Drivers, Motor_transport
go

------------------------------------ Соединение двух таблиц по равенству 

select surname , name_route from Drivers, Route where Drivers.code_drivers = Route.name_driver
go


------------------------------------ Соединение двух таблиц по равенству и условию отбора

select surname , name_route from Drivers, Route where Drivers.code_drivers = Route.name_driver and Drivers.surname ='Иванов'
go

------------------------------------ Соединение по трем таблицам

select  surname , name_route, mileage from Drivers, Route, Motor_transport 
where Drivers.code_drivers = Route.name_driver and Route.type_transport = Motor_transport.code_auto
go

---- Чел 1 | Чел 2 // null // BMW
--- Inner (машина и человек) 
--- Left (Люди + машины столбцы) --> Чел 1 (null) // Чел 2 (BMW)
--- Right (Машины + люди) --> Владельцы BMW: Чел 2 


------------------------------------ Копии запросов на соединение по равенству на запросы с использование внешнего
------------------------------------ полного соединения таблиц (JOIN)

------------------------------------ Left JOIN Фамилия + Маршрут (если фамилия пустая выведет null)
------------------------------------ (Всю левую таблицу с правой)

select Drivers.surname as 'Фамилия', Route.name_route as 'Маршрут' 
from Drivers left outer join [Route] on Drivers.code_drivers = Route.name_driver


------------------------------------ Right JOIN (Всю правую таблицу с левой)

select Drivers.surname as 'Фамилия', Route.name_route as 'Маршрут' 
from Drivers right outer join [Route] on Drivers.code_drivers = Route.name_driver








-------------------------------------------- Часть 4

---------------------------------- Функция Count

select count (experience) as 'Опыт 1 год' from Drivers where experience = 1 --- Сколько сотрудников с опытом 1 год

---------------------------------- Функция SUM

select sum (experience) as 'Суммарный опыт сотрудников' from Drivers where job_title = 'Водитель'

---------------------------------- Функция UPPER LOWER (размер шрифта)

select upper (surname) from Drivers as "Все прописные" 
go
select upper (surname) from Drivers as "Все прописные" 
go

---------------------------------- Временные функции (где год 2022)

select name_route, shedule from Route where DATENAME (year, shedule)= 2022
go

---------------------------------- Группировка по одному столбцу (кол-во вакансий)

select job_title as "Должность", count (*) as "Количество" from Drivers group by job_title 
 go

 ---------------------------------- Группировка по нескольким столбцам

select job_title as "Должность", surname as "Фамилия", count (*) as "Количество" 
from Drivers group by job_title, surname --- сколько водителей с фамилией
go

---------------------------------- Условие отбора группам по HAVING

select job_title as "Должность", surname as "Фамилия", count (*) as "Количество"  
from Drivers group by job_title, surname having count(surname)>1 -- Количество водителей с фамилией иванов >1
go

---------------------------------- Условие отбора группам по HAVING без GROUP BY
select AVG (experience) from Drivers having avg(experience)>=3 --- средний опыт 
go

---------------------------------- Сортировка по столбцу 
select surname from Drivers order by surname
go

---------------------------------- Добавление новых данных

insert into Route(name_route, type_transport, name_driver, shedule) Values ('Скоростная',1,1, 2022-10-10)
go

---------------------------------- Обновление данных
--update Drivers set experience= 1*experience
--go

--update Drivers set experience= 1*experience where experience > 2
--go

--delete from Drivers where experience > 11
--go

