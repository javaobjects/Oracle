----------------------�ھ���  ����Ӳ�ѯ -------------------------


--��ϰǶ���Ӳ�ѯ
--˼����β�ѯ�ȱ�����ƽ��нˮ�ߵ�Ա��������нˮ��
select deptno,avg(sal) from emp group by deptno;

select * from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > s.avgsal;


--����Ӳ�ѯ
--˼����β�ѯ�ȱ�����ƽ��нˮ�ߵ�Ա��������нˮ
select avg(sal) from emp where deptno = ?;
select * from emp e where sal > (select avg(sal) from emp where deptno = e.deptno);

--Ƕ���Ӳ�ѯ������Ӳ�ѯ�Ա�

--Ƕ���Ӳ�ѯ���Ե�������
--����Ӳ�ѯ���ܵ���ִ��

--����Ӳ�ѯ��Ҫ����ѯ�еı����Ӳ�ѯ��������֮���Ӳ�ѯ��������


--1.��ѯ������ְλƽ�����ʸߵ�Ա��������ְλ��
select * from emp e where sal > (select avg(sal) from emp where job = e.job);

--2.��ѯ����Ϊ�䲿����͹��ʵ�Ա����ţ����������ʡ�
select * from emp e where sal = (select min(sal) from emp where deptno = e.deptno);

--���ָ�����ŵ���͹���
select min(sal) from emp where deptno = ?

--��ѯ���в������ƺ�����
select dname,(select count(*) from emp where deptno = d.deptno)
from dept d;

--���ָ�����ŵ�����
select count(*) from emp where deptno = ?


--��ѯ��ЩԱ���Ǿ���
select * from emp e where (select count(*) from emp where mgr = e.empno) > 0;


--1.��ѯ���й�Ա��ţ����ֺͲ������֡�
select empno,ename,(select dname from dept where deptno = e.deptno) "��������"
from emp e;

--(1)�����ĿҪ������Ҫ�õ��Ӳ�ѯ
--ȫ�������󶼿�����Ƕ���Ӳ�ѯ�����ǲ�һ����������Ӳ�ѯ������Щ�����ʹ������Ӳ�ѯ���ܻ�Ƚϼ�
--(2)�ж��ܷ�ʹ������Ӳ�ѯ
--(3)�Ȱ���Ŀ�Ĵ���Ľṹд��������Ҫ�Ӳ�ѯ�Ĳ��ֺ����ٲ���


--1.��ѯнˮ���������ڲ���ƽ��нˮ�Ĺ�Ա���֣����źš�
select *  from emp e where sal > (select avg(sal) from emp where deptno = e.deptno);

--2.��ѯԱ��������ֱ���ϼ������֡�
select ename,(select ename from emp where empno = e.mgr) "�ϼ�����"
from emp e;

--3.��ѯÿ�����Ź�����ߵ�Ա�����������ʡ�
select ename,sal from emp e where sal = (select max(sal) from emp where deptno = e.deptno);


--4.��ѯÿ�����Ź���ǰ�����ߵ�Ա�����������ʡ�
select ename,sal from emp e where (select count(*) from emp where deptno =  e.deptno and sal > e.sal) =1
                                  or  (select count(*) from emp where deptno =  e.deptno and sal > e.sal) = 0;
                                  
select deptno,ename,sal from emp e where (select count(*) from emp where deptno =  e.deptno and sal > e.sal)<=1;


--������
select * from emp x 
where sal in
(select sal from (select rownum,emp.* from emp order by sal desc) e where rownum<=2 and deptno=x.deptno); 



select * from emp;
select * from dept;
