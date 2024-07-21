<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="model.*, java.util.*"%>

<%
    ArrayList<ArrayList<ProdottoBean>> categorie = (ArrayList<ArrayList<ProdottoBean>>) request.getSession().getAttribute("categorie");
    if(categorie == null) {
        response.sendRedirect("./home?page=Home.jsp");    
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">    
<title>Home</title>
</head>
<body class="sfondo-home">

    <%@ include file="./fragments/header.jsp" %>
    <%@ include file="./fragments/menu.jsp" %>
    <div class="banner-container">
    	<img src="${pageContext.request.contextPath}/images/banner.jpg" alt="Banner" class="banner-image">
	</div>
    <div id="main" class="clear">
         <% for(int i = 0 ; i < categorie.size() ; i++) { %>
    		<div class="categoria categoria<%=i%>">
            <%switch(i){
                case 0 : %> <h2 id="nomecat"><a href="Anelli.jsp">ANELLI</a></h2><hr>
                            <%break;
                case 1 : %> <h2 id="nomecat"><a href="Ciondoli.jsp">CIONDOLI</a></h2><hr>
                            <%break;
                case 2 : %> <h2 id="nomecat"><a href="Collane.jsp">COLLANE</a></h2><hr>
                            <%break;
                case 3 : %> <h2 id="nomecat"><a href="Bracciali.jsp">BRACCIALI</a></h2><hr>
                            <%break;
                case 4 : %> <h2 id="nomecat"><a href="BodyChains.jsp">BODY CHAINS</a></h2><hr>
                            <%break;
                case 5 : %> <h2 id="nomecat"><a href="Piercing.jsp">PIERCING</a></h2><hr>
                            <%break;
                case 6 : %> <h2 id="nomecat"><a href="Orologi.jsp">OROLOGI</a></h2><hr>
                            <%break;
                case 7 : %> <h2 id="nomecat"><a href="Orecchini.jsp">ORECCHINI</a></h2><hr>
                            <%break;
            } %>
            <div class="item-container">
            <% for(int j = 0; j < categorie.get(i).size(); j++) {
                 ProdottoBean bean = categorie.get(i).get(j); %>
                <div class="item">
                    <ul>
                        <li><a href="dettagli?id=<%=bean.getIdProdotto()%>"><img src="<%=bean.getImmagine()%>" id="product"></a></li>
                        <li><%=bean.getNome()%></li>
                        <li class="price-style">&euro;<%=bean.getPrezzo()%></li>
                        <li>
                        <% if (user !=null){ %>
                            <% if(bean.isInVendita()) { %>
                                <a href="carrello?action=addC&id=<%=bean.getIdProdotto()%>&page=Home.jsp"><button>Aggiungi al carrello</button></a>
                            <% } else { %>
                                <span class="not-available">Prodotto non disponibile</span>
                            <% } %>
                        <% } %>
                        </li>
                    </ul>
                </div>
      			<% } %>
      		</div>
    	</div>
  <% } %>
	</div>

    <%@ include file="./fragments/footer.jsp" %>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</body>
</html>
