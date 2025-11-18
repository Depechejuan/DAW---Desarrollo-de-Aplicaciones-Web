<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdm.Master" AutoEventWireup="true" CodeBehind="ProductosMantener.aspx.cs" Inherits="GesTienda.ProductosMantener" %>
<%@ OutputCache Duration="1" VaryByParam="None" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InfoContenido" runat="server">
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="20px" Text="Mantenimiento productos"></asp:Label>
    <br />
    <br />
    <div class="sql" style="float: left; width: 50%;">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [PRODUCTO]"></asp:SqlDataSource>
        <asp:GridView ID="grdProductos" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IdProducto" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Width="90%" OnSelectedIndexChanged="grdProductos_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="IdProducto" HeaderText="IdProducto" ReadOnly="True" SortExpression="IdProducto" />
                <asp:BoundField DataField="DesPro" HeaderText="DesPro" SortExpression="DesPro" />
                <asp:BoundField DataField="PrePro" HeaderText="PrePro" SortExpression="PrePro" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <br />
    </div>
    <div class="menu" style="float: left; width: 25%; margin-right: 50px">
        <asp:Label ID="lblIdProducto" runat="server" Text="Id. Producto"></asp:Label>
    &nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtIdProducto" runat="server" Enabled="False"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblDesPro" runat="server" Text="Descripción"></asp:Label>
    &nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtDesPro" runat="server" Enabled="False"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblPrePro" runat="server" Text="Precio"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="txtPrePro" runat="server" Enabled="False">0</asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblIdUnidad" runat="server" Text="Unidad"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:DropDownList ID="ddlIdUnidad" runat="server" DataSourceID="SqlDataSource2" DataTextField="IdUnidad" Enabled="False">
    </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="lblIdTipo" runat="server" Text="Tipo Producto"></asp:Label>
    &nbsp;<asp:DropDownList ID="ddlIdTipo" runat="server" DataSourceID="SqlDataSource3" DataTextField="DesTip" DataValueField="IdTipo" Enabled="False">
    </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" OnClick="btnNuevo_Click" />
    &nbsp;<asp:Button ID="btnEditar" runat="server" Text="Editar" Visible="False" OnClick="btnEditar_Click" />
    &nbsp;<asp:Button ID="btnEliminar" runat="server" Text="Eliminar" Visible="False" OnClick="btnEliminar_Click" />
    &nbsp;<asp:Button ID="btnInsertar" runat="server" Text="Insertar" Visible="False" OnClick="btnInsertar_Click" />
    &nbsp;<asp:Button ID="btnModificar" runat="server" Text="Modificar" Visible="False" OnClick="btnModificar_Click" />
    &nbsp;<asp:Button ID="btnBorrar" runat="server" Text="Borrar" Visible="False" OnClick="btnBorrar_Click" />
    &nbsp;<asp:Button ID="btnCancelar" runat="server" Text="Cancelar" Visible="False" />

        </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <div class="errors" style="width: 100%;">
        <asp:Label ID="lblResultado" runat="server"></asp:Label>
        <asp:Label ID="lblMensajes" runat="server"></asp:Label>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [UNIDAD]"></asp:SqlDataSource>
    <br />
<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [TIPO]"></asp:SqlDataSource>
<br />
    <br />
    <br />
</asp:Content>
