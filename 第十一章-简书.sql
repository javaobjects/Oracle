--## ��ϰ1

--1. ���ű�����һ�����ţ����ű��Ϊ50����������ΪHR�������ص�ΪSY��
insert into dept(deptno,dname,loc)
       values(50,'HR','SY');

--2. ���ű�����һ�����ţ����ű��Ϊ60����������ΪMARKET��
insert into dept(deptno,dname)
       values(60,'MARKET');

--## ��ϰ2

--1. ��Ա����������һ��Ա����Ա�����Ϊ8888������ΪBOB����λΪCLERK������Ϊ��7788��
--��ְ����Ϊ1985-03-03��н��3000������Ͳ���Ϊ�ա�
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
            values(8888,'BOB','CLERK',7788
            ,to_date('1985-03-03','yyyy/mm/dd'),3000,null,null);

--## ��ϰ3

--1. ʹ��CREATE TABLE emp_back as  SELECT * FROM EMP WHERE 1=0������emp_back��,�����������ɡ�
create table emp_back
as select * from emp where 1 = 0;

--2. ��emp������ְ���ڴ���1982��1��1��֮ǰ��Ա����Ϣ���Ƶ�emp_back���С�
insert into emp_back
            select * 
            from emp
            where hiredate > '01-1��-82';

--## ��ϰ4

--1. �޸Ĳ���20��Ա����Ϣ����82��֮����ְ��Ա����ְ����������10��
select * from emp_back;

update emp_back
set hiredate = hiredate + 10
where deptno in 20
and hiredate > '01-1��-82';

select * from emp_back;

--2. �޸Ľ���Ϊnull��Ա������������Ϊ0
select * from emp_back;

update emp_back
set comm = 0
where comm is null;

select * from emp_back;

--3. �޸Ĺ����ص���NEW YORK��CHICAGO��Ա�����ʣ���������500
select * from emp_back;

update emp_back
set sal = sal + 500
where (select loc
              from dept
              where dept.deptno = emp_back.deptno)
              in ('NEW YORK','CHICAGO'); 
              
select * from emp_back;

--## ��ϰ5

--1. �ظ���һ�¸ղŵİ�����
--��1.��emp_back��������һ����dname, ���洢��������.alter table emp_back
add(dname varchar2(14));
--��2.ʹ������Ӳ�ѯ����dname��Ϊ��ȷ�Ĳ�������.
update emp_back e
set dname = 
           (select dname
           from dept d
           where deptno = e.deptno);

select * from emp_back;

--## ��ϰ6

--1. ɾ��������Ϊ7566��Ա����¼
select * from emp_back;

delete from emp_back
where mgr in 7566;

select * from emp_back;

--2. ɾ��������NEW YORK��Ա����¼
select * from emp_back;

delete from emp_back 
where (select loc 
              from dept 
              where dept.deptno=emp_back.deptno)
              in 'NEW YORK';

select * from emp_back;

--3. ɾ�����ʴ������ڲ���ƽ�����ʵ�Ա����¼
select * from emp_back;

delete from emp_back eb
where sal > (select avg(sal)
                    from emp_back
                    where eb.deptno = emp_back.deptno);

select * from emp_back;

--## ��ϰ7

--��������������У���Щ�����������

--    INSERT��

--    UPDATE..

--    INSERT

--    ROLLBACK; --��������

--    DELETE..

--    DELETE..

--    SELECT..

--    COMMIT.. --��������

--    INSERT..

--    INSERT..

--    DELETE..

--    GRANT.. --��������

--    INSERT..

--    SELECT;


--## ��ϰ8

--1. test��Ϊ�ձ��������������������test���״̬��

--    INSERT INTO test(id,name) values(1, 'a')��
--    INSERT INTO test(id,name) values(2, 'b')��
--    SAVEPOINT s1;
--    INSERT INTO test(id,name) values(3, 'c')��
--    INSERT INTO test(id,name) values(4, 'd')��
--    DELETE FROM test WHERE id in (1,3);
--    ROLLBACK TO s1;
--    DELETE FROM test WHERE id in (2,4);
--    COMMIT; --�ύ�Ͳ��ܻع��� ����ֻ�� values(1, 'a')
--    ROLLBACK;

--## ��ϰ9

