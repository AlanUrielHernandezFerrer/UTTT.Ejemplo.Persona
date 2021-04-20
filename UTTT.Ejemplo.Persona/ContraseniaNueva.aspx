<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContraseniaNueva.aspx.cs" Inherits="UTTT.Ejemplo.Persona.ContraseniaNueva" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Nueva contraseña</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
       
            </div>
        <div class="container"> 
              <asp:TextBox ID="txtUsuario" runat="server" class="form-control" Width="253px" Enabled="False"></asp:TextBox>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Escriba su nueva contraseña"></asp:Label>
            <asp:TextBox ID="txtNuevaContrasenia" runat="server" MinLength="3"  MaxLength="15" class="form-control" Width="253px" type="password"></asp:TextBox>
             <br />
            <asp:Label ID="Label2" runat="server" Text="Escriba su nueva contraseña de nuevo"></asp:Label>
            <asp:TextBox ID="txtNuevaContrasenia2" runat="server" MaxLength="25" class="form-control" Width="253px" type="password" MinLength="3"></asp:TextBox>
             <br />
            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-secondary" OnClick="btnAceptar_Click" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El campo es obligatorio" ControlToValidate="txtNuevaContrasenia"></asp:RequiredFieldValidator>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El campo es obligatorio" ControlToValidate="txtNuevaContrasenia2"></asp:RequiredFieldValidator>
               <asp:Label ID="alerta" runat="server" ForeColor="Red"></asp:Label>
        </div>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </form>
     </body>
</html>
