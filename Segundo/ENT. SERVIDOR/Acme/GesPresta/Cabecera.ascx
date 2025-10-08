<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Cabecera.ascx.cs" Inherits="GesPresta.Cabecera" %>



<nav style="display: flex; justify-content: center; align-items: center; gap: 15px; text-align: center;">
    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" PostBackUrl="~/Default.aspx">Inicio</asp:LinkButton>
    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" PostBackUrl="~/Empleados.aspx">Empleados</asp:LinkButton>
    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="false" PostBackUrl="~/Prestaciones2.aspx">Prestaciones</asp:LinkButton>
</nav>
<header style="text-align: center; margin: 0 auto;">
    <h1>
        ACME INNOVACIÓN, S. FIG.
    </h1>
    <h2>
        Gestión de Prestaciones Sociales
    </h2>
    <hr />
</header>


<hr />


