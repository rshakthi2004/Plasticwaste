<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plastic Waste Tracker - Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Header Section with Logout Button -->
    <header>
        <h1>Welcome, <%= username %>!</h1>
        <!-- Logout Form -->
        <form action="LogoutServlet" method="POST">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </header>

    <!-- Input Section -->
    <section id="input-section">
        <h2>Input Plastic Waste Data</h2>
        <form action="WasteServlet" method="POST">
            <label for="item">Plastic Item:</label>
            <input type="text" name="item" placeholder="e.g., Bottle, Wrapper" required>

            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" placeholder="e.g., 10" required>
            <label for="date">Date:</label>
            <input type="date" name="date" required>
            <button type="submit">Add Data</button>
        </form>
    </section>
    <!-- Data Section -->
    <section id="data-section">
        <h2>Collected Data</h2>
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Quantity</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, Object>> data = (List<Map<String, Object>>) session.getAttribute("collectedData");
                    if (data != null) {
                        for (Map<String, Object> entry : data) {
                %>
                    <tr>
                        <td><%= entry.get("item") %></td>
                        <td><%= entry.get("quantity") %></td>
                        <td><%= entry.get("date") %></td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </section>

    <!-- Reward Section -->
    <section id="reward-section">
        <h2>Your Rewards</h2>
        <div>
            <%
                Integer totalPoints = (Integer) session.getAttribute("totalPoints");
                if (totalPoints != null) {
                    int stars = totalPoints / 10;
                    for (int i = 0; i < stars; i++) {
                        out.print("<i class='fas fa-star'></i>");
                    }
                }
            %>
        </div>
    </section>
</body>
</html>
