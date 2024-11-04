namespace Practica_3._2._3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /* Este programa lee caracteres introducidos por teclado,
            los almacena en una cadena, calcula cuales son los mayores y
            menores atendiendo a la tabla ASCII. También almacena el número
            de ellos que son mayúsculas */
            char letra;
            char minLetra = Char.MinValue;
            char maxLetra = Char.MaxValue;
            int numMayusculas = 0;
            bool salir = false;
            while (salir == false)
            {
                //Leo una letra
                Console.WriteLine("Introduce una letra. Pulsa 0 si quieres salir: ");
                letra = Console.ReadKey().KeyChar;
                Console.WriteLine("");
                Console.WriteLine("------");
                if (letra == '0')
                    salir = true;
                //almaceno los menores y mayores.
                if (minLetra < letra)
                    minLetra = letra;
                if (maxLetra > letra)
                    maxLetra = letra;
                //Si la letra es mayusculas la contabiliza
                if ((letra > 'A') && (letra < 'Z'))
                    numMayusculas++;
            }
            //Escribe el resultado
            Console.WriteLine("La letra menor es: " + maxLetra);
            Console.WriteLine("La letra mayor es: " + minLetra);
            Console.WriteLine("Hay " + numMayusculas + " letras mayusculas");
            Console.ReadKey();
        }
    }
}