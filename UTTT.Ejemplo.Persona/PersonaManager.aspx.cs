#region Using

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using System.Windows.Forms;
using EASendMail;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;

#endregion

namespace UTTT.Ejemplo.Persona
{
    public partial class PersonaManager : System.Web.UI.Page
    {
        #region Variables

        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Persona baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        private int tipoAccion = 0;

        #endregion

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["strNombre"] == null)
            {
                Response.Redirect("Login.aspx");

                lblUserDetails.Text = "strNombre : " + Session["strNombre"];
            }
            try
            {
              

                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Persona();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Persona>().First(c => c.id == this.idPersona);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    this.btnLogout.Visible = false;
                    List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().ToList();
                    CatSexo catTemp = new CatSexo();
                    catTemp.id = -1;
                    catTemp.strValor = "Seleccionar";
                    lista.Insert(0, catTemp);
                    this.ddlSexo.DataTextField = "strValor";
                    this.ddlSexo.DataValueField = "id";
                    this.ddlSexo.DataSource = lista;
                    this.ddlSexo.DataBind();

                    //Cat estado civil
                    List<CatEstadoCivil> listaEstadoCivil = dcGlobal.GetTable<CatEstadoCivil>().ToList();
                    CatEstadoCivil catEstadoCivilTemp = new CatEstadoCivil();
                    catEstadoCivilTemp.id = -1;
                    catEstadoCivilTemp.strValor = "Seleccionar";
                    listaEstadoCivil.Insert(0, catEstadoCivilTemp);
                    this.ddlEstadoCivil.DataTextField = "strValor";
                    this.ddlEstadoCivil.DataValueField = "id";
                    this.ddlEstadoCivil.DataSource = listaEstadoCivil;
                    this.ddlEstadoCivil.DataBind();
                    //cat Sexo

                    this.ddlSexo.SelectedIndexChanged += new EventHandler(ddlSexo_SelectedIndexChanged);
                    this.ddlSexo.AutoPostBack = true;
                    //Cat estado civil
                    this.ddlEstadoCivil.SelectedIndexChanged += new EventHandler(ddlEstadoCivil_SelectedIndexChanged);
                    this.ddlEstadoCivil.AutoPostBack = true;

                    


                    if (this.idPersona == 0)
                    {

                     

                        this.lblAccion.Text = "Agregar";
                        DateTime tiempo = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                         //TextBox1.Text = tiempo.Date.ToString("dd/MM/yyyy");
                        this.TextBox1.Text = Convert.ToString(tiempo.ToShortDateString());
                        this.CalendarExtender.SelectedDate = tiempo;
                       
                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        
                        this.txtNombre.Text = this.baseEntity.strNombre;
                        this.txtAPaterno.Text = this.baseEntity.strAPaterno;
                        this.txtAMaterno.Text = this.baseEntity.strAMaterno;
                        this.txtClaveUnica.Text = this.baseEntity.strClaveUnica;
                       
                        DateTime fechaNacimiento = (DateTime)this.baseEntity.dteFechaNacimiento;
                       
                        if (fechaNacimiento != null)

                        {
                            
                            //this.TextBox1.Text = Convert.ToString((DateTime)fechaNacimiento);
                            //this.CalendarExtender.SelectedDate = (DateTime)fechaNacimiento;
                            TextBox1.Text = fechaNacimiento.Date.ToString("dd/MM/yyyy");
                        }
                        this.txtCorreoElectronico.Text = this.baseEntity.strCorreoElectronico;
                        this.txtCodigoPostal.Text = this.baseEntity.intCodigoPostal.ToString();
                        this.txtRfc.Text = this.baseEntity.strRfc;
                        //Cat estado civil
                        this.ddlEstadoCivil.DataSource = listaEstadoCivil;
                        this.ddlEstadoCivil.DataBind();

                        this.setItem(ref this.ddlEstadoCivil, baseEntity.CatEstadoCivil.strValor);

                        this.setItemEditar(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                        this.setItemEditar(ref this.ddlEstadoCivil, baseEntity.CatEstadoCivil.strValor);
                    }                
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {


                this.lblFecha.Visible = false;

                //DateTime fechaNacimiento1 = this.dteCalendar.SelectedDate.Date;
                //DateTime fechaHoy = DateTime.Today;
                //int edad = fechaHoy.Year - fechaNacimiento1.Year;
                DateTime fecha = Convert.ToDateTime(TextBox1.Text);
                DateTime fechaHoy = DateTime.Today;
                int edad = fechaHoy.Year - fecha.Year;
                if (fechaHoy < fecha.AddYears(edad)) edad--;

                if (edad < 18)
                {
                    this.showMessage("Eres menor de edad no puedes registrarte");
                    
                    this.lblFecha.Visible = true;
                    this.lblFecha.Text = "*Debido a tu fecha de nacimiento eres menor de edad y no puedes registrarte";


                }
                else
                {
                    this.lblFecha.Visible = false;
                    if (!Page.IsValid)
                    {
                        return;
                    }
                    DataContext dcGuardar = new DcGeneralDataContext();
                    UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                    if (this.idPersona == 0)
                    {
                        this.lblFecha.Visible = false;

                        persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                        persona.strNombre = this.txtNombre.Text.Trim();
                        persona.strAMaterno = this.txtAMaterno.Text.Trim();
                        persona.strAPaterno = this.txtAPaterno.Text.Trim();


                        // Bind the data to the control.


                        // Set the default selected item, if desired.
                        //ddlSexo.SelectedIndex = idPersona;
                        //persona.idCatSexo = int.Parse(this.ddlSexo.ID.ToLower());

                        //persona.idCatSexo = int.Parse(this.ddlSexo.Items.Count.ToString());
                        persona.idCatEstadoCivil = int.Parse(this.ddlEstadoCivil.Text);
                        
                        persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                        DateTime fechaNacimiento = Convert.ToDateTime(TextBox1.Text);
                        persona.dteFechaNacimiento = fechaNacimiento;

                        persona.strCorreoElectronico = this.txtCorreoElectronico.Text.Trim();
                        persona.intCodigoPostal = int.Parse(this.txtCodigoPostal.Text);
                        persona.strRfc = this.txtRfc.Text.Trim();


                        String mensaje = String.Empty;
                        if (!this.validacion(persona, ref mensaje))

                        {
                            this.lblMensaje.Text = mensaje;
                            this.lblMensaje.Visible = true;
                            return;
                        }
                        if (!this.validaSql(ref mensaje))

                        {
                            this.lblMensaje.Text = mensaje;
                            this.lblMensaje.Visible = true;
                            return;
                        }
                        if (!this.validaHtml(ref mensaje))

                        {
                            this.lblMensaje.Text = mensaje;
                            this.lblMensaje.Visible = true;
                            return;
                        }
                        this.lblFecha.Visible = false;

                        dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                        dcGuardar.SubmitChanges();
                        this.showMessage("El registro se agrego correctamente.");
                        this.Response.Redirect("~/PersonaPrincipal.aspx", false);

                    }
                    if (this.idPersona > 0)
                    {
                      
                        persona = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().First(c => c.id == idPersona);
                        persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                        persona.strNombre = this.txtNombre.Text.Trim();
                        persona.strAMaterno = this.txtAMaterno.Text.Trim();
                        persona.strAPaterno = this.txtAPaterno.Text.Trim();
                        persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                        persona.idCatEstadoCivil = int.Parse(this.ddlEstadoCivil.Text);
                        DateTime fechaNacimiento = Convert.ToDateTime(TextBox1.Text);
                        persona.dteFechaNacimiento = fechaNacimiento;
                        persona.strCorreoElectronico = this.txtCorreoElectronico.Text.Trim();
                        persona.intCodigoPostal = int.Parse(this.txtCodigoPostal.Text);
                        persona.strRfc = this.txtRfc.Text.Trim();
                        dcGuardar.SubmitChanges();
                        this.showMessage("El registro se edito correctamente.");
                        this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                    }

                }
            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);

                var mensaje = "Error message: " + _e.Message;

                if (_e.InnerException != null)
                {
                    mensaje = mensaje + " Inner exception: " + _e.InnerException.Message;
                }

                mensaje = mensaje + " Stack trace: " + _e.StackTrace;
                this.Response.Redirect("~/ErrorPage.aspx", false);


                this.EnviarCorreo("alan.ferrer3212@gmail.com", "Error inesperado", mensaje);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {              
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                int idSexo = int.Parse(this.ddlSexo.Text);
                Expression<Func<CatSexo, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();
                this.ddlSexo.DataTextField = "strValor";
                this.ddlSexo.DataValueField = "id"; 
                this.ddlSexo.DataSource = lista;
                this.ddlSexo.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }

            //DataTable dt = new DataTable();
            //List<CatSexo> objCat = new List<CatSexo>();
            //using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
            //{
            //    using (SqlCommand cmd = new SqlCommand("SELECT id,strValor FROM CatSexo", con))
            //    {
            //        con.Open();
            //        SqlDataAdapter da = new SqlDataAdapter(cmd);
            //        da.Fill(dt);
            //        if (dt.Rows.Count > 0)
            //        {
            //            for (int i = 0; i < dt.Rows.Count; i++)
            //            {
            //                objCat.Add(new CatSexo
            //                {
            //                    CatId = dt.Rows[i]["id"].ToString(),
            //                    CatValor = dt.Rows[i]["strValor"].ToString()
            //                });
            //            }
            //        }
            //        //return objCat;
            //    }
            //}
        }

        #endregion


        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }
        public void setItemEditar(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value!= _value)
                {
                    item.Enabled = false;

                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }




