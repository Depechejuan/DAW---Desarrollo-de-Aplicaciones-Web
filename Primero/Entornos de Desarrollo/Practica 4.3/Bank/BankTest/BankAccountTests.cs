using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using BankAccountNS;

namespace BankTest
{
    [TestClass]
    public class BankAccountTests
    {
        [TestMethod]
        // unit test code [TestMethod]
        public void Debit_WithValidAmount_UpdatesBalance()
        {
            // preparación del caso de prueba
            double beginningBalance = 11.99;
            double debitAmount = 4.55;
            double expected = 7.44;
            BankAccount account = new BankAccount("Mr. Bryan Walton", beginningBalance);

            // acción a probar
            account.Debit(debitAmount);

            // afirmación de la prueba (valor esperado Vs. Valor obtenido)
            double actual = account.Balance;
            Assert.AreEqual(expected, actual, 0.001, "Account not debited correctly");
        }
        public void TestMethod1()
        {
            
        }
    }


}
