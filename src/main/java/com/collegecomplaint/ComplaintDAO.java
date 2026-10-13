
package com.collegecomplaint;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.collegecomplaint.dao.DBConnection;
import com.collegecomplaint.model.Complaint;

public class ComplaintDAO {

    public boolean addComplaint(Complaint c) {
        String sql = "INSERT INTO complaints "
                + "(student_name, roll_no, category, description) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getStudentName());
            ps.setString(2, c.getRollNo());
            ps.setString(3, c.getCategory());
            ps.setString(4, c.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE complaints SET status = ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Complaint> getAllComplaints() {
        List<Complaint> list = new ArrayList<>();

        String sql = "SELECT * FROM complaints WHERE status IS NULL OR status <> 'Resolved' ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Complaint c = new Complaint();

                c.setId(rs.getInt("id"));
                c.setStudentName(rs.getString("student_name"));
                c.setRollNo(rs.getString("roll_no"));
                c.setCategory(rs.getString("category"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));

                list.add(c);
            }

            System.out.println("Database: " + con.getCatalog());
            System.out.println("Complaints fetched: " + list.size());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Complaint> getComplaintsByRollNo(String rollNo) {
        List<Complaint> list = new ArrayList<>();

        String sql = "SELECT id, student_name, roll_no, category, "
                   + "description, status FROM complaints "
                   + "WHERE roll_no = ? ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, rollNo);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Complaint c = new Complaint();

                    c.setId(rs.getInt("id"));
                    c.setStudentName(rs.getString("student_name"));
                    c.setRollNo(rs.getString("roll_no"));
                    c.setCategory(rs.getString("category"));
                    c.setDescription(rs.getString("description"));
                    c.setStatus(rs.getString("status"));

                    list.add(c);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getTotalComplaints() {
        return countComplaints(
                "SELECT COUNT(*) FROM complaints", null);
    }

    public int getPendingComplaints() {
        return countComplaints(
                "SELECT COUNT(*) FROM complaints WHERE status = ?",
                "Pending");
    }

    public int getInProgressComplaints() {
        return countComplaints(
                "SELECT COUNT(*) FROM complaints WHERE status = ?",
                "In Progress");
    }

    public int getResolvedComplaints() {
        return countComplaints(
                "SELECT COUNT(*) FROM complaints WHERE status = ?",
                "Resolved");
    }

    private int countComplaints(String sql, String status) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (status != null) {
                ps.setString(1, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
