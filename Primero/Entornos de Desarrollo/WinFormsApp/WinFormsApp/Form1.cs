namespace WinFormsApp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        public void btnCalcular_Click(object sender, EventArgs e)
        {
            int num1, num2, num3;
            num1 = int.Parse(txtNum1.Text);
            num2 = int.Parse(txtNum2.Text);
            num3 = int.Parse(txtNum3.Text);
            if (num1 > num2)
            {
                num3 = num3 + 5;
            }
            if (num1 == num3)
            {
                num2++;
            }
            if (num2 < num3)
            {
                num1--;
            }
            if (num1 * num2 > num3)
            {
                num3 = num2 + 1;
            }
            MessageBox.Show("Valores finales: \n num1: " + num1 + "\n num2: " + num2 + "\n num3: " + num3);
        }
    }
}
