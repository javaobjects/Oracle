-------------------��ʮһ��  ���ݲ������������----------------------

--DML���ݲ�������

--���������ݣ�insert into ...values��

--û����ʽָ��������һ���У�Ĭ����Ҫ���ǲ���ȫ����������
insert into emp values(7777,'clearlove','player',8888,sysdate,1000,5000,20);

--����������������
insert into emp values(7777,'clearlove','player',8888,to_date('2019/4/2','YYYY/MM/DD'),1000,5000,20);

--����в���ָ����(û��ָ�����У���Ĭ��Ϊ��ֵ)
insert into emp(empno,ename) values(7777,'clearlove');

1.���ű�����һ�����ţ����ű��Ϊ50����������ΪHR�������ص�ΪSY��
2.���ű�����һ�����ţ����ű��Ϊ60����������ΪMARKET��
1.��Ա����������һ��Ա����Ա�����Ϊ8888������ΪBOB����λΪCLERK������Ϊ��7788��
   ��ְ����Ϊ1985-03-03��н��3000������Ͳ���Ϊ�ա�
   
   
--�����������
--�ؼ�����values�Ӿ�����һ���Ӳ�ѯ������

--����manager��(���ڱ���ְλΪmanager��Ա����Ϣ)
CREATE TABLE manager AS
SELECT * FROM emp WHERE 1=0;

--��manager���в���ְλΪMANAGER�ļ�¼
insert into manager (select * from emp where job = 'MANAGER');
select * from manager;

--��ϰ
--1.ʹ��CREATE TABLE emp_back as SELECT * FROM EMP WHERE 1=0������emp_back��,�����������ɡ�
CREATE TABLE emp_back as SELECT * FROM EMP WHERE 1=0;
select * from emp_back;

--2.��emp������ְ���ڴ���1982��1��1��֮ǰ��Ա����Ϣ���Ƶ�emp_back���С�
insert into emp_back (select * from emp where hiredate > '01-1��-82');


--�޸�����(update) 
--��Ա�����Ϊ7782�Ĳ��ű���޸�Ϊ20
update emp
set deptno = 20
where empno = 7782;

--���Ҫ�޸����м�¼��WHERE�Ӿ���Ժ���
update emp
set sal = 10000;

--�޸Ķ���ֵ
--��Ա�����Ϊ7782�Ĳ��ű���޸�Ϊ20,���ҹ�������Ϊ5000;
update emp
set deptno = 20,sal = 5000
where empno = 7782;

--�޸�ʱ��������Լ��
--��Ա�����Ϊ7782�Ĳ��ű���޸�Ϊ50
update emp
set deptno = 50
where empno = 7782;    --Υ��������Լ��


--���update����update��ʹ������Ӳ�ѯ��
--��emp��������һ����dname, ���洢��������
ALTER TABLE emp ADD(dname VARCHAR2(14));

--ʹ������Ӳ�ѯ����dname��Ϊ��ȷ�Ĳ�������
update emp e
set dname = (select dname from dept where deptno = e.deptno);


--***��ȷ��update��һ��������whereȷ���޸���һ�����ݣ�����set�������Ӧ�����޸�Ϊʲôֵ****

--1.�޸Ĳ���20��Ա����Ϣ����82��֮����ְ��Ա����ְ����������10��
update emp
set hiredate = hiredate + 10
where deptno = 20 and hiredate > '01-1��-82';

--2.�޸Ľ���Ϊnull��Ա������������Ϊ0
update emp
set comm = 0
where comm is null;

--3.�޸Ĺ����ص���NEW YORK��CHICAGO��Ա�����ʣ���������500
update emp
set sal = sal + 500
where deptno in (select deptno from dept where loc in('NEW YORK','CHICAGO'));

update emp e 
set sal=sal+490 
where (select loc from dept where deptno=e.deptno) in('NEW YOKE','CHICAGO');


--ɾ������(delete)  ɾ��ָ��������
--ɾ��ְλ��CLERK��Ա����¼
delete from emp
where job = 'CLERK';

--ɾ���������ȫ������(���ڣ�ֻ������û��)
delete from emp;

--ɾ������SALES��Ա����¼
delete from emp
where deptno = (select deptno from dept where dname = 'SALES');

--���delete����ɾ����ʱ��ʹ������Ӳ�ѯ��
--ɾ������������ְ��Ա����¼
delete from emp e
where (select count(*) from emp_jobhistory where empno = e.empno) >0;

1.ɾ��������Ϊ7566��Ա����¼
2.ɾ��������NEW YORK��Ա����¼
--3.ɾ�����ʴ������ڲ���ƽ�����ʵ�Ա����¼
delete from emp e
where sal > (select avg(sal) from emp where deptno = e.deptno);

commit;


--�������
--�������ɣ���һ��DQL��ѯ��������һ��DML���ݲ���������һ��TPL,DDL,DCL��

--���ñ����ع���ָ����λ��
insert into emp(empno,ename) values(7778,'1');
insert into emp(empno,ename) values(7779,'1');
savepoint s1;
insert into emp(empno,ename) values(7780,'1');
insert into emp(empno,ename) values(7781,'1');
rollback to s1;


--�м���
delete from emp where empno = 7839;

--����(������û���ĳ�����������������ʱ�򣬸ñ�ı�ṹ���ܱ��ı�)


create table student (        --ѧ����
      xh char(4),--ѧ��
      xm varchar2(10),--����
      sex char(4),--�Ա�
      birthday date,--��������
      sal number(7,2), --��ѧ��
      studentcid number(2) --ѧ���༶��
)

Create table class (   --�༶��
			classid number(2), --�༶���
			cname varchar2(20),--�༶����
  			ccount  number(3) --�༶����
)

��1����������༶��ϢΪ��1��JAVA1�࣬null
                         2��JAVA2�࣬null
                         3��JAVA3�࣬null
insert into class values(1,'JAVA1��',null);
insert into class values(2,'JAVA2��',null);
insert into class values(3,'JAVA3��',null);

��2�����ѧ����Ϣ���£���A001��,��������,���С�,��01-5��-05��,100,1


insert into student values('A001','����','��','01-5��-05',100,1);

��3�����ѧ����Ϣ���£�'A002','MIKE','��','1905-05-06',10
insert into student values('A002','mike','��',to_date('1905-05-06','yyyy/mm/dd'),100,1);


��4�����벿��ѧ����Ϣ�� 'A003','JOHN','Ů��;
insert into student (xh,xm,sex) values('A003','JOHN','Ů');

��5����A001ѧ���Ա��޸�Ϊ'Ů��
update student 
set sex='Ů'
where xh='A001';

��6����A001ѧ����Ϣ�޸����£��Ա�Ϊ�У���������Ϊ1980-04-01
update student
set birthday='01-4��-80',sex='��'
where xh='A001';

��7��������Ϊ�յ�ѧ���༶�޸�ΪJava3��
update student
set studentcid=3
where birthday is null;

��8����ʹ��һ��SQL��䣬ʹ���Ӳ�ѯ�����°༶����ÿ���༶�������ֶ�
update class c
set ccount = (select count(*) from student where studentcid = c.classid);


select * from student;
select * from  class




select * from emp;
select * from emp_jobhistory;
select * from emp; 
select * from dept;  
