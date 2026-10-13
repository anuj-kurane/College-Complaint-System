package com.collegecomplaint.servlet;

import java.io.IOException;

import com.collegecomplaint.ComplaintDAO;
import com.collegecomplaint.model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
                           throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentName = request.getParameter("student_name");
        String rollNo = request.getParameter("roll_no");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        Complaint complaint = new Complaint(
                studentName,
                rollNo,
                category,
                description
        );

        ComplaintDAO dao = new ComplaintDAO();

        if (dao.addComplaint(complaint)) {

            response.sendRedirect(
                request.getContextPath()
                + "/complaint.jsp?success=1"
            );

        } else {

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Could not save complaint."
            );
        }
    }
}