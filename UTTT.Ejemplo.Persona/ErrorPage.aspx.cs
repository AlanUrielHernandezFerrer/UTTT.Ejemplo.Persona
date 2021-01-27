using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UTTT.Ejemplo.Persona
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Logic objetoLogic = new Logic();
            string msg = objetoLogic.EnviarCorreo(para.Text, asunto.Text, mensaje.Text);
            ScriptManager.RegisterClientScriptBlock(this, typeof(string), "MsgAlert", "alert('" + msg + "');window.location ='ErrorPage.aspx';", true);
        }
    }
}