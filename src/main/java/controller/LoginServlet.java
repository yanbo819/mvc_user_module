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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
       
        if (session != null && session.getAttribute("user") != null) {
         
            response.sendRedirect("home");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
   
        UserDB userDB = UserDB.getInstance();
   
        UserBean user = userDB.getUser(email);

        if (user != null && user.getPassword().equals(password)) {
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            session.setAttribute("message", "Login successful!");
      
            response.sendRedirect("home");
        } else {
           
            request.setAttribute("error", "Invalid email or password");
        
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}