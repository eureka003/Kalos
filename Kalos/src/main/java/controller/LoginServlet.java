package controller;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.*;
import model.*;
/**
 * Servlet implementation class LoginServlet
 */@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO usDao = new UserDAO();
        try {    
            String username = request.getParameter("un");
            String password = request.getParameter("pw");
            
            System.out.println("Attempting to retrieve user: " + username); // Debug log
            
            UserBean user = usDao.doRetrieveByUsername(username);
            
            if (user != null) {
                System.out.println("User found: " + user.getUsername()); // Debug log
                
                String storedPassword = user.getPassword();
                if (storedPassword != null && !storedPassword.isEmpty()) {
                    System.out.println("Stored password length: " + storedPassword.length()); // Debug log
                    
                    try {
                        if (BCrypt.checkpw(password, storedPassword)) {
                            // Password is correct
                            HttpSession session = request.getSession(true);    
                            session.setAttribute("currentSessionUser", user); 
                            String checkout = request.getParameter("checkout");
                            if (checkout != null) {
                                response.sendRedirect(request.getContextPath() + "/account?page=Checkout.jsp");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/Home.jsp");
                            }
                        } else {
                            System.out.println("Password incorrect for user: " + username); // Debug log
                            response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error");
                        }
                    } catch (IllegalArgumentException e) {
                        System.out.println("Error in password check: " + e.getMessage()); // Debug log
                        response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error");
                    }
                } else {
                    System.out.println("Stored password is null or empty for user: " + username); // Debug log
                    response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error");
                }
            } else {
                System.out.println("User not found: " + username); // Debug log
                response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error");
            }
        } catch(SQLException e) {
            System.out.println("SQL Error:" + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error");
        } catch(Exception e) {
            System.out.println("Unexpected Error:" + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error");
        }
    }
}