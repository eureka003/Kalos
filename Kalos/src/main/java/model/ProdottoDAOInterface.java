package model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface ProdottoDAOInterface {

	public void doSave(ProdottoBean prodotto) throws SQLException;

	public boolean doDelete(int idProdotto) throws SQLException;

	public ProdottoBean doRetrieveByKey(int idProdotto) throws SQLException;
	
	public ArrayList<ProdottoBean> doRetrieveAll(String order) throws SQLException;
	
	public void doUpdateQnt(int id, int qnt) throws SQLException;
	
	public void doUpdate(ProdottoBean bean) throws SQLException;
	
	public ArrayList<ProdottoBean> doRetrieveByTipologia(String tipologia) throws SQLException;
}
