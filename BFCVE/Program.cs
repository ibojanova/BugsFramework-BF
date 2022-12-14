/*@author Irena Bojanova(ivb)
 *@date - 2/27/2022 */

using BFDB;

namespace BFCVE
{
    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Application.Run(new BFCVEForm());
        }
    }
}