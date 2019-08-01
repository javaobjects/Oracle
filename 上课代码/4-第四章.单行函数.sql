--------------------������ ���к���-----------------

--ע�⣺������Ҫ��עÿ�������Ĳ���������ֵ

-------------------�ַ�����------------------
--��Сдת������
--ȫ���ַ�ת��Ϊ��д(upper)
--����α��dual���Զ�һЩ���������κα��е����ݽ��в���
select upper('hehe') from dual;

--ȫ���ַ�ת��ΪСд(lower)
select lower('HEHE') from dual;
select lower(ename) from emp;

--��ÿ�����ʵ�����ĸ��д������תΪСд��initcap��
select initcap('sQL cOUrse') from dual;
select initcap(ename) from emp;

--concat���Ӻ���(��ͬ��'||')
--��ѯ��empno��Ա������Ϊename
select concat(concat(empno,'��Ա������Ϊ'),ename) from emp;

--substr(����һ����������������)��ȡ�ַ��� 
--����һ��ʾ��ȡ��һ���ַ�������������ʾ����һλ��ʼ��ȡ����������ʾ��ȡ�೤�����������Բ�д����д��Ĭ�Ͻ�ȡ�����
select substr('heheda',3) from dual;
select substr('heheda',3,2) from dual;
select substr(ename,1,1),ename from emp;  --��ȡemp����ÿ��Ա������������ĸ

--lengthȡ����
select length(ename),ename from emp;

--��ϰ1.дһ����ѯ,������ĸ��д��������ĸСд��ʾ��Ա�� ename����ʾ���ֵĳ��ȣ�
--����ÿ��һ���ʵ��ı�ǩ���������������й�Ա���ֵĿ�ʼ��ĸ��J��A �� M �Ĺ�Ա��
--���Բ�ѯ�������Ա��ename�������򡣣���ʾ��ʹ��initcap��length��substr��
select initcap(ename) "����" , length(ename) "���ֳ���" from emp 
where substr(ename,1,1) in('J','A','M')
order by ename asc;

--����ָ�����ַ�����λ�� instr(����һ��������,��������������)  ���ص���һ��λ�ã�����һ������
--����һ������   ���������Ӵ�   ����������ʾ���ĸ�λ�ÿ�ʼ��   �����ģ��Ӵ��ڼ��γ��ֵ�λ��
select instr('Adams aam','m',2,2) from dual;
select instr('Adams aam','m') from dual;   --4
select instr('Adams aam','m',5,1) from dual;  --9


--����亯��lpad(����һ����������������)
--����һ���������ַ���  ���������������ַ����ĳ���  �����������ʲô�ַ�
--VIP0000000001
select concat('VIP',lpad('1',10,'0')) from dual;
select lpad(empno,10,'*') from emp;

--����亯��rpad(����һ����������������)
--����һ���������ַ���  ���������������ַ����ĳ���  �����������ʲô�ַ�
select concat('VIP',rpad('1',10,'0')) from dual;

--ȥ����β�ַ� trim(Ĭ��ȥ����β�ո�)
select trim(' abc ') from dual;
--ȥ����βָ���ַ�'a'
select trim('a' from 'aabcc') from dual;
--��ȥ���ײ���a
select trim(leading 'a' from 'aabaa') from dual;
--��ȥ��β����a
select trim(trailing 'a' from 'aabaa') from dual;

--�滻�ַ��� replace(����һ����������������)
--����һ������  ������������������Ĵ�  ������������������Ĵ�
select replace('abc','a','d') from dual;

--3.��ѯÿ��ְ���ı��,����������
--Ҫ�󽫲�ѯ�������ݰ���һ���ĸ�ʽ�ϲ���һ���ַ���.
--ǰ10λ�����,���㲿����*���,�����
--�м�10λ�����������㲿����*���,�����
--��10λ�����ʣ����㲿����*���,�Ҷ���

select rpad(empno,10,'*') from emp;
select rpad(ename,10,'*') from emp;
select lpad(sal,10,'*') from emp;

select concat(concat(rpad(empno,10,'*'),rpad(ename,10,'*')),lpad(sal,10,'*')) from emp;
select rpad(empno,10,'*') || rpad(ename,10,'*') || lpad(sal,10,'*') from emp;

-----------------------��ֵ����------------
--round(����һ��������)  ����һ���������������������  ���������������뵽С�����λ,�����Ļ�Ĭ���������뵽����λ
select round(123.456) from dual;
select round(123.456,2) from dual;   --123.46;

--trunc(����һ��������)  ����һ����������ȡ������  ����������ȡ��С�����λ,�����Ļ�Ĭ�Ͻ�ȡ������λ
select trunc(123.456) from dual;    --123(��ȡ������λ)
select trunc(123.456,2) from dual;   --ֱ�ӽ�ȡ  �õ�123.45

