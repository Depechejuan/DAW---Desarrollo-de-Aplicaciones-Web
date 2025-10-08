<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MPPrestaciones.aspx.cs" Inherits="GesPresta.MPPrestaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

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


<form id="form1" runat="server" class="prestaciones">

<%--        <h2>DATOS DE LAS PRESTACIONES</h2>
        <div class="forms">
            <div class="row">
                <p class="title">
                    <asp:Label ID="Label1" runat="server" Text="Código Prestación: "></asp:Label>
                </p>
                <div class="input">
                    <asp:TextBox ID="txtCodPre" runat="server" Width="300px"></asp:TextBox>
    <asp:Button ID="btnVerPrestaciones" runat="server" Text="Ver Prestaciones" CausesValidation="False"
OnClick="btnVerPrestaciones_Click" />

                    <asp:RequiredFieldValidator ID="rqdtxtCodPre" runat="server" ControlToValidate="txtCodPre" ErrorMessage="El Código
Empleado es obligatorio" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regtxtCodPre" runat="server" ControlToValidate="txtCodPre" ErrorMessage="El formato debe ser: 000-000-000" ForeColor="Green" ValidationExpression="\d{3}-\d{3}-\d{3}"></asp:RegularExpressionValidator>
                </div>
                <div style="margin: 0 40px">
                    <uc2:prestacionesBuscar ID="prestacionesBuscar1" runat="server" Visible="False"/>
                </div>
                <br />
                <div style="margin: 0 40px">
                    <asp:Button ID="btnSeleccionar" runat="server" CausesValidation="False" Text="Seleccionar" Visible="False" OnClick="btnSeleccionar_Click" />
                </div>
                <p>&nbsp;</p>
            </div>
            <div class="row">
                <p class="title">
                    <asp:Label ID="Label2" runat="server" Text="Descripción: "></asp:Label>
                </p>
                <div class="input">
                    <asp:TextBox ID="txtDesPre" runat="server" Width="300px"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <p class="title">
                    <asp:Label ID="Label3" runat="server" Text="Importe Fijo: "></asp:Label>
                </p>
                <div class="input">
                    <asp:TextBox ID="txtImpPre" runat="server" Width="300px"></asp:TextBox>
                    <asp:RangeValidator ID="rngtxtImpPre" runat="server" BorderStyle="None" ControlToValidate="txtImpPre" ErrorMessage="El importe debe estar entre 0 y 500" ForeColor="#CC3300" MaximumValue="500,00" MinimumValue="0"></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="rqdtxtImpPre" runat="server" ControlToValidate="txtImpPre" ErrorMessage="El importe fijo es obligatoria" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row">
                <p class="title">
                    <asp:Label ID="Label4" runat="server" Text="Porcentaje del Importe: "></asp:Label>
                </p>
                <div class="input">
                    <asp:TextBox ID="txtPorPre" runat="server" Width="300px"></asp:TextBox>
                    <asp:RangeValidator ID="rngtxtPorPre" runat="server" ControlToValidate="txtPorPre" ErrorMessage="El porcentaje debe estar entre 0 y 15" ForeColor="#CC3300" MaximumValue="15,00" MinimumValue="0,00"></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="rqdtxtPorPre" runat="server" ControlToValidate="txtPorPre" ErrorMessage="El porcentaje del informe es obligatorio" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row">
                <p class="title">
                    <asp:Label ID="Label5" runat="server" Text="Tipo de Prestación:"></asp:Label>
                </p>
                <div class="input">
                    <asp:DropDownList ID="ddlTipPre" runat="server" Width="216px">
                    <asp:ListItem>Dentaria</asp:ListItem>
                    <asp:ListItem>Familiar</asp:ListItem>
                    <asp:ListItem Selected="True">Ocular</asp:ListItem>
                    <asp:ListItem>Otras</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <asp:Button ID="cmdEnviar" runat="server" Text="Enviar" PostBackUrl="~/Prestaciones1Respuesta.aspx" OnClick="Page_Load" Width="132px" />

        </div>
    <br />

    <br />
    <br />--%>
        
</form>