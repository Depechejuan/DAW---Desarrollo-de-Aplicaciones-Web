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

        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]

        public void Debit_ExpectedException_DebitOverLimit()
        {
            double beginningBalance = 11.99;
            double debitAmount = 32.60;
            double expected = -20.61;
            BankAccount account = new BankAccount("Mr. Juan Leon", beginningBalance);

            // acción a probar
            account.Debit(debitAmount);
            double actual = account.Balance;
            Assert.AreEqual(expected, actual, 0.001, "Account not debited correctly");
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void Debit_ExpectedException_DebitWithNoMoney()
        {
            double beginningBalance = -10;
            double debitAmount = 100;
            double expected = -110;
            BankAccount account = new BankAccount("Mr. Juan Leon", beginningBalance);

            // acción a probar
            account.Debit(debitAmount);
            double actual = account.Balance;
            Assert.AreEqual(expected, actual, 0.001, "Account not debited correctly");
        }


        [TestMethod]
        public void Debit_ExpectedException_ForzenAccount()
        {
            double beginningBalance = 200;
            double debitAmount = 100;
            double expected = 100;
            BankAccount account = new BankAccount("Mr. Juan Leon", beginningBalance);
            account.FreezeAccount();

            // acción a probar
            account.Debit(debitAmount);
            double actual = account.Balance;
            Assert.AreEqual(expected, actual, 0.001, "Account not debited correctly");
        }

        //unit test method
        [TestMethod]
        [ExpectedException(typeof(Exception))]
        public void Debit_WhenBankAccountIsFrezee_ShouldThrowException()
        {
            // preparación del caso de prueba
            double beginningBalance = 11.99;
            double debitAmount = -100.00;
            BankAccount account = new BankAccount("Mr. Bryan Walton", beginningBalance);
            account.FreezeAccount();
            // acción a probar
            account.Debit(debitAmount);
            // la afirmación es manejado por el atributo ExpectedException
        }


        public void TestMethod1()
        {
            
        }
    }


}
