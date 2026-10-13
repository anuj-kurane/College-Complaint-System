package com.collegecomplaint.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {

    public boolean login(String username, String password) {

        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            boolean result = rs.next();

            rs.close();
            ps.close();
            con.close();

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}