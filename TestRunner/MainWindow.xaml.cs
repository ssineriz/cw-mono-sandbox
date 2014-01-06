using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace TestRunner
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                resp.Foreground = SystemColors.WindowTextBrush;
                resp.Text = "";
                var client = new System.Net.WebClient();                
                var buf = client.UploadData(string.Format("http://{0}:{1}/", server.Text, port.Text), "POST", System.Text.UTF8Encoding.UTF8.GetBytes(code.Text));
                resp.Text = System.Text.UTF8Encoding.UTF8.GetString(buf, 0, buf.Length);
            }
            catch (Exception ex)
            {
                resp.Foreground = Brushes.Red;
                resp.Text = ex.ToString();
            }
        }
    }
}
