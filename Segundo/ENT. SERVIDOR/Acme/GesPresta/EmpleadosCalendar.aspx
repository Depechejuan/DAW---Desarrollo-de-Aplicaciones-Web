<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmpleadosCalendar.aspx.cs" Inherits="GesPresta.EmpleadosCalendar" %>

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
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            border: 3px solid red;
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
                        <asp:TextBox ID="txtCodEmp" runat="server" Width="257px" required></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <p class="title">
                        <asp:Label ID="Label2" runat="server" Text="NIF:"></asp:Label>
                    </p>
                    <div class="input">
                        <asp:TextBox ID="txtNifEmp" runat="server" required></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <p class="title">
                        <asp:Label ID="Label3" runat="server" Text="Apellidos y Nombre:"></asp:Label>
                    </p>
                    <div class="input"> <asp:TextBox ID="txtNomEmp" runat="server" required></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label4" runat="server" Text="Dirección:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtDirEmp" runat="server" required></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label5" runat="server" Text="Ciudad:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtCiuEmp" runat="server" required></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label6" runat="server" Text="Teléfonos:"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtTelEmp" runat="server" required></asp:TextBox></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label8" runat="server" Text="Fecha de Ingreso"></asp:Label></p>
                    <div class="input"><asp:TextBox ID="txtFinEmp" runat="server" required></asp:TextBox></div>
                </div>
                 <div class="row">
                    <p class="title"><asp:Label ID="Label9" runat="server" Text="Sexo:" required></asp:Label></p>
                    <div class="input">
                        <asp:RadioButtonList ID="rblSexEmp" runat="server">
                            <asp:ListItem Selected="True">Hombre</asp:ListItem>
                            <asp:ListItem>Mujer</asp:ListItem>
                        </asp:RadioButtonList></div>
                </div>
                <div class="row">
                    <p class="title"><asp:Label ID="Label10" runat="server" Text="Departamento:" required></asp:Label></p>
                    <div class="input">
                        <asp:DropDownList ID="ddlDepEmp" runat="server">
                            <asp:ListItem Selected="True">Investigación</asp:ListItem>
                            <asp:ListItem>Desarrollo</asp:ListItem>
                            <asp:ListItem>Innovación</asp:ListItem>
                            <asp:ListItem>Administración</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="row">
                    <p class="title">
                        <asp:Label ID="Label11" runat="server" Text="Fecha de Nacimiento: "></asp:Label>
                        <asp:TextBox ID="TxtCal1" runat="server" AutoPostBack="True" 
                                     OnTextChanged="txtCal1_TextChanged" required></asp:TextBox>
                    </p>
                    <div class="input">
                        <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" SelectedDate="2000-01-01" VisibleDate="2000-01-01" Width="220px" required>
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>
                    </div>

                    <p class="title">
                        <asp:Label ID="Label12" runat="server" Text="Fecha de Ingreso: "></asp:Label>
                        <asp:TextBox ID="TxtCal2" runat="server" AutoPostBack="True" 
                                     OnTextChanged="txtCal2_TextChanged" required></asp:TextBox>
                    </p>
                    <div class="input">
                        <asp:Calendar ID="Calendar2" runat="server" 
                                      OnSelectionChanged="Calendar2_SelectionChanged" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px" required>
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>
                    </div>
                    <div class="extra">
                        <asp:Label ID="Label13" runat="server" Text="Antigüedad"></asp:Label>
                        <br />
                        &nbsp;<asp:TextBox ID="TxtAños" runat="server" Width="116px" OnTextChanged="TxtAños_TextChanged"></asp:TextBox>
                        &nbsp;<asp:Label ID="Label14" runat="server" Text="Años"></asp:Label>
                        &nbsp;<asp:TextBox ID="TxtMeses" runat="server" Width="116px"></asp:TextBox>
                        &nbsp;<asp:Label ID="Label15" runat="server" Text="Meses"></asp:Label>
                        &nbsp;<asp:TextBox ID="txtDias" runat="server" Width="116px"></asp:TextBox>
                        &nbsp;<asp:Label ID="Label16" runat="server" Text="Días"></asp:Label>
                    </div>
                </div>
                <asp:Button ID="cmdEnviar" runat="server" Text="Enviar" OnClick="cmdEnviar_Click" Width="30%" BorderColor="#666699" />
      

            </div>
            <p>
                &nbsp;</p>
            <p>
                <asp:Label ID="lblError1" runat="server" BackColor="#66FFFF"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblError2" runat="server" BackColor="#66FFFF"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblError3" runat="server" BackColor="#66FFFF"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblError4" runat="server" BackColor="#66FFFF"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblError5" runat="server" BackColor="#66FFFF"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblValores" runat="server" BackColor="#66FFFF" Visible="False" Width="60%"></asp:Label>
            </p>
        </form>
    </body>
</html>
