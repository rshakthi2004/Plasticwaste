<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plastic Waste Tracker - Login</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="LoginServlet" method="post">
            <div class="role-selector">
                <label for="role">Select Role:</label>
                <select name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="student">Student</option>
                    <option value="staff">Staff</option>
                </select>
            </div>
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="staffId" placeholder="Staff ID (only for staff)" style="display: none;" id="staffIdInput">
            <button type="submit">Login</button>
            <p class="error">${requestScope.errorMessage}</p>
        </form>
    </div>
    <script>
        const roleSelect = document.querySelector('select[name="role"]');
        const staffIdInput = document.querySelector('input[name="staffId"]');
        roleSelect.addEventListener('change', function () {
            staffIdInput.style.display = this.value === 'staff' ? 'block' : 'none';
        });
    </script>
</body>
</html>
