using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace webAbogadosAsoc.Clases
{
    public class clsTipoDoc
    {
        #region "Atributos / Propiedades"
        private string strApp;
        public string Error { private set; get; }
        private string strSQL;
        #endregion
        #region "Constructor"
        public clsTipoDoc(string Aplicacion)
        {
            strApp = Aplicacion;
            strSQL = string.Empty;
            Error = string.Empty;
        }
        #endregion
        #region "Métodos Públicos"
        public bool llenarCombo(DropDownList Combo)
        {
            try
            {
                if (Combo == null)
                {
                    Error = "Error";
                    return false;
                }
                strSQL = "Exec USP_TipoDoc_BuscarGeneral;";
                clsGenerales objGles = new clsGenerales();
                if (!objGles.llenarCombo(strApp, Combo, strSQL, "Clave", "Dato"))
                {
                    Error = objGles.Error;
                    objGles = null;
                    return false;
                }
                objGles = null;
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        #endregion
    }
}