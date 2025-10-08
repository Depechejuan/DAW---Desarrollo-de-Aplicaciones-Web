namespace PruebasUnitariasApp
{
    public class ValidadorUsuario
    {
        public const string EDAD_0_MESSAGE = "Evidentemente no eres mayor de edad";
        public const string EDAD_NEGATIVE_MESSAGE = "Todavía no has nacido";
        public static bool EsMayorDeEdad(int edad)
        {
            if (edad == 0)
                throw new ArgumentException(EDAD_0_MESSAGE);
            else if (edad < 0)
                throw new ArgumentException(EDAD_NEGATIVE_MESSAGE);
            return edad >= 18;
        }

        public static bool EsUsuarioValido(string nombre, string email)
        {
            return !string.IsNullOrWhiteSpace(nombre) &&
                   !string.IsNullOrWhiteSpace(email) &&
                   email.Contains("@");
        }
    }
}