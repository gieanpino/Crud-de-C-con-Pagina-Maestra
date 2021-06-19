using System;

//Referenciar y usar
using System.Data;


//eferenciar y usar
using libParametros;

namespace libConexionBD
{
    public class clsConexionBD
    {
    #region "Atríbutos/Propiedades"
        private string strApp;         //Para el nombre de la aplicación
        private string strCadenaCnx;   //Para la cadena de conexón a la BD
        private bool   blnHayCnx;      //Para saber si hay o no Cnx a la BD

        public string SQL     { private get; set; }  //Para la sentencia SQL a ejecutarse en la BD
        public object vrUnico { get; private set; }  //Para la captura y retorno del Vr. único(método: ConsultarValorUnico)) 
        public string Error   { get; private set; }  //Para el mensaje de error

        //Objetos ADO.NET
        public SqlDataReader dataReader_Lleno { get; private set; }  //Para el objeto DataReader (contenedor de info)
        public DataSet       dataSet_Lleno { get; private set; }    //Para el objeto DataSet (contenedor de info)

        private SqlConnection  objCnx;     //Para el objeto Conexión
        private SqlCommand     objCmd;     //Para el objeto Command (realiza la transacción)
        private SqlDataAdapter objAdapter; //Para el objeto DataAdapter (para llenar el DataSet, entre otros)
        private SqlParameter   objParam;   //Para el objeto Parameter (contiene valores para el parámetro utilizado por el command)
    #endregion

    #region "Constructor"
        public clsConexionBD ( string NombreAplicacion )
        {
            strApp     = NombreAplicacion;
            blnHayCnx  = false;
            //Objetos ADO.NET
            objCnx     = new SqlConnection();  //Para la Conexión
            objCmd     = new SqlCommand();     //Para la Transacción
            objAdapter = new SqlDataAdapter(); //Para llenar el DataSet
            dataSet_Lleno = new DataSet();     //El DataSet
            objParam      = new SqlParameter();     //Para los parámetros del Command
        }
    #endregion

    #region "Métodos Privados"
        private bool generarCadenaCnx ( )
        {
            try
            {
                if ( string.IsNullOrEmpty ( strApp ) )
                {
                    Error = "Sin Datos de la aplicación";
                    return false;
                }
                clsParametros objParams = new clsParametros( );
                if ( ! objParams.generarCadenaCnx ( strApp ) )
                {
                    Error     = objParams.Error;
                    objParams = null;
                    return false;
                }
                strCadenaCnx = objParams.cadenaCnx;
                objParams    = null;
                return true;
            }
            catch ( Exception ex )
            {
                Error = ex.Message;
                return false;
            }
        }
        private bool abrirCnx ( )
        {
            if ( ! generarCadenaCnx ( ) )
                return false;
            objCnx.ConnectionString = strCadenaCnx;
            try
            {
                objCnx.Open ( );
                blnHayCnx = true;
                return true;
            }
            catch ( Exception ex )
            {
                Error     = ex.Message;
                blnHayCnx = false;
                return false;
            }
        }
    #endregion

    #region "Métodos Públicos"
        public void cerrarCnx ( )
        {
            try
            {
                objCnx.Close();
                objCnx    = null;
                blnHayCnx = false;
            }
            catch ( Exception ex )
            {
                Error = "Problemas en cierre o liberación de la conexión, " + ex.Message;
            }
        }
        public bool Consultar          ( bool blnTipoEjec   )
        {
            try
            {
                if ( string.IsNullOrEmpty ( SQL ) )
                {
                    Error = "No definió la instrucción SQL";
                    return false;
                }
                if ( ! blnHayCnx )
                    if ( ! abrirCnx( ) )
                        return false;
                //Preparar el Comando para ejecutar la transacción SQL en la BD
                objCmd.Connection  = objCnx;
                objCmd.CommandText = SQL;
                if ( blnTipoEjec )
                    objCmd.CommandType = CommandType.StoredProcedure;
                else
                    objCmd.CommandType = CommandType.Text;
                dataReader_Lleno       = objCmd.ExecuteReader();  //Realizar la transacción en la BD
                return true;
            }
            catch ( Exception ex )
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool consultarValorUnico( bool blnParametros )
        {
            try
            {
                if ( string.IsNullOrEmpty( SQL ) )
                {
                    Error = "No definió la instrucción SQL";
                    return false;
                }
                if ( ! blnHayCnx )
                    if ( ! abrirCnx( ) )
                        return false;
                //Preparar el Comando para ejecutar la transacción SQL en la BD
                objCmd.Connection  = objCnx;
                objCmd.CommandText = SQL;
                if ( blnParametros )
                    objCmd.CommandType = CommandType.StoredProcedure;
                else
                    objCmd.CommandType = CommandType.Text;
                vrUnico = objCmd.ExecuteScalar();  //Realizar la transacción en la BD
                return true;
            }
            catch ( Exception ex )
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool ejecutarSentencia  ( bool blnParametros )
        {
            try
            {
                if ( string.IsNullOrEmpty( SQL ) )
                {
                    Error = "No definió la instrucción SQL";
                    return false;
                }
                if ( ! blnHayCnx )
                    if ( ! abrirCnx( ) )
                        return false;
                //Preparar el Comando para ejecutar la transacción SQL en la BD
                objCmd.Connection  = objCnx;
                objCmd.CommandText = SQL;
                if ( blnParametros )
                    objCmd.CommandType = CommandType.StoredProcedure;
                else
                    objCmd.CommandType = CommandType.Text;
                objCmd.ExecuteNonQuery( );   //Realizar la transacción en la BD
                return true;
            }
            catch ( Exception ex )
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool llenarDataSet      ( bool blnParametros )
        {
            try
            {
                if ( string.IsNullOrEmpty( SQL ) )
                {
                    Error = "No definió la instrucción SQL";
                    return false;
                }
                if ( ! blnHayCnx )
                    if ( ! abrirCnx( ) )
                        return false;
                //Preparar el Comando para el DataAdapter
                objCmd.Connection  = objCnx;
                objCmd.CommandText = SQL;
                if ( blnParametros )
                    objCmd.CommandType = CommandType.StoredProcedure;
                else
                    objCmd.CommandType = CommandType.Text;
                //Preparar el DataAdapter para el uso del comando en la BD
                //El DataAdapter Utiliza el Command para la transacción
                objAdapter.SelectCommand = objCmd;
                //Realizar la transacción en la BD y el llenado del DataSet/Datatable
                objAdapter.Fill( dataSet_Lleno );
                return true;
            }
            catch ( Exception ex )
            {
                Error = ex.Message;
                return false;
            }
        }
        public bool agregarParametro   ( ParameterDirection Direccion, string Nombre, 
                                         SqlDbType TipoDato, Int16 Tamano, object Valor)
        {
            try
            {
                objParam.Direction     = Direccion; //Establecer si el parámetro es de Entrada, salida o bidireccional
                objParam.ParameterName = Nombre;    //Establecer el nombre del parámetro
                objParam.SqlDbType     = TipoDato;  //Establecer el tipo de dato del parámetro
                objParam.Size          = Tamano;    //Establecer el tamaño del parámetro
                objParam.Value         = Valor;     //Establecer el valor del parámetro

                objCmd.Parameters.Add( objParam ); //Adicionar el parámetro al command
                objParam = new SqlParameter();     //Crear un nuevo parámetro
                return true;
            }
            catch ( Exception ex )
            {
                Error = "Error en ingreso de dato, " + ex.Message;
                return false;
            }
        }
    #endregion
    }
}
