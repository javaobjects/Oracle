--------------------------------------------------------------------------
-- �ַ����� 
--------------------------------------------------------------------------
----------------
--��Сдת������  lower   upper   initcap  
----------------
--lower() תСд
select empno,ename,job from emp where ename like 'a%' or ename like 'A%';
select empno,ename,job,lower(ename),lower(job) from emp where lower(ename) like 'a%';--��������ת��

select 'SQL Course',lower('SQL Course') from dual;--���ݱ�������ʽת��  dualα�� һ��N��   sql course

--upper() ת��д
select 'SQL Course',upper('SQL Course') from dual;--SQL COURSE

--initCap() ����ĸ��д
select 'sql course',Initcap('sql course') from dual;--Sql Course

----------------
--�ַ�������  concat   substr  length   instr   lpad  rpad  trim  replace
----------------
--concat(����һ��������) ƴ���ַ���
select ename || ' ��ְλ�� ' || job from emp;  --SMITH ��ְλ�� CLERK

select concat(ename,' ��ְλ�� ',job) from emp;--not ok ����������Ч
select concat(concat(ename,' ��ְλ�� '),job) from emp;--ok

--substr(����һ��������[,������]) ��ȡ�ַ���,�±��1��ʼ
--   ����һ������ȡ��Ŀ���ַ���
--   ����������ʼλ��
--   ����������ȡ���ȣ���ʡ�ԣ�Ĭ�ϳ��ȵ����
select substr('zr@neusoft.com',3) from dual;  --@neusoft.com
select substr('zr@neusoft.com',1,2) from dual;--zr

select substr('zr@neusoft.com',-4) from dual; --.com
select substr('zr@neusoft.com',-3) from dual; --com

--length() ��ȡ�ַ����ĳ���
select empno,ename,length(ename) from emp;

select length('12ab����') from dual;  --6

1.дһ����ѯ,������ĸ��д��������ĸСд��ʾ��Ա�� ename��
��ʾ���ֵĳ��ȣ�����ÿ��һ���ʵ��ı�ǩ(����)��
�������������й�Ա���ֵĿ�ʼ��ĸ��J��A �� M �Ĺ�Ա�����Բ�ѯ�������Ա��ename��������
����ʾ��ʹ��initcap��length��substr��
select initCap(ename) Ա������,length(ename) �������� from emp where substr(ename,1,1) in('J','A','M');
select initCap(ename) Ա������,length(ename) �������� from emp where ename like 'A%' or ename like 'J%' or ename like  'M%';

--instr(����һ��������[,������][,������]) ����ָ���ַ����±�,����ַ������ڣ�����0
--     ����һ�������ҵ�Ŀ���ַ���
--     �����������ҵ��ַ���˭
--     ����������ʼλ��,Ĭ�ϴ�1��ʼ
--     �����ģ���N�γ��ֵ�λ��
select instr('zr@neusoft.com','@') from dual; --3
select instr('zhaorong@neusoft.com','@') "@���ŵ��±�",
       substr('zhaorong@neusoft.com',1,instr('zhaorong@neusoft.com','@')-1) ����ǰ׺ from dual; --3,zhaorong
       
select instr('sql course','s') from dual; --1
select instr('sql course','s',3) from dual; --9
select instr('sql courses','s',3,2) from dual; --11

--lpad ��ȫ   V0000007369
select empno,'V' || lpad(empno,10,'0') from emp;     --V0000007369  �ٶ�����Ϊ10�����㲹0
select empno,concat('V',lpad(empno,10,'0')) from emp;--V0000007369

--rpad �Ҳ�ȫ
select ename,rpad(ename,10,'*') from emp;--SMITH*****

--trim() ȥ��β�ַ���Ĭ��ȥ��β�ո�
select ' SQL Course ',trim(' SQL Course ') from dual;--Ĭ��ȥ��β�ո�
select 'ISQL CourseI',trim(leading 'I' from 'ISQL CourseI') from dual;--SQL CourseI ȥ�ײ��ַ�
select 'ISQL CourseI',trim(trailing 'I' from 'ISQL CourseI') from dual;--ISQL Course ȥβ���ַ�
select 'ISQL CourseI',trim(both 'I' from 'ISQL CourseI') from dual;--SQL Course   ȥ��β�ַ�

--replace(����һ����������������) �滻�ַ���
--     ʹ�ò������滻��������ֵ                
select ' SQL Course ',replace(' SQL Course ',' ','') from dual;
select replace('����һ�����ۣ��м���������ַ���̸���˵���ϰ���','ϰ���','***') from dual;

--��ϰ
1.��ѯԱ�������а�����д��Сд��ĸA��Ա��������
select empno,ename from emp where ename like '%a%' or ename like '%A%';
select empno,ename from emp where lower(ename) like '%a%';
select empno,ename,lower(ename) from emp where instr(lower(ename),'a') > 0;

2.��ѯ���ű��Ϊ10��20����ְ������81��5��1��֮�󣬲��������а�����д��ĸA��Ա��������Ա���������ȣ���ʾ��Ҫ��ʹ��INSTR����������ʹ��like�����ж�)
select ename,length(ename) from emp where deptno in(10,20) and hiredate > '1-5��-81' and instr(ename,'A') >0 ;

