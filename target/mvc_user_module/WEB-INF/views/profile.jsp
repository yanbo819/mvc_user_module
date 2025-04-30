<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.UserBean" %>
<% 
    UserBean user = (UserBean) request.getAttribute("userData");
    if(user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String message = (String) session.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h1>User Profile</h1>
            <div class="user-avatar">
                <%= user.getFirstName() %><%= user.getLastName() %>
            </div>
        </div>

        <% if (message != null) { %>
            <div class="success-message message">
                <%= message %>
            </div>
            <% session.removeAttribute("message"); %>
        <% } %>

        <form action="profile" method="post" class="profile-form">
            <div class="form-grid">
                <div class="form-group">
                    <label>First Name</label>
                    <input type="text" name="firstName" value="<%= user.getFirstName() %>" required>
                </div>
                <div class="form-group">
                    <label>Last Name</label>
                    <input type="text" name="lastName" value="<%= user.getLastName() %>" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="<%= user.getEmail() %>" readonly>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="tel" name="phoneNumber" 
                           value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" value="<%= user.getPassword() %>" required>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" 
                           value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
                </div>
                <div class="form-group">
                    <label>City</label>
                    <input type="text" name="city" 
                           value="<%= user.getCity() != null ? user.getCity() : "" %>">
                </div>
                <div class="form-group">
                    <label>State</label>
                    <input type="text" name="state" 
                           value="<%= user.getState() != null ? user.getState() : "" %>">
                </div>
                <div class="form-group">
                    <label>Zip Code</label>
                    <input type="text" name="zipCode" 
                           value="<%= user.getZipCode() != null ? user.getZipCode() : "" %>">
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-save">Save Changes</button>
                <a href="home" class="btn btn-back">Back to Home</a>
            </div>
        </form>
    </div>
</body>
</html>