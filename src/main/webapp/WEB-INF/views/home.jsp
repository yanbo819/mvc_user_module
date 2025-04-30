<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.UserBean" %>
<% 
    UserBean user = (UserBean) session.getAttribute("user");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <% if(user == null) { %>
            <div class="auth-box">
                <a href="login" class="btn btn-primary login-btn">Go to Login Page</a>
            </div>
        <% } else { %>
            <div class="profile-header">
                <h1>Welcome, <%= user.getFirstName() %></h1>
                <p class="user-info"><%= user.getEmail() %></p>
            </div>
        <% } %>
        
        <% if(message != null) { %>
            <div class="message success-message">
                <%= message %>
            </div>
        <% } %>
        
        <% if(user != null) { %>
            <div class="action-links">
                <a href="profile" class="btn btn-primary">Edit Profile</a>
                <a href="home?logout=true" class="btn btn-secondary">Logout</a>
            </div>
        <% } %>
    </div>
</body>
</html>