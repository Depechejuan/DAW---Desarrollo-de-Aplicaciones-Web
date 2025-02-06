
namespace proyecto.documentacion
{
    
    public class Trabajador
    {
        
        private const int EdadJubilacionDefecto = 67;
        
        private string nombre;        
        private int edad;
        
        public string Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }        
       
        public int Edad
        {
            get { return edad; }
            set 
            {
                if (value >= 1 && value <= 150)
                    edad = value;
            }
        }
       
        public int CalculoAnyosJubilacion()
        {
            return EdadJubilacionDefecto - edad;
        }
       
        public int CalculoAnyosJubilacion(int edadJubilacion)
        {
            if (edadJubilacion < EdadJubilacionDefecto && edadJubilacion >= edad)
                return edadJubilacion - edad;
            else
                return EdadJubilacionDefecto - edad;
        }

    }
}
