package model;

import java.io.Serializable;
import java.util.Date;

public class OrdineBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public OrdineBean() {

	}
	
	public int getIdOrdine() {
		return idOrdine;
	}
	
	public void setIdOrdine(int idOrdine) {
		this.idOrdine = idOrdine;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public double getImportoTotale() {
		return importoTotale;
	}
	
	public void setImportoTotale(double importoTotale) {
		this.importoTotale = importoTotale;
	}
	
	public String getStato() {
		return stato;
	}
	
	public void setStato(String stato) {
		this.stato = stato;
	}
	
	public String getData() {
		return data;
	}
	
	public void setData(String data) {
		this.data = data;
	}

	public String getIndirizzo() {
		return indirizzo;
	}
	
	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
	
	public String getCap() {
		return cap;
	}
	
	public void setCap(String cap) {
		this.cap = cap;
	}
	
	public String getCartaCredito() {
		return cartaCredito;
	}
	
	public void setCartaCredito(String cartaCredito) {
		this.cartaCredito = cartaCredito;
	}
	
	private int idOrdine;
	private String email;
	private double importoTotale;
	private String stato;
	private String data;
	private String indirizzo;
	private String cap;
	private String cartaCredito;
	
}