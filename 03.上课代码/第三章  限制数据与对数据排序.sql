---------------------------------------------
--ʹ��WHERE�Ӿ�   <   <=  =  >  >=  <>
---------------------------------------------
--�Ƚ���ֵ������
1.��ѯ���ű��Ϊ10��Ա����Ϣ
select * from emp where deptno = 10;

--�Ƚ��ַ���������   ע�⣺1.ʹ��''������������  2.���ִ�Сд
2.��ѯְλΪSALESMAN��Ա����Ϣ
select * from emp where job = 'SALESMAN';
select * from emp where job = 'salesman';

--�Ƚ�������������  ע�⣺1.ʹ��''������������  2.Ĭ�����ڸ�ʽΪDD-MON-RR ����-�·�-RR��ʽ�����
3.��ѯ��ְ����Ϊ"1980/12/17"��Ա����Ϣ
select * from emp where hiredate = '17-12��-80';

4.��ѯ��ְ���ڲ�Ϊ"1980/12/17"��Ա����Ϣ
select * from emp where hiredate <> '17-12��-80';
---------------------------------------------
--����Ƚ������   BETWEEN..AND..   IN   LIKE  IS NULL
---------------------------------------------
--BETWEEN..AND..   ʹ��BETWEEN .. AND.. ��������ж�Ҫ�Ƚϵ�ֵ�Ƿ���ĳ����Χ��
1.��ѯн����800��1000֮���Ա����Ϣ
select * from emp where sal between 800 and 1000;--��������ֵ
select * from emp where sal>=800 and sal<=1000;--ͬ��
--select * from emp where 800<=sal<=1000;-- not ok

2.��ѯ82����ְ��Ա����Ϣ
select * from emp where hiredate between '1-1��-82' and '31-12��-82';
select * from emp where hiredate>='1-1��-82' and hiredate<='31-12��-82';

--IN����� ʹ��IN������ж�Ҫ�Ƚϵ�ֵ�Ƿ�ͼ����б��е��κ�һ��ֵ���
1.��ѯ���ű��Ϊ10����20��Ա����Ϣ
select * from emp where deptno in(10,20);
select * from emp where deptno = 10 or deptno = 20;--ͬ��

--LIKE����� ģ����ѯ  
--         %  ƥ����������ַ�   _ ƥ��һ��������ַ�
select * from emp where ename like 'A%';--��A��ͷ
select * from emp where ename like '%S';--��S��β
select * from emp where ename like '%S%';--����S
select * from emp where ename like '_M%';--�ڶ�����ĸΪM

select * from emp where job like 'SALES@_%' escape '@'; --��ѯ��'SALES_'��ͷ

--IS NULL �����  �ж�ֵΪ�յ�����
1.��ѯû�н����Ա����Ϣ
select * from emp where comm = null;  --not ok nullֵ������ֵ���㷵��null
select * from emp where comm is null;--ok
---------------------------------------------
--�߼������   and  or  not
---------------------------------------------
--�߼���(AND)��  Ҫ������������Ϊ��,�����Ϊ��
1.����ְλΪCLERK��ͬʱнˮ����1000��Ա����Ϣ
select * from emp where job = 'CLERK' and sal > 1000;

--�߼���(OR)��ֻ��Ҫ���������е�һ��Ϊ��,����ͷ�����
1.����ְλΪCLERK������нˮ����3000��Ա����Ϣ
select * from emp where job = 'CLERK' or sal > 3000;

--�߼���(NOT) NOT����������Ժ�IN ��BETWEEN��AND��LIKE��IS NULLһ��ʹ��
--not in
1.��ѯ���ű�Ų���10����20��Ա����Ϣ
select * from emp where deptno not in(10,20);

--not between...and
1.��ѯн�ʲ���1000��3000��Χ���ڵ�Ա����Ϣ
select * from emp where sal not between 1000 and 3000;

--not like
1.��ѯְλ����SALES��ͷ��Ա����Ϣ
select * from emp where job not like 'SALES%';

--is not null
1.��ѯ����Ϊ�յ�Ա����Ϣ
select * from emp where comm is not null;

--�߼���������ȼ��� not > and > or
1.��ѯְλΪCLERK����MANAGER��ͬʱн�ʴ���2000��Ա����Ϣ
select * from emp where job = 'CLERK' or job = 'MANAGER' and sal > 2000;--not ok
select * from emp where job = 'CLERK' or (job = 'MANAGER' and sal > 2000);--not ok ͬ��

select * from emp where (job = 'CLERK' or job = 'MANAGER') and sal > 2000;--ok

---------------------------------------------
--ORDER BY�Ӿ�    ��������(Ĭ��)  asc     ��������  desc
---------------------------------------------
--������:��������
select * from emp order by sal;         --��ֵ����  Ĭ����������
select * from emp order by sal asc;     --��ֵ����  Ĭ����������

select * from emp order by hiredate asc;--��������   Ĭ����������

select * from emp order by ename asc;   --�ַ�����   Ĭ����������

--������:��������
select * from emp order by sal desc;    --��ֵ����  ��������

--���������������� 
select * from emp order by deptno,sal;        --���ݲ������������ٸ���ÿ�����ŵ�н����������
select * from emp order by deptno asc,sal asc;--ͬ��
select * from emp order by deptno asc,sal desc;--���ݲ������������ٸ���ÿ�����ŵ�н�ʽ�������

--���б�������
select empno,ename,sal,(sal*12) yearSalary from emp order by yearSalary;

--����������������
select * from emp order by 2;--���ݵڶ�������
select * from emp order by 8;--���ݵڰ�������

select * from emp order by 9;--not ok ���ݵھ�������---�ھ��в����ڵģ�select�б��н�����8�У�ȡֵ1~8֮�䣬9����ȡֵ��Χ

select * from emp where deptno  = 10 order by 8,6;
