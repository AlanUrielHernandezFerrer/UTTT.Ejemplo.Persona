<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prueba.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Prueba" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
     DataSourceID="SqlDataSource1" DefaultMode="Edit" Height="50px" 
     Width="125px" AutoGenerateInsertButton="True" 
     AutoGenerateEditButton="True" Visible="False">

<Fields>
   <asp:BoundField DataField="userid" HeaderText="UserId" 
        SortExpression="UserId" />
   <asp:TemplateField HeaderText="username" SortExpression="username">
     <EditItemTemplate>
        <asp:TextBox ID="TextBox1" runat="server" 
             Text='<%# Bind("username")%>'></asp:TextBox>
     </EditItemTemplate>
     <InsertItemTemplate>
        <asp:TextBox ID="TextBox1" runat="server" 
             Text='<%# Bind("username")%>'></asp:TextBox>
     </InsertItemTemplate>
     <ItemTemplate>
        <asp:Label ID="Label1" runat="server" 
             Text='<%# Bind("username")%>'></asp:Label>
     </ItemTemplate>
   </asp:TemplateField>
</Fields>

</asp:DetailsView>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
     ConnectionString="<%$ ConnectionStrings:membership %>"
     SelectCommand=
    "SELECT [UserName], [UserId] FROM [vw_aspnet_Users] Where userid=@userid"
>
   <SelectParameters>
      <asp:QueryStringParameter Name="UserId" QueryStringField="UserId" /> 
   </SelectParameters>
</asp:SqlDataSource>
    </form>
</body>
</html>
