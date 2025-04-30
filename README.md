## 一、Objectives and Preparations  
### 1. Objectives  
- **JavaBean**: Used `UserBean` to encapsulate user data.  
- **Servlet**: Implemented `LoginServlet`, `RegisterServlet`, `ProfileServlet`, and `HomeServlet` to handle HTTP requests.  
- **MVC**:  
  - **Model**: `UserBean` (data) and `UserDB` (database operations).  
  - **View**: `login.jsp`, `register.jsp`, `profile.jsp`, and `home.jsp`.
  - **Controller**: `LoginServlet`, `RegisterServlet`, `ProfileServlet`, and `HomeServlet`.

### 2. Preparations  
- JSP for rendering views.  
- JavaBean (`UserBean`) for data encapsulation.  
- Servlets for business logic and routing.  
- MVC architecture to separate concerns.  

---

## 二、Requirements Analysis and Overall Design  
- **Core Functionalities**:  
  1. **Registration**: Implemented in `RegisterServlet` with password validation and email uniqueness check.  
  2. **Login**: Managed by `LoginServlet` with session handling.  
  3. **Profile Reset**: `ProfileServlet` allows updating personal information.

- **Additional Functionalities**:
    1. **Home Page**: `HomeServlet` The entry point for the application, displaying a welcome message based on login status. 

---

## 三、Design Interface  
Below are the renderings of the user interface:  

1. **Home Page**  
   - Logged out:
   ![Home Page Screenshot](resources/home_Loggedout_screenshot.png)

   - Logged in:
   ![Home Page Screenshot](resources/home_Loggedin_screenshot.png)

2. **Login Page**  
   ![Login Page Screenshot](resources/login_screenshot.png)  

3. **Registration Page**  
   ![Registration Page Screenshot](resources/register_screenshot.png)  

4. **Profile Page**  
   ![Profile Page Screenshot](resources/profile_screenshot.png)
   ![Profile Page Screenshot](resources/profile_updated_screenshot.png)

---

## 四、Design Database  
- **DBMS**: MySQL.  
- **Table Schema**:  
  ```sql
  CREATE TABLE users (
    email VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    work_phone VARCHAR(20) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip VARCHAR(20) NOT NULL
  );
  ```
- **Data Storage**: `UserDB` class uses JDBC to interact with the database.  

---

## 五、Coding and Debugging
### 1. Code Structure  
  ![Class Diagram](resources/mvc_user_module_diagram.png)

### 2. Code Snippets
  **Summary of Main Codes Using MVC Architecture**

---

### **1. Controllers (Servlets)**  
Handle HTTP requests, interact with the Model, and forward to Views.

**HomeServlet** (Handles home page and logout):  
```java
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        // Manages session logout and forwards to home.jsp
        HttpSession session = request.getSession(false);
        if ("true".equals(request.getParameter("logout")) && session != null) {
            session.invalidate();
        }
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
```

**ProfileServlet** (Updates user profile):  
```java
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        // Updates user data via UserDB
        UserBean user = (UserBean) session.getAttribute("user");
        user.setFirstName(request.getParameter("firstName"));
        UserDB userDB = new UserDB();
        userDB.updateUser(user);
    }
}
```

**LoginServlet** (Authenticates users):  
```java
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        // Validates credentials using UserDB
        UserBean user = userDB.getUser(email);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("user", user);
        }
    }
}
```

---

### **2. Model (Data & Database)**  
Encapsulates data and database operations.

**UserBean** (Data container):  
```java
public class UserBean implements Serializable {
    private String email, password, country, firstName, lastName, jobTitle, workPhone, companyName, address, city, zip;
    // Getters and setters for all fields
}
```

**UserDB** (Database interactions):  
```java
public class UserDB {
    public void addUser(UserBean user) throws SQLException {
        // Inserts user into the database
        String sql = "INSERT INTO users (...) VALUES (...)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.executeUpdate();
    }
}
```

---

### **3. Views (JSP Pages)**  
Render UI and display dynamic data using JSP.

**home.jsp** (Displays user status):  
```jsp
<h1><%= user != null ? "Welcome back, " + user.getFirstName() : "Welcome" %></h1>
<% if (user == null) { %>
    <a href="login">Login</a>
<% } %>
```

**profile.jsp** (Profile edit form):  
```jsp
<form action="profile" method="post">
    <input type="text" name="firstName" value="<%= user.getFirstName() %>">
    <button type="submit">Update Profile</button>
</form>
```

---

### **4. Utility**  
**DatabaseUtil** (Manages DB connections):  
```java
public class DatabaseUtil {
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
```

---

**Key MVC Flow**:  
1. **Controller** (Servlet) receives a request.  
2. **Model** (`UserDB`/`UserBean`) processes data/database operations.  
3. **View** (JSP) renders the response using data from the Model.


### 2. Questions and Solutions  
- **Q1**: How to handle session invalidation on logout?  
  **Solution**: Used `session.invalidate()` in `HomeServlet` to destroy the session and redirect to the home page.  

- **Q2**: SQL exceptions during user registration due to duplicate emails.  
  **Solution**: Added a uniqueness check using `UserDB.containsEmail()` and displayed an error message in `register.jsp`.  

- **Q3**: Password validation failed due to mismatched retyped passwords.  
  **Solution**: Added client-side validation in `RegisterServlet` using `password.equals(retypePassword)`.  

- **Q4**: Database connection errors in production.  
  **Solution**: Wrapped database operations in try-catch blocks and used `DatabaseUtil` to centralize connection logic.  

- **Q5**: Profile update not reflecting in the session.  
  **Solution**: Updated the session attribute `user` after calling `userDB.updateUser(user)`.  

---

## 六、Conclusion and Summary  
- **Achievements**:  
  - Implemented a fully functional user module with **registration**, **login**, and **profile management** using MVC.  
  - Integrated **MySQL** for persistent storage and ensured data integrity with input validation.  
  - Designed responsive UI with CSS and JSP, enhancing user experience.  

- **Challenges**:  
  - **Session Management**: Required careful handling of session attributes across multiple servlets.  
  - **Database Integration**: Debugging SQL syntax errors and connection timeouts.  
  - **Input Validation**: Ensuring server-side validation while maintaining user-friendly error messages.  

- **Learning Outcomes**:  
  - Mastered the use of **Servlets** and **JSP** for dynamic web applications.  
  - Strengthened understanding of **MVC architecture** and separation of concerns.  
  - Improved problem-solving skills in debugging database and session-related issues.  

- **Future Improvements**:  
  - Add password encryption for enhanced security.  
  - Implement email verification during registration.  
  - Extend the module with role-based access control.