<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaPrincipal" Debug="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">
     <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

    <title>Persona Principal</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
</head>

<%--<script src="Scripts/jquery-3.5.1.min.js"></script>
<script language="javascript" type="text/javascript">  
    $.expr[":"].containsNoCase = function (el, i, m) {
        var search = m[3];
        if (!search) return false;
        return eval("/" + search + "/i").test($(el).text());
    };

    $(document).ready(function () {
        $('#txtNombre').keyup(function () {
            if ($('#txtNombre').val().length > 1) {
                $('#dgvPersonas tr').hide();
                $('#dgvPersonas tr:first').show();
                $('#dgvPersonas tr td:containsNoCase(\'' + $('#txtNombre').val() + '\')').parent().show();
            }
            else if ($('#txtSearch').val().length == 0) {
                resetSearchValue();
            }

            if ($('#dgvPersonas tr:visible').length == 1) {
                $('.norecords').remove();
                $('#dgvPersonas').append('<tr class="norecords"><td colspan="6" class="Normal" style="text-align: center">No records were found</td></tr>');
            }
        });

        $('#txtNombre').keyup(function (event) {
            if (event.keyCode == 27) {
                resetSearchValue();
            }
        });
    });

    function resetSearchValue() {
        $('#txtNombre').val('');
        $('#dgvPersonas tr').show();
        $('.norecords').remove();
        $('#txtNombre').focus();
    }

</script>--%>
   
<body>
    <nav class="navbar navbar-dark bg-primary">
  <div class="container-fluid">
      Persona
    <button runat="server" class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      
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


        <div class="mb-3 container-fluid" style="color: #000000; font-size: medium; font-family: Arial; font-weight: bold">
            
  <h1>Persona principal</h1>
        </div>
        <div>


            <div class="container">
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar persona" type="button"
                    OnClick="btnAgregar_Click" ViewStateMode="Disabled" class="btn btn-primary" BorderStyle="Double" />
                 <asp:Button ID="btnMenu" runat="server" Text="Menu principal"   class="btn btn-info" OnClick="btnMenu_Click"/>
            </div>
            <div class="container">

                <br />

                <asp:Label ID="Label2" runat="server" Text="Sexo:"></asp:Label>
        <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-control form-select" Height="35px" Width="253px"
            Style="margin-left: 0px">
        </asp:DropDownList>

                </div>

            <div class="container">
                <asp:Label ID="Label4" runat="server" Text="Estado civil:"></asp:Label>
                <asp:DropDownList ID="ddlEstadoCivil" runat="server" CssClass="form-control form-select" Height="35px" Width="253px" ></asp:DropDownList>
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
            <div class="align-content-center">
                <center>
                <asp:Label ID="Label1" runat="server" Text="Detalles"></asp:Label>
                    <br />
                </center>
            </div>
            </div>
  

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                            <asp:GridView ID="dgvPersonas" runat="server" class="table table-bordered table-condensed"
                            AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourcePersona"
                            Width="1067px" CellPadding="3"
                            OnRowCommand="dgvPersonas_RowCommand"
                            ViewStateMode="Disabled" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                            <Columns>
                                <asp:BoundField DataField="strClaveUnica" HeaderText="Clave Unica"
                                    ReadOnly="True" SortExpression="strClaveUnica" />
                                <asp:BoundField DataField="strNombre" HeaderText="Nombre" ReadOnly="True"
                                    SortExpression="strNombre" />
                                <asp:BoundField DataField="strAPaterno" HeaderText="APaterno" ReadOnly="True"
                                    SortExpression="strAPaterno" />
                                <asp:BoundField DataField="strAMaterno" HeaderText="AMaterno" ReadOnly="True"
                                    SortExpression="strAMaterno" />
                                <asp:BoundField DataField="CatSexo" HeaderText="Sexo"
                                    SortExpression="CatSexo" />
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

                                <asp:TemplateField HeaderText="Direccion">
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="imgDireccion" CommandName="Direccion" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="50px" />

                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
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
        <asp:LinqDataSource ID="DataSourcePersona" runat="server"
           
            ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext"
            OnSelecting="DataSourcePersona_Selecting"
            Select="new (strNombre, strAPaterno, strAMaterno, CatSexo, strClaveUnica,id)"
            TableName="Persona" EntityTypeName="">
        </asp:LinqDataSource>


        

        <br />
        <br />





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
