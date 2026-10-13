package com.collegecomplaint.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.collegecomplaint.dao.AdminDAO;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        boolean result = dao.login(username, password);

        if (result) {

            HttpSession session = request.getSession();

            session.setAttribute("admin", username);

            response.sendRedirect(
                    request.getContextPath() + "/adminDashboard");

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/adminLogin.jsp?error=1");
        }
    }
}