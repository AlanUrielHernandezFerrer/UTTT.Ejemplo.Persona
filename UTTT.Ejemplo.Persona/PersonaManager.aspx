<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" EnableEventValidation="false" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="javascript">

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return true;

        return false;
    }

</script>

<script language="javascript">
    function validateYear(evt) {
        if (date) {
            var date = new Date(date);
            if (date.getFullYear() > 2003)

                alert("No puedes registrarte ya que eres menor de edad");
        }
    }
</script>


 

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

     <%--<script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PersonaManager.aspx/PopulateDropDownList",
                data: "{}",
                dataType: "json",
                success: function (result) {
                    $('#ddlSexo').empty();
                    $('#ddlSexo').append("<option value='0'>---Seleciona---</option>");
                    $.each(result.d, function (key, value) {
                        $("#ddlSexo").append($("<option></option>").val(value.id).html(value.strValor));

                    });
                },
                error: function ajaxError(result) {
                    alert(result.status + ' : ' + result.statusText);
                }

            });
        });

    </script>--%>

   <%-- <script type="text/javascript">

        $(document).ready(function () {

            $.ajax({

                type: "POST",
                url: "PersonaManager.aspx/PopulateDropDownList",
                data: {},
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var jsdata = JSON.parse(data.d);
                    $.each(jsdata, function (key, value) {
                        $('#<%=ddlSexo.ClientID%>').append($("<option>Select</option>").val(value.id).html(value.strValor));
                  });
              },
              error: function (data) {
                  alert("error found");
              }

          });

      });

    </script>--%>



    <title>Persona manager</title>
