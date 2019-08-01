---------------------------------�������--------------------------

--------------------------Oracle���е������﷨--------------------------
--ע������
--N��������ʱ��������ҪN��1����������
--����ڶ�����г�����ͬ������������Ҫʹ�ñ�����Ϊ���Ըñ��������ǰ׺

--�ѿ�����(�õ�n*m�Ľ����)
select * from emp,dept;

--��ֵ����(�ڵѿ������õ��ı���ѡ�����Ӧ����)
select * from emp,dept where emp.deptno = dept.deptno;

--дһ����ѯ��䣬��ѯԱ���������������ơ������ص�
select ename,dname,loc from emp,dept where emp.deptno = dept.deptno;

--дһ����ѯ��䣬��ѯԱ���������������ơ������ص� ���ҹ��ʴ���2000��Ա��
--���Ҫ����������������ʱ����and������
select ename,dname,loc,sal from emp,dept where emp.deptno = dept.deptno and sal > 2000;

--�����ñ���������е�ǰ׺
select ename,dname,loc,sal from emp e,dept d where e.deptno = d.deptno and sal > 2000;

--1.дһ����ѯ����ʾ����Ա�����������ű�ţ��������ơ�
select ename,e.deptno,dname from emp e,dept d where e.deptno = d.deptno

--2.дһ����ѯ����ʾ���й�����CHICAGO���ҽ���Ϊ�յ�Ա�������������ص㣬����
select ename,loc,comm from emp e,dept d where  e.deptno = d.deptno and loc = 'CHICAGO' and comm is not null;


--3.дһ����ѯ����ʾ���������к���A�ַ���Ա�������������ص㡣
select ename,loc from emp e,dept d where e.deptno = d.deptno and ename like '%A%';


--�ǵ�ֵ����
--��ѯÿ��Ա�������������ʣ����ʵȼ�
select ename,sal,grade from emp e,salgrade g where e.sal between g.losal and g.hisal; 


--1.��ѯÿ��Ա���ı�ţ����������ʣ����ʵȼ������ڹ������У����չ��ʵȼ�������������
select empno,ename,sal,grade,loc,grade from emp e,dept d,salgrade g 
where sal between losal and hisal and e.deptno = d.deptno 
order by g.grade;

--�ⲿ����(+)
--(+)д������������
--(+)���ڵ�һ��Ϊ�ӱ��ӱ�����ݿ��Բ���ʾ����+������һ��Ϊ�������������һ��Ҫ��ʾ
select * from emp e,dept d where e.deptno = d.deptno;

--��ѯ���й�Ա���������ű�ţ��������ƣ�����û��Ա���Ĳ���ҲҪ��ʾ����
select * from emp e,dept d where e.deptno(+) = d.deptno;

--��������
--��ѯÿ��Ա����������ֱ���ϼ�����
select e.ename,m.ename from emp e,emp m where e.mgr = m.empno;

--1.��ѯ���й�����NEW YORK��CHICAGO��Ա��������Ա����ţ��Լ����ǵľ��������������š�
select e.ename,e.empno,m.ename,m.empno from emp e,emp m,dept d 
where e.mgr = m.empno and e.deptno = d.deptno and loc in('NEW YORK','CHICAGO');

--2.����һ��Ļ����ϣ����û�о����Ա��King��������Ա���������(Ա����������)
select e.ename,e.empno,m.ename,m.empno from emp e,emp m,dept d 
where e.mgr = m.empno(+) and e.deptno = d.deptno and loc in('NEW YORK','CHICAGO')
order by e.empno;

--3.��ѯ����Ա����ţ��������������ƣ�����û�в��ŵ�Ա��ҲҪ��ʾ������(Ա��������)
select empno,ename,dname from emp e,dept d where e.deptno = d.deptno(+);


--------------------------SQL99��׼�������﷨--------------------------
--ʹ�����������ݿ�

--��������(�ѿ�����)  cross join
select * from emp cross join dept;

--��Ȼ����  natural join
--��Ȼ�����Ƕ�������֮����ͬ���ֺ��������͵����Զ����еĵ�ֵ����
--�����ӵ��Ǹ����ŵ���һ��,��һ�а�����������
select * from emp natural join dept;

--using�Ӿ�����ֵ����
--�ֶ����natural join
select * from emp join dept using(deptno);

--on�Ӿ�
--�ɶ��Խϸߣ��Ƽ�ʹ��(������ӵı��������������Ҫ�ظ�����дһ��join �� on)
select * from emp e join dept d on(e.deptno = d.deptno) join salgrade s on(e.sal between s.losal and s.hisal);

--�������� left outer join�����Ϊ����
--���ȫ��Ա����Ϣ������û��Ա���Ĳ���ҲҪ���
select * from dept d left outer join emp e on(e.deptno = d.deptno);

--�������� right outer join���ұ�Ϊ����
--���ȫ��Ա����Ϣ������û��Ա���Ĳ���ҲҪ���
select * from emp e right outer join dept d on(e.deptno = d.deptno);

--ȫ������ full outer join
--û��Ա���Ĳ��Ż�����û�в��ŵ�Ա�����ᱻ���
select * from emp e full outer join dept d on(e.deptno = d.deptno);


--1.����һ��Ա����Ͳ��ű�Ľ������ӡ�
select * from emp cross join dept;

--2.ʹ����Ȼ���ӣ���ʾ��ְ������80��5��1��֮���Ա���������������ƣ���ְ����
select ename,dname,hiredate from emp natural join dept where hiredate > '01-5��-80';

--3.ʹ��USING�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص�
select ename,dname,loc from emp join dept using(deptno) where loc = 'CHICAGO';

--4.ʹ��ON�Ӿ䣬��ʾ������CHICAGO��Ա���������������ƣ������ص㣬н�ʵȼ�
select ename,dname,loc,grade
from emp e join dept d on(e.deptno = d.deptno) join salgrade s on(e.sal between s.losal and s.hisal)    
where loc = 'CHICAGO';


--5.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������
select e.ename,m.ename from emp e left outer join emp m on(e.mgr = m.empno);


--6.ʹ�������ӣ���ѯÿ��Ա��������������������û�о����KingҲҪ��ʾ������
select e.ename,m.ename from emp m right outer join emp e on(e.mgr = m.empno);


--1.��ʾԱ��SMITH���������������ƣ�ֱ���ϼ�����
select e.ename,dname,m.ename from emp e,emp m,dept d
where e.mgr = m.empno and e.deptno = d.deptno and e.ename = 'SMITH';

--2.��ʾԱ���������������ƣ����ʣ����ʼ���Ҫ���ʼ������4����
select e.ename,d.dname,e.sal,s.grade from emp e,dept d,salgrade s 
where e.deptno = d.deptno and e.sal between s.losal and s.hisal and grade > 4;

--3.��ʾԱ��KING��FORD�����Ա���������侭��������
select e.ename,m.ename from emp e,emp m where e.mgr = m.empno and m.ename in('KING','FORD');

--4.��ʾԱ���������μӹ���ʱ�䣬���������μӹ���ʱ�䣬Ҫ��μ�ʱ��Ⱦ����硣
select e.ename,e.hiredate,m.ename,m.hiredate from emp e,emp m where e.mgr = m.empno and e.hiredate < m.hiredate;






select * from emp;
select * from dept;
select * from salgrade;
