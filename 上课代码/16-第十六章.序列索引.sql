----------------------------------��ʮ����   ���С�����--------------------------------

--����(����������������������ֵ����һ��������һ���Զ�����)

--��������
create sequence se_test1
increment by 1
start with 1
maxvalue 1000000
minvalue 1
cache 20;

--CURRVAL�ڱ�����֮ǰ��������ʹ��NEXTVAL������һ������ֵ
select se_test.nextval from dual;
select se_test.currval from dual;

insert into cla(cno) values(se_test.nextval);
select * from cla;

--1.����һ�����У���������ʼֵ��1��ʼ�������ֵ��������1����ѭ����
create sequence se_test
start with 1
increment by 1
nocycle;

--2.��ѯ���еĵ�ǰֵ����һ��ֵ
select se_test.currval from dual;
select se_test.nextval from dual;


--3.ʹ�õ�1�����������У����ű��в���������¼�����ű��ʹ������ֵ���������Ʒֱ�Ϊ��Education��Market�����зֱ�Ϊ��DALLAS��WASHTON
insert into dept values(se_test.nextval,'Education','DALLAS');
insert into dept values(se_test.nextval,'Market','WASHTON');


--����
--���������Ĺ�Ч
create table emp_back as select * from emp;
insert into emp_back select * from emp_back;
update emp_back set empno = se_test.nextval;

select * from emp_back where empno = 250000;   --0.1�� û��������ʱ����ݸ��в�ѯ��ʱ��

--��emp_back����empno�������
create index ind1 on emp_back(empno);
select * from emp_back where empno = 250000;   --0.05�� ��������ʱ����ݸ��в�ѯ��ʱ��



select * from emp_back;
select * from dept;
