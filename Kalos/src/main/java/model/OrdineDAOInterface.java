package model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface OrdineDAOInterface {

	public void doSave(OrdineBean ordine) throws SQLException;
	
	public OrdineBean doRetrieveByKey(int idOrdine) throws SQLException;
	
	public ArrayList<OrdineBean> doRetrieveByEmail(String email) throws SQLException;
	
	public ArrayList<OrdineBean> doRetrieveAll(String order) throws SQLException;
}