--0.开篇

          --什么叫数据库？ 存数据的仓库，只是它由数据库管理系统来管理

          --为什么使用数据库
          --操作是毫秒级的
          --数据是持久化存储
          --数据非常便于管理
          --存储量大
          
          --什么是数据  --无处不在


          
--1.深入了解数据库

         --关系型数据库   Oracle
         --非关系型数据库      Redis

         --进行数据库开发前一定要打开监听器服务跟service服务

         --登录sys用户    密码  XXX as sysdba  

         -- conn  用户名/口令 
         
         --第一次使用scott用户前需要先对这个用户进行解锁(先登录管理员)
              解锁scott用户 ： alter user scott account unlock;
              
              修改密码：alter user scott identified by 新密码;


--数据库管理系统  管理数据库的各种软件（数据一样，只是管理数据的软件不同）
