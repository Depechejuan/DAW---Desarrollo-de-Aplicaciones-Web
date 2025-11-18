<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductosVer.aspx.cs" Inherits="GesTienda.ProductosVer" %>
<%@ OutputCache Duration="1" VaryByParam="None" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InfoContenido" runat="server">
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="20px" Text="Producttos"></asp:Label>
<br />
<asp:Label ID="lblResultado" runat="server"></asp:Label>
<asp:Label ID="lblMensajes" runat="server"></asp:Label>
</asp:Content>
