package com.hito.lesson02;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.hito.lesson02.utils.JdbcUtils;

public class TestSelect {
    public static void main(String[] args) {
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            st = conn.createStatement();
            String sql = "select * from users where id = 4";
            rs = st.executeQuery(sql);
            if (rs.next()) {
                System.out.println(rs.getInt("id") + " " + rs.getString("NAME") + " " + rs.getString("PASSWORD") + " "
                        + rs.getString("email") + " " + rs.getDate("birthday"));
            } else {
                System.out.println("查询失败！");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(conn, st, rs);
        }
    }
}
