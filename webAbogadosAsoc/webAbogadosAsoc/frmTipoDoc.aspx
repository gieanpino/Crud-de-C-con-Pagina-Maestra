<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmTipoDoc.aspx.cs" Inherits="webAbogadosAsoc.Formulario_web15" %>
<asp:Content ID="Content4" ContentPlaceHolderID="Cuerpo" runat="server">
    <table align="center" class="auto-style3">
        <tr>
            <td class="auto-style4"><strong>Maestro de Tipo de Documento</strong></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table align="center" class="auto-style2">
                    <tr>
                        <td class="auto-style10" style="width: 40%">Codigo:</td>
                        <td>
                            <asp:TextBox ID="txtCodigo" runat="server" Width="77px"></asp:TextBox>
                            <span class="auto-style9">&nbsp;&nbsp;
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagenes/Buscar.jpg" />
                            </span></td>
                    </tr>
                    <tr>
                        <td class="auto-style10">Descripción:</td>
                        <td>
                            <asp:TextBox ID="txtCodigo0" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server">
                    <strong>
                    <asp:Menu ID="Menu1" runat="server" BackColor="White" BorderColor="#0066FF" BorderStyle="Solid" BorderWidth="2px" CssClass="auto-style6" DynamicHorizontalOffset="2" OnMenuItemClick="Menu1_MenuItemClick" Orientation="Horizontal" Width="100%">
                        <Items>
                            <asp:MenuItem Text="Agregar" Value="opcAgregar"></asp:MenuItem>
                            <asp:MenuItem Text="Modificar" Value="opcModificar"></asp:MenuItem>
                            <asp:MenuItem Text="Buscar" Value="opcBuscar"></asp:MenuItem>
                            <asp:MenuItem Text="Grabar" Value="opcGrabar"></asp:MenuItem>
                            <asp:MenuItem Text="Cancelar" Value="opcCancelar"></asp:MenuItem>
                        </Items>
                        <StaticHoverStyle BackColor="#009999" BorderColor="#0066FF" />
                    </asp:Menu>
                    </strong>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:GridView ID="grvDatos" runat="server" CssClass="auto-style9">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="auto-style7">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7"><strong>
                <asp:Label ID="lblMsj" runat="server" CssClass="auto-style8"></asp:Label>
                </strong></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style10 {
            text-align: right;
            color: #000000;
        }
        .auto-style9 {
            color: #000000;
        }
        .auto-style6 {
            font-size: small;
            color: #00CC99;
        }
        .auto-style7 {
            text-align: center;
        }
        .auto-style8 {
            color: #FF0000;
            font-size: large;
        }
    </style>
</asp:Content>

