<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registrarse.aspx.cs" Inherits="GesTienda.Registrarse" %>

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

     h2, h3 {
         text-align: center;
     }
     .btn {
         text-align: center;
         margin: 0 auto;
     }

     #Login1 {
         margin: 0 auto;
     }

     p {
         text-align: center;
     }

     #form1{
         display: flex;
         flex-direction: column;

     }
     .container {
         display: flex;
         flex-direction: row;
         margin-bottom: 10px;
     }
     .text {
         width: 49%;
         text-align: right;
         padding-right: 10px;
         font-weight: bold;
     }
     .form {
         width: 49%;
     }
     .button {
         margin: 0 auto;
     }
 </style>
</head>
<body>
    <header>TIENDA ONLINE - SHOPPING DAW</header>
    <main>
        <h2>GESTIENDA</h2>
        <h3>Registro de Usuario</h3>
        <form id="form1" runat="server">
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label1" runat="server" Text="Correo Electrónico"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtCorCli" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label2" runat="server" Text="Contraseña"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtPassword1" runat="server" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label3" runat="server" Text="Introduzca nuevamente la Contraseña"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtPassword2" runat="server" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label4" runat="server" Text="NIF/NIE/CIF"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtIdCliente" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label5" runat="server" Text="Nombre/Razón Social"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtNomCli" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label6" runat="server" Text="Dirección"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtDirCli" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label7" runat="server" Text="Población"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtPobCli" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label8" runat="server" Text="Código Postal"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtCpoCli" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="container">
                <div class="text">
                    <asp:Label ID="Label9" runat="server" Text="Teléfono"></asp:Label>
                </div>
                <div class="form">
                    <asp:TextBox ID="txtTelCli" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="button">
                <asp:Button ID="Button1" runat="server" Text="Insertar" OnClick="btnInsertar_Click" />
            </div>
            
            <div>
            <asp:Label ID="lblMensajes" runat="server"></asp:Label>

     

            </div>
        <footer>
            <p>Desararollo de Aplicaciones Web interactivas.</p>
            <p>IES Mare Nostrum, Alicante</p>

        </footer>
        </form>

    </main>
</body>
</html>
