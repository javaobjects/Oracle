----------------------������  �Ӳ�ѯ-----------------------

--�Ӳ�ѯ���Ե���ִ��

--�����Ӳ�ѯ���Ӳ�ѯֻ����һ�����ݣ�
--��ѯ����JONES�Ĺ�Ա���ʸߵ�������Ա
select sal from emp where ename = 'JONES';
select * from emp where sal > (select sal from emp where ename = 'JONES');

--��ʾ   �͹�Ա7369������ͬ����  ����  ���ʴ��ڹ�Ա7876  �Ĺ�Ա��  �����͹�����
select job from emp where empno = 7369;   --CLERK
select sal from emp where empno = 7876;   --1100

select * from emp 
where job = (select job from emp where empno = 7369) 
  and sal > (select sal from emp where empno = 7876);
  
--�Ӳ�ѯ��ʹ���麯��
--��ѯ������͵�Ա����������λ������
select min(sal) from emp;
select ename,job,sal from emp where sal = (select min(sal) from emp);

--HAVING�Ӿ���ʹ���Ӳ�ѯ
--��ѯ������͹��ʱ�  20������͹��ʸ�  ��   ���ű�ż���͹���
select min(sal) from emp where deptno = 20;  --�Ӳ�ѯ  800
select deptno,min(sal) from emp 
group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 20);

--��ѯ�ĸ����ŵ�Ա������ ���� ������ƽ��������
select avg(count(*)) from emp group by deptno;  --4.666667
select deptno,count(*) from emp 
group by deptno 
having count(*) > (select avg(count(*)) from emp group by deptno);


--1.��ѯ��ְ���������Ա����������ְ����
select min(hiredate) from emp;   --1980/12/17
select ename,hiredate from emp where hiredate = (select min(hiredate) from emp);

--2.��ѯ���ʱ�SMITH���ʸ߲��ҹ����ص���CHICAGO��Ա�����������ʣ���������
select sal from emp where ename = 'SMITH';
select * from emp e,dept d 
where e.deptno = d.deptno and sal > (select sal from emp where ename = 'SMITH') and loc = 'CHICAGO';

--3.��ѯ��ְ���ڱ�20������ְ���������Ա����Ҫ���Ա����������ְ����
select min(hiredate) from emp where deptno = 30;
select ename,hiredate from emp where hiredate < (select min(hiredate) from emp where deptno = 30);

--4.��ѯ���������������в���ƽ�������ĵĲ��ű�ţ��������ƣ���������
select avg(count(*)) from emp group by deptno;
select e.deptno,dname,count(*) from emp e,dept d
where e.deptno = d.deptno 
group by e.deptno,dname having count(*) > (select avg(count(*)) from emp group by deptno);



--�����Ӳ�ѯ(�Ӳ�ѯ���ض�������)
--in�����
--��ѯ�Ǿ����Ա������������
select ename,sal from emp where empno in(select mgr from emp);

--any�����
--��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10��������һ��Ա�����ʸߵ�  Ա����ţ�������ְλ������
--����һ
select sal from emp where deptno = 10;
select * from emp where deptno <> 10 and sal >any (select sal from emp where deptno = 10);

--������
select min(sal) from emp where deptno = 10;
select * from emp where deptno <> 10 and sal > (select min(sal) from emp where deptno = 10);

--all�����
--��ѯ���ű�Ų�Ϊ10���ҹ��ʱ�10��������Ա�����ʵ͵�Ա����ţ�������ְλ������
select sal from emp where deptno = 10;
select * from emp where deptno <> 10 and sal <all (select sal from emp where deptno = 10);



--1.��ѯ��ְ���ڱ�10��������һ��Ա�����Ա����������ְ���ڣ�������10����Ա��
select hiredate from emp where deptno = 10;
select ename,hiredate from emp where hiredate >any (select hiredate from emp where deptno = 10) and deptno <> 10;

--2.��ѯ��ְ���ڱ�10��������Ա�����Ա����������ְ���ڣ�������10����Ա��
select ename,hiredate from emp where hiredate >all (select hiredate from emp where deptno = 10) and deptno <> 10;

--3.��ѯְλ��10��������һ��Ա��ְλ��ͬ��Ա��������ְλ��������10����Ա��
select job from emp where deptno = 10;
select ename,job from emp where job in(select job from emp where deptno = 10) and deptno <> 10;


--�����Ӳ�ѯ
--�ɶԱȽ�
--��ѯ����1981����ְ������һ��Ա���Ĳ��ź�ְλ��ȫ��ͬ  Ա�����������š�ְλ����ְ����,������1981����ְԱ����
select deptno,job from emp where to_char(hiredate,'YYYY') = '1981';

