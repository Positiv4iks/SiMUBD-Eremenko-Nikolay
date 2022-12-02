use Tpark

------------------------------------ ���������� ������������ ���� ������ (����� 2 ������)
select Drivers.name, Drivers.surname, Motor_transport.name from Drivers, Motor_transport
go

------------------------------------ ���������� ���� ������ �� ��������� 

select surname , name_route from Drivers, Route where Drivers.code_drivers = Route.name_driver
go


------------------------------------ ���������� ���� ������ �� ��������� � ������� ������

select surname , name_route from Drivers, Route where Drivers.code_drivers = Route.name_driver and Drivers.surname ='������'
go

------------------------------------ ���������� �� ���� ��������

select  surname , name_route, mileage from Drivers, Route, Motor_transport 
where Drivers.code_drivers = Route.name_driver and Route.type_transport = Motor_transport.code_auto
go

---- ��� 1 | ��� 2 // null // BMW
--- Inner (������ � �������) 
--- Left (���� + ������ �������) --> ��� 1 (null) // ��� 2 (BMW)
--- Right (������ + ����) --> ��������� BMW: ��� 2 


------------------------------------ ����� �������� �� ���������� �� ��������� �� ������� � ������������� ��������
------------------------------------ ������� ���������� ������ (JOIN)

------------------------------------ Left JOIN ������� + ������� (���� ������� ������ ������� null)
------------------------------------ (��� ����� ������� � ������)

select Drivers.surname as '�������', Route.name_route as '�������' 
from Drivers left outer join [Route] on Drivers.code_drivers = Route.name_driver


------------------------------------ Right JOIN (��� ������ ������� � �����)

select Drivers.surname as '�������', Route.name_route as '�������' 
from Drivers right outer join [Route] on Drivers.code_drivers = Route.name_driver








-------------------------------------------- ����� 4

---------------------------------- ������� Count

select count (experience) as '���� 1 ���' from Drivers where experience = 1 --- ������� ����������� � ������ 1 ���

---------------------------------- ������� SUM

select sum (experience) as '��������� ���� �����������' from Drivers where job_title = '��������'

---------------------------------- ������� UPPER LOWER (������ ������)

select upper (surname) from Drivers as "��� ���������" 
go
select upper (surname) from Drivers as "��� ���������" 
go

---------------------------------- ��������� ������� (��� ��� 2022)

select name_route, shedule from Route where DATENAME (year, shedule)= 2022
go

---------------------------------- ����������� �� ������ ������� (���-�� ��������)

select job_title as "���������", count (*) as "����������" from Drivers group by job_title 
 go

 ---------------------------------- ����������� �� ���������� ��������

select job_title as "���������", surname as "�������", count (*) as "����������" 
from Drivers group by job_title, surname --- ������� ��������� � ��������
go

---------------------------------- ������� ������ ������� �� HAVING

select job_title as "���������", surname as "�������", count (*) as "����������"  
from Drivers group by job_title, surname having count(surname)>1 -- ���������� ��������� � �������� ������ >1
go

---------------------------------- ������� ������ ������� �� HAVING ��� GROUP BY
select AVG (experience) from Drivers having avg(experience)>=3 --- ������� ���� 
go

---------------------------------- ���������� �� ������� 
select surname from Drivers order by surname
go

---------------------------------- ���������� ����� ������

insert into Route(name_route, type_transport, name_driver, shedule) Values ('����������',1,1, 2022-10-10)
go

---------------------------------- ���������� ������
--update Drivers set experience= 1*experience
--go

--update Drivers set experience= 1*experience where experience > 2
--go

--delete from Drivers where experience > 11
--go

