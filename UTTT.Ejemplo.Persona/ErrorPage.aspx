<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="UTTT.Ejemplo.Persona.ErrorPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Error de pagina</title>
</head>
<body>
    <form id="form1" runat="server">
        <center>
        <div>
        <div>
       <asp:TextBox ID="mensaje" runat="server" placeholder="Escribe tu mensaje" Visible="False" ></asp:TextBox>
            <br />
            <br />
            </div>


            <div>
       <asp:TextBox ID="asunto" runat="server" placeholder="Asunto" Visible="False"></asp:TextBox>
                <br />
                <br />
                </div>


        <div>
        <asp:TextBox ID="para" runat="server" type="email" placeholder="Correo destinatario" Visible="False"></asp:TextBox>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Hubo un error inesperado o se agaoto tu tiempo de sesion" BackColor="Red"></asp:Label>
            <br />
            </div>
            <asp:Button ID="Button1" runat="server" Text="Enviar correo" OnClick="Button1_Click" Visible="False"/>
            <br />
            <br />
            Contacto de la empresa: alan.ferrer3212@gmail.com</div>
    </center>
    </form>
</body>
</html>
