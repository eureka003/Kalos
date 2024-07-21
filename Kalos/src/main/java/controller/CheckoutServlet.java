package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

/**
 * Servlet implementation class SpedizioneServlet
 */
@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
		ProdottoDAO daoProd = new ProdottoDAO();
		OrdineDAO daoOrd = new OrdineDAO();
		ComposizioneDAO daoComp = new ComposizioneDAO();
		IndirizzoSpedizioneDAO daoSped = new IndirizzoSpedizioneDAO();
		MetodoPagamentoDAO daoPag = new MetodoPagamentoDAO();
		
		UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
	
		Carrello cart = (Carrello) request.getSession().getAttribute("cart");
		Double prezzoTot = cart.calcolaCosto();
		
		Date now = new Date();
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		String mysqlDateString = formatter.format(now);
		
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
		
		IndirizzoSpedizioneBean sped = new IndirizzoSpedizioneBean();
		sped.setNome(nome);
		sped.setCognome(cognome);
		sped.setIndirizzo(ind);
		sped.setTelefono(telefono);
		sped.setCap(cap);
		sped.setProvincia(prov);
		sped.setCittà(città);
		daoSped.doSave(sped);
		
		 MetodoPagamentoBean pag = new MetodoPagamentoBean();
		 
		 pag.setTitolare(tit);		 
		 pag.setNumero(numC);
		 pag.setScadenza(scad);
		 daoPag.doSave(pag);
			 
			 
		    OrdineBean ordine = new OrdineBean();
		 	ordine.setEmail(user.getEmail());
			ordine.setIndirizzo(ind);
			ordine.setCap(cap);
			ordine.setCartaCredito(numC);
			ordine.setData(mysqlDateString);
			ordine.setStato("confermato");
			ordine.setImportoTotale(prezzoTot);
			daoOrd.doSave(ordine);
			
			ArrayList<OrdineBean> ordini = daoOrd.doRetrieveByEmail(user.getEmail());
			int newId = ordini.get(ordini.size() - 1).getIdOrdine();
			
			ComposizioneBean comp = new ComposizioneBean();
			for(int i = 0; i < cart.size() ; i++) {
				int qnt = cart.get(i).getQuantitàCarrello();
				ProdottoBean prod = cart.get(i).getProdotto();
				int newQnt = prod.getQuantità() - qnt;
		
				daoProd.doUpdateQnt(cart.get(i).getId(), newQnt);
				
				comp.setIdOrdine(newId);
				comp.setIdProdotto(cart.get(i).getId());
				comp.setPrezzoTotale(cart.get(i).getTotalPrice());
				comp.setIva(cart.get(i).getProdotto().getIva());
				comp.setQuantità(qnt);
				daoComp.doSave(comp);
			}
				 // Clear and refresh session attributes
		        request.getSession().removeAttribute("categorie");
		        request.getSession().removeAttribute("products");

		        ArrayList<ArrayList<ProdottoBean>> categorie = new ArrayList<>();
		        categorie.add(daoProd.doRetrieveByTipologia("Anelli"));
		        categorie.add(daoProd.doRetrieveByTipologia("Ciondoli"));
		        categorie.add(daoProd.doRetrieveByTipologia("Collane"));
		        categorie.add(daoProd.doRetrieveByTipologia("Bracciali"));
		        categorie.add(daoProd.doRetrieveByTipologia("BodyChains"));
		        categorie.add(daoProd.doRetrieveByTipologia("Piercing"));
		        categorie.add(daoProd.doRetrieveByTipologia("Orologi"));
		        categorie.add(daoProd.doRetrieveByTipologia("Orecchini"));

		        request.getSession().setAttribute("categorie", categorie);
		        request.getSession().setAttribute("products", daoProd.doRetrieveAll("ID_PRODOTTO"));
			
			
			
		}catch(SQLException e) {
			e.printStackTrace();
			return;

		}
		
		request.getSession().removeAttribute("cart");
		
		response.sendRedirect(request.getContextPath() + "/Home.jsp");
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

}