--�������������Ự��ִ����ÿһ��ʱ�����ݿ�״̬��

--    �ỰA

--    1.UPDATE EMP SET sal = sal+500 WHERE deptno= 10;--1



--    3.SELECT sal FROM EMP WHERE deptno = 10;--2



--    6.COMMIT: --3

--    8.SELECT sal FROM EMP WHERE deptno = 10; --5



--    �ỰB


--    2.SELECT sal FROM EMP WHERE deptno = 10;--4



--    4.UPDATE EMP SET sal = sal+500 WHERE deptno = 20;--6

--    5.UPDATE EMP SET sal = sal+1000 WHERE deptno = 10;--7

--    7.COMMIT;--8

--## �κ���ҵ


--1.ʹ��������䣬����ѧ����student�Ͱ༶��class


   create table tab_student_11 (        --ѧ����
               xh char(4),--ѧ��
               xm varchar2(10),--����
               sex char(2),--�Ա�
               birthday date,--��������
               sal number(7,2), --��ѧ��
               studentcid number(2) --ѧ���༶��
    );
   create table tab_class_11 (   --�༶��
                classid number(2), --�༶���
                cname varchar2(20),--�༶����
                ccount  number(3) --�༶����
    )

--2. ��������ѧ����Ͱ༶�������������

--��1����������༶��ϢΪ��1��JAVA1�࣬null
--                         2��JAVA2�࣬null
--                         3��JAVA3�࣬null

insert into tab_class_11
            values(1,'JAVA1��',null);
insert into tab_class_11
            values(2,'JAVA2��',null);
insert into tab_class_11
            values(3,'JAVA3��',null);

--��2�����ѧ����Ϣ���£���A001��,��������,���С�,��01-5��-05��,100,1
insert into tab_student_11
            values('A001','����','��','01-5��-05',100,1);
--��3�����ѧ����Ϣ���£�'A002','MIKE','��','1905-05-06',10
insert into tab_student_11
            values('A002','MIKE','��','06-5��-1905',10,null);
--��4�����벿��ѧ����Ϣ�� 'A003','JOHN','Ů��
insert into tab_student_11(xh,xm,sex)
            values('A003','JOHN','Ů');

--��5����A001ѧ���Ա��޸�Ϊ'Ů��
update tab_student_11 set sex = 'Ů'
       where xh = 'A001';

--��6����A001ѧ����Ϣ�޸����£��Ա�Ϊ�У���������Ϊ1980-04-01
update tab_student_11 set sex = '��',
       birthday = '01-4��-1980'
       where xh in 'A001';

--��7��������Ϊ�յ�ѧ���༶�޸�ΪJava3��
update tab_student_11 set studentcid = 3
                      where birthday is null;

--��8����ʹ��һ��SQL��䣬ʹ���Ӳ�ѯ�����°༶����ÿ���༶�������ֶ�
update tab_class_11 set ccount =
                    (select count(*) from tab_student_11
                            where tab_class_11.classid = tab_student_11.studentcid);

select * from tab_student_11;
select * from tab_class_11;
--3.ʹ��������䣬�������±�

--    CREATE TABLE copy_emp   (
--    empno number(4),
--    ename varchar2(20),
--    hiredate date default sysdate ,
--    deptno number(2),
--    sal number(8,2))

--4. �ڵ������Ļ����ϣ������������

--(1)�ڱ�copy_emp�в������ݣ�Ҫ��sal�ֶβ����ֵ�����ź�50���μӹ���ʱ��Ϊ2000��1��1�գ������ֶ�����

--(2)�ڱ�copy_emp�в������ݣ�Ҫ���emp���в��ź�Ϊ10�Ų��ŵ�Ա����Ϣ����

--(3)�޸�copy_emp�������ݣ�Ҫ��10�Ų�������Ա����20%�Ĺ���

--(4)�޸�copy_emp����salΪ�յļ�¼�������޸�Ϊƽ������

--(5)�ѹ���Ϊƽ�����ʵ�Ա���������޸�Ϊ��

--(6)����򿪴���2�鿴�����޸�

--(7)ִ��commit������2���ٴβ鿴������Ϣ

--(8)ɾ������Ϊ�յ�Ա����Ϣ

--(9)ִ��rollback