select ename,deptno,job,hiredate 
from emp 
where (deptno,job) in (select deptno,job from emp where to_char(hiredate,'YYYY') = '1981')
                          and to_char(hiredate,'YYYY') <> '1981';
                          
--�ǳɶԱȽ�
--��ѯ����1981����ְ������һ��Ա���Ĳ��Ż�ְλ��ͬԱ�����������š�ְλ����ְ����,������1981����ְԱ��
select deptno from emp where to_char(hiredate,'YYYY') = '1981';
select job from emp where to_char(hiredate,'YYYY') = '1981';

select ename,deptno,job,hiredate 
from emp where (job in(select job from emp where to_char(hiredate,'YYYY') = '1981')
                  or deptno in(select deptno from emp where to_char(hiredate,'YYYY') = '1981'))
                  and to_char(hiredate,'YYYY') <> '1981';
                  
                  
                  
--1.��ѯְλ�������10��������һ��Ա��ְλ��������ͬ��Ա��������ְλ��������10����Ա��
select job,mgr from emp where deptno = 10;
select ename,job from emp where (job,mgr) in (select job,mgr from emp where deptno = 10) and deptno <> 10;


--2.��ѯְλ�������10��������һ��Ա��ְλ������ͬ��Ա��������ְλ��������10����Ա��
select job from emp where deptno = 10;
select mgr from emp where deptno = 10;
select ename,job from emp where (job in (select job from emp where deptno = 10) 
                                or mgr in(select mgr from emp where deptno = 10))
                                and deptno <> 10;

--�Ӳ�ѯ�еĿ�ֵ                                
--��ѯ���Ǿ����Ա������
--not in��������Ӳ�ѯ�п�ֵ��ʱ����Ҫ������Ӧ�Ĵ���
select ename from emp where empno not in (select mgr from emp where mgr is not null);

--�� FROM �Ӿ���ʹ���Ӳ�ѯ(���Ӳ�ѯ�еĽ��������һ����)
--��ѯ���Լ�����ƽ�����ʸߵ�Ա�����������ʣ����ű�ţ�����ƽ������
select deptno,avg(sal) from emp group by deptno;

select ename,sal,e.deptno,avgsal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > avgsal;

--1.��ѯ���Լ�ְλƽ�����ʸߵ�Ա��������ְλ���������ƣ�ְλƽ������
select job,avg(sal) from emp group by job;

select ename,e.job,dname,avgsal from emp e,(select job,avg(sal) avgsal from emp group by job) s,dept d
where  e.job = s.job and e.deptno = d.deptno and e.sal > s.avgsal;


--2.��ѯְλ�;���ͬԱ��SCOTT��BLAKE��ȫ��ͬ��Ա��������ְλ��������SCOOT��BLAKE���ˡ�
select job,mgr from emp where ename in('SCOTT','BLAKE');
select ename,job from emp where (job,mgr) in (select job,mgr from emp where ename in('SCOTT','BLAKE'))
                                  and ename not in('SCOTT','BLAKE');

--3.��ѯ���Ǿ����Ա��������
select ename from emp where empno not in (select mgr from emp where mgr is not null);


--��ҳ��ѯ
--rownumα�У��������κ�һ�����У�������������Ӳ�ѯ�ĳ����ı�����һ��Ĭ�ϵ�rownumα�У�
select rownum,emp.* from emp;

--�ҳ�emp����ǰ5������
select rownum,emp.* from emp where rownum <=5;

--�ҳ�6��10������(rownum��whereȥɸѡ���ݵ�ʱ��ᶯ̬�仯�����Բ���ʹ��>,>=,between...and���ж�rownum������)
select rownum,emp.* from emp where rownum >=6;    --error

--TOP-N��ѯ
--�ҳ�emp���й���ǰ5�ߵ�Ա��
select rownum,emp.* from emp where rownum <=5  order by sal desc;   --error  ��������rownum��ɸѡ��Ȼ��������
select emp.* from emp order by sal desc;
select rownum,e.* from (select emp.* from emp order by sal desc) e where rownum <=5;


--�򵥵�û�����ҳ��ѯ
--���emp���еڶ�ҳ��6-10�У�������
select rownum rn,emp.* from emp where rownum <=10;
select * from (select rownum rn,emp.* from emp where rownum <=10) where rn >= 6;

--���emp���е���ҳ��11-15�У�������
select rownum rn,emp.* from emp where rownum <=15;
select * from (select rownum rn,emp.* from emp where rownum <=15) where rn >= 11;

