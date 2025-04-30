package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserBean;
import model.UserDB;


@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        UserBean user = (UserBean) session.getAttribute("user");
        request.setAttribute("userData", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        UserBean user = (UserBean) session.getAttribute("user");
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setPassword(request.getParameter("password"));
        user.setPhoneNumber(request.getParameter("phoneNumber"));
        user.setEmail(request.getParameter("email"));
        user.setAddress(request.getParameter("address"));
        user.setCity(request.getParameter("city"));
        user.setState(request.getParameter("state"));
        user.setZipCode(request.getParameter("zipCode"));

        UserDB.getInstance().updateUser(user);
        session.setAttribute("user", user);
        session.setAttribute("message", "Profile updated successfully");
        response.sendRedirect("profile");
    }
}