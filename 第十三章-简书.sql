--1. ѧУ����һ��ѡ��ϵͳ�������漰���γ̱�ѧ������ֱ𴴽����������Լ�˼������Ӧ�е��м��������͡�

--�γ̱�
create table tab_course_13(
       cid number(4),--�γ̱��
       cname varchar(50),--�γ�����
       ctypeId number(4),--�γ�����
       score number(1),--ѧ��
       chour number(2) --��ʱ
);
--ѧ����
create table tab_student_13(
       sid char(10),--ѧ�����2019003004
       sname varchar2(20),--ѧ������
       sex char(4) default '��',--�Ա�
       telephone varchar2(15),--�绰����
       collegeId number(4),--ѧԺ
       majorId number(4),--רҵ
       classId number(4),--�༶
       inDate date --��ѧ����
);

--## ��ϰ2

--1. ͨ���Ӳ�ѯ�ķ�ʽ����һ����dept10,�ñ���10�Ų��ŵ�Ա�����ݡ�
create table tab_dept10
as select * from emp
where deptno in 10;

select * from tab_dept10;

--## ��ϰ3

--1. ��Ա���������һ���Ա��У�����Ϊgender������Ϊchar(2)��Ĭ��ֵΪ���С�
select * from copy_emp;

alter table copy_emp add (gender char(2));
alter table copy_emp modify(gender default '��');

select * from copy_emp;

--2. �޸�Ա�������Ա��е���������Ϊchar(4)

alter table copy_emp modify (gender char(4));

--3. �޸�Ա�������Ա��е�Ĭ��ֵΪ��Ů��
alter table copy_emp modify (gender default 'Ů');

--4. ɾ��Ա�����е��Ա���

select * from copy_emp;

alter table copy_emp drop column gender;

select * from copy_emp;

--## �κ���ҵ

--1. �������������Ҫ����Ҫ����ʲô���͵��ֶ�?

--(1)���2000���ֽڶ����ַ��� char(2000)

--(2)������롮������ ����ո�6�� char(10)

--(3)�Ա�����'��'��'Ů�� char(2)

--(4)���4000���ֽڱ䳤�ַ��� varchar2(4000)

--(5)��������ݿ�������'����'����ʾ����'������ nvarchar2(2)

--(6)��ʾ���ַ�ΧΪ- 10��125�η���10��126�η�, ���Ա�ʾС�� Ҳ���Ա�ʾ���� number

--(7)����ʾ4λ����  -9999 �� 9999 number(4)

--(8)��ʾ5λ��Ч���� 2λС���� һ��С��  -999.99 �� 999.99 number(5,2)

--(9)���������պ�ʱ���� date

--(10)���������պ�ʱ������� timestamp

--(11)�����ƴ����ͼ��/���� blob

--2. ������date_test,������d������Ϊdate�͡�
--����date_test���в���������¼��
--һ����ǰϵͳ���ڼ�¼��һ����¼Ϊ��1998-08-18����

create table tab_date_test(
       d date
);

select * from tab_date_test;

insert into tab_date_test
values(sysdate);
insert into tab_date_test
values(to_date('1998-08-18','yyyy/mm/dd'));

select * from tab_date_test;

--3. ������dept����ͬ��ṹ�ı�dtest����dept���в��ű����40֮ǰ����Ϣ����ñ�
create table tab_dtest
as select * from dept
where deptno < 40;

select * from tab_dtest;
--4. ������emp��ṹ��ͬ�ı�empl�������䲿�ű��Ϊǰ30�ŵ�Ա����Ϣ���Ƶ�empl��
create table tab_empl
as select * from emp
where deptno <= 30;

select * from tab_empl;
--5. ��Ϊѧ����student����һ��ѧ���Ա�gender Ĭ��ֵ ��Ů����

--6. ���޸�ѧ����������������Ϊ�����ַ���10λ��
