--����˼����β�ѯ�ȱ�����ƽ��нˮ�ߵ�Ա��������нˮ��

--Ƕ���Ӳ�ѯ��д��:

--�ҵ����д����
--��һ�����Ȳ�ѯԱ��������нˮ
select ename,sal from emp;
--�ڶ�����--ÿ�����ŵ�ƽ��нˮ,������Ϊһ����
select avg(sal) avgSal,deptno from emp group by deptno;
--����������ǰ��������֮�Ͻ���
select ename,sal,emp.deptno from emp,
(select avg(sal) avgSal,deptno from emp group by deptno) tab_avgSal
where sal > avgSal and emp.deptno = tab_avgSal.deptno;
--��׼��д�� ��
select empno,ename,sal
from   emp e ,(select deptno,avg(sal) avgsal from emp group by deptno) d
where e.deptno =d.deptno
and e.sal >d.avgsal;

--����Ӳ�ѯ����
select empno,ename,sal,deptno
from emp outer
where sal > (select avg(sal) from emp where deptno = outer.deptno);
--����ѯ�е���ÿ������һ�Σ��Ӳ�ѯ��ִ��һ��

--## ��ϰ1 

--������ϰ��ʹ������Ӳ�ѯ���

--1. ��ѯ������ְλƽ�����ʸߵ�Ա��������ְλ��
select ename,job
from emp outer
where sal > (select avg(sal) from emp where job = outer.job);

--2. ��ѯ����Ϊ�䲿����͹��ʵ�Ա����ţ����������ʡ�
select empno,ename,sal
from emp outer
where sal = (select min(sal) from emp where deptno = outer.deptno);



select * from emp;
select * from dept;

--## ��ϰ2

--������ϰ��������Ӳ�ѯ���

--1. ��ѯ���й�Ա��ţ����ֺͲ������֡�

--2. ��ѯ��ЩԱ���Ǿ���

--3. ��ѯ��ЩԱ�����Ǿ���

--4. ��ѯÿ�����Ź�����͵�����Ա����ţ����������ʡ� 

--## ��ϰ3

--������ϰ����exists��not exists���

--1. �г�������һ����Ա�����в������ơ�

--2. �г�һ����Ա��û�е����в������ơ�

--## �κ���ҵ

--������ϰ��ʹ������Ӳ�ѯ��ɡ�

--1. ��ѯнˮ���������ڲ���ƽ��нˮ�Ĺ�Ա���֣����źš�

--2. ��ѯԱ��������ֱ���ϼ������֡�

--3. ��ѯÿ�����Ź�����ߵ�Ա�����������ʡ�

--4. ��ѯÿ�����Ź���ǰ�����ߵ�Ա�����������ʡ�
