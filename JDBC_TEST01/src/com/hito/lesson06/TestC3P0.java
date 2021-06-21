package com.hito.lesson06;

import java.sql.*;

import com.hito.lesson06.utils.JdbcUtils_C3P0;

public class TestC3P0 {
    public static void main(String[] args) {
        // 这个是用C3P0连接池来连接数据库
        // 需要导入C3P0需求支持的jar包 c3p0-0.9.5.5.jar 和 mchange-commons-java-0.2.20.jar
        login("hito", "123456");
    }

    public static void login(String username, String password) {
        Connection conn = null;
        // preparedstatement 防止SQL注入的本质，把传递进来的参数当做字符
        // 假设其中存在转义字符，会直接被转义
        // login("''or'1=1'", "123456"); //注入失败，'会被转义
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils_C3P0.getConnection();
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
            JdbcUtils_C3P0.release(conn, st, rs);
        }
    }
}
