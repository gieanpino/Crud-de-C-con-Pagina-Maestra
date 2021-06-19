<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmCliente.aspx.cs" Inherits="webAbogadosAsoc.Formulario_web11" %>
<asp:Content ID="Content4" ContentPlaceHolderID="Cuerpo" runat="server">
    <table align="center" class="auto-style3">
        <tr>
            <td class="auto-style4">Maestro de Clientes</td>
        </tr>
        <tr>
            <td class="auto-style11"></td>
        </tr>
        <tr>
            <td>
                <table align="center" class="auto-style2">
                    <tr>
                        <td class="auto-style10" style="width: 40%">Nro. Doc:</td>
                        <td class="auto-style15">
                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="auto-style12"></asp:TextBox>
                            <span class="auto-style13">&nbsp;&nbsp;
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagenes/Buscar.jpg" />
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">Tipo Doc:</td>
                        <td class="auto-style15">
                            <asp:DropDownList ID="ddlTipoDoc" runat="server" CssClass="auto-style12">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">Nombre:</td>
                        <td class="auto-style15">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="auto-style12"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="auto-style9">
                        <td class="auto-style10">
                            <h3 class="auto-style14">Activo:</h3>
                        </td>
                        <td class="auto-style15">
                            <asp:CheckBox ID="chkActivo" runat="server" CssClass="auto-style12" />
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
        .auto-style3 {
            width: 96%;
        }
        .auto-style4 {
            text-align: center;
            font-size: large;
            color: #0066FF;
        }
        .auto-style7 {
            text-align: center;
        }
        .auto-style8 {
            color: #FF0000;
            font-size: large;
        }
        .auto-style9 {
            color: #000000;
        }
        .auto-style10 {
            text-align: right;
            color: #000000;
            font-size: medium;
        }
        .auto-style11 {
            height: 35px;
        }
        .auto-style12 {
            font-size: medium;
        }
        .auto-style13 {
            color: #000000;
            font-size: medium;
        }
    .auto-style14 {
        font-size: medium;
        font-weight: normal;
    }
    .auto-style15 {
        text-align: left;
    }
        .auto-style6 {
            font-size: large;
            color: #00CC99;
        }
        </style>
</asp:Content>

