import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String url = "jdbc:mysql://localhost:3306/db"; 
    private static final String uname = "root"; 
    private static final String pass = "123456789"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String staffId = request.getParameter("staffId");
        
        boolean isValidUser = false;

        try (Connection connection = DriverManager.getConnection(url, uname, pass)) {
            String query;
            if ("student".equals(role)) {
                query = "SELECT * FROM students WHERE username = ? AND password = ?";
            } else if ("staff".equals(role)) {
                query = "SELECT * FROM staff WHERE username = ? AND password = ? AND staffId = ?";
            } else {
                request.setAttribute("errorMessage", "Invalid role selected.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                if ("staff".equals(role)) {
                    preparedStatement.setString(3, staffId);
                }

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        isValidUser = true;
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }

        if (isValidUser) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid login credentials. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
