1.����Ա����ʷ��λ�� emp_jobhistory��
CREATE TABLE emp_jobhistory(
    id NUMBER,--��ˮ��
    empno NUMBER,--Ա�����
    job VARCHAR2(9),--��λ
    begindate DATE,--��ʼ����
    sal Number(7,2)--�ڸø�λʱ����
)

2.�����������ݣ�
INSERT INTO emp_jobhistory VALUES(1,7839,'TRAINEE','17-11��-81',500);
INSERT INTO emp_jobhistory VALUES(2,7839,'SALESMAN','17-2��-82',1800);
INSERT INTO emp_jobhistory VALUES(3,7839,'CLERK','17-2��-83',2000);
INSERT INTO emp_jobhistory VALUES(4,7839,'SALESMAN','17-2��-85',1800);
INSERT INTO emp_jobhistory VALUES(5,7839, 'MANAGER','17-2��-87',3000);
commit;

---------------------------------------------
  Ƕ���Ӳ�ѯ ��  ����Ӳ�ѯ��
  
        �� Ƕ���Ӳ�ѯ�����Ե���ִ��
           ����Ӳ�ѯ�������Ե���ִ�У������ڸ���ѯ
           
        �� Ƕ���Ӳ�ѯ��
                1) ��ִ���Ӳ�ѯ
                2) ��ʹ�ò��� 1)�е�����,��������ѯʹ�ã�����ȷ�ϻ�ȡ������
                
           ����Ӳ�ѯ��
                1) ��ִ�и���ѯһ��
                2) ������ѯ�õ������ݣ������Ӳ�ѯʹ�ã�����ȷ�ϻ�ȡ������ѯ����
                3) �ظ�ִ�в���1)�� 2)��ֱ���������һ��
---------------------------------------------
1.��β�ѯ�ȱ�����ƽ��нˮ�ߵ�Ա��������нˮ
--Ƕ���Ӳ�ѯ
select deptno,avg(sal) from emp group by deptno;--1.���ŵ�ƽ��нˮ
select * from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s where e.deptno = s.deptno and e.sal > s.avgsal;--2.Ƕ���Ӳ�ѯ

--����Ӳ�ѯ
select * from emp where sal > ������ƽ��нˮ;
select * from emp o where o.sal > (select avg(i.sal) from emp i where i.deptno = o.deptno);

2.��ѯ���в������ƺ�����
--Ƕ���Ӳ�ѯ
select deptno,count(empno) from emp group by deptno;--1.��ѯÿ�����ŵ�����
select d.deptno,c.empCount from dept d,(select deptno,count(empno) empCount from emp group by deptno) c where d.deptno = c.deptno;--2.����ѯ

--����Ӳ�ѯ
select dname,���� from dept;
select dname,(select count(empno) from emp where deptno = dept.deptno) from dept; 

3.��ѯ��ЩԱ���Ǿ���?
--Ƕ���Ӳ�ѯ
select distinct mgr from emp where mgr is not null;--1. ����������Щ�� 
select * from emp where empno in(select distinct mgr from emp where mgr is not null);

--����Ӳ�ѯ
select * from emp where empno �Ƿ�Ϊ����;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) > 0;

4.��ѯ���ٵ���2�θ�λ��Ա����ţ���������λ
--Ƕ���Ӳ�ѯ
select empno,count(1) from emp_jobhistory group by empno;--1.��ѯÿ��Ա���ĸ�λ��������
select * from emp e,(select empno,count(1) �������� from emp_jobhistory group by empno) c where e.empno = c.empno and c.�������� > 2;

--����Ӳ�ѯ
select * from emp where ��Ա���������� > 2;
select * from emp where (select count(1) from emp_jobhistory where empno = emp.empno) > 2;

--��ϰ
������ϰ��ʹ������Ӳ�ѯ���
1.��ѯ������ְλƽ�����ʸߵ�Ա��������ְλ��
select * from emp where sal > ��ְλ��ƽ������;
select * from emp e1 where e1.sal > (select avg(e2.sal) from emp e2 where e2.job = e1.job);

2.��ѯ����Ϊ�䲿����͹��ʵ�Ա����ţ����������ʡ�
select * from emp where sal = �����ŵ���͹���;
select * from emp e1 where e1.sal = (select min(e2.sal) from emp e2 where e2.deptno = e1.deptno);

3.��ѯ���й�Ա��ţ����ֺͲ������֡�
select e.*,�������� from emp e;
select e.*,(select d.dname from dept d where d.deptno = e.deptno) from emp e;

4.��ѯ��ЩԱ���Ǿ���
select * from emp e where empno�Ǿ���;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) > 0;

5.��ѯ��ЩԱ�����Ǿ���
select * from emp e where empno���Ǿ���;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) = 0;

6.��ѯÿ�����Ź�����͵�����Ա����ţ����������ʡ�
select * from emp where ͬ�����ұ��ҵĹ���С������ <= 1;
select * from emp e1 where (select count(1) from emp e2 where e2.deptno = e1.deptno and e2.sal < e1.sal ) <= 1

1	10	1300.00  ��1300С��  0��
2	10	2450.00  ��2450С��  1��
3	10	5000.00  ��5000С��  2��

4	20	800.00   ��800С��  0��
5	20	1100.00  ��1100С�� 1��
6	20	2975.00  ��2975С�� 2��
7	20	3000.00
8	20	3000.00

9	30	950.00     ��950С��  0��
10	30	1251.00  ��1251С�� 1��
11	30	1251.00  ��1251С�� 1��
12	30	1501.00
13	30	1601.00
14	30	2850.00
	
------------------------------------------------------
--exists �� not exists
------------------------------------------------------
4.��ѯ��ЩԱ���Ǿ���
select * from emp e where empno�Ǿ���;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) > 0; --Ч�ʵ�

select * from emp e1  where exists (select * from emp e2 where e2.mgr = e1.empno);    --Ч�ʸ�

5.��ѯ��ЩԱ�����Ǿ���
select * from emp e where empno���Ǿ���;
select * from emp e1 where (select count(1) from emp e2 where e2.mgr = e1.empno) = 0;

select * from emp e1  where not exists (select * from emp e2 where e2.mgr = e1.empno);

--��ϰ
2.��ѯԱ��������ֱ���ϼ������֡�
select empno,ename,mgr,ֱ���ϼ������� from emp;
select e.empno,e.ename,e.mgr,(select m.ename from emp m where m.empno = e.mgr) from emp e;


4.��ѯÿ�����Ź���ǰ�����ߵ�Ա�����������ʡ�
select ename,sal,deptno from emp where ͬһ�����ҹ��ʱ��Ҹߵ��� <= 1;
select e1.ename,e1.sal,e1.deptno from emp e1 where (select count(1) from emp e2 where e2.deptno = e1.deptno and e2.sal > e1.sal) <= 1;

15	MILLER	1300.00	10  ��1300���ʸߵ�2��
9	CLARK	2450.00	10      ��2450���ʸߵ�1��
10	KING	5000.00	10    ��5000���ʸߵ�0��

12	ADAMS	1100.00	20
6	JONES	2975.00	20
3	SMITH	800.00	20
2	SCOTT	3000.00	20
14	FORD	3000.00	20

13	JAMES	950.00	30
11	TURNER	1501.00	30
5	WARD	1251.00	30
4	ALLEN	1601.00	30
8	BLAKE	2850.00	30
7	MARTIN	1251.00	30

