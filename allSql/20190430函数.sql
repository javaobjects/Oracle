--���к���
--�ַ�����
--lover ���ַ�ȫ��תΪСд
select ename,lower(ename) from emp;
select ename from emp where lower(ename) like '%s%';
--upper ���ַ�ȫ��תΪ��д
select upper(ename) from emp;
select ename from emp where upper(ename) like '%s%';
--initcap--���ַ�����ĸתΪ��д,������ĸ���Сд
select initcap(ename) from emp;

select 'Sql course',initcap('sql sourse') from dual;--dualα��
--concat ��������ֵ ��ͬ�� ||
select ename || '�Ĺ�����' || sal from emp;
select concat(concat(ename,'�Ĺ�����'),sal) from emp;
-- substr --��ȡ�ַ����Ӵ�,Ĭ���±�1��ʼ
select 'wuyuehong@qq.com',substr('wuyuehong@qq.com',3),
substr('wuyuehong@qq.com',10,3) from dual;
--length -- ȡ�ַ�������
select ename,length(ename) from emp;
--1.дһ����ѯ,������ĸ��д��������ĸСд��ʾ��Ա�� ename����
--ʾ���ֵĳ��ȣ�����ÿ��һ���ʵ��ı�ǩ���������������й�Ա����
--�Ŀ�ʼ��ĸ��J��A �� M �Ĺ�Ա�����Բ�ѯ�������Ա��ename����
--����

select initcap(ename) ����ĸ��д, length(ename) ���ֳ���
from emp
where initcap(ename) like 'J%' or initcap(ename) like 'A%' or initcap(ename) like 'M%'
order by ename;
--�ַ�������
-- instr ���� һ��Ŀ���ַ������������Ӵ�����������ʼ������������ �ڼ��γ���
select 'wuyuehong@qq.com',
instr('wuyuehong@qq.com','@',9),
instr('wuyuehong@qq.com','.',1,2) from dual;
--lpad--�����ַ���(��
--����һ Ŀ���ַ����������� �����ַ����� ������ ����ַ���
select ename,lpad(ename,10,'aa'),length(ename) from emp;
--rpad--�����ַ������ң�
select ename,rpad(ename,10,'aa'),rpad(ename,10,'aa'),length(ename) from emp;
--trim()--Ĭ��ȥ�ַ�����β�ո� 
--ȥ��ָ���ַ���,Ĭ��ȥ����βָ���Ӵ�
select '    sql sourse   ',trim('    sql sourse   ') from dual;
select 'hsql sourseh',trim('h' from 'hsql sourseh') from dual;
select 'hsql sourseh',trim(both 'h' from 'hsql sourseh') from dual;
select 'hsql sourseh',trim(leading 'h' from 'hsql sourseh') from dual;
select 'hsql sourseh',trim(trailing 'h' from 'hsql sourseh') from dual;
--replace �ַ��滻����
--REPLACE(s1,s2,s3) 
--����һ Ŀ���ַ��� ������Ŀ���ַ��Ӵ� �������滻�ַ���
select 'hsql sourseh',replace('hsql sourseh','hs','a') from dual;
select 'hsql sourseh',replace('hsql sourseh',' ','') from dual;
--1.��ѯԱ���������а�����д��Сд��ĸA��Ա��������

--2.��ѯ���ű��Ϊ10��20����ְ������81��5��1��֮��
--���������а�����д��ĸA��Ա��������Ա���������ȣ���ʾ��Ҫ��ʹ��INSTR����������ʹ��like�����ж�)
select * from emp where 
deptno in(10,20) and instr(ename,'A') != 0;


select ename,length(ename) from emp 
where instr(ename,'A') > 0 and hiredate > '01-5��-81' and deptno in(10,20);


--3.��ѯÿ��ְ���ı��,����������
--Ҫ�󽫲�ѯ�������ݰ���һ���ĸ�ʽ�ϲ���һ���ַ���.
--ǰ10λ�����,���㲿����*���,�����
--�м�10λ�����������㲿����*���,�����
--��10λ�����ʣ����㲿����*���,�Ҷ���

