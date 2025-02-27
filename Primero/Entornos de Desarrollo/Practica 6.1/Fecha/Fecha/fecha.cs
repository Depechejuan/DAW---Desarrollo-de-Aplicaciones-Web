
namespace Fecha
{
    public class Fecha
    {
        private int _day;
        private int _month;
        private int _year;
        //TODO validar los valores introducidos
        
        /// <summary>
        /// Constructor de Fecha sin parámetros
        /// Se establecen los valores a 1
        /// </summary>
        public Fecha()
        {
            _day = 1;
            _month = 1;
            _year = 1;
        }

        /// <summary>
        /// Constructor de Fecha con parámetros (Año, Mes, Día)
        /// </summary>
        /// <param name="year">INT - year</param>
        /// <param name="month">INT - month</param>
        /// <param name="day">INT - day</param>
        public Fecha(int year, int month, int day)
        {
            SetDate(year, month, day);
        }

        /// <summary>
        /// Constructor de Fecha con 3 parámetros
        /// Si algún parámetro no es correcto se establece a 1
        /// </summary>
        /// <param name="month">Mes</param>
        /// <param name="year">Anyo (entre 1 y 2500)</param>
        /// <param name="day">Dia</param>
        /// <param name="leap">Indica si es bisiesto</param>
        public Fecha(int month, int year, int day, bool leap)
        {
            if (year >= 1 && year <= 2500)
                this._year = year;
            else
                this._year = 1;

            bool bisiesto;

            if ((_year % 400 == 0) || ((_year % 4 == 0) && (_year % 100 != 0)))
                bisiesto = true;
            else
                bisiesto = false;

            if (month >= 1 && month <= 12)
                this._month = month;
            else
                this._month = 1;

            int diasMes = 0;

            if (Is31Days())
                diasMes = 31;

            if (!Is31Days() && _month != 2)
                diasMes = 30;

            if (_month == 2 && bisiesto)
                diasMes = 29;
            else
                diasMes = 28;

            if (1 <= day && day <= diasMes)
                this._day = day;
            else
                this._day = 1;
        }

        /// <summary>
        /// Getter - Solicita el día introducido
        /// </summary>
        /// <returns>INT (day)</returns>
        public int GetDay()
        {
            return _day;
        }

        /// <summary>
        /// Getter - Solicita el mes introducido
        /// </summary>
        /// <returns>INT (month)</returns>
        public int GetMonth()
        {
            return _month;
        }

        /// <summary>
        /// Getter - Solicita el año introducido
        /// </summary>
        /// <returns>INT (year)</returns>
        public int GetYear()
        {
            return _year;
        }

        /// <summary>
        /// Setter de Fecha, valida los parámetros
        /// </summary>
        /// <param name="year">INT - year</param>
        /// <param name="month">INT - month</param>
        /// <param name="day">INT - day</param>
        public void SetDate(int year, int month, int day)
        {
            if (year > 0)
                _year = year;
            else
                _year = 0;
            if (0 < month && month < 13)
                _month = month;
            else
                _month = 0;
            if (0 < day && day < 31)
                _day = day;
            else
                _day = 0;
        }

        /// <summary>
        /// Añade un día a la fecha.
        /// </summary>
        /// <param name="day">INT</param>
        public void SetDay(int day)
        {
            if (0 < day && day < 31)
                _day = day;
            else
                _day = 1;
        }

        /// <summary>
        /// Añade un mes a la fecha.
        /// </summary>
        /// <param name="month">INT</param>
        public void SetMonth(int month)
        {
            if (0 < month && month < 13)
                _month = month;
            else
                _month = 0;
        }

        /// <summary>
        /// Añade un año a la fecha.
        /// </summary>
        /// <param name="year">INT</param>
        public void SetYear(int year)
        {
            if (year > 0)
                _year = year;
            else
                _year = 0;
        }


        /// <summary>
        /// Comprueba que el año es bisiesto. Devuelve un booleano si lo es,
        /// además de imprimir por consola si es o no bisiesto.
        /// </summary>
        /// <returns>bool</returns>
        public bool EsBisiesto()
        {
            bool bisiesto = false;

            if ((_year % 400 == 0) || ((_year % 4 == 0) && (_year % 100 != 0)))
            {
                bisiesto = true;
                Console.WriteLine("El año " + this._year + " es bisiesto");
            }
            else
            {
                bisiesto = false;
                Console.WriteLine("El año " + this._year + " no es bisiesto");
            }

            return bisiesto;
        }

        /// <summary>
        /// Devuelve un string con la fecha en formato dia/mes/anyo
        /// </summary>
        /// <remarks> la palabra clave override indica que se sobreescribe el metodo ToString</remarks>
        /// <returns>un string con la fecha en formatodia/mes/anyo</returns> 
        public override string ToString()
        {
            return _day + "/" + _month + "/" + _year;
        }

        /// <summary>
        /// Revisa que el mes sea de 31 días o no
        /// </summary>
        /// <returns>Bool (true/false)</returns>
        private bool Is31Days()
        {
            if (1 == _month || _month == 3)
                return true;
            if (5 == _month || _month == 7)
                return true;
            if (8 == _month || _month == 10)
                return true;
            if (_month == 12)
                return true;
            return false;
        }
    }
}
