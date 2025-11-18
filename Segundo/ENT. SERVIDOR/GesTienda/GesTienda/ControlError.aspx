<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ControlError.aspx.cs" Inherits="GesTienda.ControlError" %>
<%@ OutputCache Duration="1" VaryByParam="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<style>
    .titles {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    
    #error {
        margin: 0 auto;
        margin-top: 20px;
        padding: 10px;
        border: 2px solid black;
        width: 50%;
        font-size: 16px;
        text-align: center;
    }

</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="titles">
            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="50px" Text="Aplicación Web GesTienda"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="20px" Text="Error en tiempo de ejecución"></asp:Label>
            <br />
        </div>
        <div id="error">

            <asp:Label ID="Label3" runat="server" Text="Error ASP.NET:"></asp:Label>
            <br />
            <asp:Label ID="lblErrorASP" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Error ADO.NET:"></asp:Label>
            <br />
            <asp:Label ID="lblErrorADO" runat="server" ForeColor="Red"></asp:Label>

        </div>
    </form>
</body>
</html>