------
--��ֵ����
--round �������� -- ����һĿ����ֵ ����  ��������λ
select 45.926,round(45.926)
,round(45.926,2),
round(45.926,0),
round(45.926,-1),
round(45.926,-2) from dual;
--trunc()��ȡ-- ����һĿ����ֵ ����  ��������λ
select 45.926,trunc(45.926),
trunc(45.926,2),
trunc(45.926,0),
trunc(45.926,-1),
trunc(45.926,-2) from dual;
--mod ȡ���� ��ȡģ
select 12,mod(12,5) from dual;--2
--���ں���
--sysdate���ص�ǰϵͳ����
select sysdate from dual;
--���ڵ�����
--�Ӽ� ������ֵĬ������
select sysdate+2 from dual;
select sysdate-180 from dual;
--1.��ѯÿ��Ա����ֹ������һ����ְ�����죿
--2.��ǰ����Ϊ2015�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-01��������ʵ�������������Ϊ��

--3.��ǰ����Ϊ2015�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-95��������ʵ�������������Ϊ��

--4.��ǰ����Ϊ1998�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-01��������ʵ�������������Ϊ��

--5.��ǰ����Ϊ1998�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-95��������ʵ�������������Ϊ��

--6.��ǰ����Ϊ2015�ָ꣬�����ڸ�ʽΪDD-MON-YY,ָ������Ϊ01-1��-01��������ʵ�������������Ϊ��

--7.��ǰ����Ϊ1998�ָ꣬�����ڸ�ʽΪDD-MON-YY,ָ������Ϊ01-1��-95��������ʵ�������������Ϊ��
--months_between ��������������������֮��������Ȼ����
select months_between(hiredate,sysdate),
months_between(sysdate,hiredate) from emp;
--add_months �������
select hiredate,add_months(hiredate,6) as ת������ from emp;
--next_day
select next_day(sysdate,'���ڶ�') from emp;
--last_day ����ָ�����ڵ������һ�������
select last_day('01-2��-81') from dual;
--round(date,fmt) ����ָ ����ʽ��������������
select hiredate,round(hiredate,'MM') from emp;--���·��������� ���� ����15�·ݼ�1
select hiredate,round(hiredate,'YY') from emp;--�������������� ���� ����6���1
select hiredate,round(hiredate,'DD') from emp;--��������������
--trunc(data,fmt)��ȡ���� ����ָ����ʽ ��ȡ�������
select hiredate,trunc(hiredate,'MM') from emp;
select hiredate,trunc(hiredate,'YY') from emp;
select hiredate,trunc(hiredate,'DD') from emp;

--extract ��ȡָ����ʽ����year month
select sysdate,extract(month from sysdate) from emp;

--1.��ѯ��������ǰʱ��
select sysdate from dual;
--2.��ѯ����10,20��Ա����ֹ��2000��1��1�գ������˶��ٸ��£�
--��ְ���·ݡ�(��ʾ��ʹ��months_between,extract)
select hiredate as ��ְ����,
extract(month from hiredate) as ��ְ�·�,
months_between('01-1��-00',hiredate) as �����·�
 from emp where deptno in(10,20);

--3.���Ա��������6���£���ѯְλ����MANAGER��Ա��������
--��ְ���ڣ�ת�����ڣ���ְ���ں�ĵ�һ������һ,��ְ���µ����һ�����ڡ�
--����ʾ��ʹ��add_months,next_day,last_day)

select ename as Ա������,
hiredate as ��ְ����,
add_months(hiredate,6) ת������,
next_day(hiredate,'����һ') as ��ְ���ں�ĵ�һ������һ,
last_day(hiredate)as ��ְ���µ����һ������
from emp where job not in('MANAGER');

select ename Ա������, hiredate ��ְ����, add_months(hiredate,6) ת������, 
       next_day(hiredate,'����һ') ��һ������һ, last_day(hiredate) 
from emp where job <> 'MANAGER';--kaiqingli

--ת������
--��ʽת��
select sal,sal+12.0 from emp;
select sal,sal+'10' from emp;
--��ʾת��
--to_char ����תΪ�ַ�����
select hiredate,to_char(hiredate,'yy-mm-dd') from emp;
select hiredate,to_char(hiredate,'yyyy-mm-dd') from emp;
select hiredate,to_char(hiredate,'yyyy/mm/dd') from emp;
select hiredate,to_char(hiredate,'yyyy"��"mm"��"dd"��"') from emp;
select hiredate,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from emp;
select hiredate,to_char(sysdate,'yyyy-mm-dd hh12:mi:ss') from emp;
--to_char ������ֵ�� 
select 12343434.789 from dual;
select to_char('$12343434.789') from dual;
--to_number �ַ�����ת��Ϊ��ֵ����
select saL,sal+'10' from emp;--��ʽת��
select to_number('123.4')+3 from dual;--��ʾת��
--to_date �ַ�����תΪ��������
select to_date('2018-03-01','YY/MM/DD') from dual;
--1.��ʾ������ϵͳ��ǰʱ�䣬��ʽΪ2007-10-12 17:11:11(��ʾ��ʹ��to_char����)
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from emp;
--2.��ʾename��hiredate �� ��Ա��ʼ�����������ڼ����б�ǩDAY(��ʾ��ʹ��to_char����)
select ename as Ա������,
hiredate as ��ְ����,
to_char(hiredate,'day') as day
from emp;
--3.��ѯԱ�����������ʣ���ʽ���Ĺ��ʣ���999,999.99�� (��ʾ��ʹ��to_char����)
select ename,sal,
to_char(sal,'')
from emp;
--4.���ַ���2015-3��-18 13:13:13 ת�������ڸ�ʽ���������ϵͳ��ǰʱ���������졣 (��ʾ��ʹ��to_date����)
select to_date('2015-3��-18 13:13:13','YY-MM"��"-DD hh24:mi:ss'),
trunc(sysdate - to_date('2015-3��-18 13:13:13','YY-MM"��"-DD hh24:mi:ss'))
 from dual;
