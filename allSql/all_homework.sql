--�ڶ��� ��д�򵥵Ĳ�ѯ���
--��ϰһ
--1.ʹ�����ַ�ʽ��ѯ����Ա��(EMP)��Ϣ

    select * from emp;
    select empno,ename,job,mgr,hiredate,sal,comm,deptno from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-9ce7495255b33239.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.��ѯ(EMP)Ա����š�Ա��������Ա��ְλ��Ա����н���������ű�š�

    select empno,ename,job,sal,deptno from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-ad767f5ad75f8f4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--��ϰ��
--1.Ա��ת������н�ϵ�20%�����ѯ������Ա��ת�������н��

select ename,sal,sal * 1.2 ת������н
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-beeabb35cc91a9a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.Ա��������6���£�ת������н�ϵ�20%��
--���ѯ������Ա��������һ�����н���ã������ǽ��𲿷�,��н��������6���µ���н+ת����6���µ���н)

select ename,sal * 6 + sal * 1.2 * 6 as ��һ����н
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-eac555b529513931.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--��ϰ��
--1.Ա��������6���£�ת������н�ϵ�20%��
--���ѯ������Ա��������һ����������루�迼�ǽ��𲿷�)��
--Ҫ����ʾ�б���ΪԱ���������������룬�������룬�����롣

select ename as Ա������,
sal * 6 + sal * 1.2 *6 as ��������,
nvl(comm,0) as ��������,
sal * 6 + sal * 1.2 *6 + nvl(comm,0) as ������
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-9f9832557dca4ecb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--��ϰ��
--1.Ա��������6���£�ת������н�ϵ�20%��
--���ѯ������Ա��������һ����������루�迼�ǽ��𲿷�)��Ҫ����ʾ��ʽΪ:XXX�ĵ�һ��������ΪXXX��

select ename,ename || '�ĵ�һ��������Ϊ' || (sal * 6 + sal * 1.2 * 6 + nvl(comm,0)) as ��н
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-bf98ce4ddd98688a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ѯԱ������һ�����ļ��ָ�λ���͡�

select distinct job from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-b20ed38d15bc26c2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--�κ���ҵ
--1.�ֱ�ѡ��Ա�������ű�н�ʵȼ����е��������ݡ�

