<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ejercicio1.aspx.cs" Inherits="ServiciosWebCS.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Consumidor UA</title>
    <style accesskey="text/css">
        body {
            font-family: Arial, Helvetica, sans-serif;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100dvw;
            height: 100dvh;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>CONSUMIR UN SERVICIO WEB YA EXISTENTE</h1>
        <h2>Titulaciones Oficiales en la Universidad de Alicante</h2>
        <div>
            
            <asp:Label ID="lblInfo" runat="server" Text="Curso académico (formato aaaa-aa)"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtCurso" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnObtenerInformacion" runat="server" Text="Obtener Información" OnClick="btnObtenerInformacion_Click" />
            
            <br />
            <br />
            <asp:Label ID="lblResultado" runat="server"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
            
        </div>
    </form>
</body>
</html>