--ͨ�ú���
--nvl ����һĿ����� ���������ֵ
select comm,nvl(comm,0) from emp;
-- nvl2 ����һĿ����� ������ ����������ֵ 
select comm,nvl2(comm,'�н���',0) from emp;
select comm,nvl2(comm,'�н���','��') from emp;
--nullif ����һ����������бȽ������ȷ��ؿգ����򷵻ز���һ
--����һ����������ͱ���һ��
select nullif(1,'1') from dual;--��ֵ���Ͳ�һ��
select nullif(1,1) from dual;--null
select nullif(1,2) from dual;--1
--coalesce����
select coalesce(123) from dual;--����û���㹻�Ĳ���
select coalesce(null,null,3,4,2) from dual;
select coalesce(null,null,comm,4,2) from emp;
------
--case --decode�������������ж����ӳ����
------
select * from emp;
select * from dept;
select ename,hiredate,deptno,
       case deptno
         when 10 then '�з���'
         when 20 then '������'  
         when 30 then '����'
           else '��'
             end as ����
       from emp;      
--decode
select ename,hiredate,deptno,
       decode(deptno,10,'�з���',20,'������',30,'����','��') as ����
       from emp;     
-----------------
--����Ƕ��
--ע�⣺������Ƕ���������һ����ִ��
----------------
select ename,nvl(to_char(mgr),'�޾���') from emp;
--1.����2000��1��1�յ������ж����£������ܣ��������룩��
select months_between(sysdate,'01-1��-00') as ��,
round(months_between(sysdate,'01-1��-00')*30/7) as ��
from dual;

--2.��ѯԱ��ENAME�ĵ�������ĸ��A��Ա������Ϣ(ʹ��2������)��
select * from emp where ename like '__A%';



--3.ʹ��trim�������ַ�����hello������  Hello ������bllb������ hello  
--  ���ֱ���õ������ַ���ello��Hello��ll��hello��
select trim('h' from 'hello'),
       trim(' ' from ' Hello '),
       trim('b' from 'bllb'),
       trim(' ' from ' hello ')
 from dual;

--4.��Ա�����ʰ����¸�ʽ��ʾ��123,234.00 RMB ��
select ename,sal,to_char(sal,'$99,99.99') from emp;
--5.��ѯԱ�����������侭���ţ�Ҫ�����û�о������ʾ��No Manager���ַ�����
select ename,mgr,nvl(to_char(mgr),'NO Manager') from emp;

--6.��Ա���Ĳμӹ������ڰ����¸�ʽ��ʾ���·�/��ݡ� 

--7.��Ա�����в�ѯ��Ա���Ĺ��ʣ�������Ӧ��˰�
--�������С��1000,˰��Ϊ0��������ʴ��ڵ���1000��С��2000��
--˰��Ϊ10����������ʴ��ڵ���2000��С��3000��˰��Ϊ15����������ʴ��ڵ���3000��˰��Ϊ20����
select sal,ename,
       case 
         when sal<1000 then 0
           when sal >= 1000 and sal < 2000 then (sal-1000)*0.1
             when sal >= 2000 and sal < 3000 then 1000*0.1 + (sal - 2000) * 0.15
               when sal >= 3000 then 1000*0.1 + 1000*0.15+(sal-3000)*0.2
                 end as ˰��
                 from emp;

--8.����һ����ѯ��ʾ���й�Ա�� ename�� sal����ʽ��salΪ 15 ���ַ����ȣ��� $ ����䣬�б�ǩ SALARY��






select * from emp;
