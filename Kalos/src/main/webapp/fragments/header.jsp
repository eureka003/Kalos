<%@ page language="java" pageEncoding="ISO-8859-1"  import="model.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" charset="text/html; ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="header">
	<div class="left-header">
		<div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="Logo del sito" class="logo">
        </div>
		<h2> <span id="sitename">KALÓS</span></h2>
	</div>
	<div class="center-header">
		<input id="searchbar" name="search" type="search" placeholder="Cerca nel catalogo...">
		
		<div class="risultati">
		</div>
	</div>
	<div class="right-header">
		<nav>
			<ul>
			<% UserBean user = (UserBean) request.getSession().getAttribute("currentSessionUser");
				if(user !=null){ %>
							<li class="dropdown">
  								<a href="javascript:void(0)" id="accountDropdownBtn" class="dropbtn">
   									 <i class="fas fa-user"></i>ACCOUNT</a>
  									<div id="accountDropdownContent" class="dropdown-content">
    									<a href="<%= request.getContextPath() %>/Ordine?action=mieiOrdini">I MIEI ORDINI</a>
    									<%if(user.isAmministratore()){ %>
      										<a href="<%= request.getContextPath() %>/admin/GestioneCatalogo.jsp">GESTIONE CATALOGO</a>
      										<a href="<%= request.getContextPath() %>/admin/ViewOrdini.jsp">ORDINI</a>
   								 <%} %>
   	 										<a href="<%= request.getContextPath() %>/Logout">LOGOUT</a>
  									</div>
							</li>
							<li><a href= "<%= request.getContextPath() %>/Carrello.jsp"> <i class="fas fa-shopping-cart"></i>CARRELLO</a></li>
																	
			<%}else{ %>
				<li><a href="<%= request.getContextPath() %>/Login.jsp">ACCEDI</a></li><%} %>
			</ul>
		</nav>
	</div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
	$(document).ready(function(){
		$("#searchbar").keyup(function(){
			var x = $("#searchbar").val();
			if(x != ""){
				$.get("./RicercaProdotto", {"query": x}, function(data){
					if(data!= ""){
						$(".risultati").empty();
						$(".risultati").css({"display" : "block"});
						$.each(data, function(i,item){
							$(".risultati").append("<div id='item-r' class='item"+i+"'><img id='pic' width='65' height='65' src='" + item.immagine + "'/><p id='name'>" +item.nome + "</p></div>");
							$(".item"+i).click(function(){
								$.get("./dettagli",{"id" : item.idProdotto}, function(){
									window.location = "./Dettagli.jsp";
								});
							});
						});
					}
				});
						
				}else{
					$(".risultati").css({"display" : "none"});
				};
			});
	});
</script>

<script>
  document.addEventListener('DOMContentLoaded', function() {
	  var dropdownBtn = document.getElementById('accountDropdownBtn');
	  var dropdownContent = document.getElementById('accountDropdownContent');

	  // Funzione per aprire/chiudere il dropdown
	  function toggleDropdown() {
	    if (dropdownContent.style.display === 'block') {
	      dropdownContent.style.display = 'none';
	    } else {
	      dropdownContent.style.display = 'block';
	    }
	  }

	  // Apri/chiudi il dropdown al click
	  dropdownBtn.addEventListener('click', function(e) {
	    e.preventDefault();
	    toggleDropdown();
	  });

	  // Chiudi il dropdown se si clicca fuori da esso
	  document.addEventListener('click', function(e) {
	    if (!dropdownBtn.contains(e.target) && !dropdownContent.contains(e.target)) {
	      dropdownContent.style.display = 'none';
	    }
	  });

	  // Previeni la propagazione del click sui link del dropdown
	  dropdownContent.addEventListener('click', function(e) {
	    e.stopPropagation();
	  });
	});
</script>

<script>
	$(document).click(function(event) {
    		if (!$(event.target).closest("#searchbar, .risultati").length) {
        	$(".risultati").css({"display" : "none"});
    	}
});

</script>

</body>