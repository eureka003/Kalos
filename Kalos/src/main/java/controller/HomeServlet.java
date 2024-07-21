package controller;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProdottoBean;
import model.ProdottoDAO;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProdottoDAO dao = new ProdottoDAO();
		
		ArrayList<ArrayList<ProdottoBean>> categorie = new ArrayList<>();
		String redirectedPage = request.getParameter("page");
		
		try {
			ArrayList<ProdottoBean> Anelli = dao.doRetrieveByTipologia("Anelli");
			ArrayList<ProdottoBean> Ciondoli = dao.doRetrieveByTipologia("Ciondoli");
			ArrayList<ProdottoBean> Collane = dao.doRetrieveByTipologia("Collane");
			ArrayList<ProdottoBean> Bracciali = dao.doRetrieveByTipologia("Bracciali");
			ArrayList<ProdottoBean> BodyChains = dao.doRetrieveByTipologia("BodyChains");
			ArrayList<ProdottoBean> Piercing = dao.doRetrieveByTipologia("Piercings");
			ArrayList<ProdottoBean> Orologi = dao.doRetrieveByTipologia("Orologi");
			ArrayList<ProdottoBean> Orecchini = dao.doRetrieveByTipologia("Orecchini");
			
			
			categorie.add(Anelli);
			categorie.add(Ciondoli);
			categorie.add(Collane);
			categorie.add(Bracciali);
			categorie.add(BodyChains);
			categorie.add(Piercing);
			categorie.add(Orologi);
			categorie.add(Orecchini);
			

			request.getSession().setAttribute("categorie", categorie);
			

			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/" + redirectedPage);
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
