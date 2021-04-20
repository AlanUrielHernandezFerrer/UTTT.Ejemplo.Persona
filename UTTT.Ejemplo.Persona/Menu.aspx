<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Menu</title>
     <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
       <%--<nav class="navbar navbar-dark bg-primary">
  <div class="container-fluid">
      Menu<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
     
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
    </div>
  </div>
    </nav>--%>
    <form id="form1" runat="server">
        <div class="align-content-end d-grid gap-2 d-md-flex justify-content-md-end">
          
            <asp:Label ID="lblUserDetails" runat="server" Text=""></asp:Label>
            <asp:Button ID="btnLogout" runat="server" Text="Cerrar sesion"   class="btn btn-danger" OnClick="btnLogout_Click"/>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <div align="center">
              <asp:ImageButton ID="ImageButton1" ImageUrl="~/Images/otro.png"  AlternateText="No Image available" OnClick="btnPersona_Click" runat="server" /> 
            
            <asp:Label ID="Label1" runat="server" Text="Persona"></asp:Label>
          
             <asp:ImageButton ID="ImageButton2" ImageUrl="~/Images/usuario.png"  AlternateText="No Image available" OnClick="btnUsuario_Click" runat="server" Height="257px" Width="256px" />
            <asp:Label ID="Label2" runat="server" Text="Usuario"></asp:Label>
           
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
