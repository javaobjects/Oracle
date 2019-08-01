-------------�� ���� ����Ӳ�ѯ--------------

--��ϰǶ���Ӳ�ѯ
--˼����β�ѯ�ȱ�����ƽ��нˮ�ߵ�Ա��������нˮ
select deptno,avg(sal) 
from emp
group by deptno;

select ename,sal from 
emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s
where e.deptno = s.deptno and sal > avgsal;

--����Ӳ�ѯ
--ͨ������Ӳ�ѯҲ���Խ����������
--ȫ���й��ڲ�ѯ����Ŀ��������Ƕ���Ӳ�ѯ����
--�в�����Ŀ����ʹ������Ӳ�ѯ����
--��ʱ��������Ӳ�ѯ��Ƚϼ��

--Ƕ�� ���Ե���ִ��
--����Ӳ�ѯ ���ܵ���ִ�У��������������ѯ�ı��е�ĳЩ����
--����ѯ����ÿ������һ�� �Ӳ�ѯ��ִ��һ��



--˼����β�ѯ�ȱ�����ƽ��нˮ�ߵ�Ա��������нˮ

select avg(sal) from emp where deptno = ?;

select * from
emp e
where sal > (select avg(sal) from emp where deptno = e.deptno);

--1.��ѯ������ְλƽ�����ʸߵ�Ա��������ְλ��
select ename,job
from emp e
where sal > (select avg(sal) from emp where job = e.job);


--2.��ѯ����Ϊ�䲿����͹��ʵ�Ա����ţ����������ʡ�
select empno,ename,sal
from emp e
where sal = (select min(sal) from emp where deptno = e.deptno);

--��ѯ���в������ƺ�����
select dname,(select count(*) from emp where deptno = d.deptno) as ��������
from dept d;

--�����ЩԱ���Ǿ���
select *
from emp e
where (select count(*) from emp  where mgr = e.empno) > 0;




CREATE TABLE emp_jobhistory(
    id NUMBER,--��ˮ��
    empno NUMBER,--Ա�����
    job VARCHAR2(9),--��λ
    begindate DATE,--��ʼ����
    sal Number(7,2)--�ڸø�λʱ����
)

INSERT INTO emp_jobhistory VALUES(1,7839,'TRAINEE','17-11��-81',500);
INSERT INTO emp_jobhistory VALUES(2,7839,'SALESMAN','17-2��-82',1800);
INSERT INTO emp_jobhistory VALUES(3,7839,'CLERK','17-2��-83',2000);
INSERT INTO emp_jobhistory VALUES(4,7839,'SALESMAN','17-2��-85',1800);
INSERT INTO emp_jobhistory VALUES(5,7839, 'MANAGER','17-2��-87',3000);

--��ѯ���ٵ���2�θ�λ��Ա����ţ���������λ
select * from emp e where (select count(*) from emp_jobhistory where empno = e.empno) >= 2;

--1.��ѯ���й�Ա��ţ����ֺͲ������֡�
select emp.empno,emp.ename,dept.dname
from emp join dept
on emp.deptno = dept.deptno;

select empno,ename,(select dname from dept where deptno = e.deptno)
from emp e;



--2.��ѯ��ЩԱ���Ǿ���
select ename 
from emp
where empno in (select mgr from emp);

select *
from emp e
where (select count(*) from emp  where mgr = e.empno) > 0;
--3.��ѯ��ЩԱ�����Ǿ���
select ename 
from emp
where mgr not in (select empno from emp);

select *
from emp e
where (select count(*) from emp  where mgr = e.empno) = 0;

select * from emp;
--4.��ѯÿ�����Ź�����͵�����Ա����ţ����������ʡ� 

-- �Ȱ�ÿ�����ŵĹ��ʲ��
--�ٽ��бȶ�

--���� emp ���е�ÿһ�����ݣ��鿴��Ա���Ĳ����У������һ��Ա���Ĺ��ʱ����ͣ������������ڶ���
--����ò�����û��Ա���Ĺ��ʱ������������ǹ�����͵ġ���

select empno,ename,sal from 
emp e where (select count(*) from emp where deptno = e.deptno and sal < e.sal ) = 0
or (select count(*) from emp where deptno = e.deptno and sal < e.sal ) = 1

select empno,ename,sal from 
emp e where (select count(*) from emp where deptno = e.deptno and sal < e.sal ) <= 1;

select empno,ename,sal from 
emp e where (select count(*) from emp where deptno = e.deptno and sal < e.sal ) in (0,1);




select sal 
from emp e,(select sal,deptno from emp where e.deptno = deptno order by sal desc);--�Լ�д�ġ���ûд������������


select * from emp_jobhistory;--��ʷԱ����λ��¼��

--exists������
--select 1 ֻ��һ��ռλ�� ֻҪexists�����ŵ��Ӳ�ѯ�еĽ��������ֵ,
--��ô��ǰ���������������ݾͻ���������
--��ѯ��Щ���Ǿ���
select * 
from emp e
where exists(select 1 from emp where mgr = e.empno);

--������ϰ����exists��not exists���
--1.�г�������һ����Ա�����в������ơ�

select * from emp;
select * from dept;

select dname,deptno 
from dept d
where exists(select 1 from 
(select emp.deptno,count(*) from emp join dept on emp.deptno = dept.deptno group by emp.deptno)
where deptno = d.deptno)

select dname,deptno
from dept d
where exists(select count(*) from emp where emp.deptno = d.deptno);

select dname,deptno
from dept d
where exists(select 1 from emp where emp.deptno = d.deptno );



--2.�г�һ����Ա��û�е����в������ơ�

select dname,deptno 
from dept d
where not exists(select 1 from 
(select emp.deptno,count(*) from emp join dept on emp.deptno = dept.deptno group by emp.deptno)
where deptno = d.deptno)



select * from emp;


