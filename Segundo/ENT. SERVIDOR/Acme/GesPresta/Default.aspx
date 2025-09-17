<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GesPresta.WebForm1" %>

<%@ Register src="Cabecera.ascx" tagname="Cabecera" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet" href="~/Styles/style.css" type="text/css" runat="server">
<link rel="stylesheet" href="~/Styles/forms.css" type="text/css" runat="server">

    <title></title>
</head>
<body>
    <form id="form1" runat="server" class="text">
        <uc1:Cabecera ID="Cabecera1" runat="server" />
        <br />
        <p>
            La corporación ACME está comprometida con sus empleados. Para ello ha establecido una serie de prestaciones que pueden utilizar sus empleados para obtener ayudas sociales asociados a diversos gastos de tipo familiar, médicot, etc. </p>
        <p>Esta aplicación a través de Web permite realizar todas las tareas de gestión relacionadas con la prestación de ayudas a los empleados.</p>
        <p>Para cualquier duda o consulta puede contactar con el Departamento de Ayuda Social: <asp:LinkButton ID="LinkButton1" runat="server">ayuda.social@acme.com</asp:LinkButton></p>
    </form>
</body>
</html>
