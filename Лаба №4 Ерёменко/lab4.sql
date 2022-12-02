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



-------- ��������� �������

DECLARE @DriverTemp TABLE (id INT, name varchar(255))
insert into @DriverTemp (id,name) values (1,'���� �������')
insert into @DriverTemp (id,name) values (2,'���� ������')
SELECT * FROM @DriverTemp




DECLARE @DriversTemp TABLE(id INT,	fio VARCHAR (255) )
INSERT @DriversTemp SELECT code_drivers, surname FROM Drivers
SELECT * FROM @DriversTemp







----------------------------- if ���������� ���������

DECLARE @counter INT 
DECLARE @name VARCHAR(255)
SET @counter = (SELECT COUNT(*) FROM Drivers) 
IF @counter > 11
BEGIN
SET @name = '���������� ��������� ������ 11'
SELECT @name
END ELSE BEGIN
SET @name = '���������� ��������� = ' + str(@counter)
SELECT @name
END



 ---------------------------------------------------------------WHILE
 DECLARE @a INT SET @a = 1 WHILE @a < 20
BEGIN
PRINT @a 
iF (@a>10) AND (@a<15)
BREAK --����� � ���������� 1-� ������� �� ������
ELSE
SET @a = @a+1
CONTINUE
END
PRINT @a


 ---------------------��������� ������� (���������� 1 ��������) // ����������
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

IF (@man=1) SET @ISOweek='������'; 
IF (@man=2) SET @ISOweek='�������';
IF (@man=3) SET @ISOweek='����';
IF (@man=4) SET @ISOweek='������'; 
IF (@man=5) SET @ISOweek='���';
IF (@man=6) SET @ISOweek='����'; 
IF (@man=7) SET @ISOweek='����';
IF (@man=8) SET @ISOweek='������';
IF (@man=9) SET @ISOweek='��������'; 
IF (@man=10) SET @ISOweek='�������'; 
IF (@man=11) SET @ISOweek='������';
IF (@man=12) SET @ISOweek='�������';

RETURN(@ISOweek); 
END;
GO
SET DATEFIRST 1;
SELECT dbo.ISOweek('12.05.2004') AS '�����';




-------------����������� ��������� ��������
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
SELECT Drivers.surname AS "�������", Route.name_route AS "�������"
from Drivers, Route
WHERE Drivers.code_drivers=Route.name_driver and Drivers.experience>@exp


select * from dbo.Driver_Route (2)
go






----------------------------------------------��������� ��� ���������� // ���������� ���������
CREATE PROCEDURE Count_Drivers 
AS
Select count(job_title) from Drivers
where job_title='��������' 
Go

DROP PROCEDURE Count_Drivers
EXECUTE Count_Drivers


----------------------------------------------��������� � �����������
------------------------- ���������� ��������� � ��������� ���� ��������

CREATE PROCEDURE Count_Drivers_Year @Year_check as Int 
AS
Select count(job_title) from Drivers
where job_title='��������' AND year_of_birth >= @Year_check
Go

EXECUTE Count_Drivers_Year 1950
DROP PROCEDURE Count_Drivers_Year


---------------------------------------------------------update ���������

CREATE PROC update_exp AS
UPDATE Drivers SET experience = experience+1

EXEC update_exp




---------------------����� ���� SELECT

CREATE PROC select_drivers_info @k CHAR(255) AS
SELECT * FROM Drivers WHERE surname=@k

EXEC select_drivers_info '��������'





-------------------------------------��������� � return
CREATE PROCEDURE check_surname @param int AS
IF (SELECT surname FROM Drivers WHERE code_drivers = @param)
= '��������'
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


----------- 2 ������
CREATE FUNCTION SexCheck (@Sex varchar(255))
RETURNS Table AS
RETURN SELECT surname, [name], job_title FROM Drivers WHERE sex = @Sex

SELECT * FROM SexCheck('�')


