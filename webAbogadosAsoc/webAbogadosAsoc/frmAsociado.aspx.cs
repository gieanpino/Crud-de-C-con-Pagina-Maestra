using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webAbogadosAsoc
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        #region "Variables Globales"
        private static string strApp;
        private static int intOpcion; //1: Agregar 2: Modificar 0: otra opción
        private bool blnActivo;
        private string strNroDoc, strTipoDoc, strNombre;
        #endregion

        #region Metodos Personalizados
        private void Mensaje( string Texto)
        {
            this.lblMsj.Text = Texto.Trim();
        }
        private void llenarComboTipoDoc()
        {
            try
            {
                Clases.clsTipoDoc objXX = new Clases.clsTipoDoc(strApp);
                if (!objXX.llenarCombo(this.ddlTipoDoc))
                {
                    Mensaje(objXX.Error);
                    return;
                }
            }
            catch (Exception ex)
            { Mensaje(ex.Message); }
        }
        private void llenarGridAsoc()
        {
            try
            {
                Clases.clsAsociado objXX = new Clases.clsAsociado(strApp);
                if (!objXX.llenarGrid(this.grvDatos))
                {
                    Mensaje(objXX.Error);
                    objXX = null;
                    return;
                }
            }
            catch (Exception ex)
            {
                Mensaje(ex.Message);
            }
        }
        private void Limpiar()
        {
            Mensaje(string.Empty);
            this.txtCodigo.Text = string.Empty;
            this.ddlTipoDoc.SelectedIndex = 0;
            this.txtNombre.Text = string.Empty;
            this.chkActivo.Checked = true;
        }
        private void Buscar()
        {
            Clases.clsAsociado objXX = new Clases.clsAsociado(strApp);
            if (!objXX.Buscar(strNroDoc))
            {
                Limpiar();
                Mensaje(objXX.Error);
                objXX = null;
                return;
            }
            this.txtCodigo.Text = objXX.nroDoc;
            this.ddlTipoDoc.SelectedValue = objXX.tipoDoc;
            this.txtNombre.Text = objXX.Nombre;
            this.chkActivo.Checked = objXX.Activo;
            objXX = null;
        }
        private void Grabar()
    {
        try
        {
            if (intOpcion != 1 && intOpcion != 2)
            {
                Mensaje("Opción no válida");
                return;
            }
            strNroDoc = this.txtCodigo.Text.Trim().ToUpper();
            strTipoDoc = this.ddlTipoDoc.SelectedValue;
            strNombre = this.txtNombre.Text.Trim();
            blnActivo = this.chkActivo.Checked;
            Clases.clsAsociado objXX = new Clases.clsAsociado(strApp, strNroDoc, strTipoDoc,
            strNombre, blnActivo);
            if (intOpcion == 1)
            {
                if (!objXX.grabarMaestro())
                {
                    Mensaje(objXX.Error);
                    objXX = null;
                    return;
                }
            }
            else //intOpcion == 2
            if (!objXX.modificarMaestro())
            {
                Mensaje(objXX.Error);
                objXX = null;
                return;
            }
            strNroDoc = objXX.nroDoc;
            objXX = null;
            if (strNroDoc == "-1")
            {
                Mensaje("Ya existe un registro con dichos valores");
                return;
            }
            else if (strNroDoc == "0")
            {
                Mensaje("Error al procesar registro, Consultar con el Admón del sistema");
                return;
            }
            Mensaje("Rgtro. Grabado con éxito");
            llenarGridAsoc();
        }
        catch (Exception ex)
        { Mensaje(ex.Message); }
    }

    #endregion
    protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                strApp = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;
                intOpcion = 0;
                llenarComboTipoDoc();
                this.ddlTipoDoc.SelectedIndex = 0;
                llenarGridAsoc();
            }


        }

        protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
        {

        }

        protected void grvDatos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}