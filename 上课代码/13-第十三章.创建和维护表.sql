-----------------------------��ʮ����   ������ά����-------------------------

--DQL��date query language�� ���ݲ�ѯ����  select
--DML��date manipulation language�� ���ݲ�������  insert update delete
--DDL��date Definition language�� ���ݶ������ԣ������ݿ����������  create alter drop truncate (�Զ��ύ����)




--������ 
--����  ����  �������ͣ����ݳ���  Ĭ��ֵ����ѡ��
--����һ��ѧ����
create table student(
       name varchar2(10),
       sex char(4) default '��',
       school varchar2(20),
       sno number(10)
);

--�����������ʱû�в����ж���Ĭ��ֵ���е�ʱ�������Զ������Ĭ��ֵ
insert into student(name,school,sno) values('xiaoming','xuexiao',7777);

--ѧУ����һ��ѡ��ϵͳ�������漰���γ̱�ѧ������ֱ𴴽����������Լ�˼������Ӧ�е��м���������
create table cls(
      cno   number(5),
      cname varchar2(10),
      cday  date
);


create table std(
       sname varchar2(10),
       ssex  char(4),
       sage  number(3),
       sgrade number(4,1),
       sno  number(5),
       cno  number(5)
);


--���Ӳ�ѯ�﷨������
--1.ͨ���Ӳ�ѯ�ķ�ʽ����һ����dept10,�ñ���10�Ų��ŵ�Ա������
create table dept10 as (select * from emp where deptno = 10);
select * from dept10;

--�޸ı�--�޸ı�ṹ--�޸ı������еĶ���
--������
--�޸���
--ɾ����

--ɾ����drop
drop table dept10;

--�������� rename ������  to ������
rename std to sstd;

--�ضϱ�truncate(ɾ���Զ��ύ����)
truncate table emp_back;

select * from class;




select * from emp;
select * from dept;