        #region Metodos
        /// <summary>
        /// 
        /// </summary>
        /// <param name="_persona"></param>
        /// <param name="_mensaje"></param>
        /// <returns></returns>
        /// 
        public bool validacion(UTTT.Ejemplo.Linq.Data.Entity.Persona _persona, ref String _mensaje)
        {
            
            if (_persona.idCatSexo == -1)
            {
                _mensaje = "Seleccione una categoria Masculino o Femenino";
                return false;
            }
    
            int i = 0;
            if (int.TryParse(_persona.strClaveUnica, out i) == false)
            {
                _mensaje = "La clave unica no acepta letras solo numeros";
                return false;
            }
      
            if (int.Parse(_persona.strClaveUnica) < 1 || int.Parse(_persona.strClaveUnica) > 1000)
            {
                _mensaje = "No esta dentro del rango  del 1 al 1000";
                return false;
            }

            string nombre = _persona.strNombre.Trim();
            if (nombre.Length < 3)
            {
                _mensaje = "Debe de tener mas de 3 caracteres verifique porfavor";
                return false;
            }

            if (_persona.strNombre.Equals(String.Empty))
            {
                _mensaje = "El campo Nombre esta vacio verifique porfavor";
                return false;
            }
            if (_persona.strNombre.Length > 50)
            {
                _mensaje = "Rebasa el numero de caracteres en el campo de nombre";
                return false;
            }

            string APaterno = _persona.strAPaterno.Trim();
            if (APaterno.Length < 3)
            {
                _mensaje = "Debe de tener mas de 3 caracteres en el campo";
                return false;
            }

            if (_persona.strAPaterno.Equals(String.Empty))
            {
                _mensaje = "El campo APaterno esta vacio verifique porvafor";
                return false;
            }
            if (_persona.strAPaterno.Length > 50)
            {
                _mensaje = "Rebasa el numero de caracteres en el campo de Apaterno";
                return false;
            }

            string AMaterno = _persona.strAMaterno.Trim();
            if (AMaterno.Length < 3)
            {
                _mensaje = "Debe de tener mas de 3 caracteres en el campo";
                return false;
            }
            if (_persona.strAMaterno.Equals(String.Empty))
            {
                _mensaje = "El campo AMaterno esta vacio verifique porfavor";
                return false;
            }
            if (_persona.strAMaterno.Length > 50)
            {
                _mensaje = "Rebasa el numero de caracteres en el campo de AMaterno";
                return false;
            }
        
            if (_persona.strCorreoElectronico.Equals(String.Empty))
            {
                _mensaje = "El campo Correo electronico esta vacio verifique porfavor";
                return false;
            }
            if (_persona.strCorreoElectronico.Length > 50)
            {
                _mensaje = "Rebasa el numero de caracteres de correo electronico verifique porfavor";
                return false;
            }  
            int j = 0;
            if (int.TryParse(_persona.intCodigoPostal.ToString(), out j) == false)
            {
                _mensaje = "El codigo postal no acepta letras solo numeros verifique porfavor";
                return false;
            }
            if (_persona.intCodigoPostal.Equals(String.Empty))
            {
                _mensaje = "El campo Codigo postal esta vacio verifique porfavor";
                return false;
            }
            //if (_persona.intCodigoPostal.Length > 50)
            //{
            //    _mensaje = "Rebasa el numero de caracteres en el campo de codigo postal";
            //    return false;
            //}

            if (_persona.strRfc.Equals(String.Empty))
            {
                _mensaje = "El campo Rfc esta vacio verifique porfavor";
                return false;
            }
            if (_persona.strRfc.Length > 50)
            {
                _mensaje = "Rebasa el numero de caracteres en el campo de rfc";
                return false;
            }
           


            return true;
        }

