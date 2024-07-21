package model;

import java.io.Serializable;

public class MetodoPagamentoBean implements Serializable {

private static final long serialVersionUID = 1L;

	public MetodoPagamentoBean() {
	
	}
	
	public String getNumero() {
		return numeroCarta;
	}
	
	public void setNumero(String numero) {
		this.numeroCarta = numero;
	}
	
	public String getTitolare() {
		return titolare;
	}
	
	public void setTitolare(String titolare) {
		this.titolare = titolare;
	}
	
	public String getScadenza() {
		return scadenza;
	}
	
	public void setScadenza(String scadenza) {
		this.scadenza = scadenza;
	}
	
	private String numeroCarta;
	private String titolare;
	private String scadenza;
}