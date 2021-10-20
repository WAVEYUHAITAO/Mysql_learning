`smbms``jdbc`CREATE DATABASE IF NOT EXISTS westworld #创建数据库
DROP DATABASE IF EXISTS westworld #删除数据库
#tab键上面，如果你的表名或者字段名是一个特殊字符，就需要带``
USE `school`

SELECT NAME FROM student

SHOW DATABASES #查看所有的数据库

CREATE DATABASE IF NOT EXISTS school


CREATE TABLE `student` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '学号',
  `name` VARCHAR(30) NOT NULL DEFAULT '匿名' COMMENT '姓名',
  `pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT '密码',
  `sex` VARCHAR(2) NOT NULL DEFAULT '女' COMMENT '性别',
  `birthday` DATETIME DEFAULT NULL COMMENT '出生日期',
  `gradeid` INT(10) NOT NULL COMMENT'学生的年级',`smbms`
  `address` VARCHAR(100) DEFAULT NULL COMMENT '家庭住址',
  `email` VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8

SHOW CREATE DATABASE school

SHOW CREATE TABLE student


/*关于数据库引擎
INNODB 默认使用
MYISAM
*/
#更改表的一些属性和名字
ALTER TABLE student RENAME TO student1

ALTER TABLE student1 ADD age INT(11)

ALTER TABLE student1 MODIFY age VARCHAR(11) 

ALTER TABLE student1 MODIFY age1 INT(11)
ALTER TABLE student1 CHANGE age age1 INT(10)

ALTER TABLE student1 DROP age1

DROP TABLE student1

ALTER TABLE 学生 MODIFY id INT(10) PRIMARY KEY;
#创建一个表
CREATE TABLE grade(
	id INT(10) NOT NULL AUTO_INCREMENT,
	score INT(10) COMMENT'分数',
	PRIMARY KEY(id)
)ENGINE=INNODB DEFAULT CHARSET=utf8
#创建另一个表
CREATE TABLE `student` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '学号',
  `name` VARCHAR(30) NOT NULL DEFAULT '匿名' COMMENT '姓名',
  `pwd` VARCHAR(20) NOT NULL DEFAULT '123456' COMMENT '密码',
  `sex` VARCHAR(2) NOT NULL DEFAULT '女' COMMENT '性别',
  `birthday` DATETIME DEFAULT NULL COMMENT '出生日期',
  `gradeid` INT(10) NOT NULL COMMENT'学生的年级',
  `address` VARCHAR(100) DEFAULT NULL COMMENT '家庭住址',
  `email` VARCHAR(50) DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8
#创建外键
ALTER TABLE student ADD CONSTRAINT FK_GRADEID FOREIGN KEY (gradeid) REFERENCES grade (id)
#删除外键
ALTER TABLE student DROP CONSTRAINT FK_GRADEID 
ALTER TABLE student DROP INDEX FK_GRADEID












#插入语句（添加）
#--insert into表名（字段名1，字段2，字段3）values('值1'),('值2'),('值3')
INSERT INTO grade(score)VALUE (123);#插入一个值
INSERT INTO grade(id,score)VALUE (15,123);#同时插入id和score
INSERT INTO grade(score)VALUE (456),(789);#一列插入多个值
#constraint被加入的列里的数据必须满足：包含在被引用列里！
INSERT INTO student(`name`,pwd,sex,gradeid)VALUE('李四','910610','女','1')

#修改语句 update 
#指定id=1会设定这个id的名字，不带条件会全部改名
UPDATE student SET NAME = 'hito1' WHERE id =1
#修改多个属性，逗号隔开
UPDATE student SET NAME = 'hito1',email='413168358@qq.com' WHERE id =1
#通过多个条件定位数据
#操作符 = > < >= <= BETWEEN...AND...
#update也可以多个同时update，中间用逗号隔开
UPDATE student SET `name`='长江七号' WHERE `name`='李四' AND sex='男'
UPDATE student SET birthday=CURRENT_TIME WHERE `name`='长江七号'AND sex='男'
#下面是mysql5.7和mysql8.0的两种密码策略
UPDATE USER SET PLUGIN = 'mysql_native_password' WHERE `User`='root'
UPDATE USER SET PLUGIN = 'caching_sha2_password' WHERE `User`='root'
#delete命令
#语法 delete from 表名 [where 条件]
#删除数据（避免这样写，会删除全部数据）
DELETE FROM student
#删除指定数据
DELETE FROM student WHERE id =1;

#TRUNCATE命令
#作用：完全清空一个数据库表，标的结构和索引约束不会变
TRUNCATE student
#和delete 的区别
#相同点：都能删除数据，都不会删除表结构
#不同点：truncate 重新设置 自增列 计数器归零  不会影响事务  delete不会重置计数器

#4.DQL查询数据（最重点）
#4.1 DQL (data query language)
CREATE DATABASE IF NOT EXISTS `school`;
-- 创建一个school数据库
USE `school`;-- 创建学生表
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`(
	`studentno` INT(4) NOT NULL COMMENT '学号',
    `loginpwd` VARCHAR(20) DEFAULT NULL,
    `studentname` VARCHAR(20) DEFAULT NULL COMMENT '学生姓名',
    `sex` TINYINT(1) DEFAULT NULL COMMENT '性别，0或1',
    `gradeid` INT(11) DEFAULT NULL COMMENT '年级编号',
    `phone` VARCHAR(50) NOT NULL COMMENT '联系电话，允许为空',
    `address` VARCHAR(255) NOT NULL COMMENT '地址，允许为空',
    `borndate` DATETIME DEFAULT NULL COMMENT '出生时间',
    `email` VARCHAR (50) NOT NULL COMMENT '邮箱账号允许为空',
    `identitycard` VARCHAR(18) DEFAULT NULL COMMENT '身份证号',
    PRIMARY KEY (`studentno`),
    UNIQUE KEY `identitycard`(`identitycard`),
    KEY `email` (`email`)
)ENGINE=MYISAM DEFAULT CHARSET=utf8;

