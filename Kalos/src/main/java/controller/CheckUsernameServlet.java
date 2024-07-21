package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.UserDAO;

/**
 * Servlet implementation class CheckUsernameServlet
 */
@WebServlet("/CheckUsername")
public class CheckUsernameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        UserDAO dao = new UserDAO();
        String username = request.getParameter("us");
        
        try {
            boolean exists = dao.checkUsernameExists(username);
            String json = new Gson().toJson(exists ? "not valid" : "valid");
            response.getWriter().write(json);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}