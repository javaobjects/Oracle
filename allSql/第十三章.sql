----------------��ʮ����  ������ά����----------


--DDL ���ݶ������� create alter drop
--DDL �����Զ��ύ����
--���ǿ��Զ����ݿ����������ִ��DDL���


--������
--�����ʱ�� ������֮���ö��Ÿ���,���һ���к��治��Ҫ�� ����
--����  �е��������� ���еĳ��ȣ� ��Ĭ��ֵ��

create table student(
    sno varchar2(50),
    sname varchar2(20),
    sex char(3) default '��'
);
insert into student(sno) values(7788);

--1.ѧУ����һ��ѡ��ϵͳ�������漰���γ̱�ѧ������ֱ𴴽����������Լ�˼������Ӧ�е��м��������͡�
create table course(
   sno varchar2(20),
   cno number(5),
   cname varchar2(20),
   cgrade varchar2(5)
);

--ͨ���Ӳ�ѯ���﷨ ������
--ͨ��as �Ӿ�������Ӳ�ѯ������
create table manager
as select * from emp where where 1 = 0;

--1.ͨ���Ӳ�ѯ�ķ�ʽ����һ����dept10,�ñ���10�Ų��ŵ�Ա�����ݡ�
create table dept10
as select * from emp where deptno = 10;

select * from dept10;

--�޸ı��޸ı�Ľṹ-�޸ı����еĶ��壩

--������


--�޸���

--ɾ����

--ɾ���� drop ���ܻع�
drop table dept10;

--1.��Ա���������һ���Ա��У�����Ϊgender������Ϊchar(2)��Ĭ��ֵΪ���С�
--2.�޸�Ա�������Ա��е���������Ϊchar(4)
--3.�޸�Ա�������Ա��е�Ĭ��ֵΪ��Ů��
--4.ɾ��Ա�����е��Ա���

--��������
rename dept10 to dept20;

--�ضϱ�(truncate)
--���ã��ضϱ������
--�ضϺ�����ݲ��ָܻ����Զ��ύ���񣩣��������ǵ�DML�����е�delete����ǿ��Իָ����ݵ�
truncate table dept20;

select * from deptno;





select * from user_tables;
select * from course;--�γ� ��
select * from sc;
select * from teacher;



select * from likaiqing;
select * from student;
