package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.IndirizzoSpedizioneBean;
import model.IndirizzoSpedizioneDAO;
import model.MetodoPagamentoBean;
import model.MetodoPagamentoDAO;
import model.UserBean;
import model.UserDAO;

/**
 * Servlet implementation class AccountServlet
 */
@WebServlet("/account")
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String redirectedPage = request.getParameter("page");
		
		UserDAO daoUser = new UserDAO();
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
		IndirizzoSpedizioneBean sped = new IndirizzoSpedizioneBean();
		IndirizzoSpedizioneDAO daoSped = new IndirizzoSpedizioneDAO();
		MetodoPagamentoBean pag = new MetodoPagamentoBean();
		MetodoPagamentoDAO daoPag = new MetodoPagamentoDAO();
		String action = request.getParameter("action");
		
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String telefono = request.getParameter("tel");
		String città = request.getParameter("città");
		String ind = request.getParameter("ind");
		String cap = request.getParameter("cap");
		String prov = request.getParameter("prov");	
		
		String tit = request.getParameter("tit");
		String numC = request.getParameter("numC");
		String scad = request.getParameter("scad");
		
			
		try {
			if(action!=null) {
				if(action.equalsIgnoreCase("addS")) {
					
					if(daoSped.doRetrieveByKey(ind, cap)==null) {
						
						 sped.setNome(nome);
						 sped.setCognome(cognome);
						 sped.setIndirizzo(ind);
						 sped.setTelefono(telefono);
						 sped.setCap(cap);
						 sped.setProvincia(prov);
						 sped.setCittà(città);
						 daoSped.doSave(sped);
						 
					}
					
					daoUser.doUpdateSpedizione(user.getEmail(), ind, cap);

				}
				
				else if(action.equalsIgnoreCase("removeS")) {
					daoUser.doUpdateSpedizione(user.getEmail(), null, null);
					request.getSession().removeAttribute("spedizione");
					
				}
				
				else if(action.equalsIgnoreCase("addP")) {
					if(daoPag.doRetrieveByKey(numC)==null) {
						pag.setTitolare(tit);
						pag.setNumero(numC);
						pag.setScadenza(scad);
						daoPag.doSave(pag);
					
				}
					
					daoUser.doUpdatePagamento(user.getEmail(),numC);

				}
				else if(action.equalsIgnoreCase("removeP")) {
					daoUser.doUpdatePagamento(user.getEmail(),null);
					request.getSession().removeAttribute("pagamento");

				}
			}
		}catch(SQLException e) {
			e.printStackTrace();		}
			
		if(user.getIndirizzo()!=null && user.getCap()!=null) {
			try {
				request.getSession().removeAttribute("spedizione");
				request.getSession().setAttribute("spedizione", daoSped.doRetrieveByKey(user.getIndirizzo(),user.getCap()));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(user.getCartaDiCredito()!=null) {
			try {
				request.getSession().setAttribute("pagamento", daoPag.doRetrieveByKey(user.getCartaDiCredito()));
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/" + redirectedPage);
		dispatcher.forward(request, response);

	}
}