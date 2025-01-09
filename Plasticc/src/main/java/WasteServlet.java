import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/WasteServlet")
public class WasteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String item = request.getParameter("item");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String date = request.getParameter("date");

        HttpSession session = request.getSession();
        List<Map<String, Object>> collectedData = (List<Map<String, Object>>) session.getAttribute("collectedData");
        if (collectedData == null) {
            collectedData = new ArrayList<>();
        }

        Map<String, Object> newData = new HashMap<>();
        newData.put("item", item);
        newData.put("quantity", quantity);
        newData.put("date", date);
        collectedData.add(newData);

        session.setAttribute("collectedData", collectedData);

        Integer totalPoints = (Integer) session.getAttribute("totalPoints");
        totalPoints = (totalPoints == null ? 0 : totalPoints) + quantity;
        session.setAttribute("totalPoints", totalPoints);

        response.sendRedirect("dashboard.jsp");
    }
}
