package com.hito.lesson04;

import java.sql.*;

import com.hito.lesson02.utils.JdbcUtils;

public class TestTransaction {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement st = null;
        PreparedStatement st1 = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils.getConnection();
            // 关闭数据库的自动提交，自动会开启事务
            conn.setAutoCommit(false);// 开启事务
            String sql1 = "update account set money=money+500 where name = 'A'";
            st = conn.prepareStatement(sql1);
            st.executeUpdate();
            // int x = 1 / 0; // 制造报错

            String sql2 = "update account set money=money-500 where name = 'B'";
            st1 = conn.prepareStatement(sql2);
            st1.executeUpdate();
            // 业务完成
            conn.commit();
            System.out.println("成功");
        } catch (SQLException e) {
            try {
                conn.rollback(); // 如果中间出现错误就回滚，其实不写这里也会默认回滚的
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            JdbcUtils.release(conn, st, rs);
        }
    }
}