-- 创建年级表
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`(
	`gradeid` INT(11) NOT NULL AUTO_INCREMENT COMMENT '年级编号',
	`gradename` VARCHAR(50) NOT NULL COMMENT '年级名称',
	PRIMARY KEY (`gradeid`)
) ENGINE=INNODB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8;

-- 创建科目表
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`(
	`subjectno`INT(11) NOT NULL AUTO_INCREMENT COMMENT '课程编号',
    `subjectname` VARCHAR(50) DEFAULT NULL COMMENT '课程名称',
    `classhour` INT(4) DEFAULT NULL COMMENT '学时',
    `gradeid` INT(4) DEFAULT NULL COMMENT '年级编号',
    PRIMARY KEY (`subjectno`)
)ENGINE = INNODB AUTO_INCREMENT = 19 DEFAULT CHARSET = utf8;

-- 创建成绩表
DROP TABLE IF EXISTS `result`;
CREATE TABLE `result`(
	`studentno` INT(4) NOT NULL COMMENT '学号',
    `subjectno` INT(4) NOT NULL COMMENT '课程编号',
    `examdate` DATETIME NOT NULL COMMENT '考试日期',
    `studentresult` INT (4) NOT NULL COMMENT '考试成绩',
    KEY `subjectno` (`subjectno`)
)ENGINE = INNODB DEFAULT CHARSET = utf8;

