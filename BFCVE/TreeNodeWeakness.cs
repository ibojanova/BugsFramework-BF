using BF;
using BFCVEDB;

/*@author Irena Bojanova(ivb)
 *@date - 2/27/2022 */

namespace BFCVE
{
    //adds new members to TreeNode to hold the Weakness object and Bug/Weakness/Fault flag about the weakness type
    // xxx make subclass of TreeNode<Data>
    public class TreeNodeWeakness : TreeNode
    {
        public Weakness Weakness = new();
        public readonly BWF TypeBWF;

        public TreeNodeWeakness(Weakness weakness, BWF typeBWF) : base(weakness.Class)
        {
            TypeBWF = typeBWF;
            SetWeakness(weakness);
        }

        public void SetWeakness(Weakness weakness)
        {
            Weakness = weakness;
            Name = Text = weakness.Class;
        }
    }

}
