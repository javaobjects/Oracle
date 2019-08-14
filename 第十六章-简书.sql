--## ��ϰ1
--1. ����һ�����У���������ʼֵ��1��ʼ�������ֵ��������1����ѭ����
create sequence test_seq1
       start with 1 -- ʼֵ��1��ʼ ��ʡ��
       nomaxvalue -- �����ֵ 
       increment by 1 -- ������1 ��ʡ��
       nocycle; -- ��ѭ��
drop sequence test_seq1;       
--2. ��ѯ���еĵ�ǰֵ����һ��ֵ

select test_seq1.nextval from dual;-- ��ѯ���е���һ��ֵ
select test_seq1.currval from dual; -- ��ѯ���еĵ�ǰֵ

--3. ʹ�õ�1�����������У����ű��в���������¼��
--���ű��ʹ������ֵ���������Ʒֱ�Ϊ��Education��Market��
--���зֱ�Ϊ��DALLAS��WASHTON


create table copy_dept
as select * from dept;

select * from copy_dept;

insert into copy_dept
values(test_seq1.nextval,'Education','DALLAS');

insert into copy_dept
values(test_seq1.nextval,'Market','WASHTON');

select * from copy_dept;

--## ��ϰ2

--1. ʹ���Ӳ�ѯ�ķ�ʽ������test��
create table test
as select * from emp;

select * from test;


--2. ���ٸ���test���е����ݣ����Ƶ�100w������

insert into test select * from test;
-- ִ�п� 13�� 147456������ ���Ҫִ��16������

select * from test;

--3. ����test���е�empno�ֶ�Ϊrownum
alter table test modify empno number(10);
--��Ҫ�޸ľ��ȣ����򱨴� ֵ����Ϊ����ָ����������
update test set empno = rownum;

select * from test;

--4. ��ѯtest��empnoΪ800000�ļ�¼ֵ����¼��ѯִ��ʱ�䡣

select * from test where empno in 800000;-- 0.128s

--5. ��test���empno�ֶ��ϴ�������
create index idx_test_empno 
on test(empno);

select * from test;
--6. ����ִ�е�4�⣬�ԱȲ�ѯʱ��

select * from test where empno in 800000;-- 0.039s

--## ��ϰ3

--1. �����¹�ϵģʽ��

--student(sno,sname,gender,birthday,email);--ѧ��

--course(cno,cname,type,credit);--�γ�

--sc��sno,cno,grade);--ѡ��

--�Է�����Щ�����ʺϴ���������

create index idx_student_sno on student(sno);
create index idx_course_cno on course(cno);
create index idx_sc_sno on sc(sno);

--## �κ���ҵ
--1. �������У���ʼλ1������Ϊ1����СֵΪ1�����ֵΪ9999
create sequence test_seq16_1
start with 1 -- ��ʼλ1��Ĭ��Ϊ1 �ɲ�д
increment by 1 -- ����Ϊ1��Ĭ��Ϊ1���ɲ�д
minvalue 1 -- ��СֵΪ1 
maxvalue 9999; -- ���ֵΪ9999

--2. �������У���ʼֵΪ50��ÿ������5��
create sequence test_seq16_2
start with 50 -- ��ʼֵΪ50
increment by 5; --����Ϊ5

--3. �ڱ�copy_dept�в����¼�����в��ź��������һ���д������������ɣ�
create table copy_dept2
as select * from dept
where 1 = 0;

insert into copy_dept2(deptno,dname)
            values(test_seq16_2.nextval,'���в���');

select * from copy_dept2;


--4. ��Ϊ���ʴ����������Ƚ�<10000,>1000,��round��sal��>10000,�ĸ�������Ч���ĸ�������Ч��
create index idx_emp_sal on emp(sal); -- 0.018s
select * from emp where sal < 10000;-- 0.083s ����������Ϊ˳������
select * from emp where sal > 1000;-- 0.040s ����������Ϊ˳������
select * from emp where round(sal) > 10000;-- 0.041s ���������к���

--5. ���������á�create table copy_emp_index as select * from emp��������500�������ݣ������еġ�Ա���š��ֶ��޸�ΪΨһ��

--6. ��ѯ��copy_emp_index����Ա����Ϊ200001��Ա�����������ʣ���¼ִ��ʱ�䣻

--7. ��copy_emp_index���empno�ֶ��ϴ����������ٴ�ִ�е�6����䣬��¼ִ��ʱ�䲢���Աȣ�
