package com.hito.lesson03;

import java.sql.*;

import com.hito.lesson02.utils.JdbcUtils;

public class TestSelect {
    public static void main(String[] args) {
        // preparedstatement 防止SQL注入的本质，把传递进来的参数当做字符
        // 假设其中存在转义字符，会直接被转义
        // login("''or'1=1'", "123456"); //注入失败，'会被转义
        login("hito", "123456");
    }

    public static void login(String username, String password) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            String sql = "Select * from users where NAME=? and PASSWORD=?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);

            rs = st.executeQuery();
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
