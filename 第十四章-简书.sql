--## 练习1

--1. 学校有一个选课系统，其中包括如下关系模式：

--系(系编号： 主键，
--   系名称:  唯一键，
--   系主任： 非空约束，
--   系所在校区：取值范围只能在南湖校区和浑南校区)

create table tabCollege(
       cgNo number(4) 
       constraint tabCollege_cgNo_pk primary key,
       --  系编号： 主键，
       cgName varchar2(20) 
       constraint tabCollege_cgName_unique unique,
       --   系名称:  唯一键，
       cgDirector varchar2(20) 
       constraint tabCollege_cgDirector_noNull not null,
       --   系主任： 非空约束，
       cgCampus varchar2(40) 
       constraint tabCollege_cgCampus_ck check(cgCampus in ('南湖校区','浑南校区'))
       --   系所在校区：取值范围只能在南湖校区和浑南校区)
);
-- 班级(班级编号： 主键，
--     班级名称： 唯一键，
--     所属系：  外键)
create table tabClass(
       caNo number(4) 
       constraint tabClass_caNo_pk primary key,
       -- 班级编号： 主键，
       caName varchar2(40) 
       constraint tabClass_caName_unique unique,
       --     班级名称： 唯一键，
       cgName varchar2(40) 
       constraint tabClass_cgName_fk references tabCollege(cgName)
        --     所属系：  外键
);

-- 2. 创建学生表，包含如下属性:

-- 学号 定长字符型 10位 主键

-- 姓名 变长字符型 20位 非空

-- 性别 定长字符型 2位 取值范围只能为男或女

-- 出生日期 日期型 

-- 所在班级 


create table tabStudent14(
       stNo char(10) 
       constraint tabStudent14_stNo_pk primary key,
       -- 学号 定长字符型 10位 主键
       stName varchar2(20) 
       constraint tabStudent14_stName_notNull not null,
       -- 姓名 变长字符型 20位 非空
       stSex char(2) 
       constraint tabStudent14_stSex_ck check(stSex in ('男','女')),
       -- 性别 定长字符型 2位 取值范围只能为男或女
       stBirthday date,-- 出生日期 日期型 
       caNo number(4) 
       constraint tabStudent14_caNo_fk reference tabClass(caNo)
       -- 所在班级 没有要求说明是外键，但自己的思路表之间关联应该为外键
);



-- ## 课后作业

-- 1. 简述5种约束的含义。

-- not null	非空约束，指定某列的所有行数据不能包含空值
-- unique	唯一性约束，指定列或者列的组合的所有行数据必须唯一
-- primary key	主键约束，表的每行的唯一性标识，指定列或者列的组合的所有行数据必须唯一
-- foreign key	外键约束，在列及引用列上建立的一种强制依赖关系
-- check	检查性约束，在列上指定一个必须满足的条件

-- 2. 创建学生关系sc，包括属性名：

-- 选课流水号 数值型 主键；

-- 学生编号 非空 外键

-- 课程编号 非空 外键；

-- 成绩     0-100之间；


 --  为题2创建的课程表，用以设置外键foreign key
    create table tabCourse(
    cid number(4) constraint tabCourse_cis_pk primary key,    --课程编号
    cname varchar(50) constraint tabCourse_cname_unique unique--课程姓名
    --ctypeID number(4), --课程类型
    --score number(1),   --学分
    --chour number(2)   --课时
    );
    
    
create table tabSc (
       scId number(10) 
       constraint tabSc_scId_pk primary key,
       -- 选课流水号 数值型 主键；
       stNo number(10)
       constraint tabSc_scNo_fk reference tabStudent14(stNo),
       -- 学生编号 非空 外键
       cid number(4)
       constraint tabSc_cid_fk reference tabCourse(cid),
       -- 课程编号 非空 外键；
       scGrade number(5,2) 
       constraint tabSc_scGrade_ck check(scGrade bewteen 0 and 100)
       -- 成绩     0-100之间；
);


-- 3. 创建copy_emp，要求格式同emp表完全一样，不包含数据。
create table tab_copy_emp_14
as select * from emp
where 1 = 0;

-- 4. 创建copy_dept，要求格式同dept表完全一样，不包含数据。

-- 5. 设置copy_emp 表中外键deptno，参照copy_dept中deptno,语句能否成功,为什么？

-- 6. 追加copy_dept表中主键deptno
