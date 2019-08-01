--------------------------��ʮ����  Լ��-----------------------------------

--not null�ǿ�Լ��
create table std(
       sno  number(5) not null,
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);


insert into std(sno,sname) values(7777,'clearlove');
insert into std(sname) values('clearlove');   --�޷������ֵ

--uniqueΨһ��Լ��
--�Զ������������ӿ�Ը��е������ٶȣ�
--���嵥��Ψһ
create table std(
       sno  number(5) unique,
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);

insert into std(sno,sname) values(7777,'clearlove');   
insert into std(sno,sname) values(7777,'xiaoming');   --Υ��Ψһ��Լ��

--����������Ψһ
create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5),
       constraint yueshu1 unique(sno,sname)
);

insert into std(sno,sname) values(7777,'clearlove');
insert into std(sno,sname) values(7777,'xiaoming'); 
insert into std(sno,sname) values(7777,'xiaoming');    --Υ��ΨһԼ������

--primary key����Լ��(not null + unique)
--�Զ������������ӿ�Ը��е������ٶȣ�
--ÿ����ֻ�ܴ���һ������Լ��

--�Ե���������Լ��
create table std(
       sno  number(5) primary key,
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);

insert into std(sname) values(7777); --not null
insert into std(sno,sname) values(7777,'clearlove');
insert into std(sno,sname) values(7777,'xiaoming'); --Υ��Ψһ��Լ��

--�Զ�����һ���������Լ��
create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5),
       constraint yueshu2 primary key(sno,sname)
);


--foreign key���Լ��
--������յ����б�������������Ψһ��
--����е�ֵ������������ֵ�ķ�Χ�ڣ�����Ϊ��
--����������ֵ����������ʱ���������¼������ɾ��
--on delete cascade ����ɾ��(�����������е�ĳ��ֵ���л������ɾ��)
--on delete set null(�����������е�ĳ��ֵ��Ϊ��ֵ)
delete from dept where deptno = 10;  --Υ����������Լ�� -- ���ҵ��Ӽ�¼

create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5) constraint yueshu3 references cls(cno)
);

create table cls(
      cno   number(5) primary key,
      cname varchar2(10),
      cday  date
);


--checkԼ��(check��������������ı��ʽ)
create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3) check(sage <= 120 and sage >= 0),
       sgrade number(4,1)
);

insert into std(sno,sage) values(7777,20);
insert into std(sno,sage) values(7777,121);  -- Υ�������Լ��



--׷��Լ��:����������׷���µ�Լ����������ɣ�

create table cls(
      cno   number(5) primary key,
      cname varchar2(10),
      cday  date
);

create table std(
       sno  number(5),
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       cno  number(5)
);

--ɾ��Լ����������ɣ�

--1.ѧУ��һ��ѡ��ϵͳ�����а������¹�ϵģʽ��
--ϵ(ϵ��ţ� ������
--   ϵ����:  Ψһ����
--  ϵ���Σ� �ǿ�Լ����
--  ϵ����Уȥ��ȡֵ��Χֻ�����Ϻ�У���ͻ���У��)
create table department(
       dno number(10) primary key,
       dname varchar2(50) unique,
       dheader varchar(50) not null,
       darea varchar2(50) check(darea in ('�Ϻ�У��','����У��'))
);


   
--�༶(�༶��ţ� ������
--     �༶���ƣ� Ψһ����
--     ����ϵ��  ���)
create table cla(
     cno number(10) primary key,
     cname varchar2(50) unique,
     dno number(10) constraint yueshu1 references department(dno)
);


--2.����ѧ����������������:
--ѧ�� �����ַ��� 10λ ����
--���� �䳤�ַ��� 20λ �ǿ�
--�Ա� �����ַ��� 2λ ȡֵ��Χֻ��Ϊ�л�Ů
--�������� ������ 
--���ڰ༶ 
create table student(
       sno char(10) primary key,
       sname varchar2(20) not null,
       ssex char(3) check(ssex in ('��','Ů')),
       sbirthday date,
       cno number(10)
);



















select * from std;

select * from emp;
select * from dept;
