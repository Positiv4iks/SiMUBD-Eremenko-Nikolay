use Tpark

----------------------------- ��������� ���������

select * from Drivers where experience > 1 --- ������� ����������� �� ������ > 1 
go

select * from Service_staff where city = '�����' -- ������� ����������� �� ������
go

select * from Service_staff where year_of_birth <=2000 --- ���������� <= 2000 ���� ��������
go


-------------------------------------���������� ��������� AND OR NOT 

select * from Drivers where name ='����' OR name= '����' 
go

select * from Drivers where job_title ='��������' AND year_of_birth < 2000
go

select * from Drivers where NOT sex='�'
go


------------------------------------- ���������� ���������� ����������

select* from Service_staff where sex ='�' AND year_of_birth < 2000 AND city = '�����'
go

------------------------------------- ��������� ��� ��������� (������������ ��������)

select * from Drivers where year_of_employment IN (2000,2001,2005)
go

------------------------------------- �������������� � ��������� ��������

select * from Drivers where year_of_birth BETWEEN 1980 AND 2000
go

------------------------------------- ������������ ������� 

SELECT * FROM Drivers where job_title Like '%��������%'
go

------------------------------------- �������������� ��������

select * from Route where name_route IS NULL 
go




