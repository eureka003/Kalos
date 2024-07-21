package model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface UserDAOInterface {

	public void doSave(UserBean user) throws SQLException;
	
	public UserBean doRetrieve(String username, String password) throws SQLException;
	
	public ArrayList<UserBean> doRetrieveAll(String order) throws SQLException;

	public void doUpdateSpedizione(String email, String indirizzo, String cap) throws SQLException;
	
	public void doUpdatePagamento(String email, String carta) throws SQLException;
}