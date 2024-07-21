<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
    <title>Conferma Eliminazione Prodotto</title>
</head>
<body>
	<div class="delete-container">
	<div class="delete-card">
    <h2>Conferma Eliminazione Prodotto</h2>
    <p>Sei sicuro di voler eliminare il prodotto?</p>
    <form action="${pageContext.request.contextPath}/catalogo" method="post">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="idProdotto" value="${param.idProdotto}">
        <input type="hidden" name="page" value="admin/GestioneCatalogo.jsp">
        <button type="submit">Conferma</button>
        <a href="${pageContext.request.contextPath}/admin/GestioneCatalogo.jsp"><button type="button">Annulla</button></a>
    </form>
    </div>
    </div>
</body>
</html>
