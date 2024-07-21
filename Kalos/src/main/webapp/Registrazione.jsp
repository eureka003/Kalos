<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
<title>Registrazione</title>
</head>
<body class="sfondo-login">
    <div id="main" class="clear">
     <div class="registration-container">
    <div class="registration-card">
        <h2>Registrazione</h2>
        <form action="Registrazione" method="post" id="myform" onsubmit="event.preventDefault(); validate(this)">
            <div>
                <p>Nome:</p>
                <p><input type="text" name="nome" placeholder="Mario" required/></p>    
            </div>
            <div>
                <p></p>
                <p id="errNome"></p> 
            </div>
            <div> 
                <p>Cognome:</p>
                <p><input type="text" name="cognome" placeholder="Rossi" required/></p>
            </div>
            <div>
                <p></p>
                <p id="errCognome"></p> 
            </div>
            <div>
                <p>Email:</p>
                <p><input type="text" id="em" name="email" placeholder="MarioRossi@gmail.com" required/></p>    
            </div>
            <div>
                <p></p>
                <p id="errEmail"></p> 
            </div>
            <div>
                <p>Data di nascita:</p>
                <p><input type="text" name="nascita" placeholder="23-10-1987" required/></p>    
            </div>
            <div>
                <p></p>
                <p id="errNascita"></p> 
            </div>
            <div>
                <p>Username:</p>
                <p><input type="text" id="us" name="us" placeholder="MarioR87"  required/></p>
            </div>
            <div>
                <p></p>
                <p id="errUser"></p> 
            </div>
            <div>
                <p>Password:</p>
                <p><input type="password" name="pw" placeholder="********" required/></p>
                <p>Deve contenere almeno una lettera maiuscola, una minuscola, un numero e deve essere lunga almeno 8 caratteri</p>
            </div>
            <div>
                <p></p>
                <p id="errPass"></p> 
            </div>
            <div>
                <p></p>
                <p><input type="submit" value="Registrati"></p>
            </div>        
        </form>
    </div>
    </div>
    </div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="script/Registrazione.js"></script>

    <script>
        $(document).ready(function(){
            $("#us").keyup(function(){
                var x = $("#us").val();
                if(x != ''){
                    $.post("./CheckUsername",{"us" : x},function(data){
                        if(data == 'not valid'){
                            $("#errUser").html("username già in uso").css({"color" : "red"});
                        }
                        else{
                            $("#errUser").html("");
                        }
                    });
                }
                else{
                    $("#errUser").html("");
                }
            });

            $("#em").keyup(function(){
                var email = $("#em").val();
                if(email != ''){
                    $.post("./CheckEmail",{"em" : email},function(data){
                        if(data == 'not valid'){
                            $("#errEmail").html("email già in uso").css({"color" : "red"});
                        }
                        else{
                            $("#errEmail").html("");
                        }
                    });
                }
                else{
                    $("#errEmail").html("");
                }
            });
        });
    </script>
</body>
</html>
