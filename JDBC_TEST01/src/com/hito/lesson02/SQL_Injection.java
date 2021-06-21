package com.hito.lesson02;

import java.sql.*;

import com.hito.lesson02.utils.JdbcUtils;

public class SQL_Injection {
    public static void main(String[] args) {
        new SQL_Injection().login("'or '1=1", "'or '1=1"); // 利用sql代码漏洞，本质是拼接字符串，不是乱输入，技巧的输入
    }

    private void login(String username, String password) {
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            st = conn.createStatement();
            String sql = "select * from users where NAME = '" + username + "'and PASSWORD='" + password + "'";
            rs = st.executeQuery(sql);
            while (rs.next()) {
                System.out.println("登陆成功！");
                System.out.println(rs.getInt("id") + " " + rs.getString("NAME") + " " + rs.getString("PASSWORD") + " "
                        + rs.getString("email") + " " + rs.getDate("birthday"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.release(conn, st, rs);
        }
    }

}
