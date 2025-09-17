<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prestaciones.aspx.cs" Inherits="GesPresta.Prestaciones" %>
<%@ Register src="Cabecera.ascx" tagname="Cabecera" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" href="./Styles/style.css" type="text/css">
<link rel="stylesheet" href="./Styles/forms.css" type="text/css">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" class="prestaciones">
        <uc1:Cabecera ID="Cabecera1" runat="server" />

        <div class="forms">
            <h2>DATOS DE LAS PRESTACIONES</h2>
            <p>
                <asp:Label ID="Label1" runat="server" Text="Código Prestación: "></asp:Label>
                <asp:TextBox ID="txtCodPre" runat="server"></asp:TextBox>
            </p>
            <p>
                <asp:Label ID="Label2" runat="server" Text="Descripción: "></asp:Label>
                <asp:TextBox ID="txtDesPre" runat="server" Width="422px"></asp:TextBox>
            </p>
            <p>
                <asp:Label ID="Label3" runat="server" Text="Importe Fijo: "></asp:Label>
                <asp:TextBox ID="txtImpPre" runat="server"></asp:TextBox>
            </p>
            <p>
                <asp:Label ID="Label4" runat="server" Text="Porcentaje del Importe: "></asp:Label>
                <asp:TextBox ID="txtPorPre" runat="server"></asp:TextBox>
            </p>
            <p>
                <asp:Label ID="Label5" runat="server" Text="Tipo de Prestación:"></asp:Label>
                <asp:DropDownList ID="ddlTipPre" runat="server">
                    <asp:ListItem>Dentaria</asp:ListItem>
                    <asp:ListItem>Familiar</asp:ListItem>
                    <asp:ListItem Selected="True">Ocular</asp:ListItem>
                    <asp:ListItem>Otras</asp:ListItem>
                </asp:DropDownList>
            </p>
            <p>
                &nbsp;</p>
            <p>
                <asp:Button ID="cmdEnviar" runat="server" Text="Enviar" />
            </p>

        </div>
    </form>
</body>
</html>