--mod��m,n��ȡ�� m%n
select mod(5,2) from dual;   --1


------------------------���ں���(�򵥽���)----------------------
--���Ҫ���������͵����㣬ֻ�ܶ�����Date���͵�����������
--sysdate ϵͳ����

--����sysdate�����ǰ��ϵͳʱ��
select sysdate from dual;

--����hiredate��sysdate������
--����emp����ÿ��Ա�������ڹ����˶��
select empno,sysdate - hiredate from emp;

--MONTHS_BETWEEN����������������������֮��������Ȼ����(��ߵ����ڼ�ȥ�ұߵ�����)
--��Ҫ���emp����ÿ��Ա�������ڹ����˶��ٸ���
select months_between(sysdate,hiredate) from emp;
select months_between(hiredate,sysdate) from emp;  --�õ�����һ������

--ADD_MONTHS������ָ�����ڼ�����Ӧ�������������
select add_months(hiredate,2) from emp;




-----------------------------ת������----------------------------
--��ʽת��
insert into emp(empno) values('7777');
select '123.456' + 10 from dual;

--��ʽת��
--to_char����������(ʵ���Զ������ڸ�ʽ�����)
--to_char(����һ��������)  ����һ�����ڸ�ʽ������   ���������Զ�������ڸ�ʽ
select hiredate from emp;
--XXXX-X��-X��  Сʱ�����ӣ�����   ������   
select to_char(hiredate,'yyyy-mm-dd HH24:MI:SS day') from emp;
select to_char(sysdate,'YYYY"��"') from dual;

--to_char������ֵ����(����ʵ����ֵ�������ݵĸ�ʽ����,Ȼ�����ַ���չʾ)
--��123456789תΪ��123,456,789.5(���ĸ�ʽλ������Ҫ���ڵ���ʵ�����ֵ�λ���������޷�ʶ��)
select to_char(123456789.5,'L999,999,999.99') from dual;  --��123,456,789.50
select to_char(123456789.5,'L99,999,999.999') from dual;   --��ʽλ������ʵ��λ�����޷�ʶ��

--to_number�����ַ���תΪ�Զ����ʽ�����֣�
--to_number(����һ��������)  ����һ����Ҫת��Ϊ���ֵ��ַ���   ����������ϣ�������ֵĸ�ʽ
--123.456
select to_number('123.456','999.999')+10 from dual;

--to_date(���ַ���תΪ�Զ����ʽ������)
--to_date(����һ��������)  ����һ����Ҫת��Ϊ�������͵��ַ���   ����������ϣ�������ڵĸ�ʽ
--'2019-3-29'
select to_date('2019-3-29','YYYY-MM-DD') from dual;
insert into emp(empno,hiredate) values(7778,'2019-3-29');  --����(��Ҫ��ת�����������͵����ݲ��ܽ��в������)

--1.��ʾ������ϵͳ��ǰʱ�䣬��ʽΪ2007-10-12 17:11:11(��ʾ��ʹ��to_char����)
select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') from dual;

--2.��ʾename��hiredate �� ��Ա��ʼ�����������ڼ����б�ǩDAY(��ʾ��ʹ��to_char����)
select ename,hiredate,to_char(hiredate,'DAY') from emp;

--4.���ַ���2015-3��-18 13:13:13 ת�������ڸ�ʽ���������ϵͳ��ǰʱ���������졣 (��ʾ��ʹ��to_date����)
select sysdate - to_date('2015-3��-18 13:13:13','YYYY-MONTH-DD HH24:MI:SS') "���ʱ��" from dual;

------------------ͨ�ú���--------------------
--nvl������һ����������  ����ֵ���������һ��Ϊ�գ����ز���һ�����򷵻ز�����
--�����emp����ÿ��Ա������н������һ����12����(��������)
select empno,sal*12+nvl(comm,0) "��н" from emp;

--nvl2(����һ��������,������)  ����ֵ���������һ��Ϊ�գ����ز����������򷵻ز�����
select nvl2(null,'Y','N') from dual;    ---�õ�N

--nullif(����һ��������)  ����ֵ:����������ȣ��򷵻�null�����򷵻ص�һ�����ʽ
select nullif('Y','N') from dual; --Y
select nullif('N','N') from dual; --null

--COALESCE(����һ��������....����n)  ���ز����б��е�һ����Ϊ�յĲ���
select coalesce(null,null,'Y') from dual;   --Y

--case���(�����ж�)
select empno,ename,deptno,(case deptno
                                  when 10 then '�з���'
                                  when 20 then '��ά��'
                                  else  '����'  
                                  end) "��������"  
from emp;


--decode���(�����ж�) 
select empno,ename,deptno,decode(deptno,10,'�з���',20,'��ά��','����') "��������"  from emp;                                 













select ename,nvl(to_char(mgr),'No Manager') mgrno from emp;








select * from emp;
 

