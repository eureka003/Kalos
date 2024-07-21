<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,model.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dettagli</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<%@ include file="./fragments/header.jsp" %>
	<%@ include file="./fragments/menu.jsp" %>
	
	<div id="main" class="clear">
	
	<%
		ProdottoBean product = (ProdottoBean) request.getSession().getAttribute("product");
	
		if (product != null) {
	%>
		<h2 class="nome-product"><%=product.getNome()%></h2>
		<div class="product-container">
			<div id="image"><img src="<%=product.getImmagine()%>" id="product2">
			</div>
			<div id="listDettagli">
				<ul>
					<li><span class="dettagli">Tipologia</span>: <%=product.getTipologia()%></li>
					<li><span class="dettagli">Descrizione</span>: <%=product.getDescrizione()%></li>
					<li><span class="dettagli">Descrizione Dettagliata</span>: <%=product.getDescrizioneDettagliata()%></li>	
					<li><span class="dettagli">Prezzo</span>:</li>
					<li><span class="prezzo">&euro;<%=product.getPrezzo()%></span></li>
					<% if(product.isInVendita()) {%>
						<li><span class="dettagli">Disponibilità Immediata</span></li>
						<% if(user !=null){ %>
							<li><a href="carrello?action=addC&id=<%=product.getIdProdotto()%>&page=Dettagli.jsp"><button>Aggiungi al carrello</button></a></li>
							<%}%>
					<%}else { %>
						<li><span class="dettagli">Non disponibile</span></li>
					<%}%>
				</ul>
			</div>
			</div>
	<%}%>

	</div>
			<%@ include file="./fragments/footer.jsp" %>
	
</body>
</html>