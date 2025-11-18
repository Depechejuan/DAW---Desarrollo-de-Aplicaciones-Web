<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GesTienda.Default" %>
<%@ OutputCache Duration="1" VaryByParam="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>
        header {
            background-color: darkblue;
            color: white;
            text-align: left;
            padding: 20px;
            height: 50px;
            font-weight: bold;
        }
        
        main {
            display: flex;
            flex-direction: column;
            align-content: center;
            justify-content: center;
            height: 80%;
        }

        h2 {
            text-align: center;
        }
        .btn {
            text-align: center;
            margin: 0 auto;
        }

        #Login1 {
            margin: 0 auto;
        }

        #LinkButton1 {
            text-align: center;
        }

        p {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>TIENDA ONLINE - SHOPPING DAW</header>
        <main>
            <h2>GESTIENDA</h2>

            <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate" RememberMeText="" BorderPadding="10">
                <LoginButtonStyle CssClass=".btn" />
            </asp:Login>
            <br />
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Registrarse.aspx">Registrarse</asp:LinkButton>
        <br />
            <br />
            <asp:Label ID="lblMensajes" runat="server"></asp:Label>

        </main>
        <footer>
            <p>Desararollo de Aplicaciones Web interactivas.</p>
            <p>IES Mare Nostrum, Alicante</p>

        </footer>
    </form>
</body>
</html>
