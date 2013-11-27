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
                System.Net.Sockets.TcpClient cli = new System.Net.Sockets.TcpClient(server.Text, int.Parse(port.Text));
                var buf = System.Text.UTF8Encoding.UTF8.GetBytes(code.Text + "\n");
                var ns = cli.GetStream();
                ns.Write(buf, 0, buf.Length);


                var ms = new System.IO.MemoryStream();
                buf = new byte[1024];
                int len = 0;
                for (int i = 0; ((i = ns.Read(buf, 0, 1024)) > 0); )
                {
                    ms.Write(buf, 0, i);
                    len += i;
                }
                ns.Close();
                resp.Foreground = SystemColors.WindowTextBrush;
                resp.Text = System.Text.UTF8Encoding.UTF8.GetString(ms.GetBuffer(), 0, len);
            }
            catch (Exception ex)
            {
                resp.Foreground = Brushes.Red;
                resp.Text = ex.ToString();
            }
        }
    }
}