</head>
<body runat="server">

    <nav class="navbar navbar-dark bg-primary">
  <div class="container-fluid">
      Persona
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
     
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
    </div>
  </div>
    </nav>




    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />


        <div class="mb-3 container-fluid" style="font-family: Arial; font-size: medium; font-weight: bold">
            <h1>Persona manager</h1>
        </div>

        <br />
        <div class="container">
            <h4>
                <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True" Height="25px" Width="142px"></asp:Label>
            </h4>
        </div>

        <div class="container">
            <center>
                <asp:Label ID="lblMensaje" runat="server" BorderColor="Red" Visible="False" BackColor="Red" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
            </center>


        </div>



        <div class="container float-sm-none position-relative">
            <center>

                <div class="mb-3">
                      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                          <ContentTemplate> 
                    <asp:Label ID="Label1" runat="server" Text="Sexo"></asp:Label>                  
                    <asp:DropDownList ID="ddlSexo" CssClass="form-control form-select"  Width="474px" runat="server"
                        Style="margin-left: 0px">
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlSexo" 
                        ErrorMessage="Selecione el sexo" InitialValue="-1"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                 <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlSexo" 
                    EventName="SelectedIndexChanged" />
                </Triggers>
                </asp:UpdatePanel>
                </div>


                <div class="mb-3">

                    <asp:Label ID="Label2" runat="server" Text="Clave unica:"></asp:Label>

                    <asp:TextBox ID="txtClaveUnica" runat="server" CssClass="form-control" type="number" Width="474px" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*El campo clave unica 
                es obligatorio"
                        ControlToValidate="txtClaveUnica" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="La clave unica es del 1 al 1000" MaximumValue="1000" MinimumValue="1" Type="Integer"></asp:RangeValidator>

                </div>
                <div class="mb-3">

                    <asp:Label ID="Label3" runat="server" Text="Nombre:"></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server" MinLength="3" CssClass="form-control" Width="474px"
                        MaxLength="15" Style="margin-left: 0px" onkeypress="return isNumberKey(event)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*El campo nombre 
                es obligatorio"
                        ControlToValidate="txtNombre" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        runat="server" ErrorMessage="Debe ingresar solo letras"
                        ControlToValidate="txtNombre" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>

                </div>

                <div class="mb-3">

                    <asp:Label ID="Label4" runat="server" Text="A paterno:"></asp:Label>
                    <asp:TextBox ID="txtAPaterno" runat="server" CssClass="form-control" Width="474px" onkeypress="return isNumberKey(event)"
                        MinLength="3" MaxLength="15" Style="margin-left: 0px"></asp:TextBox>


                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*El campo A Paterno 
                es obligatorio"
                        ControlToValidate="txtAPaterno" ForeColor="Red"></asp:RequiredFieldValidator>

                    <br />

                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                        runat="server" ErrorMessage="Debe ingresar solo letras o borre los espacios porfavor."
                        ControlToValidate="txtAPaterno" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>
                </div>

                <div class="mb-3">

                    <asp:Label ID="Label5" runat="server" Text="A materno:"></asp:Label>
                    <asp:TextBox ID="txtAMaterno" CssClass="form-control" runat="server" onkeypress="return isNumberKey(event);" MinLength="3" Width="474px" MaxLength="15" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*El campo A Materno 
                es obligatorio"
                        ControlToValidate="txtAPaterno" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3"
                        runat="server" ErrorMessage="Debe ingresar solo letras borre o los espacios porfavor."
                        ControlToValidate="txtAMaterno" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>
                </div>

                <div class="mb-3">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate> 
                    <asp:Label ID="Label6" runat="server" Text="Estado civil"></asp:Label>
                           
                    <asp:DropDownList ID="ddlEstadoCivil" runat="server" CssClass="form-control form-select"  Width="474px" ></asp:DropDownList>
                       
                                </ContentTemplate>
                       <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlSexo" 
                    EventName="SelectedIndexChanged" />
                </Triggers>
                    </asp:UpdatePanel>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlEstadoCivil" ErrorMessage="Selecione el estado civil" InitialValue="-1"></asp:RequiredFieldValidator>
                </div>

                <%--  <asp:Calendar ID="dteCalendar" runat="server"  title="Calendar" OnSelectionChanged="dteCalendar_SelectionChanged" Style="margin-left: 0px" Width="350px" type="date" BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" BorderWidth="1px">
                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                        <TitleStyle BackColor="White" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" BorderColor="Black" BorderWidth="4px" />
                        <TodayDayStyle BackColor="#CCCCCC" />
                    </asp:Calendar>--%>

                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="La fecha de nacimiento es obligatorio" ControlToValidate="Calendar"></asp:RequiredFieldValidator>--%>


                <div class="mb-3 ">
                    <label class="col-sm-2 col-form-label">Fecha Nacimiento:</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control col-sm-auto"  Width="474px"></asp:TextBox>
                    <br />
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender" runat="server" Format="dd/MM/yyyy" PopupPosition="BottomRight" BehaviorID="CalendarExtender" PopupButtonID="TextBox1" TargetControlID="TextBox1" />
                    <%--<asp:ImageButton CssClass="form-control col-sm-auto" ID="btnCa" runat="server" Height="55px"  Width="73px" />--%>
                </div>


                <asp:Label ID="lblFecha" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>


                <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*La fecha de nacimiento es obligatorio"  ControlToValidate="TextBox1" ></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ErrorMessage="Formato incorecto de la fecha"  ControlToValidate="textBox1" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$"></asp:RegularExpressionValidator>
                    <br />


                <div class="mb-3">

                    <asp:Label ID="lblCorreoElectronico" runat="server" Text="Correo electronico:"></asp:Label>
                    <asp:TextBox ID="txtCorreoElectronico" runat="server" CssClass="form-control" Style="margin-left: 0px" Width="474px" MinLength="3" MaxLength="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*El campo Correo electronico es obligatorio"
                        ControlToValidate="txtCorreoElectronico" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtCorreoElectronico" ErrorMessage="Correo electronico invalido" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"></asp:RegularExpressionValidator>



                </div>

                <div class="mb-3">

                    <asp:Label ID="lblCodigopostal" runat="server" Text="Codigo postal:"></asp:Label>
                    <asp:TextBox ID="txtCodigoPostal" runat="server" Style="margin-left: 0px" MinLength="3" CssClass="form-control" Width="474px" MaxLength="20" type="number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*El campo Codigo postal es obligatorio"
                        ControlToValidate="txtCodigoPostal" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtCodigoPostal"
                        ErrorMessage="Ingresa un codigo postal valido" ValidationExpression="^[0-9]{5}$"></asp:RegularExpressionValidator>

                </div>

                <div class="mb-3">
                    <asp:Label ID="lblRfc" runat="server" Text="Rfc:"></asp:Label>
                    <asp:TextBox ID="txtRfc" runat="server" CssClass="form-control" Style="margin-left: 0px" MinLength="3" MaxLength="20" Width="474px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*El campo Rfc es obligatorio"
                        ControlToValidate="txtRfc" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server"
                        ControlToValidate="txtRfc" ErrorMessage="Escribe un Rfc valido"
                        ValidationExpression="^(([A-Z]|[a-z]|\s){1})(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))"></asp:RegularExpressionValidator>
                </div>





                <div class="d-grid gap-2 d-md-block">
                    <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" type="button"
                        OnClick="btnAceptar_Click" ViewStateMode="Disabled" class="btn btn-primary" BorderStyle="Double" Font-Italic="False" />

                    <a href="PersonaPrincipal.aspx" class="btn btn-secondary">Cancelar</a>
                    <%--<asp:Button ID="btnCancelar" runat="server" Text="Cancelar" href="#PersonaPrincipal.aspx"
                       ViewStateMode="Disabled" class="btn btn-secondary" BorderStyle="Double" />--%>
                </div>
                <br />
                <br />
                <br />
                <br />
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
