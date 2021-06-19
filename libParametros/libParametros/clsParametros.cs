using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//Referenciar y usar
using System.Xml;
using System.Windows.Forms;

namespace libParametros
{
    public class clsParametros
    {
    #region "Atributos/Propiedades"
        private string strServidor;
        private string strBaseDatos;
        private string strUsuario;
        private string strClave;
        private string strSegInt;
        private string strPathXml;

        //Propiedad de solo salida
        public string cadenaCnx 
        { 
            get; private set; 
        }
        //Propiedad de solo salida
        public string Error     
        { 
            get; private set; 
        }
        //Objetos para manipular archivo XML
        private XmlDocument objDoc = new XmlDocument();
        private XmlNode objNodo;
    #endregion

    #region "Constructor"
        public clsParametros()
        {
            strServidor  = string.Empty;
            strBaseDatos = string.Empty;
            strUsuario   = string.Empty;
            strClave     = string.Empty;
            strSegInt    = string.Empty;
            strPathXml   = string.Empty;
            cadenaCnx    = string.Empty;  //Propiedad
            Error        = string.Empty;  //Propiedad
        }
    #endregion

    #region "Métodos Públicos"
        public bool generarCadenaCnx( string strNombreSitio )
        {
            try
            {
                if (string.IsNullOrEmpty(strNombreSitio))
                {
                    Error = "Sin dato, consultar admon.";
                    return false;
                }
                strPathXml = Application.StartupPath + "\\CON_" + strNombreSitio + ".xml";
                objDoc.Load( strPathXml );
                objNodo = objDoc.SelectSingleNode( "//Servidor" );
                strServidor = objNodo.InnerText;   //Recupera el nombre del servidor del archivo xml
                objNodo = objDoc.SelectSingleNode( "//BaseDatos" );
                strBaseDatos = objNodo.InnerText;    //Recupera el nombre de la BD del archivo xml
                objNodo = objDoc.SelectSingleNode( "//Usuario" );
                strUsuario = objNodo.InnerText;    //Recupera el nombre del usuario del archivo xml
                objNodo = objDoc.SelectSingleNode( "//Clave" );
                strClave = objNodo.InnerText;    //Recupera la clave del usuario del archivo xml
                objNodo = objDoc.SelectSingleNode( "//SeguridadIntegrada" );
                strSegInt = objNodo.InnerText.ToLower().Trim();

                if ( strSegInt.Equals("no") ) //Autenticación SQL SERVER   
                    cadenaCnx = "Data Source = " + strServidor + "; " +
                                "Initial Catalog = " + strBaseDatos + "; " +
                                "User Id = " + strUsuario + "; " +
                                "Password = " + strClave + ";";
                else if ( strSegInt.Equals("si") )   //Autenticación  Windows
                    cadenaCnx = "Data Source = " + strServidor + "; " +
                                "Initial Catalog = " + strBaseDatos + "; " +
                                "Integrated Security = SSPI;";
                else
                {
                    Error = "Proyecto no válido";
                    objDoc = null;
                    return false;
                }
                objDoc = null;
                return true;
            }
            catch ( Exception ex )
            {
                Error = ex.Message;
                objDoc = null;
                return false;
            }
        }
    #endregion
    }
}
