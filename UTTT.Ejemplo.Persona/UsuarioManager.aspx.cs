using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using System.Windows.Forms;
using EASendMail;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;
using UTTT.Ejemplo.Persona.Control;
using System.Web.UI.WebControls;
using System.Text;
using System.Security.Cryptography;
using System.Configuration;

namespace UTTT.Ejemplo.Persona
{
    public partial class UsuarioManager : System.Web.UI.Page
    {
        private SessionManager session = new SessionManager();
        private int idUsuario = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Usuario baseEntity;

        private DataContext dcGlobal = new DcGeneralDataContext();
        private int tipoAccion = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["strNombre"] == null)
            {
                Response.Redirect("Login.aspx");

                lblUserDetails.Text = "strNombre : " + Session["strNombre"];
            }
            try
            {
                this.btnLogout.Visible = false;
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idUsuario = this.session.Parametros["idUsuario"] != null ?
                    int.Parse(this.session.Parametros["idUsuario"].ToString()) : 0;
                if (this.idUsuario == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Usuario();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Usuario>().First(c => c.id == this.idUsuario);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }

                    List<CatUsuario> lista = dcGlobal.GetTable<CatUsuario>().ToList();
                    CatUsuario catTemp = new CatUsuario();
                    catTemp.id = -1;
                    catTemp.strValor = "Seleccionar";
                    lista.Insert(0, catTemp);
                    this.ddlCatEstado.DataTextField = "strValor";
                    this.ddlCatEstado.DataValueField = "id";
                    this.ddlCatEstado.DataSource = lista;
                    this.ddlCatEstado.DataBind();
                    bindtoddl();

                    //Cat estado civil


                    //List<Persona> listaEstadoCivil = dcGlobal.GetTable<Persona>().ToList();
                    //Persona catEstadoCivilTemp = new Persona();
                    //catEstadoCivilTemp.id = -1;
                    //catEstadoCivilTemp.strNombre = "Seleccionar";
                    //listaEstadoCivil.Insert(0, catEstadoCivilTemp);
                    //this.ddlPersona.DataTextField = "strNombre";
                    //this.ddlPersona.DataValueField = "strNombre";
                    //this.ddlPersona.DataSource = listaEstadoCivil;
                    //this.ddlPersona.DataBind();
                    //cat estado


                    this.ddlCatEstado.SelectedIndexChanged += new EventHandler(ddlSexo_SelectedIndexChanged);
                    this.ddlCatEstado.AutoPostBack = true;
                    //Cat estado civil
                    //this.ddlEstadoCivil.SelectedIndexChanged += new EventHandler(ddlEstadoCivil_SelectedIndexChanged);
                    //this.ddlEstadoCivil.AutoPostBack = true;




                    if (this.idUsuario == 0)
                    {



                        this.lblAccion.Text = "Agregar";
                        DateTime tiempo = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                        //TextBox1.Text = tiempo.Date.ToString("dd/MM/yyyy");
                        this.TextBox1.Text = Convert.ToString(tiempo.ToShortDateString());
                        this.CalendarExtender.SelectedDate = tiempo;
                        //this.ddlCatEstado.Enabled = false;
                        Label4.Visible = false;
                        ddlCatEstado.Visible = false;
                        RequiredFieldValidator4.Visible = false;
                       

                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        ddlPersona.Enabled = false;

                        this.txtNombreUsuario.Text = this.baseEntity.strNombre;
                        this.txtContrasenia1.Text = this.baseEntity.strContrasenia;
                        this.txtContrasenia2.Text = this.baseEntity.strContrasenia;



                        DateTime fechaNacimiento = (DateTime)this.baseEntity.dteFechaIngreso;

                        if (fechaNacimiento != null)

                        {

                            //this.TextBox1.Text = Convert.ToString((DateTime)fechaNacimiento);
                            //this.CalendarExtender.SelectedDate = (DateTime)fechaNacimiento;
                            TextBox1.Text = fechaNacimiento.Date.ToString("dd/MM/yyyy");
                        }
                        //
                        //this.ddlPersona.DataSource = lista;
                        this.ddlPersona.DataBind();
                        //Cat estado civil
                        this.ddlCatEstado.DataSource = lista;
                        this.ddlCatEstado.DataBind();

                        this.setItem(ref this.ddlCatEstado, baseEntity.CatUsuario.strValor);

                        this.setItemEditar(ref this.ddlCatEstado, baseEntity.CatUsuario.strValor);
                        this.setItemEditar(ref this.ddlPersona, baseEntity.Persona.strNombre);
                    }
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/UsuarioPrincipal.aspx", false);
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsValid)
                {
                    return;
                }
                DataContext dcGuardar = new DcGeneralDataContext();
                // UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = new Linq.Data.Entity.Usuario();
                if (this.idUsuario == 0)
                {
                    if (!Existe(Convert.ToInt32(ddlPersona.Text)))
                    {
                        //registro no existe


                        usuario.idPersona = int.Parse(this.ddlPersona.Text.Trim());
                    }
                    else
                    {

                        this.showMessage("Persona repetido");
                        this.lblMensaje.Text = "Persona repetido";
                        //this.showMessageException("Personaaaaaaaaaaaaaaaa");
                      
                        
                    }
                    //this.lblFecha.Visible = false;


                    //persona.strNombre = this.ddlPersona.Text.Trim();


                    //usuario.strContrasenia = this.txtContrasenia1.Text.Trim();
                    //UTTT.Ejemplo.Persona.Encrypt obclsEncriptacion = new UTTT.Ejemplo.Persona.Encrypt();
                    //string stkey = ConfigurationManager.AppSettings["stkey"];
                    //usuario.strContrasenia = obclsEncriptacion.stEncriptar3DES(txtContrasenia1.Text, stkey);
                    //usuario.strContrasenia = obclsEncriptacion.stDesencriptar3DES(txtContrasenia1.Text, stkey);
                    usuario.strContrasenia = this.txtContrasenia1.Text.Trim();





                    // Set the default selected item, if desired.
                    //ddlSexo.SelectedIndex = idPersona;
                    //persona.idCatSexo = int.Parse(this.ddlSexo.ID.ToLower());

                    //persona.idCatSexo = int.Parse(this.ddlSexo.Items.Count.ToString());
                    usuario.idCatUsuario = 1;


                    DateTime fechaNacimiento = Convert.ToDateTime(TextBox1.Text);
                    usuario.dteFechaIngreso = fechaNacimiento;
                    //if (!Existe(Convert.ToString(txtNombreUsuario.Text)))
                    //{
                    //    this.showMessage("no existe");
                    //}
                    //else
                    //{
                    //    this.showMessage("si existe");
                    //}
                    //if(!Existe(Convert.ToInt32(ddlPersona.Text)))

                    //    {
                    //        //registro no existe
                    //    }
                    //else

                    //{

                    //    this.showMessage("Persona repetido");
                    //}

                  
                    
                    var comprobar = dcGlobal.GetTable<Usuario>().Where(a => a.strNombre == txtNombreUsuario.Text).FirstOrDefault();
                    // var comprobar2 = dcGlobal.GetTable<Usuario>().Where(a => a.idPersona  == int.Parse(ddlPersona.Text)).FirstOrDefault();
                   

                    if (comprobar != null)
                    {

                        this.showMessage("Usuario repetido");
                        this.lblMensaje.Visible = true;
                        this.lblMensaje.Text = "Usuario repetido";

                    }
                    else
                    {

                        usuario.strNombre = this.txtNombreUsuario.Text.Trim();
                        String mensaje = String.Empty;
                        if (!this.validacion(usuario, ref mensaje))

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
                        //this.lblFecha.Visible = false;
                       
                        // dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                        dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().InsertOnSubmit(usuario);
                      
                        dcGuardar.SubmitChanges();
                        this.showMessage("El registro se agrego correctamente.");
                        this.Response.Redirect("~/UsuarioPrincipal.aspx", false);


                    }

                //Validaciones;
                    
                }
                if (this.idUsuario > 0)
                {

                    usuario = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().First(c => c.id == idUsuario);

                  
                    usuario.strContrasenia = this.txtContrasenia1.Text.Trim();
                    //usuario.strContrasenia = Encrypt.GetSHA256(txtContrasenia1.Text.Trim());
                  

                    DateTime fechaNacimiento = Convert.ToDateTime(TextBox1.Text);
                    usuario.dteFechaIngreso = fechaNacimiento;
                    usuario.strNombre = this.txtNombreUsuario.Text.Trim();
                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se edito correctamente.");
                    this.Response.Redirect("~/UsuarioPrincipal.aspx", false);
                    

                   
                }


            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);

                //var mensaje = "Error message: " + _e.Message;

                //if (_e.InnerException != null)
                //{
                //    mensaje = mensaje + " Inner exception: " + _e.InnerException.Message;
                //}

                //mensaje = mensaje + " Stack trace: " + _e.StackTrace;
                //this.Response.Redirect("~/ErrorPage.aspx", false);


                //this.EnviarCorreo("alan.ferrer3212@gmail.com", "Error inesperado", mensaje);
            }

        }
        public bool Existe(int id)
        {
            using (SqlConnection conn = new SqlConnection("Data Source = PersonaBD.mssql.somee.com; Initial Catalog = PersonaBD; User ID = alanuriel2000_SQLLogin_1; Password = vsq1vk5dsk"))
            {
                string query = "SELECT COUNT(*) FROM Usuario WHERE idPersona=@IdPersona";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@IdPersona", id);
                conn.Open();

                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if (count == 0)
                    return false;
                else
                    return true;

                
            }
        }
        private void EnviarCorreo(string v1, string v2, string mensaje)
        {
            throw new NotImplementedException();
        }

        private void bindtoddl()
        {
            SqlConnection con = new SqlConnection("Data Source = PersonaBD.mssql.somee.com; Initial Catalog = PersonaBD; User ID = alanuriel2000_SQLLogin_1; Password = vsq1vk5dsk");
            SqlCommand cmd = new SqlCommand("select strNombre,id from Persona", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();


            sda.Fill(ds);



            ddlPersona.DataSource = ds;

            ddlPersona.DataTextField = "strNombre"; // FieldName of Table in DataBase
            ddlPersona.DataValueField = "id";

            //ddlPersona.DisplayMember = "strNombre";

            ddlPersona.DataBind();
            ddlPersona.Items.Insert(0, new ListItem("Seleccionar", String.Empty));

            //this.ddZona.Items.Insert(0, new ListItem("Elija una Opcion..", "0"));

        }



        private void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
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
                if (item.Value != _value)
                {
                    item.Enabled = false;

                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }

        public bool validacion(UTTT.Ejemplo.Linq.Data.Entity.Usuario _usuario, ref String _mensaje)
        {
            if (_usuario.idPersona != Convert.ToInt32(ddlPersona.Text))
               
            {
                _mensaje = "Persona repetida ";
                return false;
            }

            //if (_usuario.idCatUsuario == -1)
            //{
            //    _mensaje = "Seleccione una categoria";
            //    return false;
            //}

            //string nombre = _usuario.strNombre.Trim();
            //if (nombre.Length < 3)
            //{
            //    _mensaje = "Debe de tener mas de 3 caracteres el campo nombre";
            //    return false;
            //}

            //if (_usuario.strNombre.Equals(String.Empty))
            //{
            //    _mensaje = "El campo Nombre esta vacio verifique porfavor";
            //    return false;
            //}
            //if (_usuario.strNombre.Length > 30)
            //{
            //    _mensaje = "Rebasa el numero de caracteres en el campo de nombre";
            //    return false;
            //}

            string APaterno = _usuario.strContrasenia.Trim();
            if (APaterno.Length < 3)
            {
                _mensaje = "Debe de tener mas de 3 caracteres en el campo contraseña";
                return false;
            }

            if (_usuario.strContrasenia.Equals(String.Empty))
            {
                _mensaje = "El campo contraseña esta vacio verifique porvafor";
                return false;
            }
            if (_usuario.strContrasenia.Length > 200)
            {
                _mensaje = "Rebasa el numero de caracteres en el campo contraseña";
                return false;
            }

            return true;
        }
        private bool validaSql(ref String _mensaje)
        {
            CtrValidaInyeccion valida = new CtrValidaInyeccion();
            string mensajeFuncion = string.Empty;


            if (valida.SqlInyectionValida(this.txtNombreUsuario.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombreUsuario))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtContrasenia1.Text.Trim(), ref mensajeFuncion, "Contraseña", ref this.txtContrasenia1))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtContrasenia2.Text.Trim(), ref mensajeFuncion, "Repetir contraseña", ref this.txtContrasenia2))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.TextBox1.Text.Trim(), ref mensajeFuncion, "Fecha ingreso", ref this.TextBox1))
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
            if (valida.htmlInyectionValida(this.txtNombreUsuario.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombreUsuario))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtContrasenia1.Text.Trim(), ref mensajeFuncion, "Contraseña", ref this.txtContrasenia1))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtContrasenia2.Text.Trim(), ref mensajeFuncion, "Repetir contraseña", ref this.txtContrasenia2))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.TextBox1.Text.Trim(), ref mensajeFuncion, "Fecha ingreso", ref this.TextBox1))
            {
                _mensaje = mensajeFuncion;
                return false;
            }

            return true;

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }


        //Después creamos los métodos tanto para encriptar como para desencriptar:




    }
}