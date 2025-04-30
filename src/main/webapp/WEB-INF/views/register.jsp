<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>严波网站 Create Account</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>严波网站 Create New Account</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <svg viewBox="0 0 24 24" width="24" height="24">
                    <path fill="currentColor" d="M11 15h2v2h-2zm0-8h2v6h-2zm1-5C6.47 2 2 6.47 2 12s4.47 10 10 10 10-4.47 10-10S17.53 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"/>
                </svg>
                ${error}
            </div>
        </c:if>

        <form action="register" method="post" class="form-grid">
            <!-- Personal Information -->
            <div class="form-group required">
                <label>First Name</label>
                <input type="text" name="firstName" required>
            </div> 

            <div class="form-group required">
                <label>Last Name</label>
                <input type="text" name="lastName" required>
            </div>

            <!-- Contact Information -->
            <div class="form-group required">
                <label>Email Address</label>
                <input type="email" name="email" required>
            </div>

            <!-- Security -->
            <div class="form-group required">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group required">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" required>
            </div>
            
            <!-- Additional Information -->
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phoneNumber"required>
            </div>
            <div class="form-group">
                <label>Address</label>
                <input type="text" name="address"required>
            </div>
            <div class="form-group">
                <label>City</label>
                <input type="text" name="city"required>
            </div>
            <div class="form-group">
                <label>State</label>
                <input type="text" name="state"required>
            </div>
            <div class="form-group">
                <label>Zip Code</label>
                <input type="text" name="zipCode">
            </div>      
            
            <!-- Form Actions -->
            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">0" fill="currentColor">
                        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-2 10h-4v4h-2v-4H7v-2h4V7h2v4h4v2z"/>
                    </svg>
                    Create Account
                </button>
                <a href="login" class="btn">
                    Already Registered? Sign In Here
                </a>
            </div>
        </form>
    </div>
</body>
</html>