3.��ѯÿ��ְ���ı��,����������
Ҫ�󽫲�ѯ�������ݰ���һ���ĸ�ʽ�ϲ���һ���ַ���.
ǰ10λ�����,���㲿����*���,�����
�м�10λ�����������㲿����*���,�����
��10λ�����ʣ����㲿����*���,�Ҷ���
select rpad(empno,10,'*') || rpad(ename,10,'*') || lpad(sal,10,'*') from emp;

--------------------------------------------------------------------------
-- ��ֵ���� 
--------------------------------------------------------------------------
--round() ��������
select round(45.926),round(45.926,2) from dual;      --46   45.93
select round(455.926,-1),round(455.926,-2) from dual;--460	500
select round(445.926,-1),round(445.926,-2) from dual;--450  400

--trunc() �ض�����
select trunc(45.926),trunc(45.926,2) from dual;      --45   45.92
select trunc(455.926,-1),trunc(455.926,-2) from dual;--450	400
select trunc(445.926,-1),trunc(445.926,-2) from dual;--440  400

--mod() ȡ�࣬��ģ
select mod(10,3) from dual;--1

--------------------------------------------------------------------------
-- ���ں��� 
--     ���ڼӼ�����ʱ����λ��"��"������
--------------------------------------------------------------------------
--sysdate ����ϵͳ��ǰ����
select sysdate from dual; --2019/8/20 14:48:53

1.��ѯԱ������ְ���ڣ�ת������(6����������)����ְ��������ְ��������
select empno,
       ename,
       hiredate ��ְ����,
       hiredate + (6 * 30) ת������,
       (sysdate - hiredate) ��ְ����,
       (sysdate - hiredate)/7 ��ְ������
  from emp;

--months_between����������������������֮��������Ȼ����
1.��ѯԱ������ְ���ڣ���ְ����
select empno,ename,hiredate ��ְ����,months_between(sysdate,hiredate) ��ְ���� from emp
select months_between('1-12��-81','15-8��-81') from dual; --3.54838709677419
 
--add_months������ָ�����ڼ�����Ӧ�������������
1.��ѯԱ������ְ���ڣ�ת������(6����������)
select empno,ename,hiredate ��ְ����,add_months(hiredate,6) ת������  from emp;

--next_day������ĳһ���ڵ���һ��ָ������ 
select next_day(sysdate,'���ڶ�') from dual;--2019/8/27 15:10:30

--last_day������ָ�����ڵ������һ�������
select last_day(sysdate) from dual;--2019/8/31 15:11:10

--round��������������
select sysdate,         --2019/8/20 15:12:23
       round(sysdate),   --2019/8/21  ����1-12 ��13-24Сʱ���ж�
       round(sysdate,'year'),  --2020/1/1  ����1-6 �� 7-12�·��ж�
       round(sysdate,'month'), --2019/9/1   ����1-15 �� 16-30�����ж�
       round(sysdate,'day')    --2019/8/18  ����1-3 �� 4-7 �����ж�
from dual;


--trunc���ض�����
select sysdate,         --2019/8/20 15:12:23
       trunc(sysdate),   --2019/8/20
       trunc(sysdate,'year'),  --2019/1/1
       trunc(sysdate,'month'), --2019/8/1
       trunc(sysdate,'day')    --2019/8/18
from dual;

--extract ��ȡ�ꡢ�¡���
select sysdate,
       extract(year from sysdate) ���, --2019
       extract(month from sysdate) �·�,--8
       extract(day from sysdate) ��     --20
  from dual;

--------------------------------------------------------------------------
-- ת������   to_char()  to_date()  to_number()
--------------------------------------------------------------------------
--to_char() ����������  ���� -> �ַ�
select sysdate from dual;          --2019/8/20 15:51:12
select to_char(sysdate) from dual; --20-8�� -19

select to_char(sysdate,'yyyy/mm/dd hh12:mi:ss') from dual; --2019/08/20 03:53:10    hh12ʮ��Сʱ��
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') from dual; --2019/08/20 15:53:33    hh24��ʮ��Сʱ��

select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual; --2019-08-20 15:54:11

select to_char(sysdate,'yyyy��mm��dd�� hh24:mi:ss') from dual; --not ok ���ڸ�ʽ�޷�ʶ�� ,������Ҫʹ��"" ˫���������� 
select to_char(sysdate,'yyyy"��"mm"��"dd"��" hh24:mi:ss') from dual; --ok 2019��08��20�� 15:56:09

select 
       to_char(sysdate,'year'), --twenty nineteen
       to_char(sysdate,'month'),--8��
       to_char(sysdate,'day'),  --���ڶ�
       to_char(sysdate,'dy'),   --���ڶ�
       to_char(sysdate,'am'),    --����
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day am')--2019-08-20 15:59:08 ���ڶ� ����
from dual;

