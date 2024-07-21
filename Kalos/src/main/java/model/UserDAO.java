package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.mindrot.jbcrypt.*;

public class UserDAO implements UserDAOInterface {

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/storage");

		} 
		catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
	
	private static final String TABLE_NAME = "cliente";
	
	
	@Override
	public synchronized void doSave(UserBean user) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + UserDAO.TABLE_NAME 
						+ " (NOME, COGNOME, USERNAME, PWD, EMAIL, DATA_NASCITA, CARTA_CREDITO, INDIRIZZO, CAP, AMMINISTRATORE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, user.getNome());
			preparedStatement.setString(2, user.getCognome());
			preparedStatement.setString(3, user.getUsername());
			preparedStatement.setString(4, user.getPassword());
			preparedStatement.setString(5, user.getEmail());
			preparedStatement.setDate(6, (Date) user.getDataDiNascita());
			preparedStatement.setString(7, user.getCartaDiCredito());
			preparedStatement.setString(8, user.getIndirizzo());
			preparedStatement.setString(9, user.getCap());
			preparedStatement.setBoolean(10, user.isAmministratore());
		
			preparedStatement.executeUpdate();

			connection.commit();
		}
		 finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} 
				finally {
					if (connection != null)
						connection.close();
				}
		 }
	}


	@Override
    public synchronized UserBean doRetrieve(String username, String password) throws SQLException {
        UserBean user = doRetrieveByUsername(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public synchronized UserBean doRetrieveByUsername(String username) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        UserBean user = new UserBean();

        String searchQuery = "SELECT * FROM " + UserDAO.TABLE_NAME + " WHERE username = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(searchQuery);
            preparedStatement.setString(1, username);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("pwd"));
                user.setEmail(rs.getString("email"));
                user.setNome(rs.getString("nome"));
                user.setCognome(rs.getString("cognome"));
                user.setDataDiNascita(rs.getDate("data_nascita"));
                user.setCartaDiCredito(rs.getString("carta_credito"));
                user.setIndirizzo(rs.getString("indirizzo"));
                user.setCap(rs.getString("cap"));
                user.setAmministratore(rs.getBoolean("amministratore"));
                user.setValid(true);
            } else {
                user.setValid(false);
            }
        } catch (Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex); 
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }

        return user;
    }
	
	@Override
	public synchronized ArrayList<UserBean> doRetrieveAll(String order) throws SQLException {
	
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ArrayList<UserBean> users = new ArrayList<UserBean>();

		String selectSQL = "SELECT * FROM " + UserDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				UserBean user = new UserBean();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("pwd"));
				user.setEmail(rs.getString("email"));
				user.setNome(rs.getString("nome"));
				user.setCognome(rs.getString("cognome"));
				user.setDataDiNascita(rs.getDate("data_nascita"));
				user.setCartaDiCredito(rs.getString("carta_credito"));
				user.setIndirizzo(rs.getString("indirizzo"));
				user.setCap(rs.getString("cap"));
				user.setAmministratore(rs.getBoolean("amministratore"));
				user.setValid(true);
				users.add(user);
			}
		}
		finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} 
			finally {
				if (connection != null)
					connection.close();
			}
		}
		
		return users;
	}
	
	public synchronized void doUpdateSpedizione(String email, String indirizzo, String cap) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE " + UserDAO.TABLE_NAME
				+ " SET INDIRIZZO = ?, CAP = ?"
				+ " WHERE EMAIL = ? ";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, indirizzo);
			preparedStatement.setString(2, cap);
			preparedStatement.setString(3, email);
			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	
	public synchronized void doUpdatePagamento(String email, String carta) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE " + UserDAO.TABLE_NAME
				+ " SET CARTA_CREDITO = ?"
				+ " WHERE EMAIL = ? ";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, carta);
			preparedStatement.setString(2, email);
			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	
	public boolean checkEmailExists(String email) throws SQLException {
	    String query = "SELECT COUNT(*) FROM " + TABLE_NAME + " WHERE EMAIL = ?";
	    try (Connection connection = ds.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {
	        preparedStatement.setString(1, email);
	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            if (resultSet.next()) {
	                return resultSet.getInt(1) > 0;
	            }
	        }
	    }
	    return false;
	}
	
	public boolean checkUsernameExists(String username) throws SQLException {
	    String query = "SELECT COUNT(*) FROM " + TABLE_NAME + " WHERE USERNAME = ?";
	    try (Connection connection = ds.getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(query)) {
	        preparedStatement.setString(1, username);
	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            if (resultSet.next()) {
	                return resultSet.getInt(1) > 0;
	            }
	        }
	    }
	    return false;
	}
	
}