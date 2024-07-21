<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.ProdottoBean, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
<title>Modifica prodotto</title>
</head>
<body>

	<%@ include file="../fragments/header.jsp" %>
	<%@ include file="../fragments/menu.jsp" %>
	
	
	<div id="main" class="clear">
	<div class="edit-container">
	<div class="edit-card">
		<h2>Modifica Prodotto</h2>
		
	<% int id = Integer.parseInt(request.getParameter("prodotto"));
		ArrayList<ProdottoBean> prodotti = (ArrayList<ProdottoBean>) request.getSession().getAttribute("products");
		ProdottoBean bean = null;
	for(ProdottoBean prodotto : prodotti){
		if(prodotto.getIdProdotto() == id){
			bean = prodotto;} 
			}%>
	
	<form action="../catalogo" method="post" id="myform">
		<input type="hidden" name="action" value="modifica">
		<input type="hidden" name="page" value="admin/GestioneCatalogo.jsp">
		<div class="tableRow">
			<p>ID:</p>
			<p><input type="text" name="id" value="<%=bean.getIdProdotto() %>" required></p>
		</div>
		<div class="tableRow">
			<p>Nome:</p>
			<p><input type="text" name="nome" value="<%=bean.getNome() %>" required></p>
		</div>
		<div class="tableRow">
			<p>Descrizione:</p>
			<p><input type="text" name="descrizione" value="<%=bean.getDescrizione() %>" required></p>
		</div>
		<div class="tableRow">
			<p>Iva:</p>
			<p><input type="text" name="iva" value="<%=bean.getIva() %>" required></p>
		</div>
		<div class="tableRow">
			<p>Prezzo:</p>
			<p><input type="text" name="prezzo" value="<%=bean.getPrezzo() %>" required></p>
		</div>	
		<div class="tableRow">
			<p>Quantità:</p>
			<p><input type="number" name="quantità" value="<%=bean.getQuantità() %>" min="0" required></p>
			
		</div>
		<div class="tableRow">
			<p>Immagine:</p>
			<p><input type="text" name="img" value="<%=bean.getImmagine() %>" required></p>
		</div>
		<div class="tableRow">
			<p>Tipologia:</p>
			<p>
   			 <select name="tipologia" required>
       			 <option value="Anelli" <%= "Anelli".equals(bean.getTipologia()) ? "selected" : "" %>>Anelli</option>
      			 <option value="Ciondoli" <%= "Ciondoli".equals(bean.getTipologia()) ? "selected" : "" %>>Ciondoli</option>
     			 <option value="Collane" <%= "Collane".equals(bean.getTipologia()) ? "selected" : "" %>>Collane</option>
     			 <option value="Bracciali" <%= "Bracciali".equals(bean.getTipologia()) ? "selected" : "" %>>Bracciali</option>
        		 <option value="BodyChains" <%= "BodyChains".equals(bean.getTipologia()) ? "selected" : "" %>>BodyChains</option>
        		 <option value="Piercings" <%= "Piercings".equals(bean.getTipologia()) ? "selected" : "" %>>Piercings</option>
        		 <option value="Orecchini" <%= "Orecchini".equals(bean.getTipologia()) ? "selected" : "" %>>Orecchini</option>
        		 <option value="Orologi" <%= "Orologi".equals(bean.getTipologia()) ? "selected" : "" %>>Orologi</option>
   			 </select>
			</p>
		</div>
		<div class="tableRow">	
			<p>Descrizione dettagliata:</p>
			<p><input type="text" name="descDett" value="<%=bean.getDescrizioneDettagliata()%>"></p>
		</div>
		<div class="tableRow">
			<p></p>
			<p><input type="submit" value="Modifica"></p>
		</div>
	</form>
	</div>
	</div>
		</div>
	

	<%@ include file="../fragments/footer.jsp" %>

</body>
</html>