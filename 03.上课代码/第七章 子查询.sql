-----------------------------------------------
-- ʹ���Ӳ�ѯ
--    ��  �Ӳ�ѯ���ڲ���ѯ������ִ��
--    ��  ��������в�ѯ�Ľ����������ѯ���ⲿ��ѯ��ʹ�ã�����ȷ�ϻ�ȡ������
--
--    �����Ӳ�ѯʹ�õ����������>  >=   =  <  <=  <>
--    �����Ӳ�ѯʹ�ö����������in  any  all
-----------------------------------------------
1.��ѯ����JONES��Ա���ʸߵ�������Ա
select sal from emp where ename = 'JONES';                                --1. jones�Ĺ����Ƕ��٣�  2975.00
select * from emp where sal > (select sal from emp where ename = 'JONES');--2.��ѯ����JONES��Ա���ʸߵ�������Ա

-----------------------------------------------------------
--�����Ӳ�ѯ:����һ��һ��       ʹ�õ����������>  >=   =  <  <=  <>
-----------------------------------------------------------
1.��ʾ�͹�Ա7369������ͬ�������ҹ��ʴ��ڹ�Ա7876�Ĺ�Ա�������͹�����
select job from emp where empno = 7369;                --1.��Ա7369���µĹ�����ʲô  CLERK
select sal from emp where empno = 7876;                --2.��Ա7876�Ĺ����Ƕ��� 1100.00
select ename, job
  from emp
 where job = (select job from emp where empno = 7369)
   and sal > (select sal from emp where empno = 7876); --3.����ѯ
   
--�Ӳ�ѯ��ʹ���麯��
1.��ѯ������͵�Ա����������λ������
select min(sal) from emp;                                --1. ��ѯ��͹����Ƕ���  800
select * from emp where sal = (select min(sal) from emp);--2. ����ѯ

--HAVING�Ӿ���ʹ���Ӳ�ѯ
1.��ѯ������͹��ʱ�20������͹��ʸߵĲ��ű�ż���͹���
select min(sal) from emp where deptno = 20;                           --1. 20������͹���  800
select deptno,min(sal) from emp group by deptno having min(sal) > 800;--2. ����ѯ
   
2.��ѯ�ĸ����ŵ�Ա���������ڸ�����ƽ��������
select avg(count(empno)) from emp group by deptno;                         --1. ������ƽ������   3.5
select deptno, count(empno)
  from emp
 group by deptno
having count(empno) > (select avg(count(empno)) from emp group by deptno); --2. ����ѯ
   
--��ϰ
4.��ѯ���������������в���ƽ�������ĵĲ��ű�ţ��������ƣ���������
select avg(count(empno)) from emp group by deptno;                         --1.���в���ƽ������  3.5

select e.deptno, d.dname, count(empno)
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno, d.dname
 having count(empno) > (select avg(count(empno)) from emp group by deptno); --2.����ѯ
   
-----------------------------------------------------------
--�����Ӳ�ѯ:���ض���һ��       ʹ�ö����������in  any  all 
-----------------------------------------------------------
--in 
1.��ѯԱ������Ϊ����������͹��ʵ�Ա����Ϣ
select min(sal) from emp group by deptno;-- null 950  800 1300

select empno, ename
  from emp
 where sal = (select min(sal) from emp group by deptno);-- not ok �����Ӳ�ѯ���ض�����
 
 select empno, ename,sal
  from emp
 where sal in (select min(sal) from emp group by deptno);--ok

2.��ѯ�Ǿ����Ա������������
select distinct mgr from emp;                                   --1.��ѯ��Щ���Ǿ���  7839,7782,7698,7902,7788,7566
select * from emp where empno in(select distinct mgr from emp);-- 2.����ѯ

--ANY ������ֵƥ��    <any    >any    =any���൱��in��
-- =any���൱��in��:���Ӳ�ѯ������һ��ֵ���
1.��ѯ�Ǿ����Ա�����������ʡ�
select distinct mgr from emp;                                   --1.��ѯ��Щ���Ǿ���  7839,7782,7698,7902,7788,7566
select * from emp where empno =any (select distinct mgr from emp);-- 2.����ѯ

-- >any :������Сֵ
2.��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10���š����⡿һ��Ա�����ʡ��ߡ���Ա����ţ�������ְλ�����ʡ�
select sal from emp where deptno = 10;                          --1.��ѯ10��������Ա���Ĺ��� 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal >any (select sal from emp where deptno = 10) and deptno <> 10;-- 2.����ѯ

-- <any :С�����ֵ
3.��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10���š����⡿һ��Ա�����ʡ��͡���Ա����ţ�������ְλ�����ʡ�
select sal from emp where deptno = 10;                         --1.��ѯ10��������Ա���Ĺ��� 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal <any (select sal from emp where deptno = 10) and deptno <> 10;-- 2.����ѯ


--ALL ������ֵƥ��    <all    >all    =all�������壩
-- =all :��������ֵ
1.�������塿��ѯ���ű�Ų�Ϊ10���ҹ�����10���š����С�Ա�����ʡ���ȡ���Ա����ţ�������ְλ�����ʡ�
select sal from emp where deptno = 10;                          --1.��ѯ10��������Ա���Ĺ��� 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal =all (select sal from emp where deptno = 10) and deptno <> 10;-- 2.����ѯ

