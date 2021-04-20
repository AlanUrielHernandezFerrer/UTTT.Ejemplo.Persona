<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.UsuarioPrincipal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <title>Usuario</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
</head>
  
<body>
     
     <nav class="navbar navbar-dark bg-primary">
  <div class="container-fluid">
      Usuario principal<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
     
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
    </div>
  </div>
    </nav>
            
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="align-content-end d-grid gap-2 d-md-flex justify-content-md-end">
          
          
                 <asp:Label ID="lblUserDetails" runat="server" Text=""></asp:Label>
            <asp:Button ID="btnLogout" runat="server" Text="Cerrar sesion"   class="btn btn-danger" OnClick="btnLogout_Click"/>
        </div>
           <div class="align-content-end d-grid gap-2 d-md-flex justify-content-md-end">
          
            
        </div>
        <div class="mb-3 container-fluid" style="color: #000000; font-size: medium; font-family: Arial; font-weight: bold">
            <h1> Usuario principal</h1>
            <div class="container">
            <asp:Button ID="btnAgregarUsuario" runat="server" Text="Agregar Usuario"  type="button" OnClick="btnAgregarUsuario_Click"
                    ViewStateMode="Disabled" class="btn btn-primary" BorderStyle="Double" />
                <asp:Button ID="btnMenu" runat="server" Text="Menu principal"   class="btn btn-info" OnClick="btnMenu_Click"/>
            </div>
            <br />
            <div class="container">
          
                <br />
                <br />
                 <asp:DropDownList ID="ddlCatEstado" CssClass="form-control form-select"  Width="474px" runat="server" ></asp:DropDownList>
                </div>
                 <div class="container">
               
                <asp:Label ID="Label3" runat="server" Text="Nombre"></asp:Label>

                <asp:UpdatePanel ID="PtxtName" runat="server">
                            <ContentTemplate>
                                <input type="submit" name="btnTrick" id="btnTrick" style="display:none;"/>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Width="253px" AutoPostBack="True" OnTextChanged="txtNombre_TextChanged" 
                            ViewStateMode="Disabled"></asp:TextBox>
                <br />
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" type="button"
                    OnClick="btnBuscar_Click" ViewStateMode="Disabled" CssClass="btn btn-secondary" BorderStyle="Double" Width="146px" />

           
            </div>
            <div class="container">
                <center>
            <h3>Detalles</h3>
                    </center>
            </div>


          
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgvUsuarios" runat="server"  class="table table-bordered table-condensed" 
                                        AllowPaging="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceUsuario"
                                         Width="930px"  CellPadding="4" 
                                        OnRowCommand="dgvUsuarios_RowCommand"
                                        ViewStateMode="Disabled" ForeColor="#333333" GridLines="None" >
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>

                                            <asp:BoundField DataField="strNombre" HeaderText="Nombre Usuario" ReadOnly="True" SortExpression="strNombre" />

                                            <asp:BoundField DataField="Persona" HeaderText="Persona" ReadOnly="True" SortExpression="strNombre" />
                                            <asp:TemplateField HeaderText="Editar">
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />

                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Eliminar" Visible="True">
                                                <ItemTemplate>
                                                    <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/delrecord_16x16.png" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <EditRowStyle BackColor="#2461BF" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                    </asp:GridView>


                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnBuscar" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>


                        </div>
                    </div>
                </div>
            </div>     
        </div>
          <asp:LinqDataSource ID="LinqDataSourceUsuario" runat="server" 
                            ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" 
                             OnSelecting="DataSourceUsuario_Selecting"
                            EntityTypeName="" 
                            Select="new (id, strNombre, Persona, dteFechaIngreso, CatUsuario)" 
                            TableName="Usuario">
                        </asp:LinqDataSource>
    </form>

          <script type="text/javascript">
              var nombre = document.getElementById("txtNombre").value;
              document.querySelector('#txtNombre').addEventListener('keyup', function () {
                  const btnTrick = document.querySelector('#btnTrick');
                  btnTrick.click();
              });
          </script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
