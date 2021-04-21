<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.UsuarioManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
     
     <nav class="navbar navbar-dark bg-primary">
  <div class="mb-3 container-fluid" style="color: #000000; font-size: medium; font-family: Arial; font-weight: bold"">
      Usuario
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
     
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
    </div>
  </div>
    </nav>
         
    <form id="form1" runat="server">
        <div class="align-content-end d-grid gap-2 d-md-flex justify-content-md-end">
          
             <asp:Label ID="lblUserDetails" runat="server" Text=""></asp:Label>
            <asp:Button ID="btnLogout" runat="server" Text="Cerrar sesion"   class="btn btn-danger" OnClick="btnLogout_Click"/>
        </div>
          <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="container float-sm-none position-relative">
             
       <h1>Usuario manager</h1>

            <div> 
                <center>
                <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True" Height="32px" Width="165px" Font-Size="X-Large"></asp:Label>
                </center>
                 <center>
                <asp:Label ID="lblMensaje" runat="server" BorderColor="Red" Visible="False" BackColor="Red" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
            </center>

            </div>
            
           
           
            <div class="mb-3">
                 
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
               <asp:Label ID="Label3" runat="server" Text="Nombre de la persona"></asp:Label>
            <asp:DropDownList ID="ddlPersona" runat="server"  CssClass="form-control form-select" Width="474px" AutoPostBack="True"  >
            </asp:DropDownList>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlPersona" 
                        ErrorMessage="Selecione persona" InitialValue=""></asp:RequiredFieldValidator>
                               </ContentTemplate>
                 <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlPersona" 
                    EventName="SelectedIndexChanged" />
                </Triggers>
                </asp:UpdatePanel>
                <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PersonaConnectionString %>" SelectCommand="SELECT [strNombre] FROM [Persona]"></asp:SqlDataSource>--%>
                </div>
            <div class="mb-3">
             <asp:Label runat="server" Text="Nombre del usuario"></asp:Label>
            <asp:TextBox ID="txtNombreUsuario" runat="server"  CssClass="form-control"  Width="474px" MinLength="3"  MaxLength="15" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*El campo nombre usuario es obligatorio"
                        ControlToValidate="txtNombreUsuario" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        runat="server" ErrorMessage="Debe ingresar solo letras"
                        ControlToValidate="txtNombreUsuario" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>
            </div>
            <div class="mb-3">
                <asp:Label ID="Label1" runat="server" Text="Contraseña"></asp:Label>
                <asp:TextBox ID="txtContrasenia1" runat="server" CssClass="form-control" MinLength="3"  MaxLength="15" Width="474px" type="password" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*El campo contraseña
                es obligatorio"
                        ControlToValidate="txtContrasenia1" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            <div class="mb-3">
                <asp:Label ID="Label5" runat="server" Text="Vuela a escribir la contraseña"></asp:Label>
                <asp:TextBox ID="txtContrasenia2" runat="server" CssClass="form-control" MinLength="3"  MaxLength="15"
                    
                    Width="474px" type="password"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*El campo contraseña 
                es obligatorio"
                        ControlToValidate="txtContrasenia2" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtContrasenia1" ControlToValidate="txtContrasenia2" ErrorMessage="No coinciden las contraseñas"></asp:CompareValidator>
            </div>
            <div class="mb-3">
                <asp:Label ID="Label2" runat="server" Text="Fecha de ingreso"></asp:Label>
                 <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control col-sm-auto"  Width="474px"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*La fecha es obligatorio"  ControlToValidate="TextBox1" ></asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ErrorMessage="Formato incorecto de la fecha"  ControlToValidate="textBox1" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$"></asp:RegularExpressionValidator>
                  
                 <ajaxToolkit:CalendarExtender ID="CalendarExtender" runat="server" Format="MM/dd/yyyy" PopupPosition="BottomRight" BehaviorID="CalendarExtender" PopupButtonID="TextBox1" TargetControlID="TextBox1" />
            </div>
            <div class="mb-3">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                <asp:Label ID="Label4" runat="server" Text="Estado"></asp:Label>
                <asp:DropDownList ID="ddlCatEstado" CssClass="form-control form-select"  Width="474px" runat="server" ></asp:DropDownList>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*El campo estado es obligatorio"
                        ControlToValidate="ddlCatEstado" ForeColor="Red" InitialValue="-1" ></asp:RequiredFieldValidator>
                     </ContentTemplate>
                 <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlCatEstado" 
                    EventName="SelectedIndexChanged" />
                </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="mb-3">
                <asp:Button ID="btnAceptar" OnClick="btnAceptar_Click" runat="server" Text="Guardar" type="button" ViewStateMode="Disabled" class="btn btn-primary" BorderStyle="Double" Font-Italic="False"/>
                 <a href="UsuarioPrincipal.aspx" class="btn btn-secondary">Cancelar</a>
            </div>
        </div>
    </form>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
