package com.collegecomplaint.servlet;

import java.io.IOException;
import java.util.List;

import com.collegecomplaint.ComplaintDAO;
import com.collegecomplaint.model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/checkStatus")
public class CheckStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
                           throws ServletException, IOException {

        String rollNo = request.getParameter("roll_no");

        ComplaintDAO dao = new ComplaintDAO();

        List<Complaint> complaints =
                dao.getComplaintsByRollNo(rollNo);

        request.setAttribute("complaints", complaints);
        request.setAttribute("rollNo", rollNo);

        request.getRequestDispatcher("/status.jsp")
               .forward(request, response);
    }
}