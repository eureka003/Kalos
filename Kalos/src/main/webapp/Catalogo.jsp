<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.ProdottoBean, java.util.*"%>

<%
	ArrayList<?> products = (ArrayList<?>) request.getSession().getAttribute("products");
	if(products == null) {
		response.sendRedirect("./catalogo?page=Catalogo.jsp");	
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<body>

	<%@ include file="./fragments/header.jsp" %>
	<%@ include file="./fragments/menu.jsp" %>
	
	
	<div id="main" class="clear">
	
	<h2>CATALOGO</h2>
	
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProdottoBean bean = (ProdottoBean) it.next();
		%>
		<div class="item">
			<ul>
			<li><a href="dettagli?id=<%=bean.getIdProdotto()%>"><img src="<%=bean.getImmagine()%>" height="130" width="130"></a></li>
			<li><%=bean.getNome()%></li>
			<li>prezzo: &euro;<%=bean.getPrezzo()%></li>
			<li><a href="carrello?action=addC&id=<%=bean.getIdProdotto()%>"><button>Aggiungi al carrello</button></a></li>
		 </ul>
		</div>
		<%
				}
			} else {
		%>
		
			<h2>No products available</h2>
		<%
			}
		%>
	</div>
	
		<%@ include file="./fragments/footer.jsp" %>
	
</body>
</html>