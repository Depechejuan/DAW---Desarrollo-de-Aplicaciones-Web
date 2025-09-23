<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empleados1.aspx.cs" Inherits="GesPresta.Empleados1" %>

<%@ Register src="Cabecera.ascx" tagname="Cabecera" tagprefix="uc1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="~/Styles/style.css" type="text/css" runat="server">
    <link rel="stylesheet" href="~/Styles/forms.css" type="text/css" runat="server">

    <title></title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
            padding: 2px;
            font-size: 16px;
        }

        a {
            color: blue;
        }

        .text {
            text-align: center;
            margin: 5px;
        }

        nav {
            text-align: center;
            margin: 10px;
        }

        .forms {
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #888; /* más elegante que el rojo */
            border-radius: 5px;
        }

        .row {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        .title {
            text-align: right;
            width: 30%;
            padding-right: 10px;
        }

        .input {
            text-align: left;
            width: 70%;
            margin-top: 0px;
        }

        input[type="text"], select {
            width: 90%;
            padding: 5px;
            box-sizing: border-box;
        }

        input[type="radio"] {
            margin-right: 5px;
        }

        #cmdEnviar {
            margin-top: 15px;
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
        }

    </style>
    </head>
    <body>
        <form id="form1" runat="server">
            <uc1:Cabecera ID="Cabecera1" runat="server" />
            <h2>DATOS DEL EMPLEADO</h2>
            <div class="forms">
                <div class="row">
                    <p class="title">
                        <asp:Label ID="Label1" runat="server" Text="Código Empleado:"></asp:Label>
                    </p>
                    <div class="input">
                        <asp:TextBox ID="txtCodEmp" runat="server" Width="257px"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <p class="title">
                        <asp:Label ID="Label2" runat="server" Text="NIF:"></asp:Label>
                    </p>
                    <div class="input">
                        <asp:TextBox ID="txtNifEmp" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <p class="title">
                        <asp:Label ID="Label3" runat="server" Text="Apellidos y Nombre:"></asp:Label>
                    </p>
                    <div class="input"> <asp:TextBox ID="txtNomEmp" runat="server"></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label4" runat="server" Text="Dirección:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtDirEmp" runat="server"></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label5" runat="server" Text="Ciudad:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtCiuEmp" runat="server"></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label6" runat="server" Text="Teléfonos:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtTelEmp" runat="server"></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label7" runat="server" Text="Fecha de Nacimiento:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtFnaEmp" runat="server"></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label8" runat="server" Text="Fecha de Ingreso"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtFinEmp" runat="server"></asp:TextBox></div>
                </div>
                 <div class="row">
                    <p class="title"><asp:Label ID="Label9" runat="server" Text="Sexo:"></asp:Label></p>
                    <div class="input">
                        <asp:RadioButtonList ID="rblSexEmp" runat="server">
                            <asp:ListItem Selected="True">Hombre</asp:ListItem>
                            <asp:ListItem>Mujer</asp:ListItem>
                        </asp:RadioButtonList></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label10" runat="server" Text="Departamento:"></asp:Label></p>
                    <div class="input">
                        <asp:DropDownList ID="ddlDepEmp" runat="server">
                            <asp:ListItem Selected="True">Investigación</asp:ListItem>
                            <asp:ListItem>Desarrollo</asp:ListItem>
                            <asp:ListItem>Innovación</asp:ListItem>
                            <asp:ListItem>Administración</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:Button ID="cmdEnviar" runat="server" Text="Enviar" OnClick="cmdEnviar_Click" Width="30%" />
      

            </div>
            <p>
                &nbsp;</p>
            <p>
                <asp:Label ID="lblValores" runat="server" BackColor="#66FFFF" Visible="False" Width="60%"></asp:Label>
            </p>
        </form>
    </body>
</html>
