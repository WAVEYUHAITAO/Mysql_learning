package com.hito.lesson05;

import java.sql.*;

import com.hito.lesson05.utils.JdbcUtils_DBCP;

public class TestDBCP {
    public static void main(String[] args) {
        // 这个是用DBCP连接池来连接数据库
        // 需要导入DBCP需求支持的jar包 commons-dbcp-1.4 、 commons-pool-1.6
        // 新版commons-dbcp2.0以后，除了上述两个，还需要额外的jar包 commons-logging！
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
            conn = JdbcUtils_DBCP.getConnection();
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
            JdbcUtils_DBCP.release(conn, st, rs);
        }
    }
}
