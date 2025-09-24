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
            "<br/> Fecha de Incorporación: " + txtFinEmp.Text +
            "<br/> Sexo: " + rblSexEmp.SelectedItem.Value +
            "<br/> Departamento: " + ddlDepEmp.Text +
            "<br/> Fecha de Nacimiento: " + TxtCal1.Text +
            "<br/> Años, Meses y Días en la Compañía: " + TxtAños.Text + " años, " + TxtMeses.Text + " meses y " + txtDias.Text + " días";
            
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            TxtCal1.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd");
            DateTime fechaNacimiento = Calendar1.SelectedDate;

            VerificarFechaNacimiento(fechaNacimiento);
        }

        private void VerificarFechaNacimiento(DateTime fechaNacimiento)
        {
            DateTime now = System.DateTime.Now;
            if (fechaNacimiento > now)
            {
                lblError3.Text = "La fecha de nacimiento es mayor que la fecha actual";
                lblError3.Visible = true;
            }
            else
            {
                lblError3.Visible = false;
            }
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            TxtCal2.Text = Calendar2.SelectedDate.ToString("yyyy-MM-dd");

            DateTime fechaNacimiento = Calendar1.SelectedDate;
            DateTime fechaIngreso = Calendar2.SelectedDate;

            ComprobarIngresoYNacimiento(fechaIngreso, fechaNacimiento);


            VerificarFechaIngreso(fechaIngreso);

            if (fechaIngreso < DateTime.Now)
                CheckDiffTime(fechaIngreso);
            else
            {
                TxtAños.Text = "";
                TxtMeses.Text = "";
                txtDias.Text = "";
            }
        }

        private void ComprobarIngresoYNacimiento(DateTime fechaIngreso, DateTime fechaNacimiento)
        {
            if (fechaIngreso <= fechaNacimiento)
            {
                lblError1.Text = "La fecha de ingreso no puede ser anterior o igual a la fecha de nacimiento.";
                lblError1.Visible = true;
            }
            else
            {
                lblError1.Visible = false;
            }
        }

        private void VerificarFechaIngreso(DateTime fechaIngreso)
        {
            if (fechaIngreso > DateTime.Now)
            {
                lblError2.Text = "La fecha de ingreso en la compañía es mayor que la fecha actual";
                lblError2.Visible = true;
            }
            else
            {
                lblError2.Visible = false;
            }
        }

        protected void txtCal1_TextChanged(object sender, EventArgs e)
        {
            DateTime fecha;
            if (DateTime.TryParse(TxtCal1.Text, out fecha))
            {
                Calendar1.SelectedDate = fecha;
                Calendar1.VisibleDate = fecha;
            }

            VerificarFechaNacimiento(fecha);
        }

        protected void txtCal2_TextChanged(object sender, EventArgs e)
        {
            DateTime fechaIngreso;
            if (DateTime.TryParse(TxtCal2.Text, out fechaIngreso))
            {
                Calendar2.SelectedDate = fechaIngreso;
                Calendar2.VisibleDate = fechaIngreso;
            }

            DateTime fechaNacimiento = Calendar1.SelectedDate;
            ComprobarIngresoYNacimiento(fechaIngreso, fechaNacimiento);

            VerificarFechaIngreso(fechaIngreso);
            if (fechaIngreso < DateTime.Now)
                CheckDiffTime(fechaIngreso);
            else
            {
                TxtAños.Text = "";
                TxtMeses.Text = "";
                txtDias.Text = "";
            }
        }

        private void CheckDiffTime(DateTime fechaIngreso)
        {
            DateTime dtHoy = System.DateTime.Now;
            TimeSpan diferencia = dtHoy - fechaIngreso;
            DateTime fechamin = new DateTime(1, 1, 1);
            TxtAños.Text = ((fechamin + diferencia).Year - 1).ToString();
            TxtMeses.Text = ((fechamin + diferencia).Month - 1).ToString();
            txtDias.Text = ((fechamin + diferencia).Day).ToString();
        }

        protected void TxtAños_TextChanged(object sender, EventArgs e)
        {

        }
    }
}