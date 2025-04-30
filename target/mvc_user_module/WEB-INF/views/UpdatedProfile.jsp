<%-- Keep existing header and messages --%>
<form action="profile" method="post" class="form-grid">
    <div class="form-group">
        <label>First Name:</label>
        <input type="text" name="firstName" value="<%= user.getFirstName() %>" required>
    </div>
    <div class="form-group">
        <label>Last Name:</label>
        <input type="text" name="lastName" value="<%= user.getLastName() %>" required>
    </div>
    <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" readonly>
    </div>
    <div class="form-group">
        <label>Password:</label>
        <input type="password" name="password" value="<%= user.getPassword() %>" required>
    </div>
    <div class="form-group">
        <label>Phone Number:</label>
        <input type="tel" name="phoneNumber" value="<%= user.getPhoneNumber() %>"required>
    </div>
    <div class="form-group">
        <label>Address:</label>
        <input type="text" name="address" value="<%= user.getAddress() %>"required>
    </div>
    <div class="form-group">
        <label>City:</label>
        <input type="text" name="city" value="<%= user.getCity() %>"required>
    </div>
    <div class="form-group">
        <label>State:</label>
        <input type="text" name="state" value="<%= user.getState() %>"required>
    </div>
    <div class="form-group">
        <label>Zip Code:</label>
        <input type="text" name="zipCode" value="<%= user.getZipCode() %>"required>
    </div>
    <div class="form-group full-width">
        <button type="submit" class="btn-primary">Update Profile</button>
    </div>
</form>