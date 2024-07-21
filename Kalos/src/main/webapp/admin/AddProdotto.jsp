<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
    <title>Aggiungi prodotto</title>
</head>
<body>
    <%@ include file="../fragments/header.jsp" %>
    <%@ include file="../fragments/menu.jsp" %>

    <%!
        // Metodo per codificare i caratteri speciali
        public String encodeHTML(String input) {
            StringBuilder encoded = new StringBuilder();
            for (int i = 0; i < input.length(); i++) {
                char c = input.charAt(i);
                switch (c) {
                    case '<':
                        encoded.append("&lt;");
                        break;
                    case '>':
                        encoded.append("&gt;");
                        break;
                    case '&':
                        encoded.append("&amp;");
                        break;
                    case '"':
                        encoded.append("&quot;");
                        break;
                    case '\'':
                        encoded.append("&#x27;");
                        break;
                    case '/':
                        encoded.append("&#x2F;");
                        break;
                    default:
                        encoded.append(c);
                }
            }
            return encoded.toString();
        }
    %>

    <div id="main" class="clear">
        <h2>AGGIUNGI PRODOTTO</h2>

        <form action="../catalogo" method="post" id="myform">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="page" value="admin/GestioneCatalogo.jsp"><br><br>
            <div class="tableRow">
                <p>Nome:</p>
                <p><input type="text" name="nome" value="<%= encodeHTML(request.getParameter("nome") != null ? request.getParameter("nome") : "") %>" required></p>
            </div>
            <div class="tableRow">
                <p>Descrizione:</p>
                <p><input type="text" name="descrizione" value="<%= encodeHTML(request.getParameter("descrizione") != null ? request.getParameter("descrizione") : "") %>" required></p>
            </div>
            <div class="tableRow">
                <p>Iva:</p>
                <p><input type="text" name="iva" value="<%= encodeHTML(request.getParameter("iva") != null ? request.getParameter("iva") : "") %>" required></p>
            </div>
            <div class="tableRow">
                <p>Prezzo:</p>
                <p><input type="text" name="prezzo" value="<%= encodeHTML(request.getParameter("prezzo") != null ? request.getParameter("prezzo") : "") %>" required></p>
            </div>
            <div class="tableRow">
                <p>Quantità:</p>
                <p><input type="number" name="quantità" value="<%= encodeHTML(request.getParameter("quantità") != null ? request.getParameter("quantità") : "") %>" required></p>
            </div>
            <div class="tableRow">
                <p>Immagine:</p>
                <p><input type="text" name="img" value="<%= encodeHTML(request.getParameter("img") != null ? request.getParameter("img") : "") %>" required></p>
            </div>
            <div class="tableRow">
				<p>Tipologia:</p>
				<p>
   				 <select name="tipologia" required>
     				    <option value="Anelli" <%= "Anelli".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Anelli</option>
        				<option value="Ciondoli" <%= "Ciondoli".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Ciondoli</option>
        				<option value="Collane" <%= "Collane".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Collane</option>
        				<option value="Bracciali" <%= "Bracciali".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Bracciali</option>
        				<option value="BodyChains" <%= "BodyChains".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>BodyChains</option>
        				<option value="Piercings" <%= "Piercings".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Piercings</option>
        				<option value="Orecchini" <%= "Orecchini".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Orecchini</option>
        				<option value="Orologi" <%= "Orologi".equals(encodeHTML(request.getParameter("tipologia") != null ? request.getParameter("tipologia") : "")) ? "selected" : "" %>>Orologi</option>
    			 </select>
				</p>				
            </div>
            <div class="tableRow">
                <p>Descrizione dettagliata:</p>
                <p><input type="text" name="descDett" value="<%= encodeHTML(request.getParameter("descDett") != null ? request.getParameter("descDett") : "") %>"></p>
            </div>
            <div class="tableRow">
                <p></p>
                <p><input type="submit" value="Aggiungi"></p>
            </div>
        </form>
    </div>

    <%@ include file="../fragments/footer.jsp" %>
</body>
</html>