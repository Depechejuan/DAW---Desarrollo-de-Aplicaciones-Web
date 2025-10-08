using PruebasUnitariasApp;

namespace TestPruebasUnitariasApp
{
    [TestClass]
    public sealed class MSTestSettings
    {
        [DataTestMethod]
        [DataRow(25, true)] //mayor de edad
        [DataRow(10, false)] //menor de edad
        [DataRow(18, true)] //mayor de edad
        [DataRow(1, false)] //menor de edad
        public void Es_Mayor_Edad_VariosCasos(int edad, bool esperado)
        {
            bool result = ValidadorUsuario.EsMayorDeEdad(edad);
            Assert.AreEqual(esperado, result);
        }

        [DataTestMethod]
        [DataRow(0, typeof(ArgumentException),
        ValidadorUsuario.EDAD_0_MESSAGE)]
        [DataRow(-5, typeof(ArgumentException),
        ValidadorUsuario.EDAD_NEGATIVE_MESSAGE)]
        public void EsMayorDeEdad_ValoresInvalidos(int edad, Type
        tipoExcepcion, string mensajeEsperado)
        {
            var ex = Assert.ThrowsException<ArgumentException>(() =>
            ValidadorUsuario.EsMayorDeEdad(edad));
            Assert.AreEqual(mensajeEsperado, ex.Message);
        }

        [DataRow("", "prueba@gmail.com", false)]
        [DataRow("", "prueba.gmail.com", false)]
        [DataRow("Paco", "prueba@gmail.com", true)]
        [DataRow("Paco", "prueba.gmail.com", false)]
        [DataRow("Paco", "", false)]
        public void Es_Usuario_Valido(string nombre, string email, bool expected)
        {
            bool result = ValidadorUsuario.EsUsuarioValido(nombre, email);
            Assert.AreEqual(result, expected);
        }

        //[TestMethod]
        //public void Es_Nombre_Vacio()
        //{
        //    bool result = ValidadorUsuario.EsUsuarioValido("", "prueba@gmail.com");
        //    Assert.IsFalse(result);
        //}

        //[TestMethod]
        //public void Es_Email_Vacio()
        //{
        //    bool result = ValidadorUsuario.EsUsuarioValido("Obi Wan Kenobi", "");
        //    Assert.IsFalse(result);
        //}
        //[TestMethod]
        //public void Es_Email_Sin_Arroba_Vacio()
        //{
        //    bool result = ValidadorUsuario.EsUsuarioValido("Obi Wan Kenobi", "prueba.gmail.com");
        //    Assert.IsFalse(result);
        //}
        //[TestMethod]
        //public void Es_Usuario_Valido()
        //{
        //    bool result = ValidadorUsuario.EsUsuarioValido("Obi Wan Kenobi", "prueba@gmail.com");
        //    Assert.IsTrue(result);
        //}
    }
}
