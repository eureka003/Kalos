package model;

public class ItemCarrello {

	public ItemCarrello(ProdottoBean prodotto){
		this.prodotto = prodotto;
		quantit‡Carrello = 1;
	}
	
	public ProdottoBean getProdotto() {
		return prodotto;
	}
	
	public void setProdotto(ProdottoBean prodotto) {
		this.prodotto = prodotto;
	}
	
	public int getQuantit‡Carrello() {
		return quantit‡Carrello;
	}
	
	public void setQuantit‡Carrello(int quantit‡) {
		this.quantit‡Carrello = quantit‡;
	}
	
	public int getId() {
		return prodotto.getIdProdotto();
	}
	
	public double getTotalPrice() {
		return quantit‡Carrello * prodotto.getPrezzo();
		

	}
	
	public String getDescription() {
		return prodotto.getDescrizione();
	}
	
	public void incrementa() {
		if(quantit‡Carrello < prodotto.getQuantit‡() )
			quantit‡Carrello = quantit‡Carrello + 1;
	}
	
	public void decrementa() {
		if( quantit‡Carrello > 1)
			quantit‡Carrello = quantit‡Carrello - 1;
	}
	
	private ProdottoBean prodotto;
	private int quantit‡Carrello;
}