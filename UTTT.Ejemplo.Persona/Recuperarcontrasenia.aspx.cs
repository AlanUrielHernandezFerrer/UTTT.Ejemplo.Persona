﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Net;
using System.Net.Mail;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using UTTT.Ejemplo.Persona.Model;
using System.Security.Cryptography;
using System.Text;

namespace UTTT.Ejemplo.Persona
{
    public partial class Recuperarcontrasenia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        PersonaBDEntities db = new PersonaBDEntities();
        DataContext dcGuardar = new DcGeneralDataContext();
        UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = new Linq.Data.Entity.Usuario();
        private UTTT.Ejemplo.Linq.Data.Entity.Usuario baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        protected void ButPwd_Click(object sender, EventArgs e)
        {
            try
            {
                var user = db.Persona.FirstOrDefault(p => p.strCorreoElectronico == TxtEmail.Text);
                if (user != null)
                {
                    var user2 = db.Usuario.FirstOrDefault(p => p.idPersona == user.id);
                    string correo = user.strCorreoElectronico.ToString();
                    MD5("123456");
                    string tak = Token();
                    Error(tak, correo);
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Usuario>().First(c => c.id == user2.id);
                    DataContext dcGuardar = new DcGeneralDataContext();
                    UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = new Linq.Data.Entity.Usuario();
                    if (dcGlobal != null)
                    {
                        usuario = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().First(c => c.id == user2.id);
                        var por = tak;
                        Session["abc"] = por.ToString().Trim();
                        usuario.token = por.ToString().Trim();
                        var net = Session["abc"].ToString();
                        dcGuardar.SubmitChanges();
                        this.alerta.Text = "Sele envio un correo revise porfavor";
                    }
                }
                else
                {
                    this.alerta.Text = "Este correo no esta registrado";
                }
            }
            catch (Exception ex)
            {
                this.alerta.Text = ex.Message;
            }
        }

        public static string MD5(string word)
        {
            MD5 md5 = MD5CryptoServiceProvider.Create();
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] stream = null;
            StringBuilder sb = new StringBuilder();
            stream = md5.ComputeHash(encoding.GetBytes(word));
            for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
            return sb.ToString();
        }
        public static string Token()
        {
            long i = 1;
            foreach (byte b in Guid.NewGuid().ToByteArray()) i *= ((int)b + 1);
            return MD5(string.Format("{0:x}", i - DateTime.Now.Ticks));
        }
        public new void Error(string error, string correo)
        {
            string EmailOrigen = "pruebasproyectos3212@gmail.com";
            string EmailDestino = correo;
            string contra = "pruebasproyectos";

            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailDestino, "Cambio de contraseña", "http://alanuriel.somee.com/ContraseniaNueva.aspx" + "?token=" + error);
           
            oMailMessage.IsBodyHtml = true;
            SmtpClient oSmtpClient = new SmtpClient("smtp.gmail.com");
            oSmtpClient.EnableSsl = true;
            oSmtpClient.UseDefaultCredentials = false;
            oSmtpClient.Port = 587;
            oSmtpClient.Credentials = new System.Net.NetworkCredential(EmailOrigen, contra);

            oSmtpClient.Send(oMailMessage);

            oMailMessage.Dispose();
        }
    }
}