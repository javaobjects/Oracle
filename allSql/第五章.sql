select * from emp,salgrade 
where emp.sal between losal and hisal;

select e.ename,m.ename from emp e,emp m where e.mgr = m.empno;


------------sql 99 ��׼������ �﷨------------------
--���ӵ����д��from�Ӿ䵱��
--�������� cross join
select * from 
emp cross join dept;

--��Ȼ���� natural join 
--�Զ����ҵ���������ͬ����ͬ�������͵��� �Զ�ʵ������ ���Զ��ģ�
--�Զ������ӵ��зŵ���һ�� 
--�Զ����յ�һ����������
select * from emp
natural join dept;
--using �Ӿ� ���൱��һ���ֶ��汾���Զ����� ��
--�﷨ �� a �� join b�� using(�У�
select * from emp join dept using(deptno);

--on�Ӿ�(�Ƚϳ��ã���Ϊ���������﷨��oracle�﷨�Ƚ�����)
--�﷨�� a�� join b�� on(��������) join c�� on(���� ����)
--��� �����������ϵı����ӵĻ�����Ҫ�ظ���д join�Ӿ��on�Ӿ�
select * from emp join dept on(emp.deptno = dept.deptno);

select * from emp join dept on(emp.deptno = dept.deptno) 
join salgrade s on(emp.sal between s.losal and s.hisal);

-- ������
--��������
--�﷨ �� a�� left outer join b�� on (��������)
--��������ߵı����������һ��Ҫ��ʾ
--��ѯ���й�Ա���������ű�ţ��������� ������û��Ա���Ĳ���ҲҪ��ʾ ����
--���� �����ŵ� ��һλ������ ������������
select * from
dept d left outer join emp e on (d.deptno = e.deptno);

--�������� 
--�﷨�� a�� right outer join b �� on������ ����)
-- �������ұߵı���������� һ��Ҫ��ʾ 
--��ѯ���й�Ա���������ű�ţ��������� ������û��Ա���Ĳ���ҲҪ��ʾ ����
select * from 
emp e right outer join dept d on(d.deptno = e.deptno);
--ȫ������ 
--���� �ı������ �� Ҫ��ʾ 
--�﷨ ��a �� full outer join dept  d on(d.deptno = e.deptno);

--ʹ��SQL-99д�������������ϰ
--1.����һ��Ա����Ͳ��ű�Ľ������ӡ�

select * from emp 
cross join dept;

--2.ʹ����Ȼ���ӣ���ʾ��ְ������80��5��1��֮���Ա���������������ƣ���ְ���� natural join
select emp.ename,dept.dname,emp.hiredate
from emp
natural join dept where hiredate > '01-5��-80';

--3.ʹ��USING�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص� JOIN dept d USING (deptno) 
select emp.ename,dept.dname,dept.loc
from emp join dept using(deptno)
where dept.loc in 'CHICAGO';

--4.ʹ��ON�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص㣬н�ʵȼ�
select emp.ename,dept.dname,dept.loc,salgrade.grade
from emp
join dept
on(emp.deptno = dept.deptno)
join salgrade
on(emp.sal between salgrade.losal and salgrade.hisal)
where dept.loc = 'CHICAGO';

--5.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������left outer join
select e.ename as Ա������,
m.ename as �������� 
from emp e
left outer join emp m
on (e.mgr = m.empno);

--6.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������ RIGHT  OUTER JOIN

select e.ename,
m.ename
from emp m
right outer join emp e
on (e.mgr = m.empno);



select * from emp;
select * from dept;
select * from salgrade;


