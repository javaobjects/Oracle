----------------------------��ʮ����   ��ͼ -----------------------------

--��ͼ���߼�������һ������������ݼ���

--������ͼ
create view emp_back 
as (select empno,ename,hiredate from emp)


--������ͼʱas������д����еı���
create view emp_back 
as (select empno "Ա�����",ename "Ա������",hiredate "��ְ����" from emp)

--����һ����ͼ��ͨ������ͼ���Բ�ѯ��������2000-5000�ڲ��������а�����A��Ա����ţ����������ʡ�
create view emp_back
as (select empno,ename,sal from emp where sal between 2000 and 5000 and ename like '%A%');

--ֱ������ͼ����DML����(����ɾ��ԭ�����Ǹ���)
delete from emp_back where empno = 7698;

--ϣ�����˲��ܹ�ֱ��ͨ����ͼ���޸�ԭ���ı������
--with read onlyֻ����ֱ��������ͼ�����ݣ����ܶ���ͼ���������DML����
create view emp_back
as (select empno,ename,sal from emp where sal between 2000 and 5000 and ename like '%A%')
with read only
;

--1.����һ����ͼ��ͨ������ͼ���Բ�ѯ��������NEW YORK��CHICAGO��Ա����ţ����������ű�ţ���ְ���ڡ�
create view emp_test1 
as (select empno,ename,e.deptno,hiredate from emp e,dept d where e.deptno = d.deptno and loc in('NEW YORK','CHICAGO'));

select * from emp_test1;
select * from emp_test2;

--2.����һ����ͼ��ͨ������ͼ���Բ�ѯ��ÿ�����ŵĲ������Ƽ���͹��ʡ�
create view emp_test2 
as ( select dname,(select min(sal) minsal from emp where deptno = d.deptno) "������͹���" from dept d)

select * from emp_test2;

--3.ͨ��������ͼ����ѯÿ�����Ź�����͵�Ա����������������
select ename,e.dname from emp_test1 q,emp_test2 w,dept e 
where q.deptno = e.deptno and w.dname = e.dname;


select * from emp_back;
select * from emp;
select * from dept;
