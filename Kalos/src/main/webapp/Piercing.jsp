<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="model.*, java.util.*"%>
    
    <%
	ArrayList<ArrayList<ProdottoBean>> categorie = (ArrayList<ArrayList<ProdottoBean>>) request.getSession().getAttribute("categorie");
	if(categorie == null) {
		response.sendRedirect("./home?page=Piercing.jsp");	
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
<title>Piercing</title>
</head>
<body>
<%@ include file="./fragments/header.jsp" %>
	<%@ include file="./fragments/menu.jsp" %>
	
	<%
	ArrayList<ProdottoBean> piercing = categorie.get(5);%>
	
	<div class="banner-container">
    	<img src="${pageContext.request.contextPath}/images/banner-piercing.jpg" alt="Banner" class="banner-image">
	</div>
	
	<div id="main" class="clear">
		<div class="item-container2">
		<%
			if (piercing != null && piercing.size() != 0) {
				Iterator<?> it = piercing.iterator();
				while (it.hasNext()) {
					ProdottoBean bean = (ProdottoBean) it.next();
		%>
		<div class="itemtwo">
			<ul>
			<li><a href="dettagli?id=<%=bean.getIdProdotto()%>"><img src="<%=bean.getImmagine()%>" id="product"></a></li>
			<li><%=bean.getNome()%></li>
			<li>&euro;<%=bean.getPrezzo()%></li>
			<li><a href="carrello?action=addC&id=<%=bean.getIdProdotto()%>&page=Piercing.jsp"><button id="add-to-cart">Aggiungi al carrello</button></a></li>
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
	</div>
		<%@ include file="./fragments/footer.jsp" %>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		
</body>
</html>