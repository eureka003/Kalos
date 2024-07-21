<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="model.OrdineBean, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">

<title>Ordini</title>
</head>
<body>
	<%@ include file="../fragments/header.jsp" %>
	<%@ include file="../fragments/menu.jsp" %>
	
	
	<div id="main" class="clear">
	
		<h2>ORDINI</h2>
		
	<div class="account">
		<form action="../ordiniAdmin">
		
			<div class="tableRow">
				<p></p>
				<p class="heading">Cerca per data</p>
			</div>
				<input type = "hidden" name="action" value="data">
				<div class="tableRow">
					<p>Dal:</p>
					<p> <input type = "date" name="dal" required></p>
				</div>
				<div class="tableRow">
					<p>Al:</p>
					<p><input type="date" name="al" required></p>
				</div>
				<div class="tableRow">
					<p></p>
					<p><input type="submit" value="Cerca"></p>
				</div>
				
			</form>
		</div>
			
		<div class="account">
			<form action="../ordiniAdmin">
			
			<div class="tableRow">
				<p></p>
				<p class="heading">Cerca per nominativo</p>
			</div>
				<input type = "hidden" name="action" value="nominativo">
				<div class="tableRow">
					<p>Nome:</p>
					<p><input type = "text" name="nome" required></p>
				</div>
				<div class="tableRow">
				<p>Cognome:</p>
				<p><input type = "text" name="cognome" required></p>
				</div>
				<div class="tableRow">	
					<p></p>
					<p><input type="submit" value="Cerca"></p>
				</div>
		
			
		</form>
		</div>
			<% ArrayList<?> ordini = (ArrayList<?>) request.getSession().getAttribute("adminOrdini");
	
			if (ordini != null && ordini.size() != 0) {%>
			
				<table class = "ordini">
				<tr>
					<th>Id</th>
					<th>Data</th>
					<th>Importo totale</th>
					<th></th>
				
				</tr>
				
				<% Iterator<?> it = ordini.iterator();
				while (it.hasNext()) {
					OrdineBean bean = (OrdineBean) it.next();
				%>
		
		<tr>
			<td> <%= bean.getIdOrdine() %></td>
			<td> <%= bean.getData() %></td>
			<td> &euro;<%=String.format("%.2f",bean.getImportoTotale())%></td>
			<td> <a href="../Ordine?action=dettagliOrdine&id=<%= bean.getIdOrdine() %>"> dettagli</a></td>
		</tr>
		
		<%}%></table>
			 <%} else {%>
		
		
			<h2>Non ci sono ordini</h2>
		
		<%
			}
		%>
	
	
	</div>
	
		<%@ include file="../fragments/footer.jsp" %>
	
	
</body>
</html>