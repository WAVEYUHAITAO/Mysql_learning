package com.hito.lesson01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//我的第一个JDBC程序
public class JdbcFirstDemo {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        // 1.加载驱动
        // jdbc4.0之后不需要显式的去加载驱动，如果驱动包符合 SPI 模式就会自动加载
        // 就是说程序会自动去项目中查找是否有驱动，当然没有驱动的话自然是连接不了的

        // 什么是SPI模式？
        // SPI ，全称为 Service Provider Interface，是一种服务发现机制。
        // 它通过在ClassPath路径下的META-INF/services文件夹查找文件，自动加载文件里所定义的类。
        // 这一机制为很多框架扩展提供了可能，比如在Dubbo、JDBC中都使用到了SPI机制。
        // ————————————————
        // 版权声明：本文为CSDN博主「善良的喆哥」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
        // 原文链接：https://blog.csdn.net/m0_44944880/article/details/106309962
        // JDBC4.0之后 自动扫描jar包下这个文件;
        // 所以理论上可以不写Class.forName(“com.mysql.jdbc.Driver”);
        // 但建议还是写上,得考虑兼容性;兼容老版本;

        Class.forName("com.mysql.cj.jdbc.Driver");

        // 2.用户信息和url
        // mysql --3306
        // jdbc:mysql://主机地址:端口号/数据库名称？useUnicode=true&characterEncoding=utf8&useSSL=true

        // oralce -- 1521
        // jdbc:oracle:thin:@localhost:1521:sid
        String url = "jdbc:mysql://localhost:3306/jdbcstudy?useUnicode=true&characterEncoding=utf8&useSSL=true";
        String username = "root";
        String password = "123456";
        // 3.连接成功，返回数据库对象
        Connection connection = DriverManager.getConnection(url, username, password);

        // 4.执行SQL的对象
        Statement statement = connection.createStatement();

        // 5.执行SQL的对象 去 执行SQL ，查看结果
        String sql = "SELECT * FROM users";

        ResultSet resultSet = statement.executeQuery(sql);
        // statement.executeQuery(); //查询操作返回 ResultSet
        // statement.execute(); //执行任何sql
        // statement.executeUpdate();//更新，插入，删除 都是用这个，返回一个受影响的行数

        while (resultSet.next()) {
            System.out.println("id= " + resultSet.getObject("id"));
            System.out.println("id= " + resultSet.getObject("NAME"));
            System.out.println("id= " + resultSet.getObject("PASSWORD"));
            System.out.println("id= " + resultSet.getObject("email"));
            System.out.println("id= " + resultSet.getObject("birthday"));
        }

        // resultSet.getObject(); //在不知道列类型的情况下使用
        // resultSet.getString(); //知道类型的用下面这些
        // resultSet.getInt();
        // resultSet.getDate();
        // resultSet.getFloat();

        // 6.释放连接,必须完成，因为连接会占用内存，消耗资源。
        resultSet.close();
        statement.close();
        connection.close();
    }

}
