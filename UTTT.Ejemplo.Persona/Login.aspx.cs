using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Security;
using System.Configuration;

namespace UTTT.Ejemplo.Persona
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = new Linq.Data.Entity.Usuario();
            //UTTT.Ejemplo.Persona.Encrypt obclsEncriptacion = new UTTT.Ejemplo.Persona.Encrypt();
            //string stkey = ConfigurationManager.AppSettings["stkey"];
            //usuario.strContrasenia = obclsEncriptacion.stDesencriptar3DES(txtPassword.Text, stkey);
            lblErrorMessage.Visible = false;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
           // using (SqlConnection sqlCon = new SqlConnection("Data Source=ALAN;Initial Catalog=Persona;Integrated Security=True"))
            using (SqlConnection sqlCon = new SqlConnection("Data Source = PersonaBD.mssql.somee.com; Initial Catalog = PersonaBD; User ID = alanuriel2000_SQLLogin_1; Password = vsq1vk5dsk"))
               
            {
                string query = "SELECT COUNT(1) FROM USUARIO WHERE strNombre=@strNombre AND strContrasenia=@strcontrasenia AND idCatUsuario=1";
                SqlCommand sqlcmd = new SqlCommand(query, sqlCon);

                sqlcmd.Parameters.AddWithValue("@strNombre", txtUser.Text.Trim());
                
                sqlcmd.Parameters.AddWithValue("@strContrasenia", txtPassword.Text.Trim());
              

                sqlCon.Open();
                int count = Convert.ToInt32(sqlcmd.ExecuteScalar());
                if (count == 1 )
                {
                    Session["strNombre"] = txtUser.Text.Trim();
                    Response.Redirect("Menu.aspx");

                }
                else
                { lblErrorMessage.Visible = true; }
            }

           
        }

        protected void btnRecuperar_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("~/Recuperarcontrasenia.aspx");
        }
    }
    }
