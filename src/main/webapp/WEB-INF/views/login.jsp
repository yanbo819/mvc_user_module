<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container" style="max-width: 500px;">
        <h1>User Login</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Sign In</button>
            </div>
        </form>

        <p class="text-center">New user? <a href="register" class="btn-link">Create account</a></p>
    </div>
</body>
</html>