select * from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-f2a9b9a9aca2c284.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select * from dept;
![](https://upload-images.jianshu.io/upload_images/5227364-dd1057592734ec37.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select * from salgrade;
![](https://upload-images.jianshu.io/upload_images/5227364-5cc4f799923b653f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select * from bonus;
![](https://upload-images.jianshu.io/upload_images/5227364-a9362c76a7e3bf7e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.�ֱ�鿴Ա�������ű�н�ʵȼ���ı�ṹ��
--������
--��ϰһ
--1.��ѯְλΪSALESMAN��Ա����š�ְλ����ְ���ڡ�

    select empno,job,hiredate from emp
    where job = 'SALESMAN';
![](https://upload-images.jianshu.io/upload_images/5227364-99cc1f36e3e07fb8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.��ѯ1985��12��31��֮ǰ��ְ��Ա����������ְ���ڡ�

    select ename,hiredate from emp
    where hiredate < '31-12��-85';
![](https://upload-images.jianshu.io/upload_images/5227364-18054adac50c503b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--3.��ѯ���ű�Ų���10���ŵ�Ա�����������ű�š�
select ename,deptno from emp
where deptno not in 10;
![](https://upload-images.jianshu.io/upload_images/5227364-57aacaa9c58373e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--��ϰ��
--1.��ѯ��ְ������82����85���Ա����������ְ���ڡ�

    select ename,hiredate from emp
    where hiredate between '01-1��-82' and '31-12��-85';--עд01�»ᱨ������
![](https://upload-images.jianshu.io/upload_images/5227364-448e1edb9d135f2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--2.��ѯ��н��3000��5000��Ա����������н��
select ename,sal from emp
where sal between 3000 and 5000;
![](https://upload-images.jianshu.io/upload_images/5227364-24cb153df9674fdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--3.��ѯ���ű��Ϊ10����20��Ա�����������ű�š�
select ename,deptno
from emp
where deptno in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-73fee56e271b5166.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--4.��ѯ������Ϊ7902, 7566, 7788��Ա�������������š�

select ename,mgr
from emp
where mgr in(7902,7566,7788);
![](https://upload-images.jianshu.io/upload_images/5227364-673c1ca24354e6c9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
--��ϰ��
--1.��ѯԱ��������W��ͷ��Ա��������

select ename 
from emp
where ename like 'W%';
![](https://upload-images.jianshu.io/upload_images/5227364-1cfce5d1c7161953.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ѯԱ������������2���ַ�ΪT��Ա��������

select ename 
from emp
where ename like '%T_';
![](https://upload-images.jianshu.io/upload_images/5227364-7a293d50fcb796dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.��ѯ����Ϊ�յ�Ա������������

select ename,comm
from emp
where comm is null;
![](https://upload-images.jianshu.io/upload_images/5227364-ea453936b108ba7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--��ϰ��
--1.��ѯ���ʳ���2000����ְλ��MANAGER,����ְλ��SALESMAN��Ա��������ְλ������
select ename,job,sal
from emp
where sal > 2000 and job = 'MANAGER' or job = 'SALESMAN';
![](https://upload-images.jianshu.io/upload_images/5227364-c265fe2b245184e9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--2.��ѯ���ʳ���2000����ְλ�� MANAGER��SALESMAN��Ա��������ְλ�����ʡ�
select ename,job,sal
from emp
where sal > 2000 and job in('MANAGER','SALESMAN');
![](https://upload-images.jianshu.io/upload_images/5227364-f6e490acfa66d6bd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.��ѯ������10����20�����ҹ�����3000��5000֮���Ա�����������š����ʡ�

select ename,deptno,sal
from emp
where deptno in(10,20) and sal between 3000 and 5000;
![](https://upload-images.jianshu.io/upload_images/5227364-fafe9e5897013c64.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--4.��ѯ��ְ������81�꣬����ְλ����SALES��ͷ��Ա����������ְ���ڡ�ְλ��

select ename,hiredate,job
from emp
where hiredate between '01-1��-81' and '31-12��-81' and job not like 'SALES%';
![](https://upload-images.jianshu.io/upload_images/5227364-f6d3198d2ab2a4cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--5.��ѯְλΪSALESMAN��MANAGER�����ű��Ϊ10����20����������A��Ա��������ְλ�����ű�š�

select ename,job,deptno
from emp
where job in('SALESMAN','MANAGER') and deptno in(10,20) and ename like '%A%';
![](https://upload-images.jianshu.io/upload_images/5227364-0baf5b7b6d9fe61c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--��ϰ��
--1.��ѯ������20��30��Ա�����������ű�ţ������չ�����������
select ename,deptno,sal
from emp
where deptno in(20,30) order by sal asc;
![](https://upload-images.jianshu.io/upload_images/5227364-06de2d6ac93ff5a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--2.��ѯ������2000-3000֮�䣬���Ų���10�ŵ�Ա�����������ű�ţ����ʣ������ղ������򣬹��ʽ�������

select ename,deptno,sal
from emp
where sal between 2000 and 3000 and deptno not in 10 order by deptno asc,sal desc;
![](https://upload-images.jianshu.io/upload_images/5227364-005158ce69647f24.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--3.��ѯ��ְ������82����83��֮�䣬ְλ��SALES����MAN��ͷ��Ա����������ְ���ڣ�ְλ����������ְ���ڽ�������

select ename,hiredate,job
from emp
where hiredate between '01-1��-82' and '31-12��-83' and (job like 'SALES%' or job like 'MAN%')
order by hiredate desc;
![](https://upload-images.jianshu.io/upload_images/5227364-0a47024600192e57.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--�κ���ҵ 
--1.��ѯ��ְʱ����1982-7-9֮�󣬲��Ҳ�����SALESMAN������Ա����������ְʱ�䡢ְλ��
select ename,hiredate,job
from emp
where hiredate > '09-7��-82' and job not in 'SALESMAN';
![](https://upload-images.jianshu.io/upload_images/5227364-8c908c3767948708.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ѯԱ�������ĵ�������ĸ��a��Ա��������
select ename
from emp
where ename like '__A%';
![](https://upload-images.jianshu.io/upload_images/5227364-81d9da2684cfb103.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.��ѯ����10��20�Ų��������Ա�����������ű�š�

select ename,deptno
from emp
where deptno not in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-5009cae203be67d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--4.��ѯ���ź�Ϊ30��Ա������Ϣ���Ȱ����ʽ��������ٰ������������� 
select *
from emp
where deptno in 30
order by sal desc,
ename asc;
![](https://upload-images.jianshu.io/upload_images/5227364-fbeed7ed0801147c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--5.��ѯû���ϼ���Ա��(�����Ϊ��)��Ա��������

select ename
from emp
where mgr is null;
![](https://upload-images.jianshu.io/upload_images/5227364-edf41870f675c9be.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--6.��ѯ���ʴ��ڵ���4500���Ҳ���Ϊ10����20��Ա��������\���ʡ����ű�š�

select ename,sal,deptno
from emp
where sal >= 4500 and deptno in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-65a6c5b3dc83aafe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

------ ���к���
--��ϰ1
--1.дһ����ѯ,������ĸ��д��������ĸСд��ʾ��Ա�� ename��
--��ʾ���ֵĳ��ȣ�����ÿ��һ���ʵ��ı�ǩ���������������й�Ա���ֵĿ�ʼ��ĸ��J��A �� M �Ĺ�Ա��
--���Բ�ѯ�������Ա��ename�������򡣣���ʾ��ʹ��initcap[����������ĸ��д]��length��substr��

select initcap(ename) as ����ĸ��д,
length(ename) as ���ֳ���,
substr(ename,0,1),
substr(ename,1,1),
substr(ename,2,1) 
from emp 
where substr(ename,0,1) in('J','A','m')
order by ename asc;
![](https://upload-images.jianshu.io/upload_images/5227364-7e442a5d7b794ed3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--��ϰ2
--1.��ѯԱ���������а�����д��Сд��ĸA��Ա��������

select ename,
instr(ename,'a'),
instr(ename,'A')
from emp
where instr(ename,'a') <> 0 or instr(ename,'A') <> 0;
![](https://upload-images.jianshu.io/upload_images/5227364-d4d65ea74586247a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--2.��ѯ���ű��Ϊ10��20����ְ������81��5��1��֮��
--���������а�����д��ĸA��Ա��������Ա���������ȣ���ʾ��Ҫ��ʹ��INSTR����������ʹ��like�����ж�)

select ename,
length(ename),
hiredate,
deptno,
instr(ename,'A')
from emp
where deptno in(10,20) and
hiredate > '01-5��-81' and
instr(ename,'A') <> 0;
![](https://upload-images.jianshu.io/upload_images/5227364-2e22b29589c47e07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.��ѯÿ��ְ���ı��,����������
--Ҫ�󽫲�ѯ�������ݰ���һ���ĸ�ʽ�ϲ���һ���ַ���.
--ǰ10λ�����,���㲿����*���,�����
--�м�10λ�����������㲿����*���,�����
--��10λ�����ʣ����㲿����*���,�Ҷ���

select deptno,
ename,
sal,
lpad(deptno,10,'*'),
lpad(ename,10,'*'),
rpad(sal,10,'*')  
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-dc1877dd091490b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



--��ϰ3
--1.дһ����ѯ���ֱ����100.456 �������뵽С������2λ����1λ������λ��ֵ��
select round(100.456,2),
round(100.456,1),
round(100.456,0)
from dual;
![](https://upload-images.jianshu.io/upload_images/5227364-0cabb121c4bae720.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



--2.дһ����ѯ���ֱ����100.456 ��С������2λ����1λ������λ�ضϵ�ֵ��
select trunc(100.456,2),
trunc(100.456,1),
trunc(100.456,0)
from dual;
![](https://upload-images.jianshu.io/upload_images/5227364-963a51be44d89c17.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--��ϰ4
--1.��ѯÿ��Ա����ֹ������һ����ְ�����죿
select ename,trunc(sysdate - hiredate) as ��������ְ������ 
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-a88569ce6da99300.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ǰ����Ϊ2015�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-01��������ʵ�������������Ϊ��



--3.��ǰ����Ϊ2015�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-95��������ʵ�������������Ϊ��
--4.��ǰ����Ϊ1998�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-01��������ʵ�������������Ϊ��
--5.��ǰ����Ϊ1998�ָ꣬�����ڸ�ʽΪDD-MON-RR,ָ������Ϊ01-1��-95��������ʵ�������������Ϊ��
--6.��ǰ����Ϊ2015�ָ꣬�����ڸ�ʽΪDD-MON-YY,ָ������Ϊ01-1��-01��������ʵ�������������Ϊ��
--7.��ǰ����Ϊ1998�ָ꣬�����ڸ�ʽΪDD-MON-YY,ָ������Ϊ01-1��-95��������ʵ�������������Ϊ��

--��ϰ5
--1.��ѯ��������ǰʱ��
select * from user_tables;

select sysdate 
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-3314c097d872a304.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ѯ����10,20��Ա����ֹ��2000��1��1�գ������˶��ٸ��£���ְ���·ݡ�(��ʾ��ʹ��months_between,extract)

select hiredate,
trunc(months_between('01-1��-00',hiredate)) ��������,
extract(month from hiredate)
from emp
where deptno in(10,20);
![](https://upload-images.jianshu.io/upload_images/5227364-56f411f2be6cd167.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.���Ա��������6���£���ѯְλ����MANAGER��Ա��������
--��ְ���ڣ�ת�����ڣ���ְ���ں�ĵ�һ������һ,��ְ���µ����һ�����ڡ�
--����ʾ��ʹ��add_months,next_day,last_day)

select hiredate as ��ְ����,
add_months(hiredate,6) as ת������,
next_day(hiredate,'����һ') as ��ְ��ĵ�һ������һ,
last_day(hiredate) as ��ְ���µ����һ������
from emp
where job not in 'MANAGER';
![](https://upload-images.jianshu.io/upload_images/5227364-f4a5ad5261c9f752.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



--��ϰ6
--1.��ʾ������ϵͳ��ǰʱ�䣬��ʽΪ2007-10-12 17:11:11(��ʾ��ʹ��to_char����)

select sysdate,
to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') 
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-61ef77af8f1040e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ʾename��hiredate �� ��Ա��ʼ�����������ڼ����б�ǩDAY(��ʾ��ʹ��to_char����)
select ename,hiredate,to_char(hiredate,'DAY') as DAY
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-7f13da7187c51017.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.��ѯԱ�����������ʣ���ʽ���Ĺ��ʣ���999,999.99�� (��ʾ��ʹ��to_char����)

select ename,sal,to_char(sal,'$99,999')
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-7121ef1c67c7494a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--4.���ַ���2015-3��-18 13:13:13 ת�������ڸ�ʽ���������ϵͳ��ǰʱ���������졣 (��ʾ��ʹ��to_date����)

select to_date('2015-3��-18 13:13:13','yyyy-mm"��"-dd hh24:mi:ss') as ����,
trunc(sysdate-to_date('2015-3��-18 13:13:13','yyyy-mm"��"-dd hh24:mi:ss')) as ��������
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-735cfabfb12553d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


--�κ���ҵ
--1.����2000��1��1�յ������ж����£������ܣ��������룩��

select round(months_between(sysdate,'01-1��-00')),
round(months_between(sysdate,'01-1��-00')*30/7)
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-5cf56dbdcfedca08.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--2.��ѯԱ��ENAME�ĵ�������ĸ��A��Ա������Ϣ(ʹ��2������)��

select ename,instr(ename,'A',3,1)
from emp
where instr(ename,'A',3,1) = 3;--�ӵ�����λ�ÿ�ʼ��һ�γ��ֵ�λ��
![](https://upload-images.jianshu.io/upload_images/5227364-57cf05cd81880442.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

select ename,substr(ename,3,1)
from emp
where substr(ename,3,1) in 'A';--�ӵ�����λ�ÿ�ʼ��ȡһ���ַ���
![](https://upload-images.jianshu.io/upload_images/5227364-baa62e501610cf2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--3.ʹ��trim�������ַ�����hello������  Hello ������bllb������ hello    ��
--�ֱ���õ������ַ���ello��Hello��ll��hello��
select trim(leading 'h' from 'hello'),
trim(both ' ' from ' Hello '),
trim(both 'b' from 'bllb'),
trim(trailing ' ' from 'hello    ')
from dual;
![](https://upload-images.jianshu.io/upload_images/5227364-c8327f78452f230c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--4.��Ա�����ʰ����¸�ʽ��ʾ��123,234.00 RMB ��
select sal,to_char(sal,'$99,999')
from emp;--������ֻ��д�����������������˽������������ظ�֪ѽ
![](https://upload-images.jianshu.io/upload_images/5227364-cd5e2aed44eaa5dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--5.��ѯԱ�����������侭���ţ�Ҫ�����û�о������ʾ��No Manager���ַ�����
select ename,mgr,nvl(to_char(mgr),'No Manager')
from emp; -- ��˵ nvl()��������������ͬһ���͡������򡣡������� ^o^
![](https://upload-images.jianshu.io/upload_images/5227364-58122c1d20d51a8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--6.��Ա���Ĳμӹ������ڰ����¸�ʽ��ʾ���·�/��ݡ� 
select hiredate,
extract(month from hiredate) || '/' || extract(year from hiredate) as "�·�/���"
from emp;

select hiredate,to_char(hiredate,'mm/yyyy') as "�·�/���"
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-492f68284a8b16bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--7.��Ա�����в�ѯ��Ա���Ĺ��ʣ�������Ӧ��˰��������С��1000,˰��Ϊ0��
--������ʴ��ڵ���1000��С��2000��˰��Ϊ10����������ʴ��ڵ���2000��С��3000��
--˰��Ϊ15����������ʴ��ڵ���3000��˰��Ϊ20����
select ename,sal,
case
  when sal < 1000 then 0
    when sal >=1000 and sal < 2000 then (sal-1000)*0.1
      when sal >=2000 and sal <3000 then 1000 * 0.1 + (sal - 2000) * 0.15
        when sal > 3000 then 1000 * 0.1 + 1000 * 0.15 + (sal - 3000) * 0.2
          else 0
            end as ˰��
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-11ff88c807d7af02.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

--8.����һ����ѯ��ʾ���й�Ա�� ename�� sal����ʽ��salΪ 15 ���ַ����ȣ��� $ ����䣬�б�ǩ SALARY��

select ename,sal,lpad(sal,15,'$') as SALARY
from emp;
![](https://upload-images.jianshu.io/upload_images/5227364-ec00b23990449574.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


