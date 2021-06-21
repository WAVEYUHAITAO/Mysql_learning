package com.hito.lesson06.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class JdbcUtils_C3P0 {
    // 方法1
    private static DataSource dataSource = null;

    // 方法2
    // private static ComboPooledDataSource dataSource = null;
    static {

        try {

            // 创建数据源 -->创建
            // C3P0使用的xml不用加载，只要放在classloader可以找到的路径，默认加载
            // 方法1
            // dataSource = new ComboPooledDataSource(); //调用默认数据源
            dataSource = new ComboPooledDataSource("MySQL");// 配置文件写法,括号里有参数就是指定数据源，没参数就是默认数据源

            // 方法2 不推荐
            // dataSource = new ComboPooledDataSource();
            // dataSource.setDriverClass("com.mysql.cj.jdbc.Driver");
            // dataSource.setUser("root");
            // dataSource.setPassword("123456");
            // dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/jdbcstudy");

            // dataSource.setMinPoolSize(10);
            // dataSource.setMaxPoolSize(100);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    // 获取连接
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection(); // 从数据源获取连接
    }

    // 释放连接资源
    public static void release(Connection conn, Statement st, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (st != null) {
            try {
                st.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}