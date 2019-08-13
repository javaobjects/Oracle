-- ## ��ϰ1
-- 1. ����һ����ͼ��ͨ������ͼ���Բ�ѯ��������2000-5000�ڲ��������а�����A��Ա����ţ����������ʡ�
create or replace view viewSal2k_5k
       as select empno,ename,sal from emp
       where sal between 2000 and 5000
       and ename like '%A%';

-- 2. ͨ��������������ͼ��ѯ����

select * from viewSal2k_5k;

-- ## ��ϰ2

-- 1. ����һ����ͼ��ͨ������ͼ���Բ�ѯ��������NEW YORK��CHICAGO��Ա����ţ����������ű�ţ���ְ���ڡ�
create or replace view viewLoc_NY_CA
as select empno,ename,dept.deptno,hiredate
          from emp,dept
          where emp.deptno = dept.deptno
          and loc in ('NEW YORK','CHICAGO');

select * from viewLoc_NY_CA;


-- 2. ����һ����ͼ��ͨ������ͼ���Բ�ѯ��ÿ�����ŵĲ������Ƽ���͹��ʡ�

create or replace view viewMinSalbydname
as select dname,min(sal) minSalbydname
   from emp,dept
   where emp.deptno(+) = dept.deptno
   group by dept.dname;
select * from viewMinSalbydname;

-- 3. ͨ��������ͼ����ѯÿ�����Ź�����͵�Ա����������������

select ename,viewMinSalbydname.dname
from emp,dept,viewMinSalbydname
where emp.deptno = dept.deptno
and dept.dname = viewMinSalbydname.dname
and emp.sal = viewMinSalbydname.minSalbydname;


-- ## �κ���ҵ

-- 1. ������ͼv_emp_20������20�Ų��ŵ�Ա����ţ���������н��(��н=12*(����+���𣩣�
create or replace view v_emp_20
as select empno,ename,12 * (nvl(sal,0) + nvl(comm,0)) ��н
from emp where deptno in 20;

select * from v_emp_20;

-- 2. ����ͼv_emp_20�в�ѯ��н����1��ԪԱ������Ϣ��

select * from v_emp_20
where ��н > 10000;

-- 3. ��Ϊ���ʴ���2000��Ա��������ͼ��Ҫ����ʾԱ���Ĳ�����Ϣ��ְλ��Ϣ�������ص㣻

create or replace view v_sal2000M
as select dname,job,loc
   from emp,dept
   where emp.deptno = dept.deptno
   and sal > 2000;
select * from v_sal2000M;
-- 4. ���������ͼִ��insert,update,delete,����ܷ�ɹ���Ϊʲô��

insert into v_sal2000M values('aaa','bbb','ccc'); -- error �޷��޸���Ǽ�ֵ������Ӧ����




