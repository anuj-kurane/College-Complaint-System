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
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/adminLogin.jsp");
            return;
        }

        ComplaintDAO dao = new ComplaintDAO();

        List<Complaint> complaints = dao.getAllComplaints();

        request.setAttribute("complaints", complaints);
        request.setAttribute("total", dao.getTotalComplaints());
        request.setAttribute("pending", dao.getPendingComplaints());
        request.setAttribute("inProgress", dao.getInProgressComplaints());
        request.setAttribute("resolved", dao.getResolvedComplaints());

        request.getRequestDispatcher("/adminDashboard.jsp")
               .forward(request, response);
    }
}