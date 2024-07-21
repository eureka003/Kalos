package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ComposizioneDAO;
import model.OrdineDAO;
import model.UserBean;

/**
 * Servlet implementation class OrdineServlet
 */
@WebServlet("/Ordine")
public class OrdineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		OrdineDAO ordDao = new OrdineDAO();
		ComposizioneDAO compDao = new ComposizioneDAO();
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");

		String action = request.getParameter("action");
		
		try {
			if(action!=null) {
				if(action.equalsIgnoreCase("mieiOrdini")) {
					String email = user.getEmail();
					request.getSession().removeAttribute("ordini");
					request.getSession().setAttribute("ordini", ordDao.doRetrieveByEmail(email));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/MieiOrdini.jsp");
					dispatcher.forward(request, response);
				
				}
				
				else if(action.equalsIgnoreCase("dettagliOrdine")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.getSession().removeAttribute("composzione");
					request.getSession().setAttribute("composizione", compDao.doRetrieveByOrdine(id));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ComposizioneOrdine.jsp");
					dispatcher.forward(request, response);				
				}
			}
			
		}catch(SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

}