--���������ݵķ�ҳ��ѯ
--��ѯ��������ߵ�Ա���ĵ�һҳ���ݣ�һҳ��5�У�
select * from emp order by sal desc;
select rownum,s.* from (select * from emp order by sal desc) s where rownum <=5;

--��ѯ��������ߵ�Ա���ĵڶ�ҳ���ݣ�һҳ��5�У�
select rownum rn,s.* from (select * from emp order by sal desc) s where rownum <=10
select * from (select rownum rn,s.* from (select * from emp order by sal desc) s where rownum <=10) where rn >=6;


--1.����ÿҳ��ʾ5����¼���ֱ��ѯ��1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ�
--��һҳ
select rownum,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <=5;

--�ڶ�ҳ
select rownum rn,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <= 10  --ǰʮ������
select * from (select rownum rn,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <= 10)
where rn >= 6 ;

--����ҳ
select * from (select rownum rn,ename,hiredate,dname from emp e,dept d where e.deptno = d.deptno and rownum <= 15)
where rn >= 11 ;


--2.����ÿҳ��ʾ5����¼���ֱ��ѯ������ߵĵ�1ҳ����2ҳ����3ҳ��Ϣ��Ҫ����ʾԱ����������ְ���ڡ��������ơ����ʡ�
select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc ;  --��Ҫ��ҳ������
select rownum,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=5;   --��һҳ

--�ڶ�ҳ
select rownum,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=10;   --ǰʮ������

select * from (select rownum rn,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=10) where rn >= 6;


--����ҳ
select * from (select rownum rn,s.* 
from (select ename,hiredate,dname,sal from emp e,dept d where e.deptno = d.deptno order by sal desc) s
where rownum <=15) where rn >= 11;





--2.��ѯ������ߵ�Ա�������͹��ʡ�
select max(sal) from emp;
select ename,sal from emp where sal = (select max(sal) from emp);

--3. ��ѯ������͹��ʸ���10�Ų�����͹��ʵĲ��ŵı�š����Ƽ�������͹��ʡ�
select min(sal) from emp where deptno = 10;
select e.deptno,dname,min(sal) from emp e,dept d 
where e.deptno = d.deptno 
group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 10);

--10.дһ����ѯ��ʾ���ϼ��쵼��KING��Ա������������
select empno from emp m where ename = 'KING';
select ename,sal from emp where mgr = (select empno from emp m where ename = 'KING');

--13.��ѯ�����Լ�����ƽ�����ʵ�Ա�����������ʣ����ڲ���ƽ�����ʣ����ڲ���ƽ�����ʵĶ��
select deptno,avg(sal) from emp group by deptno;
select * from emp;
select ename,sal,avgsal,(sal - avgsal) "���"
from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > s.avgsal;

--19. ��ʾÿ�����ŵ���߹��ʵ�Ա��
select deptno,max(sal) from emp group by deptno;
select * from emp;
select * from emp e,(select deptno,max(sal) maxsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal = s.maxsal;


--23. ��ʾ�����ʴ��ڱ�����ƽ�����ʵ�Ա������������
select deptno,avg(sal) from emp group by deptno;
select ename,sal from emp e,(select deptno,avg(sal) avgsal from emp group by deptno) s 
where e.deptno = s.deptno and e.sal > s.avgsal;


--25. ��ʾ�ȹ�����ߵ�Ա���μӹ���ʱ�����Ա���������μӹ���ʱ��
select max(sal) from emp;
select hiredate from emp where sal = (select max(sal) from emp);
select ename,hiredate from emp where hiredate > (select hiredate from emp where sal = (select max(sal) from emp));


--26. ��ʾ��ƽ��������ߵĵĲ���ƽ�����ʼ���������
select dname,avg(sal) from emp e,dept d where e.deptno = d.deptno group by dname;
select max(avg(sal)) from emp group by deptno;

--����һ
select * from (select dname,avg(sal) avgsal from emp e,dept d where e.deptno = d.deptno group by dname)
where avgsal = (select max(avg(sal)) from emp group by deptno);

--������
select dname,avg(sal)  from emp e,dept d 
where e.deptno = d.deptno 
group by dname 
having avg(sal) =(select max(avg(sal)) from emp group by deptno);

--������
select dname,avg(sal)  avgsal from emp e,dept d 
where e.deptno = d.deptno 
group by dname order by avgsal desc;

select rownum,s.* from (select dname,avg(sal)  avgsal from emp e,dept d 
where e.deptno = d.deptno 
group by dname order by avgsal desc) s where rownum <=1;
 



 

select * from emp;
select * from dept;