-- >all :�������ֵ
2.��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10���š����С�Ա�����ʡ��ߡ���Ա����ţ�������ְλ�����ʡ�
select sal from emp where deptno = 10;                          --1.��ѯ10��������Ա���Ĺ��� 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal >all (select sal from emp where deptno = 10) and deptno <> 10;-- 2.����ѯ

-- <all :С����Сֵ
3.��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10���š����С�Ա�����ʡ��͡���Ա����ţ�������ְλ�����ʡ�
select sal from emp where deptno = 10;                         --1.��ѯ10��������Ա���Ĺ��� 2450.00,5000.00,1300.00
select empno,ename,job,sal from emp where sal <all (select sal from emp where deptno = 10) and deptno <> 10;-- 2.����ѯ


-----------------------------------------------------------
--�����Ӳ�ѯ:���ض��ж���       ͨ���ö����������in
-----------------------------------------------------------
--�ɶԱȽ�
1.��ѯ����1981����ְ�ġ����⡿һ��Ա���ġ����ź�ְλ��ȫ��ͬ��Ա�����������š�ְλ����ְ����,������1981����ְԱ��
select * from emp where hiredate between '1-1��-81' and '31-12��-81';  --1.1981����ְ��Ա���Ĳ��ź�ְλ
select * from emp where substr(hiredate,-2) = '81';                    --1.1981����ְ��Ա���Ĳ��ź�ְλ
select * from emp where to_char(hiredate,'yyyy') = '1981';             --1.1981����ְ��Ա���Ĳ��ź�ְλ
select * from emp where extract(year from hiredate) = '1981';          --1.1981����ְ��Ա���Ĳ��ź�ְλ

select distinct deptno,job from emp where extract(year from hiredate) = '1981';          --1.1981����ְ��Ա���Ĳ��ź�ְλ

select *
  from emp
 where (deptno, job) = any (select distinct deptno,job from emp where extract(year from hiredate) = '1981')
   and extract(year from hiredate) <> '1981'; --2.����ѯ

--���ɶԱȽ�
1.��ѯ����1981����ְ�ġ����⡿һ��Ա���ġ����Ż�ְλ��ͬ��Ա�����������š�ְλ����ְ����,������1981����ְԱ����
select distinct deptno from emp where extract(year from hiredate) = '1981';          --1.1981����ְ��Ա���Ĳ���
select distinct job from emp where extract(year from hiredate) = '1981';             --2.1981����ְ��Ա����ְλ

select *
  from emp
 where (deptno in (select distinct deptno from emp where extract(year from hiredate) = '1981')
    or job in (select distinct job from emp where extract(year from hiredate) = '1981'))
   and extract(year from hiredate) <> '1981';

--�Ӳ�ѯ�е�nullֵ
1.��ѯ�Ǿ����Ա������������
select distinct mgr from emp;                                   --1.��ѯ��Щ���Ǿ���  null,7839,7782,7698,7902,7788,7566
select * from emp where empno in(select distinct mgr from emp); -- 2.����ѯ

2.��ѯ���Ǿ����Ա������
select distinct mgr from emp where mgr is not null;             --1.��ѯ��Щ���Ǿ���  7839,7782,7698,7902,7788,7566
select * from emp where empno not in(select distinct mgr from emp where mgr is not null);--2.����ѯ

--��from�Ӿ���ʹ���Ӳ�ѯ
1.��ѯ���Լ�����ƽ�����ʸߵ�Ա�����������ʣ����ű�ţ�����ƽ������
select deptno,avg(sal) from emp group by deptno;--1.����ƽ������
select e.ename,e.sal,e.deptno,s.avgsal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s where e.deptno = s.deptno and e.sal > s.avgsal;

--��ϰ
1.��ѯ���Լ�ְλƽ�����ʸߵ�Ա��������ְλ���������ƣ�ְλƽ������
select job,avg(sal) avgsal from emp group by job;--1.ְλƽ������

select e.ename,e.job,d.dname,s.avgsal
  from emp e, dept d, (select job, avg(sal) avgsal from emp group by job) s
 where e.deptno = d.deptno
   and e.job = s.job
   and e.sal > s.avgsal;
   
--rownum:α��,��Զ��1��ʼ
--     ע�⣺ rownumֻ��ִ��<��<=���㣬����ִ��>��>=��һ����������Between..And��

--TOP-N��ѯ
1.��ѯ������ߵ�����Ա������Ϣ
select rownum,e1.* from (select emp.* from emp where sal is not null order by sal desc) e1 where rownum <= 3;

2.��ѯ������͵�����Ա������Ϣ
select rownum,e1.* from (select emp.* from emp where sal is not null order by sal) e1 where rownum <= 3;


--���ݿ��ҳ
����ÿҳ��ʾ5��
1  1-5
2  6-10
3  11-15
4  16-20