        private bool validaSql(ref String _mensaje)
        {
            CtrValidaInyeccion valida = new CtrValidaInyeccion();
            string mensajeFuncion = string.Empty;


            if (valida.SqlInyectionValida(this.txtNombre.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtAPaterno.Text.Trim(), ref mensajeFuncion, "APaterno", ref this.txtAPaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtAMaterno.Text.Trim(), ref mensajeFuncion, "AMaterno", ref this.txtAMaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtCorreoElectronico.Text.Trim(), ref mensajeFuncion, "Correo electronico", ref this.txtCorreoElectronico))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtCodigoPostal.Text.Trim(), ref mensajeFuncion, "Codigo postal", ref this.txtCodigoPostal))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtRfc.Text.Trim(), ref mensajeFuncion, "Rfc", ref this.txtRfc))
            {
                _mensaje = mensajeFuncion;
                return false;
            }

            return true;
        }

        private bool validaHtml(ref String _mensaje)
           
        {
            CtrValidaInyeccion valida = new CtrValidaInyeccion();
            string mensajeFuncion = string.Empty;
            if(valida.htmlInyectionValida(this.txtClaveUnica.Text.Trim(),ref mensajeFuncion, "Clave unica", ref this.txtClaveUnica))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtNombre.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtAPaterno.Text.Trim(), ref mensajeFuncion, "APaterno", ref this.txtAPaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtAMaterno.Text.Trim(), ref mensajeFuncion, "AMaterno", ref this.txtAMaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtCorreoElectronico.Text.Trim(), ref mensajeFuncion, "Correo electronico", ref this.txtCorreoElectronico))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtCodigoPostal.Text.Trim(), ref mensajeFuncion, "Codigo postal", ref this.txtCodigoPostal))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtRfc.Text.Trim(), ref mensajeFuncion, "Rfc", ref this.txtRfc))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            return true;

        }


        public void EnviarCorreo(string correoDestino, string asunto, string mensajeCorreo)
        {
            string mensaje = "Error al enviar correo.";

            try
            {
                SmtpMail objetoCorreo = new SmtpMail("TryIt");

                objetoCorreo.From = "alan.ferrer3212@gmail.com";
                objetoCorreo.To = correoDestino;
                objetoCorreo.Subject = asunto;
                objetoCorreo.TextBody = mensajeCorreo;

                SmtpServer objetoServidor = new SmtpServer("smtp.gmail.com");

                objetoServidor.User = "alan.ferrer3212@gmail.com";
                objetoServidor.Password = "Barcelona 2000";
                objetoServidor.Port = 587;
                objetoServidor.ConnectType = SmtpConnectType.ConnectSSLAuto;
                

                SmtpClient objetoCliente = new SmtpClient();
                objetoCliente.SendMail(objetoServidor, objetoCorreo);
                mensaje = "Correo Enviado Correctamente.";


            }
            catch (Exception ex)
            {
                mensaje = "Error al enviar correo." + ex.Message;
            }
        }

        //public class CatSexo
        //{


        //    public int id { get; set; }
        //    public string strValor { get; set; }

        //}
        //[WebMethod]
        //public static List<CatSexo> PopulateDropDownList()
        //{
        //    DataTable dt = new DataTable();
        //    List<CatSexo> objCat = new List<CatSexo>();
        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("SELECT id,strValor FROM CatSexo", con))
        //        {
        //            con.Open();
        //            SqlDataAdapter da = new SqlDataAdapter(cmd);
        //            da.Fill(dt);
        //            if (dt.Rows.Count > 0)
        //            {
        //                for (int i = 0; i < dt.Rows.Count; i++)
        //                {
        //                    objCat.Add(new CatSexo
        //                    {
        //                        Convert.ToInt32(id) = dt.Rows[i]["id"].ToString(),
        //                        strValor = dt.Rows[i]["strValor"].ToString()
        //                    });
        //                }
        //            }
        //            return objCat;
        //        }
        //    }
        //}

        //[WebMethod]
        //public static string BindDropdownlist()
        //{
        //    SqlConnection con = new SqlConnection(@"Data Source=ALAN;Initial Catalog=Persona;Integrated Security=True");

        //    DataTable dt = new DataTable();

        //    SqlDataAdapter da = new SqlDataAdapter("SELECT id,strValor FROM CatSexo", con);

        //    con.Open();
        //    da.Fill(dt);
        //    con.Close();

        //    List<CatSexo> liststudent = new List<CatSexo>();



        //    if (dt.Rows.Count > 0)
        //    {
        //        for (int i = 0; i < dt.Rows.Count; i++)
        //        {
        //            CatSexo objst = new CatSexo();
        //            objst.id = Convert.ToInt32(dt.Rows[i]["id"]);
        //            objst.strValor = Convert.ToString(dt.Rows[i]["strValor"]);
        //            liststudent.Insert(i, objst);
        //        }



        //    }

        //    JavaScriptSerializer jscript = new JavaScriptSerializer();
        //    return jscript.Serialize(liststudent);
        //}

        //[WebMethod]
        //public static List<CatSexo> PopulateDropDownList ()
        //{
        //    DataTable dt = new DataTable();
        //    List<CatSexo> objCat = new List<CatSexo>();
        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("SELECT id,strValor FROM CatSexo", con))
        //        {
        //            con.Open();
        //            SqlDataAdapter da = new SqlDataAdapter(cmd);
        //            da.Fill(dt);
        //            if (dt.Rows.Count > 0)
        //            {
        //                for (int i = 0; i < dt.Rows.Count; i++)
        //                {
        //                    CatSexo objst = new CatSexo();
        //                    objst.id = Convert.ToInt32(dt.Rows[i]["id"]);
        //                    objst.strValor = Convert.ToString(dt.Rows[i]["strValor"]);
        //                    objCat.Insert(i, objst);
        //                }
                        
        //            }
        //        }
        //        return objCat;
        //    }
        //}
        

        //public class CatSexo
        //{
        //    public int id  { get; set; }
        //    public string strValor { get; set; }
        //}

        #endregion
        protected void dteCalendar_SelectionChanged(object sender, EventArgs e)
        {
            this.lblFecha.Visible = false;


        }

        protected void btnError_Click(object sender, EventArgs e)
        {
            int hola = 0;
        }

        protected void ddlEstadoCivil_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                int idEstadoCivil = int.Parse(this.ddlEstadoCivil.Text);
                Expression<Func<CatEstadoCivil, bool>> predicateEstadoCivil = c => c.id == idEstadoCivil;
                predicateEstadoCivil.Compile();
                List<CatEstadoCivil> lista = dcGlobal.GetTable<CatEstadoCivil>().Where(predicateEstadoCivil).ToList();
                CatEstadoCivil catEstadoCivilTemp = new CatEstadoCivil();
                this.ddlEstadoCivil.DataTextField = "strValor";
                this.ddlEstadoCivil.DataValueField = "id";
                this.ddlEstadoCivil.DataSource = lista;
                this.ddlEstadoCivil.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }
    }
}