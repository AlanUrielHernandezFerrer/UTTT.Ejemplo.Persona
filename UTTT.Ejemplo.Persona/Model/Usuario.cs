//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UTTT.Ejemplo.Persona.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Usuario
    {
        public int id { get; set; }
        public string strNombre { get; set; }
        public string strContrasenia { get; set; }
        public System.DateTime dteFechaIngreso { get; set; }
        public Nullable<int> idPersona { get; set; }
        public Nullable<int> idCatUsuario { get; set; }
        public string token { get; set; }
    
        public virtual CatUsuario CatUsuario { get; set; }
        public virtual Persona Persona { get; set; }
    }
}
