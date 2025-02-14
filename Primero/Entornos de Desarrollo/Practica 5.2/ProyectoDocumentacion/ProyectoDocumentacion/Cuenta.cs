
using System;

namespace CuentaBancaria
{
    /// <summary>
    /// * Clase que representa una cuenta corriente
    /// * Tiene el campo saldo que representa el saldo de la cuenta, en euros
    /// * Existen dos constructores, uno vacío(que inicializa el saldo a cero)
    /// * y otro con parámetro, que establece el saldo en el valor del parámetro
    /// * La propiedad Saldo devuelve el saldo que hay en la cuenta
    /// * Los metodos Retirar e Ingresar sirven para retirar o ingresar la cantidad indicada
    /// 
    /// * Estos métodos generan error si la cantidad no es válida -menor o igual que cero- o
    /// * en el caso de Retirar,
    /// *
    /// * Este comentario se debe eliminar y usar comentarios de documentacion en su lugar

    /// </summary>
    public class CuentaBancaria
    {
        private double _saldo; // Indicador de saldo de la cuenta.

        public const String ERR_CANTIDAD_NO_VALIDA = "La cantidad indicada no es válida."; // Creación variable de excepción
        public const String ERR_SALDO_INSUFICIENTE = "Saldo insuficiente."; // Creación variable de excepción

        /// <summary>
        /// Constructor de la cuenta bancaria, establece saldo a 0.
        /// </summary>
        CuentaBancaria()
        {
            this._saldo = 0;
        }
        /// <summary>
        /// Constructor 
        /// </summary>
        /// <param name="saldo"></param>
        CuentaBancaria(double saldo)
        {
            //this();
            Ingresar(saldo);
        }

        /// <summary>
        /// Setter y Getter de Saldo
        /// </summary>
        public double Saldo
        {
            get { return _saldo; }
            set { _saldo = value; }
        }

        /// <summary>
        /// Función para ingresar dinero en la cuenta
        /// </summary>
        /// <param name="cantidad">cantidad a retirar (double)</param>
        /// <exception cref="ArgumentOutOfRangeException">Excepción si la cantidad a retirar no es válida</exception>
        public void Ingresar(double cantidad)
        {
            if (cantidad <= 0)
                throw new ArgumentOutOfRangeException(ERR_CANTIDAD_NO_VALIDA);
            Saldo += cantidad;
        }


        /// <summary>
        /// Función para retirar efectivo.
        /// </summary>
        /// <param name="cantidad">saldo (INT)</param>
        /// <exception cref="ArgumentOutOfRangeException">Excepción por cantidad no váida (negativo) o saldo insuficiente</exception>
        public void Retirar(double cantidad)
        {
            if (cantidad <= 0)
                throw new ArgumentOutOfRangeException(ERR_CANTIDAD_NO_VALIDA);
            if (cantidad > Saldo)
                throw new ArgumentOutOfRangeException(ERR_SALDO_INSUFICIENTE);
            Saldo -= cantidad;
        }
    }
}