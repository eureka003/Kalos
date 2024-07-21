package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MetodoPagamentoDAO implements MetodoPagamentoDAOInterface{

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/storage");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
	
	private static final String TABLE_NAME = "metodo_pagamento";

	
	@Override
	public synchronized void doSave(MetodoPagamentoBean bean) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + MetodoPagamentoDAO.TABLE_NAME
				+ " (NUMERO_CARTA, TITOLARE_CARTA, SCADENZA_CARTA) VALUES (?, ?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, bean.getNumero());
			preparedStatement.setString(2, bean.getTitolare());
			preparedStatement.setString(3, bean.getScadenza());


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
	public synchronized MetodoPagamentoBean doRetrieveByKey(String numeroCarta) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		MetodoPagamentoBean bean = new MetodoPagamentoBean();

		String selectSQL = "SELECT * FROM " + MetodoPagamentoDAO.TABLE_NAME 
						+ " WHERE NUMERO_CARTA = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, numeroCarta);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setTitolare(rs.getString("TITOLARE_CARTA"));
				bean.setScadenza(rs.getString("SCADENZA_CARTA"));
				bean.setNumero(rs.getString("NUMERO_CARTA"));

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
		
		return bean;
	}
	
	
	public synchronized void doDelete(MetodoPagamentoBean bean) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String query = "DELETE FROM " + MetodoPagamentoDAO.TABLE_NAME
				+ " WHERE NUMERO_CARTA = ? ";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bean.getNumero());

			preparedStatement.executeUpdate();
		
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
	
	
}