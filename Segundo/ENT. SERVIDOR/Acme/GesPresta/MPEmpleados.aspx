<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MPEmpleados.aspx.cs" Inherits="GesPresta.MPEmpleados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
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
            margin-left: 40px;
        }

        .input {
            text-align: left;
            width: 70%;
            margin-top: 0px;
            display: flex;
            flex-direction: row;
            gap: 5px;
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
    <h2>DATOS DE LOS EMPLEADOS</h2>
        <div class="forms">
            <div class="row">
                <p class="title">
                    <asp:Label ID="Label1" runat="server" Text="Código Empleado:"></asp:Label>
                </p>
                <div class="input">
                    <asp:TextBox ID="txtCodEmp" runat="server" Width="257px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqdTxtCodEmp" runat="server" ControlToValidate="txtCodEmp" ErrorMessage="El Código
Empleado es obligatorio" ForeColor="#CC3300">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regtxtCodEmp" runat="server" ControlToValidate="txtCodEmp" ErrorMessage="El formato de los datos a introducir debe ser:  1letra-5dígitos" ForeColor="#CC3300" ValidationExpression="\w\d{5}">*</asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row">
                <p class="title">
                    <asp:Label ID="Label2" runat="server" Text="NIF:"></asp:Label>
                </p>
                <div class="input">
                    <asp:TextBox ID="txtNifEmp" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqdtxtNifEmp" runat="server" ControlToValidate="txtNifEmp" ErrorMessage="El NIF del empleado es obligatorio" ForeColor="#CC3300">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regtxtNifEmp" runat="server" ControlToValidate="txtNifEmp" ErrorMessage="El formato de los datos a introducir debe ser:  8numeros-1letra" ForeColor="#CC3300" ValidationExpression="\d{8}-\w">*</asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row">
                <p class="title">
                    <asp:Label ID="Label3" runat="server" Text="Apellidos y Nombre:"></asp:Label>
                </p>
                <div class="input"> <asp:TextBox ID="txtNomEmp" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqdtxtNomEmp" runat="server" ControlToValidate="txtNomEmp" ErrorMessage="Los apellidos y Nombre del empleado son obligatorios" ForeColor="#CC3300">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <p class="title"><asp:Label ID="Label4" runat="server" Text="Dirección:"></asp:Label></p>
                <div class="input"><asp:TextBox ID="txtDirEmp" runat="server" ></asp:TextBox></div>
            </div>
            <div class="row">
                <p class="title"><asp:Label ID="Label5" runat="server" Text="Ciudad:"></asp:Label></p>
                <div class="input"><asp:TextBox ID="txtCiuEmp" runat="server" ></asp:TextBox></div>
            </div>
            <div class="row">
                <p class="title"><asp:Label ID="Label6" runat="server" Text="Teléfonos:"></asp:Label></p>
                <div class="input"><asp:TextBox ID="txtTelEmp" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rqdtxtTelEmp" runat="server" ControlToValidate="txtTelEmp" ErrorMessage="El Teléfono del empleado es obligatorio" ForeColor="#CC3300">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <div class="input"></div>
            </div>
                <div class="row">
                <p class="title"><asp:Label ID="Label9" runat="server" Text="Sexo:" ></asp:Label></p>
                <div class="input">
                    <asp:RadioButtonList ID="rblSexEmp" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True">Hombre</asp:ListItem>
                        <asp:ListItem>Mujer</asp:ListItem>
                    </asp:RadioButtonList></div>
            </div>
            <div class="row">
                <p class="title"><asp:Label ID="Label10" runat="server" Text="Departamento:" ></asp:Label></p>
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
                                    OnTextChanged="txtCal1_TextChanged" ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regTxtCal1" runat="server" ControlToValidate="TxtCal1" ErrorMessage="*" ForeColor="Green" ValidationExpression="^(?:\d{4}([-\/])\d{2}\1\d{2}|\d{2}([-\/])\d{2}\2\d{4})$
"></asp:RegularExpressionValidator>
                </p>
                <div class="input">
                    <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" SelectedDate="2000-01-01" VisibleDate="2000-01-01" Width="220px" >
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>
                    <asp:RequiredFieldValidator ID="rqdTxtCal1" runat="server" ControlToValidate="TxtCal1" ErrorMessage="La fecha de nacimiento del empleado es obligatoria." ForeColor="#CC3300">*</asp:RequiredFieldValidator>
                </div>

                <p class="title">
                    <asp:Label ID="Label12" runat="server" Text="Fecha de Ingreso: "></asp:Label>
                    <asp:TextBox ID="TxtCal2" runat="server" AutoPostBack="True" 
                                    OnTextChanged="txtCal2_TextChanged" ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regTxtCal2" runat="server" ControlToValidate="TxtCal2" ErrorMessage="*" ForeColor="Green" ValidationExpression="^(?:\d{4}([-\/])\d{2}\1\d{2}|\d{2}([-\/])\d{2}\2\d{4})$
"></asp:RegularExpressionValidator>
                </p>
                <div class="input">
                    <asp:Calendar ID="Calendar2" runat="server" 
                                    OnSelectionChanged="Calendar2_SelectionChanged" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px" >
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>
                    <asp:RequiredFieldValidator ID="rqdTxtCal2" runat="server" ControlToValidate="TxtCal2" ErrorMessage="La fecha de ingreso del empleado es obligatoria." ForeColor="#CC3300">*</asp:RequiredFieldValidator>
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
          <asp:CompareValidator ID="cmpTxtCal1" runat="server" ControlToCompare="TxtCal2" ControlToValidate="TxtCal1" ErrorMessage="La Fecha de Ingreso del Empleado debe ser mayor que la Fecha de Nacimiento" ForeColor="#CC3300" Operator="LessThan" Type="Date"></asp:CompareValidator>
    </p>
      <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List" ForeColor="Red" />
    <p>
        <asp:Label ID="lblValores" runat="server" BackColor="#66FFFF" Visible="False" Width="60%"></asp:Label>
    </p>

</asp:Content>
