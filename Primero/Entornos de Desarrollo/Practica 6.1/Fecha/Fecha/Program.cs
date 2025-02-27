using System;
namespace Fecha
{
    class Program
    {
        static void Main(string[] args)
        {
            //Fecha correcta, año bisiesto
            Fecha fecha1 = new Fecha(12, 2012, 4, false);
            Console.WriteLine("Fecha 1: " + fecha1.ToString());
            fecha1.EsBisiesto();
                
            Fecha fecha2 = new Fecha(10, 2013, 4, false);
            Console.WriteLine("Fecha 2: " + fecha2.ToString());
            fecha2.EsBisiesto();
                
            Fecha fecha3 = new Fecha(13, -4, 4, false);
            Console.WriteLine("Fecha 3: " + fecha3.ToString());

            //Fecha con asignación incorrecta de valores erroneos
            Fecha fecha4 = new Fecha();
            fecha4.SetDay(67);
            fecha4.SetMonth(80);
            fecha4.SetYear(3678);
            Console.WriteLine("Fecha 4: " + fecha4.ToString());
            

            
        }
    }
}