--TO_CHAR ������ֵ��  ��ֵ -> �ַ�
--        ע�⣺�����������͵��ַ���ת��ʱ����ʽ�еĿ��һ��Ҫ����ʵ���п�ȣ��������ʾΪ###�� 
select to_char(123.456) from dual;   --123.456
select to_char(123456789.125456,'$999,999,999.99') from dual;--$123,456,789.13
select to_char(123456789.125456,'L999,999,999.99') from dual;--��123,456,789.13

select to_char(123456789.125456,'L0999,999,999,999.99') from dual;--��0000,123,456,789.13

select to_char(123456789.125456,'L999,999.99') from dual;--#####################

--to_number �ַ� -> ��ֵ
select '123.456' + 100 from dual;  --223.456
select to_number('123.456') + 100 from dual;--223.456

select '123.456abc' + 100 from dual;  --not ok ��Ч����
select to_number('123.456abc') + 100 from dual;--not ok ��Ч����

--to_date �ַ� -> ����
select to_date('1-1��-81') from dual;--OK

select to_date('1995-10-19') from dual;--not ok �������ʽ�ַ�����ƥ��
select to_date('1995-10-19 12:24:48','yyyy-mm-dd hh24:mi:ss') from dual;  --1995/10/19 12:24:48

select to_date('1995/10/19 12:24:48','yyyy/mm/dd hh24:mi:ss') from dual;  --1995/10/19 12:24:48

select to_date('1995��10��19�� 12:24:48','yyyy"��"mm"��"dd"��" hh24:mi:ss') from dual;  --1995/10/19 12:24:48

--------------------------------------------------------------------------
-- ͨ�ú���
--------------------------------------------------------------------------
--nvl(����һ��������)  �жϲ���һ�Ƿ�Ϊnull,���Ϊnull,ȡ��������ֵ����֮��ȡ����һ�����ֵ
select ename,comm,nvl(comm,0) from emp;

--nvl2(����һ����������������) �жϲ���һ�Ƿ�Ϊnull�����Ϊnull��ȡ��������ֵ����֮��ȡ��������ֵ
select ename,comm,nvl2(comm,'����Ϊ��','����Ϊ��') from emp;

--nullif(����һ��������) �жϲ���һ==�������������ȣ�����null���������ȣ����ز���һ��ֵ
select nullif(10,10) from dual; --null
select nullif(10,20) from dual; --10
select nullif(20,10) from dual; --20

--coalesce(����һ��������................����N):�жϲ���һ�Ƿ�Ϊnull,���Ϊnull,�жϲ�������ֵ����Ϊnull��ȡ��ֵ��Ϊnull�������жϲ�����.........
select comm,coalesce(comm,0) from emp;
select comm,coalesce(comm,null,null,0,null,null) from emp;

--case....when....then...else....end ,������ if(){...}else if(){...}else{....}  �����жϺ���
select empno,ename,deptno,
       (case deptno
           when 10 then '������'
           when 20 then '���Բ�'
           when 30 then 'ʵʩ��'
           else '���Ӳ�'
       end)
 from emp;
 
 select empno,ename,deptno,
       (case
           when deptno=10 then '������'
           when deptno=20 then '���Բ�'
           when deptno=30 then 'ʵʩ��'
           else '���Ӳ�'
       end)
 from emp;


--decode() �����жϺ���
select empno,ename,deptno,decode(deptno,10,'������',20,'���Բ�',30,'ʵʩ��','���Ӳ�') from emp;


--------------------------------------------------------------------------
-- ����Ƕ�ף����к�������Ƕ��N��
--------------------------------------------------------------------------
1.��ѯԱ����Ϣ��û�о������Ա��ʾ"����BOSS"
select empno,ename,mgr,nvl(mgr,'����BOSS') from emp;--��Ч����  nvl�н�������ͬ��������
select empno,ename,mgr,lower(nvl(to_char(mgr),'����BOSS')) from emp;

--��ϰ
7.��Ա�����в�ѯ��Ա���Ĺ��ʣ�������Ӧ��˰�
�������С��1000,˰��Ϊ0��
������ʴ��ڵ���1000��С��2000��˰��Ϊ10����
������ʴ��ڵ���2000��С��3000��˰��Ϊ15����
������ʴ��ڵ���3000��˰��Ϊ20����
--��ʽһ
select ename,sal,
       (case
           when sal < 1000 then 0
           when sal>=1000 and sal<2000 then sal*0.1
           when sal>=2000 and sal<3000 then sal*0.15
           else sal*0.2
       end) Ӧ��˰��
 from emp;
 
--��ʽ��
select ename,sal,
     (case trunc(sal/1000)
         when 0 then 0
         when 1 and sal<2000 then sal*0.1
         when 2 and sal<3000 then sal*0.15
         else sal*0.2
     end) Ӧ��˰��
from emp;


--��ʽ��
select ename,sal,trunc(sal/1000),decode(trunc(sal/1000),0,0,1,sal*0.1,2,sal*0.15,sal*0.2)Ӧ��˰�� from emp;


--��ȡһ�����ڵ����
select hiredate,to_char(hiredate),substr(hiredate,-2) from emp;--80
select to_char(hiredate,'yyyy') from emp;   --1981
select extract(year from hiredate) from emp;--1981
