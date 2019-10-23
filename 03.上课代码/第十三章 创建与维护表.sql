���ݲ�ѯ���� DQL(Data Query Language): select
���ݲ������� DML(Data Manipulation Language): insert   update   delete---���table����е��������ӡ��޸ġ�ɾ��
���������� TPL(Transaction Process Language):commit  rollback
���������� DDL(Data Definition Language):   create   alter    drop-----��Զ���Ĵ������޸ġ�ɾ��
-------------------------------------------------------
--������
--     create table ����(����  ������[����] [default Ĭ��ֵ][,........]);
--
--     �Ӳ�ѯ������
--            create table ����[����1,����2....] as �Ӳ�ѯ;
-------------------------------------------------------
1.������person,��ָ�������е���Ϣ��
����   ����������  ����  ����  Ĭ��ֵ
id       number      4
cname    varchar2    20
birthday date
height   number      3
weight   number      5   2
country_code char    2          '01'   --һ������ռ2���ֽ�   Ӣ�������ֱַ�ռ1���ֽ�

--������
create table person(
       id number(4),
       cname varchar2(20),
       birthday date,
       height number(3),
       weight number(5,2),
       country_code char(2) default '01'
);
--Ĭ��ֵʹ��
--����Ĭ��ֵ
insert into person(id,cname,birthday,height,weight) values(1000,'����',sysdate,52,7);

--ʹ��Ĭ��ֵ�޸�
insert into person(id,cname,birthday,height,weight,country_code) values(2000,'����',sysdate,52,7,'10');
update person set country_code = default where id = 2000;


--���Ӳ�ѯ�﷨������
1.������dept_10,���ڱ��沿��10��Ա����������Ϣ,��ṹ��emp��һ��
create table dept_10 as select * from emp where deptno = 10;                               --����������

2.������dept_20,���ڱ��沿��20��Ա���Ĺ�Ա��š���Ա����������,��ṹ��Ϣ����emp��
create table dept_20(empno,ename,mgr) as select empno,ename,mgr from emp where deptno = 20;--����ָ����

--������һ���û��ı�
select * from scott.emp;


-------------------------------------------------------
--�޸ı�����С��޸��С�ɾ���У�
--
--     ����У�alter table ���� add (���� ������[����] [default Ĭ��ֵ]);
--     �޸��У�alter table ���� modify (���� ������[����] [default Ĭ��ֵ]);
--
--     ɾ����(ɾ������)��alter table ���� drop column ����; 
--     ɾ����(ɾ������)��alter table ���� drop (����1,����2.....); 
--
--
--     �޸���ע�⣺
--            1. �޸��������ͣ����е������ݱ���Ϊ�ա�
--            2. �޸ĳ���ԭ��
--                     ��ֵ���޸ĳ��ȣ���������С��ʱ�������е������б���Ϊ�գ�
--                                     ����������ʱ�����������޸ġ�
--                     �ַ����޸ĳ��ȣ���������С��ʱ��ֻҪ�޸ĺ��ֵ�������µ�ǰ�������ݵ����ֵ���ɣ�
--                                     ����������ʱ�����������޸ġ�
--            3. �޸��е�Ĭ��ֵ��
--                     Ĭ��ֵ���޸Ĳ���Ӱ���Ѿ����ڵ��У�ֻӰ�������ӵ���
--
--            4. �޸�������
--                     alter table ����  rename column ԭ����  to ������;
--  
--     ɾ����ע�⣺
--            1.�п�����Ҳ����û�����ݡ�  
--            2.�������ٱ���һ�С� 
--            3.�б�ɾ���󣬲����ٻָ��� 
--            4.��������õ��У����ܱ�ɾ����

-------------------------------------------------------
--�����
1.��person������Ա���:sex char(2)
alter table person add sex char(2);
insert into person(id,cname,birthday,height,weight,sex) values(3000,'����3��',sysdate,52,7,'��');

--�޸���
1.��person���sex�е����������޸�Ϊnumber(2);
alter table person modify sex number(2);              --not ok 1. �޸��������ͣ����е������ݱ���Ϊ�ա�

2.��person���sex�ĳ����޸�Ϊchar(1)
alter table person modify sex char(1);                --not ok 2.��������С��ʱ�������е������б���Ϊ��

3.��person���country_code��Ĭ��ֵ�޸�Ϊ'88'
alter table person modify country_code default '88';  --3. Ĭ��ֵ���޸Ĳ���Ӱ���Ѿ����ڵ��У�ֻӰ�������ӵ���
insert into person(id,cname,birthday,height,weight,sex) values(4000,'����4��',sysdate,52,7,'��');

4.��person���sex�������޸�ΪsexName
alter table person rename column sex to sexName;

--ɾ����
1.��person���sexName��ɾ��
alter table person drop column sexName;--ɾ������  1.�п�����Ҳ����û�����ݡ�  

2.��person���height��weight��ɾ��
alter table person drop (height,weight);--ɾ������

alter table person drop (id,cname,birthday,country_code);--not ok �޷�ɾ�����ȫ����   2.�������ٱ���һ�С�

3.��dept���deptno��ɾ��
alter table dept drop (deptno);--not ok  �޷�ɾ������ؼ�����     4.��������õ��У����ܱ�ɾ����

-------------------------------------------------------
--ɾ����
--      �﷨�� drop table ����;
-------------------------------------------------------
1.ɾ����person
drop table person

-------------------------------------------------------
--��������
--      �﷨�� rename �ɱ��� to �±���;
-------------------------------------------------------
1.��person������޸�Ϊdossier
rename person to dossier;

-------------------------------------------------------
--�ضϱ�
--      �﷨�� truncate table ������
--
--      �ضϱ�truncate��ɾ��������delete������
--          truncate����DDL���ԣ�ɾ���������е����ݣ��ͷŴ洢�ռ䣬�����Գ�������
--          delete����DML���ԣ�����ɾ��ָ��������,���ͷŴ洢�ռ䣬����ͨ��rollback�ع�����
-------------------------------------------------------
truncate table person;
delete from person;

-------------------------------------------------------
--�����ֵ�
-------------------------------------------------------
select * from user_tables;--��ѯ��ǰ�û������еı��

--��ϰ
1.�������������Ҫ����Ҫ����ʲô���͵��ֶ�?
(1)���2000���ֽڶ����ַ���
char

(2)������롮������ ����ո�6��
char(10)

(3)�Ա�����'��'��'Ů��
char(2)

(4)���4000���ֽڱ䳤�ַ���
varchar2

(5)��������ݿ�������'����'����ʾ����'������
varchar2(10)

(6)��ʾ���ַ�ΧΪ-10��125�η���10��126�η�, ���Ա�ʾС�� Ҳ���Ա�ʾ����
number

(7)����ʾ4λ����  -9999 �� 9999
number(4)

(8)��ʾ5λ��Ч���� 2λС���� һ��С��  -999.99 �� 999.99
number(5,2)

(9)���������պ�ʱ����
date

(10)���������պ�ʱ�������
timestamp

(11)�����ƴ����ͼ��/����
blob
