use Tpark

----------------------------- Операторы сравнения

select * from Drivers where experience > 1 --- вывести сотрудников со стажем > 1 
go

select * from Service_staff where city = 'Минск' -- вывести сотрудников из минска
go

select * from Service_staff where year_of_birth <=2000 --- сотрудники <= 2000 года рождения
go


-------------------------------------Логические операторы AND OR NOT 

select * from Drivers where name ='иван' OR name= 'катя' 
go

select * from Drivers where job_title ='Водитель' AND year_of_birth < 2000
go

select * from Drivers where NOT sex='ж'
go


------------------------------------- Комбинации логических операторов

select* from Service_staff where sex ='м' AND year_of_birth < 2000 AND city = 'Минск'
go

------------------------------------- Выражения над столбцами (определенные значения)

select * from Drivers where year_of_employment IN (2000,2001,2005)
go

------------------------------------- Принадлежность к диапазону значений

select * from Drivers where year_of_birth BETWEEN 1980 AND 2000
go

------------------------------------- Соответсвуют шаблону 

SELECT * FROM Drivers where job_title Like '%Водитель%'
go

------------------------------------- Неопределенное значение

select * from Route where name_route IS NULL 
go




