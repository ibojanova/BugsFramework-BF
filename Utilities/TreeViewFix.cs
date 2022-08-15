using System.Windows.Forms;

/*@author Irena Bojanova(ivb)
 *@date - 2/27/2022 */

namespace Utilities
{
    public class TreeViewFix : TreeView
    {
        //fixing a known bug in TreeView related to double-click
        protected override void WndProc(ref Message m)
        {
            if (m.Msg == 0x203) m.Msg = 0x201;
            base.WndProc(ref m);
        }
    }
}