-- 插入科目数据
INSERT INTO `subject`(`subjectno`,`subjectname`,`classhour`,`gradeid`)VALUES
(1,'高等数学-1',110,1),
(2,'高等数学-2',110,2),
(3,'高等数学-3',100,3),
(4,'高等数学-4',130,4),
(5,'C语言-1',110,1),
(6,'C语言-2',110,2),
(7,'C语言-3',100,3),
(8,'C语言-4',130,4),
(9,'Java程序设计-1',110,1),
(10,'Java程序设计-2',110,2),
(11,'Java程序设计-3',100,3),
(12,'Java程序设计-4',130,4),
(13,'数据库结构-1',110,1),
(14,'数据库结构-2',110,2),
(15,'数据库结构-3',100,3),
(16,'数据库结构-4',130,4),
(17,'C#基础',130,1);
-- 插入学生数据 其余自行添加 这里只添加了2行
INSERT INTO `student` (`studentno`,`loginpwd`,`studentname`,`sex`,`gradeid`,`phone`,`address`,`borndate`,`email`,`identitycard`)
VALUES
(1000,'123456','张伟',1,2,'13800001234','北京朝阳','1980-1-1','text123@qq.com','123456198001011234'),
(1001,'123456','赵强',1,3,'13800002222','广东深圳','1990-1-1','text111@qq.com','123456199001011233'),
(1002,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','31258521698514956'),
(1003,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','31258521695214956'),
(1004,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','31258216985214956'),
(1005,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','31258526985214956'),
(1006,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','31285216985214956'),
(1007,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','312585216985214956'),
(1008,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','31258516985214956'),
(1009,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','3125521685214956'),
(1010,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','325852169852146'),
(1011,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','1258521698524956'),
(1012,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','3258516985214956'),
(1013,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','3258569852495'),
(1014,'111111','周丹',2,2,'13326301205','山东威海','1991-7-21','413168358@qq.com','3125852814956');

-- 插入成绩数据  这里仅插入了一组，其余自行添加
INSERT INTO `result`(`studentno`,`subjectno`,`examdate`,`studentresult`)
VALUES
(1000,1,'2013-11-11 16:00:00',85),
(1000,2,'2013-11-12 16:00:00',70),
(1000,3,'2013-11-11 09:00:00',68),
(1000,4,'2013-11-13 16:00:00',98),
(1000,5,'2013-11-14 16:00:00',58),
(1000,6,'2013-11-11 16:00:00',85),
(1000,7,'2013-11-12 16:00:00',70),
(1000,8,'2013-11-11 09:00:00',68),
(1000,9,'2013-11-13 16:00:00',98),
(1000,10,'2013-11-14 16:00:00',58),
(1000,11,'2013-11-11 16:00:00',85),
(1000,12,'2013-11-12 16:00:00',70),
(1000,13,'2013-11-11 09:00:00',68),
(1000,14,'2013-11-13 16:00:00',98),
(1000,15,'2013-11-14 16:00:00',58),
(1000,16,'2013-11-11 16:00:00',85),
(1001,1,'2013-11-11 16:00:00',85),
(1001,2,'2013-11-12 16:00:00',70),
(1001,3,'2013-11-11 09:00:00',68),
(1001,4,'2013-11-13 16:00:00',98),
(1001,5,'2013-11-14 16:00:00',58),
(1001,6,'2013-11-11 16:00:00',85),
(1001,7,'2013-11-12 16:00:00',70),
(1001,8,'2013-11-11 09:00:00',68),
(1001,9,'2013-11-13 16:00:00',98),
(1001,10,'2013-11-14 16:00:00',58),
(1001,11,'2013-11-11 16:00:00',85),
(1001,12,'2013-11-12 16:00:00',70),
(1001,13,'2013-11-11 09:00:00',68),
(1001,14,'2013-11-13 16:00:00',98),
(1001,15,'2013-11-14 16:00:00',58),
(1001,16,'2013-11-11 16:00:00',85),
(1002,1,'2013-11-11 16:00:00',85),
(1002,2,'2013-11-12 16:00:00',70),
(1002,3,'2013-11-11 09:00:00',68),
(1002,4,'2013-11-13 16:00:00',98),
(1002,5,'2013-11-14 16:00:00',58),
(1002,6,'2013-11-11 16:00:00',85),
(1002,7,'2013-11-12 16:00:00',70),
(1002,8,'2013-11-11 09:00:00',68),
(1002,9,'2013-11-13 16:00:00',98),
(1002,10,'2013-11-14 16:00:00',58),
(1002,11,'2013-11-11 16:00:00',85),
(1002,12,'2013-11-12 16:00:00',70),
(1002,13,'2013-11-11 09:00:00',68),
(1002,14,'2013-11-13 16:00:00',98),
(1002,15,'2013-11-14 16:00:00',58),
(1002,16,'2013-11-11 16:00:00',85);



-- 插入年级数据
INSERT INTO `grade` (`gradeid`,`gradename`) VALUES(1,'大一'),(2,'大二'),(3,'大三'),(4,'大四'),(5,'预科班');


-- 指定查询字段  select 字段 from 表
SELECT * FROM student 
SELECT * FROM result

-- 查询指定字段
SELECT `studentno`,`studentname` FROM student 

-- 别名，给结果起一个名字 AS (可以给字段起别名也可以给表起别名)
SELECT `studentno` AS 学号,`studentname` AS 学生姓名 FROM student AS s

-- 函数 Concat(a,b)    AS可以省略
SELECT CONCAT('姓名: ',studentname) AS 新名字 FROM student

# 去重复 distinct
-- 查询一下有哪些同学参加了考试，成绩

SELECT * FROM result -- 查询全部的考试成绩
SELECT studentno FROM result -- 查询有哪些同学参加了考试
-- 发现数据重复，去重
SELECT DISTINCT studentno FROM result -- 作用，去除select查询出来的结果中重复的数据

SELECT VERSION() -- 查询系统版本号

SELECT 100*3+2 AS 计算结果 -- 用来计算

SELECT @@auto_increment_increment -- 查询自增的步长

-- 学员考试成绩+1分 
SELECT `studentno`,`studentresult`+1 AS '提分' FROM result;

#4.3 where 条件子句
#作用：检索数据中符合条件的值

#逻辑运算符 (尽量使用英文字母)
# and &&    a and b a&&b 逻辑与
# or ||     a or b a||b  逻辑或
# not !     not a   !a   逻辑非

-- 从result表中查询95到100分的学生, AND 可以用&&替换
SELECT `studentno`,`studentresult`FROM result 
WHERE `studentresult`>=95 AND `studentresult`<=100;

-- 模糊查询（区间）
SELECT `studentno`,`studentresult`FROM result 
WHERE `studentresult` BETWEEN 95 AND 100;

-- != not
SELECT `studentno`,`studentresult`FROM result 
WHERE  NOT `studentno` =1000;



#模糊查询 ：比较运算符
#运算符       语法                    描述
#IS NULL      a is null               如果操作符为null，结果为真
#IS NOT NULL  a is not null           如果操作符不为null，结果为真
#BETWEEN      a between b and c	      若a在b和c之间，则返回为真
#Like         a like b		      SQL匹配，如果a匹配b，则结果为真
#In           a in(a1,a2,a3...)       假设a在a1，或者a2...其中的某一个值中，结果为真

-- 查询姓刘的同学
-- like结合 %（代表0到任意个字符）
SELECT `studentno`,`studentname`FROM student
WHERE studentname LIKE '刘%';

-- 查询姓刘的同学，后面只有一个字的
SELECT `studentno`,`studentname`FROM student
WHERE studentname LIKE '刘_';

-- 查询姓刘的同学，后面只有两个字的
SELECT `studentno`,`studentname`FROM student
WHERE studentname LIKE '刘__';

-- 查询名字中间有嘉字的同学 %嘉%

SELECT `studentno`,`studentname`FROM student
WHERE studentname LIKE '%嘉%';

-- in关键字查询  
-- 查询1001,1002,1003号学员
SELECT `studentno`,`studentname`FROM student
WHERE studentno IN (1001,1002,1003);

-- 查询威海的学生，IN关键字必须是完全符合表内容的值，不支持 % 模糊查询
SELECT`studentno`,`studentname` FROM student
WHERE `address` IN ('山东威海')


-- null /not null
-- 查询地址为空的学生 null ''
SELECT `studentno`,`studentname`FROM student
WHERE address IS NULL OR address =''

-- 查询有出生日期的同学 不为空
SELECT `studentno`, `studentname`FROM student
WHERE `address` IN ('山东威海')

-- 查询没有出生日期的同学 为空
SELECT `studentno`,`studentname`FROM student
WHERE address = ''

#4.4联表查询

#JOIN对比
-- 查询参加了考试的同学（学号，姓名，科目编号，分数）
SELECT * FROM student
SELECT * FROM result

/*思路
1.分析需求，分析查询的字段来自哪些表，（连接查询）
2.确定使用哪种连接查询？ 7种
  确定交叉点（这两个表中哪个数据是相同的）
  判断的条件：学生表的中 studentNo = 成绩表 studentNo
*/

-- join on(条件判断) 连接查询
-- where   等值查询

-- Inner Join
SELECT s.`studentno`,`studentname`,`sex`,`identitycard`
FROM student AS s
INNER JOIN result AS r
ON s.studentno = r.studentno

-- Right Join
SELECT s.`studentno`,`studentname`,`sex`,`identitycard`
FROM student s 
RIGHT JOIN result r
ON s.studentno = r.studentno

-- Left Join
SELECT s.`studentno`,`studentname`,`sex`,`identitycard`
FROM student s 
LEFT JOIN result r
ON s.studentno = r.studentno

-- 查询缺考的同学
SELECT s.`studentno`,`studentname`,`sex`,`identitycard`
FROM student s 
LEFT JOIN result r
ON s.studentno = r.studentno
WHERE identitycard IS NULL

-- 思考题(查询了参加考试的同学信息：学号，学生姓名，科目名，分数)

SELECT s.studentno,studentname,sub.subjectno, studentresult
FROM student s 
RIGHT JOIN result r
ON r.studentno = s.studentno
INNER JOIN `subject` sub
ON r.subjectno = sub.subjectno

#自连接
#自己的表和自己的表连接，核心，一张表拆为两张一样的表即可
CREATE TABLE category(
	`categoryid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主题id',
	`pid` INT(10) NOT NULL COMMENT'父id',
	`categoryName` VARCHAR(50) NOT NULL COMMENT '主题名字',
	PRIMARY KEY(`categoryid`)
)ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8

INSERT INTO category (`categoryid`,`pid`,`categoryName`)
VALUES('2','1','信息技术'),
('3','1','软件开发'),
('4','3','数据库'),
('5','1','美术设计'),
('6','3','web开发'),
('7','5','ps技术'),
('8','2','办公信息')

-- 查询父子信息

SELECT a.categoryName AS '父栏目', b.categoryName AS '子栏目'
FROM category AS a, category AS b
WHERE a.categoryid = b.pid


#分页 limit 和排序 order by
-- 排序： 升序 ASC  降序 DESC
-- ORDER BY通过那个字段排序，怎么排
-- 查询的结果根据 成绩降序 排序
SELECT s.studentno,studentname,subjectname, studentresult
FROM student s 
RIGHT JOIN result r
ON r.studentno = s.studentno
INNER JOIN `subject` sub
ON r.subjectno = sub.subjectno
ORDER BY studentresult ASC

-- 分页，100万数据
-- 为什么要分页？
-- 缓解数据库压力，给人的体验更好，  瀑布流

-- 分页，每页只显示五条数据
-- 语法： limit 起始值，页面大小
-- limit 0,5  1~5
-- limit 1,5  2~6
-- limit 6,5  1~5
SELECT s.studentno,studentname,subjectname, studentresult
FROM student s 
RIGHT JOIN result r
ON r.studentno = s.studentno
INNER JOIN `subject` sub
ON r.subjectno = sub.subjectno
ORDER BY studentresult ASC
LIMIT 1,5

-- 第一页 limit 0,5 (1-1)*5
-- 第一页 limit 5,5 (2-1)*5
-- 第一页 limit 10,5 (3-1)*5
-- 第N页 limit 0,5 (N-1)*pagesize
-- pagesize:页面大小
-- (n-1)*pagesize起始页
-- n:当前页
-- 数据总数/页面大小=总页数

-- 思考：
-- 查询 java第一学年 课程成绩排名前十的学生，并且分数要大于80的学生信息（学号，姓名，课程名称，分数）
SELECT s.studentno,studentname,subjectname,studentresult
FROM student s
INNER JOIN result r
ON s.studentno = r.studentno
INNER JOIN `subject` sub
ON sub.subjectno = r.subjectno
WHERE subjectname = 'Java程序设计-1' AND studentresult>=80
ORDER BY studentresult DESC
LIMIT 0,10

#4.6子查询

-- where(值是固定的，这个值是计算出来的)
-- 本质：在where中嵌套一个句子

-- 查询数据库结构-1的所有考试结果（学号，科目名称，成绩），降序排列
-- 方式一 连接查询
SELECT studentno, r.subjectno,studentresult
FROM result r
INNER JOIN `subject` sub
ON r.subjectno = sub.subjectno 
WHERE subjectname = '数据库结构-1'
ORDER BY studentresult DESC

-- 方式二: 使用子查询
SELECT studentno, subjectno,studentresult
FROM result 
WHERE subjectno = (
	SELECT subjectno FROM `subject`
	WHERE subjectname = '数据库结构-1'
)
ORDER BY studentresult DESC

-- 分数不小于80分的学生的学号和姓名
-- 方式一
SELECT  s.studentno,studentname 
FROM student s
INNER JOIN result r
ON r.studentno = s.studentno
WHERE studentresult>=80

-- 方式二, 
SELECT studentno, studentname 
FROM student 
WHERE studentno IN (
	SELECT studentno FROM result
	WHERE studentresult>=80
)

-- 练习：查询 c语言-1 前5名同学的成绩的信息(学号，姓名，分数)
-- 使用子查询~

SELECT r.studentno,studentname,studentresult
FROM result r
INNER JOIN student s
ON r.studentno = s.studentno 
INNER JOIN `subject` sub
ON r.subjectno = sub.subjectno
WHERE subjectname = 'c语言-1'
ORDER BY studentresult DESC
LIMIT 0,5;



#5.MySQL函数
#5.1常用函数(不常用)
SELECT ABS(-8) -- 绝对值
SELECT CEILING(8.5) -- 向上取整
SELECT FLOOR(8.5) -- 向下取整
SELECT RAND() -- 返回一个0到1之间的随机数
SELECT SIGN(-8) -- 判断一个数的符号 (0)-(0) 负数- (-1) 正数- (1)

-- 字符串函数
SELECT CHAR_LENGTH('fdasdfda') -- 字符串长度
SELECT CONCAT('我','爱','你们') -- 拼接字符串
SELECT INSERT('我爱编程helloworld',1,2,'超级热爱') -- 指定位置插入并替换指定长度
SELECT LOWER('Hito') -- 小写
SELECT UPPER('Hito') -- 大写
SELECT INSTR('kuangshen','h') -- 返回第一次出现该字符串的位置索引
SELECT REPLACE('坚持就能成功','成功','失败')
SELECT SUBSTR('坚持就能成功',4,2)
SELECT REVERSE('坚持就能成功') -- 反转

-- 查询姓周的同学，将姓改为 邹
SELECT REPLACE(studentname,'周','邹') FROM student
WHERE studentname LIKE '周%'

-- 时间和日期函数(记住)
SELECT CURRENT_DATE() -- 获取当前日期
SELECT CURRENT_TIME() -- 获取当前时间
SELECT NOW() -- 获取当前日期+时间
SELECT LOCALTIME() -- 本地时间
SELECT SYSDATE() -- 系统时间

SELECT YEAR(NOW()) -- 年
SELECT MONTH(NOW()) -- 月
SELECT DAY(NOW()) -- 日
SELECT HOUR(NOW()) -- 时
SELECT MINUTE(NOW()) -- 分
SELECT SECOND(NOW()) -- 秒

-- 系统
SELECT SYSTEM_USER()
SELECT USER()
SELECT VERSION()

#5.2聚合函数(常用)

#函数名称
COUNT()  -- 计数
SUM() -- 求和
AVG() -- 平均

SELECT COUNT(studentname) FROM student;  -- Count(指定列),会忽略所有的null值
SELECT COUNT(*) FROM student; -- Count(*) ,不会忽略null,本质计算行数
SELECT COUNT(1) FROM student; -- Count(1) ,不会忽略null,本质计算行数

SELECT SUM(studentresult) AS 总和 FROM result
SELECT AVG(studentresult) AS 总和 FROM result
SELECT MAX(studentresult) AS 总和 FROM result
SELECT MIN(studentresult) AS 总和 FROM result

-- 查询不同课程的平均分，最高分，最低分
-- 核心： 根据不同的课程分组
SELECT subjectname, AVG(studentresult) 平均分,MAX(studentresult) 最高分,MIN(studentresult) 最低分
FROM result r
INNER JOIN `subject` sub
ON r.subjectno = sub.subjectno
GROUP BY r.subjectno
HAVING 平均分>=80  -- 通过having关键字来分组过滤
 

#5.3 数据库级别的MD5加密
CREATE TABLE testmd5(
	`id` INT(4)NOT NULL,
	`name`VARCHAR(20)NOT NULL,
	`pwd`VARCHAR(20)NOT NULL,
	PRIMARY KEY(`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8
-- 明文密码
INSERT INTO testmd5 VALUES
(1,'zhangsan','123456'),
(2,'lisi','123456'),
(3,'wangwu','123456')
-- 加密
ALTER TABLE testmd5 MODIFY pwd VARCHAR(50)
UPDATE testmd5 SET pwd=MD5(pwd) WHERE id=1 -- 加密第一行
UPDATE testmd5 SET pwd=MD5(pwd) -- 加密全部密码
-- 插入的时候加密
INSERT INTO testmd5 VALUES(4,'xiaoming',MD5('123456'))
-- 如何校验：将用户传递进来的密码，进行MD5加密，然后比对加密后的值
SELECT * FROM testmd5 WHERE `name` ='xiaoming' AND pwd=MD5('123456') -- 查询加密后的密码



#6 事务(Transaction)
#6.1什么是事务？
-- 要么都成功，要么都失败
-- -----------------------
-- 1.SQL执行 A给B 转账 A 1000 -->200 B 200
-- 2.SQL执行 B收到A的钱 A800 --> B 400
-- -----------------------
-- 核心：将一组SQL放在一个批次中去执行 innodb 和myisam最新版都支持
-- 事务原则： ACID原则 
-- 原子性(Atomicity) :原子性表示，这两个步骤一起成功，或一起失败，不能只发生其中一个动作
-- 一致性(Consistency) ：针对一个事务操作前与操作后的状态一致 （最终一致性），无论怎么转总体不变1200
-- 隔离性(Isolation) ：多个用户并发访问数据库时，数据库为每一个用户开启的事务，不能被其他事务干扰，事务之间相互隔离
-- 持久性(Durability)：表示事务结束后的数据不随着外界原因导致数据丢失，意思就是假设停电宕机，如果还没提交就是1000,200，提交后就是800,400



-- 事务的隔离级别
-- 脏读 指一个事务读取了另一个事务未提交的数据
-- 不可重复读 多次读取结果不一致
-- 虚读（幻读）



#执行事务

-- mysql 是默认开启事务自动提交的
SET autocommit =0 /*关闭*/
SET autocommit =1 /*开启(默认的)*/

-- 手动处理事务
SET autocommit =0 -- 关闭自动提交

-- 事务开启
START TRANSACTION -- 标记一个事务的开始，从这个之后的 sql 都在同一个事务内

INSERT xx
INSERT xx

-- 提交：持久化（成功！）
COMMIT

-- 回滚：回到原来的样子（失败！）
ROLLBACK

-- 事务结束
SET autocommit =1 /*开启自动提交(默认的)*/

-- 了解
SAVEPOINT 保存点名 -- 设置一个事务的保存点
ROLLBACK TO SAVEPOINT 保存点名 -- 回滚到保存点
RELEASE SAVEPOINT 保存点名 -- 撤销保存点

-- 转账 collate排序规则
CREATE DATABASE shop CHARACTER SET utf8 COLLATE utf8_general_ci
USE shop

CREATE TABLE `account`(
	`id` INT(3)NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30)NOT NULL,
	`money` DECIMAL(9,2)NOT NULL,
	PRIMARY KEY(`id`)
)ENGINE=INNODB DEFAULT CHARSET=utf8

INSERT INTO account(`name`,`money`) VALUES
('A',2000),
('B',10000)

-- 模拟转账
SET autocommit = 0; -- 关闭自动提交
START TRANSACTION -- 开启一个事务
UPDATE account SET money=money-500 WHERE `name`='A'; -- A减500
UPDATE account SET money=money+500 WHERE `name`='B'; -- B减500

COMMIT;  -- 提交事务,事务一旦提交，就被持久化，回滚就会失败
ROLLBACK; -- 回滚事务

SET autocommit =1; -- 恢复默认值


#7.索引  MySQL官方对索引的定义为：索引(index)是帮助MySQL高效获取数据的数据结构。
#                                 提取句子主干，就可以得到索引的本质：索引是数据结构

#7.1索引的分类

-- 主键索引 (PRIMARY KEY)
	-- 唯一的标识，主键不可重复
-- 唯一索引 (UNIQUE KEY)
	-- 避免重复的列出现，多个列都可以标识为唯一索引
-- 常规索引 (KEY/INDEX)
	-- 默认，index. key关键字来设置
-- 全文索引 (FullText)
	-- 在特定的数据库引擎下才有


-- 索引的使用
-- 1.在创建表的时候给字段增加索引
-- 2.创建完毕后，增加索引

-- 显示所有的索引信息
USE `school`;
SHOW INDEX FROM student;

-- 增加一个全文索引    索引名（列名）
ALTER TABLE `student` ADD FULLTEXT INDEX `studentname`(`studentname`);

-- EXPLAIN 分析sql执行的状况
EXPLAIN SELECT * FROM student; -- 非全文索引
EXPLAIN SELECT * FROM student WHERE MATCH(studentname) AGAINST('刘');

#7.2测试索引


CREATE TABLE `app_user` (
`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`name` VARCHAR(50) DEFAULT '' COMMENT '用户昵称',
`email` VARCHAR(50) NOT NULL COMMENT '用户邮箱',
`phone` VARCHAR(20) DEFAULT '' COMMENT '手机号',
`gender` TINYINT(4) UNSIGNED DEFAULT 0 COMMENT '性别（0：男;1:女）',
`password` VARCHAR(100) NOT NULL COMMENT '密码',
`age` TINYINT(4) DEFAULT 0  COMMENT '年龄',
`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
`update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COMMENT = 'app用户表'

-- 插入100万数据
DELIMITER$$ -- 写函数之前必需要写，标志,这里必须写两个dollar符号
CREATE FUNCTION mock_data1()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE num INT DEFAULT 1000000;
	DECLARE i INT DEFAULT 0;
	WHILE i<num DO 
		-- 插入语句
		INSERT INTO app_user(`name`,`email`,`phone`,`gender`,`password`,`age`)
		VALUES(CONCAT('用户',i),'413168358@qq.com',FLOOR(CONCAT('18',RAND()*(999999999-100000000)+100000000)),
		FLOOR(RAND()*2),UUID(),FLOOR(RAND()*100));
		SET i = i+1;
	END WHILE;
	RETURN i;

END$

DROP FUNCTION mock_data; -- 删除函数

SELECT mock_data1(); -- 使用函数

TRUNCATE app_user; -- 删除表里的全部数据，重置计数器

SELECT * FROM app_user WHERE `name` = '用户9999'; -- 耗时1.070s

EXPLAIN SELECT * FROM app_user WHERE `name` = '用户9999';

-- 索引起名  id_表名_字段名
-- CREATE INDEX 索引名 ON 表（字段）
CREATE INDEX id_app_user_name ON app_user(`name`); 
SELECT * FROM app_user WHERE `name` = '用户9999'; -- 创建索引后，耗时0.001s
EXPLAIN SELECT * FROM app_user WHERE `name` = '用户9999'; -- 分析sql语句

-- 索引在小数据量的时候，用处不大，但是在大数据的时候，区别十分明显


#7.3 索引原则
-- 1.索引不是越多越好
-- 2.不要对经常变动的数据加索引
-- 3.小数据量的表不需要加索引
-- 4.索引一般加在经常查询的字段上

# 索引的数据结构

-- Hash 类型的索引
-- Btree: InnoDB的默认数据结构~
-- 阅读 https://blog.csdn.net/shawjan/article/details/48917791


#8.基础备份
-- 为什么要备份：
--	保证重要数据不丢失
--	数据转移A-->B
-- Mysql 数据库备份的方式
-- 1.直接拷贝物理文件
-- 2.在sqlyog这种可视化工具中手动导出
-- 3.使用命令行导出 mysqldump	

# mysqldump(导出备份)的使用
-- mysqldump -h主机 -u用户 -p密码 数据库 表1 表2 表3 > 磁盘位置
-- mysqldump -hlocalhost -uroot -p123456 school student > F:\repositories\MySQL-learning


# 命令行导入 sql 
-- cmd，先登陆数据库，进入某一个数据库
-- source 备份文件在磁盘位置       
-- mysql -uroot -p123456  数据库 < 磁盘位置




#9.权限管理
-- 9.1用户管理
-- SQLyog 可视化管理
-- 添加删除用SQLyog上面的小红人
-- 本质还是对mysql里的user表增删改查
ALTER USER hito@localhost IDENTIFIED WITH mysql_native_password BY '123456'; -- sqlyog新建用户使用mysql5.7密码验证方式caching_sha2_password需要修改成mysql_native_password

-- 创建用户 CREATE USER 用户名 IDENTIFIED BY '密码'
CREATE USER hito IDENTIFIED BY '123456'

-- 修改密码/修改密码验证规则 (修改当前用户密码)
ALTER USER hito IDENTIFIED WITH mysql_native_password;
ALTER USER hito IDENTIFIED BY '23456';

-- 重命名用户
RENAME USER hito TO hito01;

-- 用户授权 ALL PRIVILEGES 全部的权限， 库.表
-- ALL PRIVILEGES 除了给别人授权，其他都能干
GRANT ALL PRIVILEGES ON *.* TO hito01;
GRANT ALL PRIVILEGES ON *.* TO hito01 WITH GRANT OPTION;
-- 查询指定用户权限
-- root用户的权限就是在后面加上with grant option
SHOW GRANTS FOR hito01 
SHOW GRANTS FOR root@localhost

-- 撤销权限 REVOKE 哪些权限，在那个库撤销，给谁撤销
REVOKE ALL PRIVILEGES ON *.* FROM hito01;  -- 撤销用户所有权限
REVOKE GRANT OPTION ON *.* FROM hito01; -- 撤销指定权限

-- 删除用户
DROP USER hito01;

#10.规范数据库设计
-- 10.1 为什么需要设计
-- 当数据库比较复杂的时候，我们就需要设计了
-- 糟糕的数据库设计：
-- 	数据库冗余，浪费空间
--	数据库插入和删除都会很麻烦(屏蔽使用外键)
-- 良好的数据库设计：
-- 	节省内存空间
--	保证数据库的完整性
--	方便我们开发系统
-- 软件开发中，关于数据库的设计
--	分析需求：分析业务和需要处理的数据库的需求
--	概要设计：设计关系图E-R图

-- 设计数据库的步骤：(个人博客)
--	收集信息，分析需求
--		用户表(用户登陆注销，用户的个人信息,写博客,创建分类)
--		分类表(文章分类，谁创建的)
--		文章表(文章的信息)
--		评论表
--		友情链接表（友链信息）
--		自定义表(系统信息，某个关键的字，或者一些字段) key: value
--	标识实体(把需求落地到每个字段)
--  	标识实体之间的关系
--		写博客：user->blog
--		创建分类：user->category
--		关注：user->user
--		友链：links




#10.数据库规约，三大范式

-- 为什么需要数据规范化？
-- 信息重复
-- 更新异常
-- 插入异常
--	无法正常显示信息
-- 删除异常
--	丢失有效信息，文章删除了，标签还在


-- 考虑商业化的需求和目标

# 。。。业务级别MySQL学习


#第一范式（1NF）：要求数据库表的每一列都是不可分割的原子数据项。

#第二范式（2NF）：在1NF的基础上，非码属性必须完全依赖于候选码（在1NF基础上消除非主属性对主码的部分函数依赖）

#第二范式需要确保数据库表中的每一列都和主键相关，而不能只与主键的某一部分相关（主要针对联合主键而言）。
#第三范式（3NF）：在2NF基础上，任何非主属性不依赖于其它非主属性（在2NF基础上消除传递依赖）

# 规范性和性能的问题

-- 关联查询的表不得超过三张表
-- 考虑到商业化的需求和目标 数据库的性能更加重要
-- 在规范性能的问题的时候，需要适当的考虑一下规范性
-- 故意给某些表增加一些冗余的字段 (从多表查询变为单表查询)
-- 故意增加一些计算列(从大数据量降低为小数据量的查询，索引)




#11 JDBC(重点)
#11.1 数据库驱动
#SUN公司为了简化 开发人员的(对数据库的统一)操作，提供了(JAVA操作数据库的)一个规范，俗称JDBC
#这些规范的实现由具体的厂商去做
#对于开发人员来说，只需要了解JDBC即可


#创建测试数据库
CREATE DATABASE `jdbcStudy` CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `jdbcStudy`;

CREATE TABLE `users`(
 `id` INT PRIMARY KEY,
 `NAME` VARCHAR(40),
 `PASSWORD` VARCHAR(40),
 `email` VARCHAR(60),
  birthday DATE
);

INSERT INTO `users`(`id`,`NAME`,`PASSWORD`,`email`,`birthday`)
VALUES(1,'zhangsan','123456','zs@sina.com','1980-12-04'),
(2,'lisi','123456','lisi@sina.com','1981-12-04'),
(3,'wangwu','123456','wangwu@sina.com','1979-12-04')



CREATE TABLE users(
	id INT PRIMARY KEY,
	`name` VARCHAR(40),
	`password` VARCHAR(40),
	`email` VARCHAR(60),
	`birthday` DATE


);
INSERT INTO users(id,`name`,`password`,`email`,birthday)
VALUES(1,'张三','123456','ht@qq.com','2020-01-01');
INSERT INTO users(id,`name`,`password`,`email`,birthday)
VALUES(2,'李四','123456','ls@qq.com','2020-01-01');
INSERT INTO users(id,`name`,`password`,`email`,birthday)
VALUES(3,'王五','123456','wz@qq.com','2020-01-01');


CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(40),
	money FLOAT

);
INSERT INTO account(`name`,money)VALUES('A',1000);
INSERT INTO account(`name`,money)VALUES('B',1000);
INSERT INTO account(`name`,money)VALUES('C',1000);

#SMBMS项目
CREATE DATABASE smbms CHARACTER SET utf8 COLLATE utf8_general_ci;
DROP DATABASE smbms;
CREATE TABLE `smbms_user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userCode` VARCHAR(15) DEFAULT NULL COMMENT '用户编码',
  `userName` VARCHAR(15) DEFAULT NULL COMMENT '用户名字',
  `userPassword` VARCHAR(20) DEFAULT NULL COMMENT '用户密码',
  `gender` INT(10) DEFAULT NULL COMMENT '性别',
  `birthday` DATE DEFAULT NULL COMMENT '出生日期',
  `phone` VARCHAR(20) DEFAULT NULL COMMENT '电话',
  `address` VARCHAR(30) DEFAULT NULL COMMENT '地址',
  `userRole` BIGINT(20) DEFAULT NULL COMMENT '用户角色',
  `createdBy` BIGINT(20) DEFAULT NULL COMMENT '创建者',
  `creationDate` DATETIME DEFAULT NULL COMMENT '创建时间',
  `modifyBy` BIGINT(20) DEFAULT NULL COMMENT '更新者',
  `modifyDate` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `smbms_role` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `roleCode` VARCHAR(30) DEFAULT NULL COMMENT '角色编码',
  `roleName` VARCHAR(15) DEFAULT NULL COMMENT '角色名称',
  `createdBy` BIGINT(20) DEFAULT NULL COMMENT '创建者',
  `creationDate` DATETIME DEFAULT NULL COMMENT '创建时间',
  `modifyBy` BIGINT(20) DEFAULT NULL COMMENT '更新者',
  `modifyDate` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `smbms_provider` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `proCode` VARCHAR(15) DEFAULT NULL COMMENT '供应商编码',
  `proName` VARCHAR(15) DEFAULT NULL COMMENT '供应商名称',
  `proDesc` VARCHAR(50) DEFAULT NULL COMMENT '供应商描述',
  `proContact` VARCHAR(15) DEFAULT NULL COMMENT '供应商联系人',
  `proPhone` VARCHAR(20) DEFAULT NULL COMMENT '供应商电话',
  `proAddress` VARCHAR(30) DEFAULT NULL COMMENT '供应商地址',
  `proFax` VARCHAR(20) DEFAULT NULL COMMENT '供应商传真',
  `createdBy` BIGINT(20) DEFAULT NULL COMMENT '创建者',
  `creationDate` DATETIME DEFAULT NULL COMMENT '创建时间',
  `modifyBy` BIGINT(20) DEFAULT NULL COMMENT '更新者',
  `modifyDate` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `smbms_bill` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `billCode` VARCHAR(30) DEFAULT NULL COMMENT '账单编码',
  `productName` VARCHAR(20) DEFAULT NULL COMMENT '商品名称',
  `productDesc` VARCHAR(50) DEFAULT NULL COMMENT '商品描述',
  `productUnit` VARCHAR(60) DEFAULT NULL COMMENT '商品数量',
  `productCount` DECIMAL(20,2) DEFAULT NULL COMMENT '总金额',
  `totalPrice` DECIMAL(20,2) DEFAULT NULL COMMENT '是否支付',
  `isPayment` INT(10) DEFAULT NULL COMMENT '供应商ID',
  `createdBy` BIGINT(20) DEFAULT NULL COMMENT '创建者',
  `creationDate` DATETIME DEFAULT NULL COMMENT '创建时间',
  `modifyBy` BIGINT(20) DEFAULT NULL COMMENT '更新者',
  `modifyDate` DATETIME DEFAULT NULL COMMENT '更新时间',
  `prividerId` INT(10) DEFAULT NULL COMMENT '供应商ID',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `smbms_address` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `contact` VARCHAR(15) DEFAULT NULL COMMENT '联系人姓名',
  `addressDesc` VARCHAR(50) DEFAULT NULL COMMENT '收货地址',
  `postCode` VARCHAR(15) DEFAULT NULL COMMENT '邮编',
  `tel` INT(20) DEFAULT NULL COMMENT '联系人电话',
  `createdBy` VARCHAR(20) DEFAULT NULL COMMENT '创建者',
  `creationDate` DATETIME DEFAULT NULL COMMENT '创建时间',
  `modifyBy` BIGINT(20) DEFAULT NULL COMMENT '修改者',
  `modifyDate` DATETIME DEFAULT NULL COMMENT '修改时间',
  `userId` BIGINT(20) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;




CREATE DATABASE `mybatis`;

USE `mybatis`;

CREATE TABLE `user`(
`id` INT(20) NOT NULL,
`name` VARCHAR(30) DEFAULT NULL,
`pwd` VARCHAR(30) DEFAULT NULL,
PRIMARY KEY(`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


INSERT INTO `user`(`id`,`name`,`pwd`) VALUES
(1,'海涛','123456'),
(2,'张三','223456'),
(3,'刘蔓','323456');

CREATE TABLE `teacher` (
  `id` INT(10) NOT NULL,
  `name` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO teacher(`id`, `name`) VALUES (1, '秦老师'); 

CREATE TABLE `student` (
  `id` INT(10) NOT NULL,
  `name` VARCHAR(30) DEFAULT NULL,
  `tid` INT(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fktid` (`tid`),
  CONSTRAINT `fktid` FOREIGN KEY (`tid`) REFERENCES `teacher` (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
INSERT INTO `student` (`id`, `name`, `tid`) VALUES (1, '小明', 1); 
INSERT INTO `student` (`id`, `name`, `tid`) VALUES (2, '小红', 1); 
INSERT INTO `student` (`id`, `name`, `tid`) VALUES (3, '小张', 1); 
INSERT INTO `student` (`id`, `name`, `tid`) VALUES (4, '小李', 1); 
INSERT INTO `student` (`id`, `name`, `tid`) VALUES (5, '小王', 1);


CREATE TABLE `blog`(
`id` VARCHAR(50) NOT NULL COMMENT '博客id',
`title` VARCHAR(100) NOT NULL COMMENT '博客标题',
`author` VARCHAR(30) NOT NULL COMMENT '博客作者',
`create_time` DATETIME NOT NULL COMMENT '创建时间',
`views` INT(30) NOT NULL COMMENT '浏览量'
)ENGINE=INNODB DEFAULT CHARSET=utf8;
