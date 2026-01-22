<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LineasFactura.aspx.cs" Inherits="GesFactura.LineasFactura" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<style>
    body {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .form-container {
        display: flex;
        flex-direction: row;
        align-content: center;
        width: 100dvw;
        margin: 1dvh 5dvw;
    }
    .left {
        text-align: right;
        margin-right: 10px;
        width: 50dvw;
    }
    .right {
        text-align: left;
        width: 50dvw;
    }
    .button {
        display: flex;
        width: 100dvw;
        justify-content: center;
    }
    .resultado {
        display: flex;
        justify-content: center;
        width: 100dvw;
        flex-direction: column;
    }
    .resultado > h2 {
        display: flex;
        justify-content: center;
        width: 100dvw;
    }
    .titles, .results { 
        width: 100dvw;
        display: flex;
        flex-direction: row;
        justify-content: space-evenly;
    }
    .titles > p {
        font-weight: bold;
    }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <h1>Uso de Servicio Web - Cálculos factura de un artículo</h1>
    <form id="form1" runat="server">

        <div class="form-container">
            <div class="left">
                <asp:Label ID="Label1" runat="server" Text="Cantidad"></asp:Label>
            </div>
            <div class="right">
                <asp:TextBox ID="txtCantidad" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="form-container">
            <div class="left">
                <asp:Label ID="Label2" runat="server" Text="Precio"></asp:Label>
            </div>
            <div class="right">
                <asp:TextBox ID="txtPrecio" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="form-container">
            <div class="left">
                <asp:Label ID="Label3" runat="server" Text="Descuento (%)"></asp:Label>
            </div>
            <div class="right">
                <asp:TextBox ID="txtDescuento" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="form-container">
            <div class="left">
                <asp:Label ID="Label4" runat="server" Text="Tipo de IVA (%)"></asp:Label>
            </div>
            <div class="right">
                <asp:TextBox ID="txtTipoIVA" runat="server" style="height: 22px"></asp:TextBox>
            </div>
        </div>
        <div class="form-container">
            <div class="button">
                <asp:Button ID="btnEnviar" runat="server" Text="Enviar" OnClick="btnEnviar_Click" />
            </div>
        </div>

        <div class="resultado">
            <h2>
                Resultados de los Cálculos:
            </h2>
            <div class="titles">
                <p>Bruto</p>
                <p>Descuento</p>
                <p>Base Imponible</p>
                <p>IVA</p>
                <p>Total</p>
            </div>
            <div class="results">
                <p>
                    <asp:Label ID="lblBruto" runat="server"></asp:Label>
                </p>
                <p>
                    <asp:Label ID="lblDescuento" runat="server"></asp:Label>
                </p>
                <p>
                    <asp:Label ID="lblBaseImponible" runat="server"></asp:Label>
                </p>
                <p>
                    <asp:Label ID="lblIva" runat="server"></asp:Label>
                </p>
                <p>
                    <asp:Label ID="lblTotal" runat="server"></asp:Label>
                </p>
            </div>
        </div>

    </form>
</body>
</html>
