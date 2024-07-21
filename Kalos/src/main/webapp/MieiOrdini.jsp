<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.OrdineBean, java.util.*"%>
    
  
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
<title>I miei ordini</title>
</head>
<body>

	<%@ include file="./fragments/header.jsp" %>
	<%@ include file="./fragments/menu.jsp" %>
	
	<div id="main" class="clear">
	
	<h2>I Miei Ordini</h2>
	
	<% ArrayList<?> ordini = (ArrayList<?>) request.getSession().getAttribute("ordini");
	
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
			<td> <a href="Ordine?action=dettagliOrdine&id=<%= bean.getIdOrdine() %>"> dettagli</a></td>
		</tr>
		
		<%}%></table>
			 <%} else {%>
		
		
			<h2>Non ci sono ordini</h2>
		
		<%
			}
		%>
	
	
	
	</div>
	
		<%@ include file="./fragments/footer.jsp" %>

</body>
</html>