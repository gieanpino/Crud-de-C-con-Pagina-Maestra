<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmAsociado.aspx.cs" Inherits="webAbogadosAsoc.Formulario_web12" %>
<asp:Content ID="Content4" ContentPlaceHolderID="Cuerpo" runat="server">
    <table align="center" class="auto-style3">
        <tr>
            <td class="auto-style4">Maestro de Asociados</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table align="center" class="auto-style17">
                    <tr>
                        <td class="auto-style16" style="width: 40%">Nro. Doc:</td>
                        <td class="auto-style9">
                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="auto-style15"></asp:TextBox>
                            <span class="auto-style15">&nbsp;&nbsp;
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagenes/Buscar.jpg" Height="20px" />
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style16">Tipo Doc:</td>
                        <td class="auto-style9">
                            <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="auto-style15">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style16">Nombre:</td>
                        <td class="auto-style9">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="auto-style15"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="auto-style12">
                        <td class="auto-style5">
                            <h4 class="auto-style18">Activo:</h4>
                        </td>
                        <td class="auto-style13">
                            <asp:CheckBox ID="chkActivo" runat="server" />
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
                    <asp:Menu ID="mnuOpciones" runat="server" BackColor="White" BorderColor="#0066FF" BorderStyle="Solid" BorderWidth="2px" CssClass="auto-style6" DynamicHorizontalOffset="2" OnMenuItemClick="Menu1_MenuItemClick" Orientation="Horizontal" Width="100%" RenderingMode="Table">
                        <Items>
                            <asp:MenuItem Text="Agregar" Value="opcAgregar"></asp:MenuItem>
                            <asp:MenuItem Text="Modificar" Value="opcModificar"></asp:MenuItem>
                            <asp:MenuItem Text="Buscar" Value="opcBuscar"></asp:MenuItem>
                            <asp:MenuItem Text="Grabar" Value="opcGrabar"></asp:MenuItem>
                            <asp:MenuItem Text="Cancelar" Value="opcCancelar"></asp:MenuItem>
                            <asp:MenuItem Text="Imprimir" Value="opcImprimir"></asp:MenuItem>
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
                <asp:GridView ID="grvDatos" runat="server" Width="98%" CssClass="auto-style15">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Imagenes/Buscar.jpg" ShowSelectButton="True">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:CommandField>
                    </Columns>
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
        .auto-style3 {
            width: 96%;
        }
        .auto-style4 {
            text-align: center;
            font-size: large;
            color: #0066FF;
        }
        .auto-style5 {
        text-align: center;
        color: #666666;
    }
        .auto-style6 {
            font-size: large;
            color: #00CC99;
        }
        .auto-style7 {
            text-align: center;
        }
        .auto-style8 {
            color: #FF0000;
            font-size: large;
        }
    .auto-style9 {
        text-align: left;
    }
    .auto-style12 {
        font-size: medium;
        color: #000000;
    }
    .auto-style13 {
        text-align: left;
        color: #666666;
    }
    .auto-style15 {
        font-size: medium;
        color: #666666;
    }
        .auto-style16 {
        text-align: right;
        font-size: medium;
        color: #666666;
    }
        .auto-style17 {
            width: 100%;
            font-size: medium;
        }
    .auto-style18 {
        font-weight: normal;
        text-align: right;
    }
    </style>
</asp:Content>