��ʼ�±꣺ÿҳ��ʾ���� * ��ǰҳ��-(ÿҳ��ʾ����-1)= ÿҳ��ʾ����*��ǰҳ��-ÿҳ��ʾ����+1=(��ǰҳ��-1)*ÿҳ��ʾ���� + 1
�����±꣺ÿҳ��ʾ���� * ��ǰҳ��

1.��ѯ��һҳ����
select rownum,e.* from emp e where rownum <= 5;

2.��ѯ�ڶ�ҳ����
select e1.* from (select rownum rn,e.* from emp e where rownum <= 10) e1 where e1.rn >= 6; --Ч�ʸߣ�����ѯ10��
select e1.* from (select rownum rn,e.* from emp e) e1 where e1.rn <= 10 and e1.rn >= 6;    --Ч�ʵͣ���Զ��ѯ��������

3.��ѯ����ҳ����
select e1.* from (select rownum rn,e.* from emp e where rownum <= 15) e1 where e1.rn >= 11;
select e1.* from (select rownum rn,e.* from emp e) e1 where e1.rn <= 15 and e1.rn >= 11;

--���õ�SQL��ҳ��ѯ���
select e1.* from (select rownum rn,e.* from emp e where rownum <= &end) e1 where e1.rn >= &begin;

select e1.* from (select rownum rn,e.* from emp e where rownum <= (ÿҳ��ʾ���� * ��ǰҳ��)) e1 where e1.rn >= (��ǰҳ��-1)*ÿҳ��ʾ���� + 1);
select e1.* from (select rownum rn,e.* from emp e) e1 where e1.rn <=(ÿҳ��ʾ���� * ��ǰҳ��) and e1.rn >= (��ǰҳ��-1)*ÿҳ��ʾ���� + 1);

--���ݷ�ҳǰ��������
1.������ְ���ڽ���������ٷ�ҳ
select *
  from (select rownum rn, e1.*
          from (select emp.* from emp order by hiredate desc) e1
         where rownum <= 10) e2
 where e2.rn >= 6;
 
--��ϰ
1.����ÿҳ��ʾ5����¼���ֱ��ѯ������ߵĵ�1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ����ʡ�
select *
  from (select rownum rn, e2.*
          from (select * from emp order by sal desc) e2,dept d
         where e2.deptno = d.deptno and rownum <= 10) e3
 where rn >= 6;


select *
  from (select rownum rn, e2.*
          from (select * from emp order by sal desc) e2
         where rownum <= 10) e3,
       dept d
 where e3.deptno = d.deptno
   and rn >= 6;

select *
  from (select rownum rn, e2.*
          from (select e.*, d.dname,d.loc
                  from emp e, dept d
                 where e.deptno = d.deptno
                 order by sal desc) e2
         where rownum <= 10) e3
 where rn >= 6;


--��ϰ
14. �г�������һ����Ա�����в���
--�������
select deptno,count(empno) from emp group by deptno having count(empno) >= 1;--�������

--Ƕ���Ӳ�ѯ
select deptno,count(empno) from emp group by deptno;--1.��ѯ��������
select * from (select deptno,count(empno) ecount from emp group by deptno) d where d.ecount >= 1;--2.����ѯ

select deptno,count(empno) from emp group by deptno;--1.��ѯ��������
select * from dept d,(select deptno,count(empno) ecount from emp group by deptno) c where d.deptno = c.deptno(+) and c.ecount >=1;--2.����ѯ

--����Ӳ�ѯ
select * from dept where exists (select * from emp where deptno= dept.deptno);--1.����Ӳ�ѯ

24. ��ʾÿλ�������Ա������͹��ʣ�����͹����ߵ�����
select mgr,min(sal) from emp group by mgr;--1.ÿλ�������Ա������͹���
select * from emp e,(select mgr,min(sal) minsal from emp group by mgr) s where e.mgr = s.mgr and e.sal = s.minsal;--2.����ѯ

25. ��ʾ�ȹ�����ߵ�Ա���μӹ���ʱ�����Ա���������μӹ���ʱ��
select max(sal) from emp;                                       --1.��ߵĹ���   5000
select hiredate from emp where sal = (select max(sal) from emp);--2.�鹤����ߵ�Ա���Ĳμӹ�����ʱ��  1981/11/17
select * from emp where hiredate > (select hiredate from emp where sal = (select max(sal) from emp));--3.����ѯ

26. ��ʾ��ƽ��������ߵĵĲ���ƽ�����ʼ���������
select deptno,avg(sal) from emp group by deptno; --1.����ƽ������
select max(avg(sal)) from emp group by deptno; --1.���ŵ����ƽ������---����  2916.66666666667

select e.deptno, d.dname, avg(e.sal) avgsal
  from emp e, dept d
 where e.deptno = d.deptno
 group by e.deptno, d.dname
having avg(e.sal) = (select max(avg(sal)) from emp group by deptno); --2.����ѯ

--����rownumʵ��
select *
  from (select e.deptno, d.dname, avg(e.sal) avgsal
          from emp e, dept d
         where e.deptno = d.deptno
         group by e.deptno, d.dname
         order by avgsal desc) e
 where rownum = 1;


