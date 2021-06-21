package com.hito.lesson03;

import java.sql.*;
import java.util.Date;

import com.hito.lesson02.utils.JdbcUtils;

public class TestInsert {
    public static void main(String[] args) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils.getConnection();
            // 区别
            String sql = "insert into users(id,`NAME`,`PASSWORD`,`email`,`birthday`)values(?,?,?,?,?)";
            st = conn.prepareStatement(sql);

            // 手动赋值
            st.setInt(1, 4);
            st.setString(2, "haitao");
            st.setString(3, "123123");
            st.setString(4, "413168358@qq.com");
            // 注意点： sql.Date 数据库用的
            // util.Date Java
            st.setDate(5, new java.sql.Date(new Date().getTime()));

            // 执行
            int i = st.executeUpdate();
            if (i > 0) {
                System.out.println("插入成功");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(conn, st, rs);
        }
    }
}
