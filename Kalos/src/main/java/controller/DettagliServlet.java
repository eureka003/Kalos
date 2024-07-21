package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Carrello;
import model.ProdottoDAO;

@WebServlet("/dettagli")
public class DettagliServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProdottoDAO prodDao = new ProdottoDAO();
		
		try {
				int id = Integer.parseInt(request.getParameter("id"));
				request.getSession().removeAttribute("product");
				request.getSession().setAttribute("product", prodDao.doRetrieveByKey(id));
			
			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		/*RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Dettagli.jsp");
		dispatcher.forward(request, response);*/
		response.sendRedirect(request.getContextPath() + "/Dettagli.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}

