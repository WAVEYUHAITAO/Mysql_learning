package com.hito.lesson02;

import java.sql.*;

import com.hito.lesson02.utils.JdbcUtils;

public class TestInsert {
    public static void main(String[] args) {
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils.getConnection(); // 获取数据库连接
            st = conn.createStatement();
            // String sql = "INSERT INTO
            // users(`id`,`NAME`,`PASSWORD`,`email`,`birthday`)VALUES(4,'hito','123456','413168358@qq.com','1991-07-21')";//增加，用excuteupdate
            // String sql = "delete from users where id = 4";// 删除，用excuteupdate
            String sql = "update users set name='hito' where id = 1 ";// 改，用excuteupdate
            int i = st.executeUpdate(sql);
            if (i > 0) {
                System.out.println("插入成功！");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(conn, st, rs);
        }
    }
}
