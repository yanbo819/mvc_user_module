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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("home");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean newUser = new UserBean();
        newUser.setEmail(request.getParameter("email"));
        newUser.setPassword(request.getParameter("password"));
        newUser.setFirstName(request.getParameter("firstName"));
        newUser.setLastName(request.getParameter("lastName"));
        newUser.setPhoneNumber(request.getParameter("phoneNumber"));
        newUser.setAddress(request.getParameter("address"));
        newUser.setCity(request.getParameter("city"));
        newUser.setState(request.getParameter("state"));
        newUser.setZipCode(request.getParameter("zipCode"));

        if (!request.getParameter("password").equals(request.getParameter("confirmPassword"))) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        UserDB userDB = UserDB.getInstance();
        if (userDB.containsEmail(newUser.getEmail())) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        try {
            userDB.addUser(newUser);
            HttpSession session = request.getSession();
            session.setAttribute("user", newUser);
            session.setAttribute("message", "Registration successful!");
            response.sendRedirect("home");
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}