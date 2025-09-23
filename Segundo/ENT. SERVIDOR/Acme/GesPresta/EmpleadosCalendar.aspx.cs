using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GesPresta
{
    public partial class EmpleadosCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtCodEmp.Focus();
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged1(object sender, EventArgs e)
        {

        }

        protected void cmdEnviar_Click(object sender, EventArgs e)
        {
            lblValores.Visible = true;
            lblValores.Text = "VALORES DEL FORMULARIO" +
            "<br/> Código Empleado: " + txtCodEmp.Text +
            "<br/> NIF: " + txtNifEmp.Text +
            "<br/> Apellidos y Nombre: " + txtNomEmp.Text +
            "<br/> Dirección: " + txtDirEmp.Text +
            "<br/> Ciudad: " + txtCiuEmp.Text +
            "<br/> Teléfonos: " + txtTelEmp.Text +
            "<br/> Fecha de Nacimiento: " + txtFnaEmp.Text +
            "<br/> Fecha de Incorporación: " + txtFinEmp.Text +
            "<br/> Sexo: " + rblSexEmp.SelectedItem.Value +
            "<br/> Departamento: " + ddlDepEmp.Text;
        }
    }
}