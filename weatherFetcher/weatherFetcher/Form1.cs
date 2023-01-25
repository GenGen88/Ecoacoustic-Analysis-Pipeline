using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Text.RegularExpressions;

namespace weatherFetcher
{
    public partial class Form1 : Form
    {
        public static int linkCountr = 0;

        public Form1()
        {
            InitializeComponent();
        }

        private void webBrowser1_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            MessageBox.Show("hellowworld");
            Regex csvRegex = new Regex("b>, get the <a href=\"(\\/ climate\\/ dwo\\/[1 - 9].+\\/ text\\/.+\\.csv)\"");
            Regex linksRegex = new Regex("href = \"(\\/climate\\/dwo\\/[0-9]+\\/htm\\/.{10}\\.[0-9]+\\.shtml)");
            MatchCollection linkMatches = linksRegex.Matches(webBrowser1.DocumentText);
            MatchCollection csvMatch = csvRegex.Matches(webBrowser1.DocumentText);
            MessageBox.Show("hello2");
           
            // convert regex match to string
            string csvLink = csvMatch.Cast<Match>().Select(match => match.Value).ToList()[0].ToString();
            MessageBox.Show("convertToString");

            // download csv
            WebClient webClient = new WebClient();
            webClient.DownloadFile(csvLink, "C:/Users/gldia/OneDrive/Documents/VRES-Analyser/weatherFetcher/out");

            // navigate to the new link
            linkCountr++;

            if (linkCountr > linkMatches.Count)
            {
                return;
            }
            else
            {
               string link = linkMatches[linkCountr].ToString();
                webBrowser1.Navigate(link);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            webBrowser1.ScriptErrorsSuppressed = true;
        }
    }
}
