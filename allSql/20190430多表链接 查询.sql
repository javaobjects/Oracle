--������Ӳ�ѯ Ƕ���Ӳ�ѯ ����Ӳ�ѯ ��Լ�� ����
------------
--������� ��ѯ
------------
--�ѿ����� 14*4
select emp.empno,
emp.ename,emp.job,emp.mgr,
emp.hiredate,emp.sal,
emp.deptno,dept.deptno,
dept.dname
from emp,dept;

select emp.empno,
emp.ename,emp.job,emp.mgr,
emp.hiredate,emp.sal,
emp.deptno,dept.deptno,
dept.dname
from emp,dept
where emp.deptno = dept.deptno;

select emp.*,dept.* from emp,dept where emp.deptno = dept.deptno;
--��ѯ����Ա����š����������ű�ţ������ص�
select empno,ename,dept.deptno,loc
from emp,dept
where dept.deptno = emp.deptno;
--����ֻ���ѯ�����ص���NEW YORK��Ա����ţ����������ű�ţ������ص�
select empno,ename,dept.deptno,loc
from emp,dept
where dept.deptno = emp.deptno and loc = 'NEW YORK';
--���������
select e.empno,e.ename,d.deptno,d.loc
from emp e,dept d
where d.deptno = e.deptno and d.loc = 'NEW YORK';
--1.дһ����ѯ����ʾ����Ա�����������ű�ţ��������ơ�
select emp.ename,emp.deptno,dept.dname
from emp,dept;
--2.дһ����ѯ����ʾ���й�����CHICAGO���ҽ���Ϊ�յ�Ա�������������ص㣬����
select emp.ename,dept.loc,emp.comm
from emp,dept where dept.loc = 'CHICAGO' and emp.comm is not null;
--3.дһ����ѯ����ʾ���������к���A�ַ���Ա�������������ص㡣
select emp.ename,dept.loc 
from emp,dept
where emp.ename like '%A%';
--�����е���������������-deptno,dtype)
--��ѯ����Ա����� ������ �����ű�ţ������ص� ��������������
select e.empno,e.ename,d.deptno,d.loc
from emp e,dept d,dep de
where d.deptno = e.deptno and d.deptno = de.deptno
----------------
--�ǵ�ֵ ���� 
--------------
--��ѯ���ʵȼ� ��Ա���� ���������� 
select s.grade,e.ename,d.dname,e.sal
from dept d,emp e,salgrade s
where e.sal between s.losal and s.hisal and e.deptno = d.deptno
order by e.sal;
--��ĿǰΪֹsql��� ��ִ��˳��
--1 from
--2 where
--3 select
--4 order by 
--1.��ѯÿ��Ա���ı�ţ����������ʣ����ʵȼ������ڹ������У����չ��ʵȼ�������������

-----------
--�ⲿ���� 
----------
--��ѯû�й�Ա�����Ĳ���
--��ѯ���й�Ա���������ű�ţ��������ƣ�����û��Ա���Ĳ���ҲҪ��ʾ����
select ename,dept.deptno,dept.dname
from emp,dept
where dept.deptno = emp.deptno(+);
--��ѯÿ��Ա����������ֱ���ϼ�������--e Ա����  w �����
select e.ename,w.ename
from emp e,emp w
where e.mgr = w.empno;






select * from salgrade;
select * from dept;
select * from emp;
