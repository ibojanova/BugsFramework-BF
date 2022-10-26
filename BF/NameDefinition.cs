using System.Diagnostics.CodeAnalysis;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BF
{
    public record NameBWF(string Name, BWF BWFType); 

    public enum BWF { Bug, Weakness, Failure };

}
