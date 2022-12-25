// See https://aka.ms/new-console-template for more information

/*@author Irena Bojanova(ivb)
 *@date - 10/20/2022 */

using System.Text.RegularExpressions;

Console.WriteLine("Hello, World!");

var file = @"c:\__Irena\Bugs\BF\BF FIGS\CWE-graph--DCL-NRS-TCV-TCM-consequence.pdf_tex";

var text = File.ReadAllText(file);

text = Regex.Replace(text, @"\[t\]{l}(?<n>\d+)\\end", m => @"[t]{l}\cwelink{" + m.Groups["n"].Value + @"}\end");

var pattern = @"(?<p>\\put\()(?<c>[\d\.]+)(?<s>,.+cwelink\{\d{4})";
text = Regex.Replace(text, pattern, m =>
{
    var n = double.Parse(m.Groups["c"].Value) - 0.005;
    return m.Groups["p"].Value + n.ToString() + m.Groups["s"].Value;
});
File.WriteAllText(file + "_new", text);


//Instructions for making svg clickable from exported SVG file
//1.Regex search > (\d +)</ text > and replace with ><a xlink:href = "https://cwe.mitre.org/data/definitions/$1.html"  target = "_blank" >$1 </ a ></ text >
//2.If not present, add xmlns:xlink = "http://www.w3.org/1999/xlink" definition inside SVG tag at top of file