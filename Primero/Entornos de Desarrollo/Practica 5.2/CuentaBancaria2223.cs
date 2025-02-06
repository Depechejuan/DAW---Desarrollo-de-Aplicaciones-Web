
namespace CuentaBancaria
{
    /* Clase que representa una cuenta corriente
     * Tiene el campo saldo que representa el saldo de la cuenta, en euros
	 * Existen dos constructores, uno vacío (que inicializa el saldo a cero)
	 * y otro con parámetro, que establece el saldo en el valor del parámetro
     * La propiedad Saldo devuelve el saldo que hay en la cuenta
     * Los metodos Retirar e Ingresar sirven para retirar o ingresar la cantidad indicada 
	 * Estos métodos generan error si la cantidad no es válida -menor o igual que cero- o
	 * en el caso de Retirar, 
     * 
     * Este comentario se debe eliminar y usar comentarios de documentacion en su lugar
     */
    public class CuentaBancaria
    {
        private double saldo;
		
		public const String ERR_CANTIDAD_NO_VALIDA "La cantidad indicada no es válida.";
		public const String ERR_SALDO_INSUFICIENTE "Saldo insuficiente.";

		CuentaBancaria() 
		{
			this.saldo = 0;
		}
		
		CuentaBancaria(double saldo) 
		{
			this();
			Ingresar( saldo );
		}

        public double Saldo
        {
            get { return saldo; }
			set { saldo = value; }
        }

        public void Ingresar (double cantidad)
        {
            if (cantidad <= 0)
				throw new ArgumentOutOfRangeException(ERR_CANTIDAD_NO_VALIDA);
            Saldo += cantidad;
        }

        public void Retirar (double cantidad)
        {
            if (cantidad <= 0)
				throw new ArgumentOutOfRangeException(ERR_CANTIDAD_NO_VALIDA);
            if (cantidad > Saldo)
				throw new ArgumentOutOfRangeException(ERR_SALDO_INSUFICIENTE);
            Saldo -= cantidad;
            }
        }
    }
}
