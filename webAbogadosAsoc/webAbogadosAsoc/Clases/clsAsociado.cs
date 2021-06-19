using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using libConexionBD;

namespace webAbogadosAsoc.Clases
{
    public class clsAsociado
    {
        #region "Atributos/Propiedades"
        private string strApp;
        private string strSQL;
        public string nroDoc { get; set; }
        public string tipoDoc { get; set; }
        public string Nombre { get; set; }
        public bool Activo { get; set; }
        public string Error { get; private set; }
        private SqlDataReader myReader;
        #endregion
        #region "Constructor"
        public clsAsociado(string Aplicacion)
        {
            strApp = Aplicacion;
            nroDoc = string.Empty;
            tipoDoc = string.Empty;
            Nombre = string.Empty;
            Activo = true;
            strSQL = string.Empty;
            Error = string.Empty;
        }
        public clsAsociado(string Aplicacion, string nroDocu, string tipoDocu,
        string Nombres, bool Activado)
        {
            strApp = Aplicacion;
            nroDoc = nroDocu;
            tipoDoc = tipoDocu;
            Nombre = Nombres;
            Activo = Activado;
            strSQL = string.Empty;
            Error = string.Empty;
        }
        #endregion
        #region "Métodos Privados"
        private bool validarDatos()
        {
            if (string.IsNullOrEmpty(nroDoc))
            {
                Error = "Falta el Nro. del documento";
                return false;
            }
            if (string.IsNullOrEmpty(tipoDoc))
            {
                Error = "Falta el tipo del documento";
                return false;
            }
            if (string.IsNullOrEmpty(Nombre))
            {
                Error = "Falta el nombre del asociado";
                return false;
            }
            return true;
        }
        private bool Grabar()
        {
            try
            {
                if (string.IsNullOrEmpty(strApp))
                {
                    Error = "Falta el nombre de la aplicación";
                    return false;
                }
                clsConexionBD objCnx = new clsConexionBD(strApp);
                objCnx.SQL = strSQL;
                if (!objCnx.consultarValorUnico(false))
                {
                    Error = objCnx.Error;
                    objCnx.cerrarCnx();
                    objCnx = null;
                    return false;
                }
                nroDoc = objCnx.vrUnico.ToString();
                objCnx.cerrarCnx();
                objCnx = null;
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        #endregion
        #region "Métodos Públicos"
        public bool Buscar(string nroDocumento)
        {
            try
            {
                strSQL = "EXEC USP_Asoc_BuscarXcodigo '" + nroDocumento + "';";
                clsConexionBD objCnx = new clsConexionBD(strApp);
                objCnx.SQL = strSQL;
                if (!objCnx.Consultar(false))
                {
                    Error = objCnx.Error;
                    objCnx.cerrarCnx();
                    objCnx = null;
                    return false;
                }
                myReader = objCnx.dataReader_Lleno;
                if (!myReader.HasRows)
                {
                    Error = "No existe registro con Nro. de documento: " + nroDocumento;
                    objCnx.cerrarCnx();
                    objCnx = null;
                    return false;
                }
                myReader.Read();
                nroDoc = myReader.GetString(0);
                tipoDoc = myReader.GetString(1);
                Nombre = myReader.GetString(2);
                Activo = myReader.GetBoolean(3);
                myReader.Close();
                return true;
            }
            catch (Exception ex)
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool grabarMaestro()
        {
            if (!validarDatos())
                return false;
            int intAct = Activo ? 1 : 0;
            strSQL = "EXEC USP_Asoc_Grabar '" + nroDoc + "', '" + tipoDoc + "', " +
            "'" + Nombre + "', " + intAct + ";";
            return Grabar();
        }
        public bool modificarMaestro()
        {
            if (!validarDatos())
                return false;
            int intAct = Activo ? 1 : 0;
            strSQL = "EXEC USP_Asoc_Modificar '" + nroDoc + "', " + "'" + tipoDoc + "', " +
            "'" + Nombre + "', " + intAct + ";";
            return Grabar();
        }
        public bool llenarCombo(DropDownList Cmb)
        {
            strSQL = "EXEC USP_Asoc_LlenarCombo;";
            clsGenerales objGles = new clsGenerales();
            if (!objGles.llenarCombo(strApp, Cmb, strSQL, "Clave", "Dato"))
            {
                Error = objGles.Error;
                objGles = null;
                return false;
            }
            objGles = null;
            return true;
        }
        public bool llenarGrid(GridView Grid)
        {
            strSQL = "EXEC USP_Asoc_BuscarGeneral;";
            clsGenerales objGles = new clsGenerales();
            if (!objGles.llenarGrid(strApp, Grid, strSQL))
            {
                Error = objGles.Error;
                objGles = null;
                return false;
            }
            objGles = null;
            return true;
        }
        #endregion
    }


}