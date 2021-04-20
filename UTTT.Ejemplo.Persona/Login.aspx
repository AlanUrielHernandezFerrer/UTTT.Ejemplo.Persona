<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <title>Login</title>
</head>
<body>
      
    <form id="form1" runat="server">
                        
        <div class="container-fluid">
            <center>

            <br />
            <div class="mb-3">
             <asp:Image id="Image1" runat="server" Height="99px" ImageUrl="~/Images/login.png" runat="server" Width="106px" AlternateText="Imagen no disponible" ImageAlign="TextTop" />
                </div>
                <br />
            <div class="mb-3">
		   
                    
                        <asp:TextBox ID="txtUser" class="form-control" runat="server" MaxLength="25" Width="253px" placeholder="Usuario"></asp:TextBox>
                    
                   
                </div>
                     <div class="mb-3">
                        
                    
                  
                        <asp:TextBox ID="txtPassword" class="form-control"  type="password" MaxLength="30" runat="server" Width="253px" placeholder="Contraseña" ></asp:TextBox>
                   </div>
             <div class="mb-3">
                 <asp:Button ID="btnLogin" runat="server" Text="Ingresar" type="submit" class="btn btn-primary" OnClick="btnLogin_Click" />
                 <a href="#"  OnClick="window.open('Recuperarcontrasenia.aspx','FP','width=500,height=50,top=300,left=500,fullscreen=no,resizable=0');">Recuperar contraseña </a>
                 </div>
                <div>
                    <asp:Literal ID="LitMsg" runat="server"></asp:Literal>
                </div>
               
            <div class="mb-3">
                        <asp:Label ID="lblErrorMessage" runat="server" Text="Error de credenciales" ForeColor="Red"></asp:Label>
                    
             </div>   
           
           </center>
        </div>
                                 
    </form>
      
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
