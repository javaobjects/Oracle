﻿create table student(
sno varchar2(10) primary key,
sname varchar2(20),
sage number(2),
ssex varchar2(5)
);
create table teacher(
tno varchar2(10) primary key,
tname varchar2(20)
);
create table course(
cno varchar2(10),
cname varchar2(20),
tno varchar2(20),
constraint pk_course primary key (cno,tno)
);
create table sc(
sno varchar2(10),
cno varchar2(10),
score number(4,2),
constraint pk_sc primary key (sno,cno)
);
--/*******初始化学生表的数据******/
insert into student values ('s001','张三',23,'男');
insert into student values ('s002','李四',23,'男');
insert into student values ('s003','吴鹏',25,'男');
insert into student values ('s004','琴沁',20,'女');
insert into student values ('s005','王丽',20,'女');
insert into student values ('s006','李波',21,'男');
insert into student values ('s007','刘玉',21,'男');
insert into student values ('s008','萧蓉',21,'女');
insert into student values ('s009','陈萧晓',23,'女');
insert into student values ('s010','陈美',22,'女');
commit;
--/******************初始化教师表***********************/
insert into teacher values ('t001', '刘阳');
insert into teacher values ('t002', '谌燕');
insert into teacher values ('t003', '胡明星');
commit;
--/***************初始化课程表****************************/
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');
commit;
--/***************初始化成绩表***********************/
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',60.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',81.9);
insert into sc values ('s001','c003','59');
commit;
--练习：
--注意：以下练习中的数据是根据初始化到数据库中的数据来写的SQL 语句，请大家务必注意。
 
--1、查询“c001”课程比“c002”课程成绩高的所有学生的学号；
select c001.* from
(select * from sc where sc.cno = 'c001') c001,
(select * from sc where sc.cno = 'c002') c002
where c001.sno = c002.sno and c001.score > c002.score;

select distinct * from
sc c001,sc c002
where c001.sno = c002.sno and c001.score > c002.score;
--2、查询平均成绩大于60 分的同学的学号和平均成绩；


select * from student;
select * from teacher;
select * from course;
select * from sc;
--3、查询所有同学的学号、姓名、选课数、总成绩；
--4、查询姓“刘”的老师的个数；
--5、查询没学过“谌燕”老师课的同学的学号、姓名；
--6、查询学过“c001”并且也学过编号“c002”课程的同学的学号、姓名；
--7、查询学过“谌燕”老师所教的所有课的同学的学号、姓名；
--8、查询课程编号“c002”的成绩比课程编号“c001”课程低的所有同学的学号、姓名；
--9、查询所有课程成绩小于60 分的同学的学号、姓名；
--10、查询没有学全所有课的同学的学号、姓名；
--11、查询至少有一门课与学号为“s001”的同学所学相同的同学的学号和姓名；
--12、查询至少学过学号为“s001”同学所有一门课的其他同学学号和姓名；
--13、把“SC”表中“谌燕”老师教的课的成绩都更改为此课程的平均成绩；
--14、查询和“s001”号的同学学习的课程完全相同的其他同学学号和姓名；
--15、删除学习“谌燕”老师课的SC 表记录；
--16、向SC 表中插入一些记录，这些记录要求符合以下条件：没有上过编号“c002”课程的同学学号、“c002”号课的平均成绩；
--17、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分
--18、按各科平均成绩从低到高和及格率的百分数从高到低顺序
--19、查询不同老师所教不同课程平均分从高到低显示
--20、统计列印各科成绩,各分数段人数:课程ID,课程名称,[100-85],[85-70],[70-60],[ <60]
--21、查询各科成绩前三名的记录:(不考虑成绩并列情况)
--22、查询每门课程被选修的学生数
--23、查询出只选修了一门课程的全部学生的学号和姓名
--24、查询男生、女生人数
--25、查询姓“张”的学生名单
--26、查询同名同性学生名单，并统计同名人数
--27、1981 年出生的学生名单(注：Student 表中Sage 列的类型是number)
--28、查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列
--29、查询平均成绩大于85 的所有学生的学号、姓名和平均成绩
--30、查询课程名称为“数据库”，且分数低于60 的学生姓名和分数
--31、查询所有学生的选课情况；
--32、查询任何一门课程成绩在70 分以上的姓名、课程名称和分数；
--33、查询不及格的课程，并按课程号从大到小排列
--34、查询课程编号为c001 且课程成绩在80 分以上的学生的学号和姓名；
--35、求选了课程的学生人数
--36、查询选修“谌燕”老师所授课程的学生中，成绩最高的学生姓名及其成绩
--37、查询各个课程及相应的选修人数
--38、查询不同课程成绩相同的学生的学号、课程号、学生成绩
--39、查询每门功课成绩最好的前两名
--40、统计每门课程的学生选修人数（超过10 人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
--41、检索至少选修两门课程的学生学号
--42、查询全部学生都选修的课程的课程号和课程名
--43、查询没学过“谌燕”老师讲授的任一门课程的学生姓名
--44、查询两门以上不及格课程的同学的学号及其平均成绩
--45、检索“c004”课程分数小于60，按分数降序排列的同学学号
--46、删除“s002”同学的“c001”课程的成绩
