use Tpark
go


DECLARE @a INT, @b numeric(10,2)
SET @a = 20
SET @b = (@a+@a)/10
SELECT @b

-----------------------------------------------

DECLARE @a INT
SELECT @a = count(*) FROM Drivers
SELECT @a

-----------------------------------------------

DECLARE @str CHAR(30)
SELECT @str = surname FROM Drivers
SELECT @str

-----------------------------------------------



-------- временные таблицы

DECLARE @DriverTemp TABLE (id INT, name varchar(255))
insert into @DriverTemp (id,name) values (1,'Коля Ерёменко')
insert into @DriverTemp (id,name) values (2,'Иван Иванов')
SELECT * FROM @DriverTemp




DECLARE @DriversTemp TABLE(id INT,	fio VARCHAR (255) )
INSERT @DriversTemp SELECT code_drivers, surname FROM Drivers
SELECT * FROM @DriversTemp







----------------------------- if количество водителей

DECLARE @counter INT 
DECLARE @name VARCHAR(255)
SET @counter = (SELECT COUNT(*) FROM Drivers) 
IF @counter > 11
BEGIN
SET @name = 'Количество водителей больше 11'
SELECT @name
END ELSE BEGIN
SET @name = 'Количество водителей = ' + str(@counter)
SELECT @name
END



 ---------------------------------------------------------------WHILE
 DECLARE @a INT SET @a = 1 WHILE @a < 20
BEGIN
PRINT @a 
iF (@a>10) AND (@a<15)
BREAK --выход и выполнение 1-й команды за циклом
ELSE
SET @a = @a+1
CONTINUE
END
PRINT @a


 ---------------------скалярная функция (вычисление 1 значения) // агрегатная
use Tpark
go

IF OBJECT_ID (N'dbo.ISOweek', N'FN') IS NOT NULL 
DROP FUNCTION dbo.ISOweek;

go
CREATE FUNCTION dbo.ISOweek (@DATE date) RETURNS CHAR(15)
WITH EXECUTE AS CALLER AS
BEGIN
DECLARE @man int; 
DECLARE @ISOweek char(15); 
SET @man= MONTH(@DATE)

IF (@man=1) SET @ISOweek='Январь'; 
IF (@man=2) SET @ISOweek='Февраль';
IF (@man=3) SET @ISOweek='Март';
IF (@man=4) SET @ISOweek='Апрель'; 
IF (@man=5) SET @ISOweek='Май';
IF (@man=6) SET @ISOweek='Июнь'; 
IF (@man=7) SET @ISOweek='Июль';
IF (@man=8) SET @ISOweek='Август';
IF (@man=9) SET @ISOweek='Сентябрь'; 
IF (@man=10) SET @ISOweek='Октябрь'; 
IF (@man=11) SET @ISOweek='Ноябрь';
IF (@man=12) SET @ISOweek='Декабрь';

RETURN(@ISOweek); 
END;
GO
SET DATEFIRST 1;
SELECT dbo.ISOweek('12.05.2004') AS 'Месяц';




-------------возвращение табличное значение
CREATE FUNCTION ExpMoreThan(@exp int)  
RETURNS TABLE  
AS  
RETURN  
    SELECT surname, experience 
    FROM Drivers  
    WHERE experience > @exp


select * from dbo.ExpMoreThan(3)
go



CREATE FUNCTION Driver_Route (@exp int) RETURNS TABLE
AS RETURN 
SELECT Drivers.surname AS "Фамилия", Route.name_route AS "Маршрут"
from Drivers, Route
WHERE Drivers.code_drivers=Route.name_driver and Drivers.experience>@exp


select * from dbo.Driver_Route (2)
go






----------------------------------------------процедура без параметров // количество водителей
CREATE PROCEDURE Count_Drivers 
AS
Select count(job_title) from Drivers
where job_title='Водитель' 
Go

DROP PROCEDURE Count_Drivers
EXECUTE Count_Drivers


----------------------------------------------процедура с параметрами
------------------------- Количество водителей с проверкой года рождение

CREATE PROCEDURE Count_Drivers_Year @Year_check as Int 
AS
Select count(job_title) from Drivers
where job_title='Водитель' AND year_of_birth >= @Year_check
Go

EXECUTE Count_Drivers_Year 1950
DROP PROCEDURE Count_Drivers_Year


---------------------------------------------------------update процедура

CREATE PROC update_exp AS
UPDATE Drivers SET experience = experience+1

EXEC update_exp




---------------------Вывод инфы SELECT

CREATE PROC select_drivers_info @k CHAR(255) AS
SELECT * FROM Drivers WHERE surname=@k

EXEC select_drivers_info 'Шевченко'





-------------------------------------процедура с return
CREATE PROCEDURE check_surname @param int AS
IF (SELECT surname FROM Drivers WHERE code_drivers = @param)
= 'шевченко'
RETURN 1 ELSE RETURN 2


DECLARE @return_status int
EXECUTE @return_status = check_surname 1 SELECT 'Return Status' = @return_status 


CREATE FUNCTION Calculator (@Opd1 bigint, @Opd2 bigint, @Oprt char(1) = '*') RETURNS bigint
AS BEGIN
DECLARE @Result bigint SET @Result =
CASE @Oprt
WHEN '+' THEN @Opd1 + @Opd2 WHEN '-' THEN @Opd1 - @Opd2
WHEN '*' THEN @Opd1 * @Opd2 WHEN '/' THEN @Opd1 / @Opd2 ELSE 0
END
Return @Result END

SELECT dbo.Calculator(4,5,'+' ),
dbo.Calculator(3,7, '*') - dbo.Calculator(64,4,'/')*2.9 -11


----------- 2 запрос
CREATE FUNCTION SexCheck (@Sex varchar(255))
RETURNS Table AS
RETURN SELECT surname, [name], job_title FROM Drivers WHERE sex = @Sex

SELECT * FROM SexCheck('м')


