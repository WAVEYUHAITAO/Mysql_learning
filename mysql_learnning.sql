CREATE DATABASE IF NOT EXISTS westworld #创建数据库
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
  `gradeid` INT(10) NOT NULL COMMENT'学生的年级',
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
SELECT `studentno`,`studentresult`+1 AS '提分' FROM result

#4.3 where 条件子句
#作用：检索数据中符合条件的值

#逻辑运算符 (尽量使用英文字母)
# and &&    a and b a&&b 逻辑与
# or ||     a or b a||b  逻辑或
# not !                  逻辑非



